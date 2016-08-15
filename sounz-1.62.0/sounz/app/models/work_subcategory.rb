class WorkSubcategory < ActiveRecord::Base
  set_primary_key "work_subcategory_id"
  set_sequence_name "work_subcategories_work_subcategory_id_seq"
  
  # this is to show the relationship with category
  belongs_to :work_category
  has_many :work_categorizations
  has_many :works, :through => :work_categorizations
  
  
#  has_many :main_categorized_works, :class=> 'Work',:foreign_key => :main_category_id
  
  acts_as_dropdown :order => :display_order
  
  
  SUITABLE_FOR_YOUTH = WorkSubcategory.find(:first, :conditions => ["work_subcategory_desc = 'Suitable for Youth'"])
  
  def self.find_by_desc(desc)
  	WorkSubcategory.find(:first, :conditions => ["work_subcategory_desc = ?", desc])
  end
  
end
