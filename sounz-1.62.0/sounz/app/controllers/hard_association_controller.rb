#The ability to add arbitrary FRBR relationships where a database link is also required has been removed.
#As such, this widget is meant to replicate the functionality of the association controller, but also
#deal with the hard links.  It will also mean a consistent look n feel
class HardAssociationController < ApplicationController

  include ModelAsStringHelper
  include FinderHelper
  include FrbrHelper

  #The following variables require to be set up in the session prior to rendering the widget
  # * [:hard_association][:frbr_instance] - this is the model_id, eg work_14000 as a string
  # * [:hard_association][:children_method] - the method used to get child objects, e.g. a work
  #                                           has expressions, an expression manifestations.  It is expected
  #                                           this will return an array of one of the FRBR entity types
  # * [:hard_association][:parent_entity_type]
  # * [:hard_association][:parent_entity_type]
  # * [:hard_association][:parent_entity_type]
  # * [:hard_association][:parent_entity_type]
  # * [:hard_association][:parent_entity_type]
  #
  def showNOT
  #  parent_entity_type = session[:hard_association][:parent_entity_type]
  #  child_entity_type  = session[:hard_association][:child_entity_type]
    model_id= session[:hard_association][:frbr_instance]
    children_method= session[:hard_association][:children_method]
    @frbr_instance = convert_id_to_model(model_id)
    show_params(params)
    asdsadfsdf



    #Just in case....
    @frbr_children = @frbr_instance.send(children_method) if children_method != 'destroy'


  end


  # Search using SOLR for matches to the search term for the given entity type.  The view will
  # render a menu
  def find_objects
    search_text = params[:search_text]
    @instance_id = params[:frbr_object_id]
    hard_assoc_key = (@instance_id+'_hard_association').to_sym
    model_class = session[hard_assoc_key][:child_entity_type].camelize.constantize
    if !FrbrHelper.is_frbr_object?(model_class)
      render :text => 'You can only search FRBR objects, you tried to search '+model_class.to_s
    elsif search_text.length < 3
      render :text => 'Please type at least 3 letters'
    else
      fields = [
        {:name => 'frbr_ui_desc_for_solr_t', :boost => 1}, #FIXME - is there a way to avoid appending _t
      ]
      le_query = FinderHelper.build_query(model_class, search_text, fields)
      @matching_frbr_objects = solr_query(le_query,{})[0][:docs].map{|f|f.objectData}

      #now weed out the ones that already exist
      model_id= session[hard_assoc_key][:frbr_instance]
      children_method= session[hard_assoc_key][:children_method]
      @frbr_instance = convert_id_to_model(model_id)

      #Just in case....
      @frbr_children = @frbr_instance.send(children_method) if children_method != 'destroy'
      for match in @matching_frbr_objects
        if @frbr_children.include?(match)
          @matching_frbr_objects.delete(match)
        end
      end
      render :layout => false
    end
  end

=begin
begin
  transaction do
    logger.debug "**TRACE1**"
    save! #This will throw an exception if it fails
    logger.debug "**TRACE2 expression has id #{self.expression_id}**"
    update_frbr_for_expression_work_relationship #This also throws an exception if it fails
    logger.debug "**TRACE3 - relationship added"
   end
rescue Exception => e
    logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"

   logger.debug "**TRACE4**"
   return false
end

