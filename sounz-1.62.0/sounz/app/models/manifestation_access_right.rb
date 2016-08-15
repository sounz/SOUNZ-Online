class ManifestationAccessRight < ActiveRecord::Base
  set_primary_key :manifestation_access_right_id
  
  belongs_to :access_right
  belongs_to :manifestation
  
  validates_presence_of :access_right_source, :manifestation, :access_right
  
  validates_inclusion_of :access_right_source, :in => ["publisher", "composer"]
end
