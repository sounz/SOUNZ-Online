class ManifestationsController < ApplicationController
  
  include AttachmentHelper
  include ApplicationHelper
  include ModelAsStringHelper
  include StatusesHelper
  include DurationAsIntervalHelper
  include FrbrMruHelper
  include HardAssociationHelper
  include AccessRightHelper
  include FrbrLinksHelper
  
  EXPRESSION_TYPE = EntityType.find_by_symbol(:expression)
  
  helper_method :external_format
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @manifestations = Manifestation.paginate( :page => params[:page], :per_page => 50, :order => 'manifestation_title')
  end

  def show
    @manifestation = Manifestation.find(params[:id])
    extension = ''
    extension = "Score - " if @manifestation.is_a_score?
    extension = "Recording - " if @manifestation.is_a_recording?
    @page_title="#{extension}#{@manifestation.manifestation_title}"
  end
  
  
  #- This is for the frbr related data -
  def related
    @manifestation = Manifestation.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@manifestation, "frbr_"+mode) #hide frbr_ from URL
    @sub_partial_path = "shared/frbr/objects/full/manifestation/frbr_list_wrapper"
  end
  
  
  
  
  #Create a new manifestation for an existing expression and link the little blighter up
  def new_for_expression
    @related_expression = Expression.find(params[:id])
    @manifestation = Manifestation.new
    @interval_duration = IntervalDuration.create_from_string(nil)
    @has_related_expression = true
    prepare_new
    render :action => 'new'
  end


  # This is called to create a stand alone manifestation with no linkage to any other object
  def new
    @has_related_expression = false
    @manifestation = Manifestation.new
 #OBSOLETE   @interval_duration = IntervalDuration.create_from_string(nil)
    prepare_new
  end
  
  
  #- Prepare a  new manifestation entry, by getting a few common fields that are required to render the form -
  def prepare_new
    #This is mixed in from duration helper
    prepare_duration_new
    
    @formats=Format.find(:all, :order => 'format_desc')
    @manifestation_types=ManifestationType.find(:all, :order => 'manifestation_type_id')
    
    #Get statuses for the dropdown in alphabetical order, and set the default to 
    get_statuses(@manifestation)
    set_default_status(@manifestation)
    save_manifestation_instance_in_session
  end
  

  #Note we have to check for a parent expression here and deal with FRBR updates
  def create
    logger.debug "** MANIFESTATION CREATE **"
    show_params(params[:manifestation])
    
   # logger.debug "Params duration are #{params[:manifestation][:duration]}"
    
    #Avoid controller breakage is params expression missing
    if !params[:expression].blank? and !params[:expression][:related_expression_id].blank?
      related_expression_id = params[:expression][:related_expression_id]
    end
    
    
    #Create a manifestation from the web parameters, and set the updated by flag
    @manifestation = Manifestation.new(params[:manifestation])
    #logger.debug "After creation of manifest duration is #{params[:manifestation][:duration]}"
      
    #Set teh manifestation to nil if the field is not set
    # process_duration_parameter(@manifestation, 'duration', params[:manifestation], :duration)
    @manifestation.duration = nil if params[:manifestation][:duration].blank?
    #logger.debug "MANIF DURATION IS #{@manifestation.duration}"
    @manifestation.updated_by = @login.login_id
  
    #--- This is the case where we have a related expression ---
    if !related_expression_id.blank? #Note this covers the nil case
      
      #Find the related expression
      @related_expression = Expression.find(related_expression_id)
      
      #Try to link the manifestation to the expression, using a transaction
      if @manifestation.add_expression(@related_expression)
        logger.debug "** MANIFESTATION SAVED, AND LINKED TO EXPRESSION **"
        flash[:notice] = 'Manifestation was successfully created, and linked to expression'
        get_statuses(@manifestation)
        redirect_to :action => 'show', :id => @manifestation
      else
        logger.debug "** MANIFESTATION NOT SAVED, REDIR TO NEW **"
        logger.debug @manifestation.to_yaml
        logger.debug @related_expression.to_yaml
        logger.debug "--- above for errors ---"
        prepare_new # populate the necessary variables to render the form
        @interval_duration = IntervalDuration.create_from_string_no_validation(@manifestation.duration)

        @has_related_expression = true
        render :action => 'new'
      end
      
    
    #--- deal with a standard save of a manifestation stand alone ---
    elsif @manifestation.save
      logger.debug "** MANIFESTATION SAVED **"
      logger.debug @manifestation.errors.to_yaml
      flash[:notice] = 'Manifestation was successfully created.'
      get_statuses(@manifestation)
      #create a moneyworks export file
      @manifestation.create_moneyworks_file()
      redirect_to :action => 'show', :id => @manifestation
    else
      logger.debug "** TMANIFESTATION NOT SAVED, REDIR TO EDIT **"

      # reset the sequence object's counter value
      ActiveRecord::Base.connection.execute("select setval('seq_manifestation_code', #{@manifestation.manifestation_code.to_i}, false)")
      
      logger.debug "T1NEW MANIF NOT SAVED DUE TO ERRORS, interval duration is #{@interval_duration}"
      prepare_new # populate the necessary variables to render the form
      logger.debug "T2 NEW MANIF NOT SAVED DUE TO ERRORS, interval duration is #{@interval_duration}"
      logger.debug "Man dur is nil? #{@manifestation.duration == nil}"
      @interval_duration = IntervalDuration.create_from_string_no_validation(@manifestation.duration)

      logger.debug "T3 NEW MANIF NOT SAVED DUE TO ERRORS, interval duration is #{@interval_duration}"
      render :action => 'new'
    end
  end
  
  


  def edit
    @manifestation = Manifestation.find(params[:id])
    @backlink = params[:backlink]
    prepare_edit
    ascertain_if_no_samples_or_attachments
  end
  
  
  def prepare_edit 
    #OBSOLETE @interval_duration = IntervalDuration.create_from_string_no_validation(@manifestation.duration)
    prepare_duration_edit(@manifestation.duration)
   
    @manifestation_types=ManifestationType.find(:all, :order => 'manifestation_type_id')
    @formats=@manifestation.manifestation_type.formats #Get the restricted set
    get_statuses(@manifestation)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
    @media_items = attachments(@manifestation)
    #Enable the hard association controller
    prime_hard_association_for_manifestation_expressions(@manifestation)
    save_manifestation_instance_in_session
    populate_access_right_variables(@manifestation)
  end
  

  def update
    @manifestation = Manifestation.find(params[:id])
    @manifestation.updated_by = @login.login_id
    
    @manifestation.duration = nil if params[:manifestation][:duration].blank?
    if @manifestation.update_attributes(params[:manifestation])
      flash[:notice] = 'Manifestation was successfully updated.'
      if !params[:back][:link].blank?
        redirect_to params[:back][:link]
      else
        redirect_to :action => 'show', :id => @manifestation
      end
    else
      prepare_edit
      render :action => 'edit'
    end
  end


  def destroy
    Manifestation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  def show_add_sample_form
     @manifestation = Manifestation.find(params[:id])
     @sample = Sample::new
     set_default_status(@sample)
     get_statuses(@sample)

     render :partial => "new_sample", :locals => {:submission => :new, :manifestation => @manifestation,
                                                    :sample => @sample}
  end

  
  
  #This action is called to cancel the add sample form
  def cancel_add_sample_form
    @manifestation = Manifestation.find(params[:id])
    render :partial => 'add_sample_form_button', :locals => {:manifestation => @manifestation}
  end
  
  
  #This action is called to cancel the update sample form
  def cancel_update_sample_form
    @manifestation = Manifestation.find(params[:id])
    @sample = Sample.find(params[:sample_id])
    @dom_id = generate_id(@sample)
    #new_sample_form
   end
  
  
  #Create a sample
  def create_sample
    @sample = Sample.new(params[:sample])
    get_statuses(@sample)
    @manifestation = Manifestation.find(params[:id])
    @manifestation.add_sample(@sample)
    @dom_id = generate_id(@sample)
    @sample.updated_by = @login.login_id
    prime_hard_association_for_manifestation_expressions(@manifestation)
    respond_to do |format|
      @saved = @manifestation.save
      if @saved
        @dom_id = generate_id(@sample) # We have already checked that this has been saved
        flash[:notice] = 'Sample was successfully created.'
        format.html { redirect_to sample_url(@sample) }
        format.xml  { head :created, :location => sample_url(@sample) }
        format.js # Use create_sample.rjs to render this
      else
        logger.debug "**** SAMPLE DID NOT SAVE ****"
        get_statuses(@sample)
        format.html { render :action => "new" }
        format.xml  { render :xml => @sample.errors.to_xml }
        format.js #Use create_sample.rjs
      end
    end
  end
  
  
  #Delete a sample, and also sample attachments
  def delete_sample
    @sample = Sample.find(params[:sample_id])
    logger.debug "Sample is #{@sample.to_yaml}"
    @manifestation = Manifestation.find(params[:id])
    @dom_id = generate_id(@sample)
   # @manifestation.samples.delete(@sample)
   # @manifestation.save
    logger.debug "**** DELETING SAMPLE #{@dom_id} ****"
    @sample.destroy
     logger.debug "**** /DELETING SAMPLE ****"
  end
  
  
  #Show the update form
  def show_sample_update_form
    @sample = Sample.find(params[:sample_id])
    get_statuses(@sample)
    logger.debug "Sample is #{@sample.to_yaml}"
    @manifestation = Manifestation.find(params[:id])
    prime_hard_association_for_manifestation_expressions(@manifestation)
    @dom_id = generate_id(@sample)
  end
  
  
  # PUT /samples/1
  # PUT /samples/1.xml
  def update_sample
    @manifestation = Manifestation.find(params[:id])
    @sample = Sample.find(params[:sample_id])
    @dom_id = generate_id(@sample)
    @sample.updated_by = @login.login_id

    respond_to do |format|
      @saved = @sample.update_attributes(params[:sample])
      if @saved
        flash[:notice] = 'Sample was successfully updated.'
        format.html { redirect_to sample_url(@sample) }
        format.xml  { head :ok }
        format.js
      else
        get_statuses(@sample)
         logger.debug "**** SAMPLE DID NOT UPDATE ****"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample.errors.to_xml }
        format.js
      end
    end
  end
  
  
  #------------------------------------------------------
  #- Respond to the dropdown change of manifestation type
  #------------------------------------------------------
  def tweak_format_dropdown
    logger.debug "***** Tweak format dropdown"
    @found_type = true #If they choose the prompt then there is no type
    type_id = params[:type]
    logger.debug "Type is is #{type_id}"
         
    if !type_id.blank?
      @manifestation_type = ManifestationType.find(type_id)
      @formats = @manifestation_type.formats
    else
      @found_type = false
      @manifestation_type = nil
    end
    
    #Get the manifestation instance
    load_manifestation_instance_from_session
    
    #Reset the format in order to get the prompt
    @manifestation.format=nil
    

    @manifestation.manifestation_type = @manifestation_type
    render :layout => false
  end
  
  
  #-------------------------------------------------------
  #- Bulk add multiple expressions to this manifestation 
  #- This merely shows the form of the last 10 updated expressions
  #-------------------------------------------------------
  def add_recent_expressions
    @manifestation = Manifestation.find(params[:id])
    expression_ids = @manifestation.expressions.map{|e| e.expression_id}
    @mru_frbr_objects= find_mru_entity_types(EXPRESSION_TYPE, @login, amount = 10, 
                                              already_chosen_ids = expression_ids)
  end
  
  
  #---------------------------------------------------------------------------------------------------
  #- Process the form submission from above form, namely a tick list of recently updated expressions -
  #---------------------------------------------------------------------------------------------------
  def add_multiple_expressions
    @manifestation = Manifestation.find(params[:manifestation][:id])
    new_expression_ids=params[:new_related_frbr][:ids]
    expression_array = []
    
    bad_id = false # Set this to true if 
    for id in new_expression_ids
      exp = convert_id_to_model(id)
      if exp.class != Expression
        bad_id = true
        flash[:message]= 'Objects that are not of type expression cannot be added here'
        break
      else
        expression_array << exp
      end
    end
    
    
    # we have not errored yet (ie tried to use non expressio models) so lets attempt to add the expressions
    
    if !bad_id
      if @manifestation.add_expressions(expression_array)
        #good
         redirect_to :action => :show, :id => @manifestation.manifestation_id
      else
        flash[:message] = "An error occurred whilst trying to add these expressions"
        render :action => :add_recent_expressions, :id => @manifestation.manifestation_id
      end
      
    #This is the case where ids where submitted that are not expressions (ie someone is le hacking)
    else
      #bad
      flash[:message] = "You can only add expressions"
      render :action => :add_recent_expressions, :id => @manifestation.manifestation_id
    end
  end
  
  # ---- Session storage of expressions ----
  
  #In order for the ajax to repopulate correctly the dates when a mode is changed, the manifestation being edited
  #needs to be stored in the session
  def save_manifestation_instance_in_session
    session[:manifestation_being_edited] = @manifestation
  end
  
  #Load the instance variable @manifestation with whats saved
  def load_manifestation_instance_from_session
    @manifestation = session[:manifestation_being_edited]
  end
  
  
  def add_loan_item
    logger.debug("ADD LOAN ITEM")
    @manifestation=Manifestation.find(params[:id])
    item=Item.new()
    myItemType=ItemType.find(:all,:conditions => ['item_type_desc=?','Music Library item']).first
    item.item_type_id=myItemType.item_type_id
    
    item.status_id=1
    item.updated_by=@login.id
    item.physical_description='NO DESCRIPTION'
    if ! item.save()
      logger.debug("COULD NOT SAVE ITEM!")
    end
    @manifestation.items << item
    @manifestation.save()
    render :partial => 'item_list', :locals =>{:object => @manifestation}
  end
  
  def add_sale_item
    logger.debug("ADD SALE ITEM")
    @manifestation=Manifestation.find(params[:id])
    item=Item.new()
    myItemType=ItemType.find(:all,:conditions => ['item_type_desc=?','Sale item']).first
    item.item_type_id=myItemType.item_type_id
    
    if ! item.save()
      logger.debug("COULD NOT SAVE ITEM!")
    end
    @manifestation.items << item
    @manifestation.save()
    render :partial => 'item_list', :locals =>{:object => @manifestation}
  end
  
  private
  
  def ascertain_if_no_samples_or_attachments
    @has_no_samples_or_attachments = false
    number_of_samples = @manifestation.samples.length
    number_attachments =  @manifestation.manifestation_attachments.length
    
    if number_of_samples == 0 or number_attachments == 0
      @has_no_samples_or_attachments = true
      @no_samples_or_attachments_message = "has "
      @no_samples_or_attachments_message << "no samples" if number_of_samples == 0
      @no_samples_or_attachments_message << " or " if (number_of_samples == 0 and number_attachments == 0)
      @no_samples_or_attachments_message << " attachments" if number_attachments == 0
    end
  end
  
  
  
end
