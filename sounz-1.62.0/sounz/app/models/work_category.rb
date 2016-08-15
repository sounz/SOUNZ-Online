class WorkCategory < ActiveRecord::Base
  set_primary_key "work_category_id" 
  set_sequence_name "work_categories_work_category_id_seq"
  has_many :work_subcategories
  
  TAONGA_PUORO    = WorkCategory.find(:first, :conditions => ['work_category_desc ilike (?)', '%Taonga Puoro%'])
  MUSIC_FOR_STAGE = WorkCategory.find(:first, :conditions => ['work_category_desc ilike (?)', '%Vocal Music for the Stage%'])
  
  #
  # Return an array of work categories ids
  # of 'vocal' work categories
  #
  def self.main_categories_for_voices_ids
    ids = Array.new
    condition  = "LOWER(work_category_desc) LIKE '%orchestra%' OR LOWER(work_category_desc) LIKE '%vocal%' OR LOWER(work_category_desc) LIKE '%choral%'"
    
    work_categories = WorkCategory.find(:all, :select => 'DISTINCT(work_category_id)', :conditions => condition)
        
    ids = work_categories.collect{ |wc| wc.work_category_id}
        
    return ids
  end
  
  def self.find_by_desc(desc)
    WorkCategory.find(:first, :conditions => ['work_category_desc ilike (?)', '%' + desc + '%'])
  end  
  
  def self.work_categories_for_additional_subcategory(work_category_desc=nil)
  	
  	conditions = "work_category_desc <> 'Additional'"
	
	conditions = conditions + " AND work_category_desc <> '#{work_category_desc}'" unless work_category_desc.blank?
  	
	return WorkCategory.find(:all, :conditions => conditions, :order => 'display_order')
	
  end
end
