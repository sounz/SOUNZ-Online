class ResourceType < ActiveRecord::Base
  set_primary_key :resource_type_id
  
  has_many :resources
  has_and_belongs_to_many :formats, 
                          :join_table => :resource_type_formats,
                          :order => :format_desc #To make the dropdowns alphabetical
  
  validates_presence_of :resource_type_desc
  validates_uniqueness_of :resource_type_desc
  
  #
  # Used in music facets
  #
  def self.find_by_desc_for_facets(desc)
  	return ResourceType.find(:all, :conditions => ['resource_type_desc ilike (?)', '%' + desc + '%'])
  end
end
