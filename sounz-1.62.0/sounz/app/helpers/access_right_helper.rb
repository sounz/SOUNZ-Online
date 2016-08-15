module AccessRightHelper
  include ModelAsStringHelper

  
  #Populate variables required to render the hard association controller
  def populate_access_right_variables(parent_model)
    access_right_key = (generate_id(parent_model)+'access_right').to_sym
    
    logger.debug "ACCESS KEY:#{access_right_key}"
    logger.debug "===================="
    
    klass_string = parent_model.class.to_s.tableize.singularize
    model_access_rights_method = klass_string +"_access_rights"
    model_access_rights = parent_model.send(model_access_rights_method)
    
    #this will be stored under something like :work_1000_access_right
    session[access_right_key] = {}
    session[access_right_key][:parent_model] = generate_id(parent_model)
    session[access_right_key][:model_access_rights] = model_access_rights
    session[access_right_key][:model_string] = klass_string
    
  end

  
  #Helper method to printout text such as 'Permission is granted by the composer for hire out'
  def self.model_access_right_to_string(model_access_right)
    return "The " << model_access_right.access_right_source << " " << model_access_right.access_right.access_right_name
  end
end

