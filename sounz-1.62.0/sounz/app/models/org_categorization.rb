class OrgCategorization < ActiveRecord::Base
  #set_primary_key :organisation_id
  #set_primary_key :marketing_subcategory_id
  
  belongs_to :marketing_subcategory
  belongs_to :organisation
  
  validates_uniqueness_of(:marketing_subcategory_id, :scope => :organisation_id)
end
