class ResourceAccessRight < ActiveRecord::Base
  set_primary_key :resource_access_right_id 
  
  belongs_to :resource
  belongs_to :access_right
  
  validates_presence_of :access_right_source, :resource, :access_right
  
  validates_inclusion_of :access_right_source, :in => ["publisher", "composer"]
end
