class CacheHelper
  
  include ModelAsStringHelper
  
  #Create a key based on the object in context and the privileges of the login
  # * object - the object being cached
  # * login - the login asking for the cached object
  # * cache_part_name - a name for the part of the page being cached, e.g. search result
  def self.make_key(object, login, cache_part_name)
    model_id = ModelAsStringHelper.static_generate_id(object)
    key = model_id
    key << cache_part_name
    key << object.updated_at.to_i.to_s
    
    if login.blank?
      key << 'NOTLOGGEDIN'
    else
      key << login.privileges_cache_key
    end
    key
  end
end
