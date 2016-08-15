class MarketingSubcategory < ActiveRecord::Base
  set_primary_key :marketing_subcategory_id
  

  
  # this is to show the relationship with category
  belongs_to :marketing_category
  
  has_many :role_categorizations
  has_many :roles, :through => :role_categorizations
  
  
  validates_presence_of :description, :message => "cannot be empty"
  validates_presence_of :abbreviation, :message => "cannot be empty"
  
  validates_length_of :description, :in => 2..300, :message => "is not between 2 and 300 chars"
  validates_length_of :abbreviation, :in => 2..100, :message => "is not between 2 and 100 chars"

  
  #For adding new nomens in the HTML interface
  acts_as_dropdown
  
  
  #Return a string containing the category and subcateogry
  def to_category_subcategory_s
  return marketing_category.abbreviation+" - "+abbreviation
  end

end
