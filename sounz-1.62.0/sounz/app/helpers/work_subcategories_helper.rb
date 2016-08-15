module WorkSubcategoriesHelper
  
  def self.find_by_name(name)
    WorkSubcategory.find(:all, :conditions => ["work_subcategory_desc ilike ?",'%'+name+'%'])
  end
end
