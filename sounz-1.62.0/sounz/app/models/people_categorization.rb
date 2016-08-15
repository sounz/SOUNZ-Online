class PeopleCategorization < ActiveRecord::Base
  belongs_to :marketing_subcategory
 belongs_to :person
  
  validates_uniqueness_of(:marketing_subcategory_id, :scope => :person_id)
end
