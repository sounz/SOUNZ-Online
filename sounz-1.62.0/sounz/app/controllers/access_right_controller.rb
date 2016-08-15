class AccessRightController < ApplicationController
  
  include ModelAsStringHelper
  
  #Remove an access right from the parent object
  def remove
    model_id = params[:id]
    @dom_id = "ar_" << model_id
    @model_access_right = convert_id_to_model(model_id)
    
    @valid = true
    begin
      @model_access_right.destroy
    rescue Exception => e
      logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      @valid = false
    end

    
    #fixme, do destroy here also
  end
  
  
  #Show the new access rights form
  def new
    @model_id = params[:id]
    prepare_edit_or_new
  end
  
  
  
  #Hide the new form and replace the new button
  def cancel_new
    @model_id = params[:id]
  end
  
  
  
  
  
  #Due to the generic nature of this beast, a bit more work is required than normal.  For example
  #we have to create the target class object dynamically
  def create
    @valid = true
    begin
      #the id of the parent object, e.g. an expression, that this access right will be assigned to
      @parent_model_id = params[:model_access_right_parent][:parent_model_id]
      access_right_key = (@parent_model_id+'access_right').to_sym
      
      logger.debug access_right_key
      logger.debug "======="
      
      access_right_class_name = session[access_right_key][:model_string] + "AccessRight"
      model_access_right_klass = access_right_class_name.camelize.constantize
      logger.debug "Model access right class is #{model_access_right_klass}"
    
      #Create the instance
      @model_access_right = model_access_right_klass.new(params[:model_access_right])

      #We still have to attach it to a parent tho...
      #Get the parent
      parent_model_id = session[access_right_key][:parent_model]
      @parent_model = convert_id_to_model(parent_model_id)
    
      #oh and of course its a different method for each one to set the model
      #e.g. thing.expression, thing.work etc
      @model_access_right.send(@parent_model.class.to_s.tableize.singularize<<'=',@parent_model)
      
      
      logger.debug @model_access_right.to_yaml
      
      @model_access_right.save! #throw an exception
      
      @dom_id = 'ar_'+generate_id(@model_access_right)
      
      #[if we have got this far then the view will be rendered]

    rescue Exception => e
      logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      @valid = false
    end
  end

  
  def edit
    prepare_edit_or_new
    @model_id = params[:id]
    @model = convert_id_to_model(@model)
  end
  
  
  # get the access rights before rendering the form
  def prepare_edit_or_new
    @access_rights = AccessRight.find(:all, :order => :access_right_name)
  end
  
  
end
