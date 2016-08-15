class MarketingCategory < ActiveRecord::Base
  set_primary_key :marketing_category_id

  validates_presence_of :description, :message => "cannot be empty"
  validates_presence_of :abbreviation, :message => "cannot be empty"
  
  validates_length_of :description, :in => 2..300, :message => "is not between 2 and 300 chars"
    validates_length_of :abbreviation, :in => 2..100, :message => "is not between 2 and 100 chars"

  
  # this is to show the relationship with subcategory
  has_many :marketing_subcategories,
  :order => "display_order"
  
  #For adding new categories in the HTML interface
  acts_as_dropdown
  
  # Comparison for sorting
  def <=> (other_category)
    self.abbreviation <=> other_category.abbreviation
  end
  
end
