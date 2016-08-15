class RoleCategorization < ActiveRecord::Base
  set_primary_key :role_categorization_id
 
  belongs_to :marketing_subcategory
  belongs_to :role
  
  # model validations
  validates_presence_of  :role_id,
                         :marketing_subcategory_id,
                         
                         :message => "cannot be empty"
                         
  validates_uniqueness_of(:marketing_subcategory_id, :scope => :role_id)
  
end
