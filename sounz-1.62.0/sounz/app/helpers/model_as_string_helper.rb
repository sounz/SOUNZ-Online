module ModelAsStringHelper
  
  #Convert a model to a string in the following way:
  # CommunicatiionPeople.find(49) => communication_people_49
  def generate_id(model)
    return "#{model.class.to_s.underscore}_#{model.id}"
  end
  
  #Convert a model to a string in the following way:
  # CommunicatiionPeople.find(49) => communication_people_49
  def self.static_generate_id(model)
    return "#{model.class.to_s.underscore}_#{model.id}"
  end
  
  
  # Convert a string of the form communication_people_49 into the corresponding model
  def convert_id_to_model(model_id_string)
    bits = model_id_string.split("_")
    gid = bits.pop
    model_name = bits.join('_').camelize
    model = model_name.constantize.find(gid.to_i)
    return model
    
  end
end