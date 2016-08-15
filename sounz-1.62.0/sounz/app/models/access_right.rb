class AccessRight < ActiveRecord::Base
  set_primary_key :access_right_id
  
  has_many :work_access_rights
  has_many :manifestation_access_rights
  has_many :expression_access_rights
  has_many :resource_access_rights

end