=end

  #Add a new FRBR relationship and hard link up also
  def add_child
    @succesful_addition = true
    @source_id = params[:source_id]
     hard_assoc_key = (@source_id+'_hard_association').to_sym
    @removal_mode = session[hard_assoc_key][:removal_mode].camelize

    #Get the parent model from the session
    parent_model_string = session[hard_assoc_key][:frbr_instance]
    logger.debug "PARENT MODEL STRING:#{parent_model_string}"
    splits = parent_model_string.split('_')
    parent_model_class_string = splits[0]
    parent_model_id_string = splits[1]

    parent_model = convert_id_to_model(parent_model_string)

    #if an exception occurs popup a javascript dialog box in the view
    begin
      parent_model.transaction do
        logger.debug "** HARD ASSOCIATION - ADD CHILD **"
        #Get child, ie the found object clicked on
        child_model_string = params[:id]
        child_model = convert_id_to_model(child_model_string)



        # get the relationship type
        relationship_type = session[hard_assoc_key][:relationship_type]

        #OK - are we dealing with many or one item?
        #get the child method
        child_method = session[hard_assoc_key][:children_method]
        logger.debug "CHILD METHOD:#{child_method}"

        #get the children
        children = parent_model.send(child_method)

        #deal with the to many case
        if children.class == Array
          logger.debug "TRACE1"
          #Oh boy this took figuring out.  The only way to get 1 to many and many to many to behave
          parent_model.send(child_method).send('<<', child_model)
        #deal with the one case
        else
          logger.debug "TRACE2"
          parent_model.send(child_method+'=', child)
        end

        #save the parent
        parent_model.save! #throw an exception if it does not work

        #now add the FRBR relationship

        #The one we are adding
        splits = child_model_string.split('_')
        child_model_class_string = splits[0]
        child_model_id_string = splits[1]

        RelationshipHelper.add_frbr_relationship(parent_model_class_string.to_sym,
                        parent_model_id_string.to_i, relationship_type.to_sym,
                        child_model_class_string.to_sym, child_model_id_string.to_i, @login.login_id)

        #For view
        @dom_id = "found_"+generate_id(child_model)
        @child_model = child_model
        @parent_dom_id="associated_to_"+parent_model_string
        @new_child_dom_id = "attached_"+child_model_string
      end
    rescue Exception => e
      @succesful_addition = false
      @error_message = Time.now.to_s+" - Addition failed, reason is: "+ e.message
      @alert = "alert('#{@error_message}');" #for javascript debugging
      logger.debug "HardAssociationException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
    end
  end






  #Detach a child and remove the FRBR relationship. Sometimes you want to detach, sometimes delete,
  #gotta figure out how that is going to work.
  def detach_child
    logger.debug "** DETACHING CHILD **"
    model_id = params[:id]
    @source_id = params[:source_id]
    @dom_id = "attached_"+model_id
    hard_assoc_key = (@source_id+'_hard_association').to_sym

    parent_model_string = session[hard_assoc_key][:frbr_instance]
    splits = parent_model_string.split('_')
    parent_model_class_string = splits[0]
    parent_model_id_string = splits[1]

    logger.debug "PARENT MODEL:#{parent_model_string}"

    #We are either deleting or attaching
    @removal_mode = session[hard_assoc_key][:removal_mode]

    #The one we are deleting
    splits = model_id.split('_')
    child_model_class_string = splits[0]
    child_model_id_string = splits[1]



    #get the child model as a ruby object
    child_model = convert_id_to_model(model_id)


    logger.debug "====== ABOUT TO DELETE CHILD MODEL ========"
    logger.debug "Removal mode is #{@removal_mode}"
    @successful_destroy = true

    begin
      #Note deletion removes associated relationships using :dependent
      if @removal_mode == "delete"
        child_model.destroy
        logger.debug "**** SUCCESSFUL DESTROY IS #{@succesful_destroy}"
      elsif @removal_mode == "detach"
         relationship_type = session[hard_assoc_key][:relationship_type]
         #get the child method
          child_method = session[hard_assoc_key][:children_method]
          logger.debug "CHILD METHOD:#{child_method}"

          parent_model = convert_id_to_model(parent_model_string)

          #get the array of children
          children = parent_model.send(child_method)
          children.delete(child_model)


          RelationshipHelper.delete_frbr_relationship(parent_model_class_string.to_sym,
            parent_model_id_string.to_i, relationship_type.to_sym, child_model_class_string.to_sym,
            child_model_id_string.to_i)
      else
        raise ArgumentError
      end

    rescue Exception => e
        @successful_destroy = false
        logger.debug "Destruction of #{child_model} failed."
        logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
    end

  end
end
