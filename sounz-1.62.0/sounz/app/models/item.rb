class Item < ActiveRecord::Base
  
  set_primary_key :item_id
  
  
  # model validation
  validates_presence_of :login_updated_by,
                        :item_type_id,
                        :status_id,
                        :item_category,
                        :updated_by,
               :message => 'cannot be empty'
          
  #validates_associated :login_updated_by
  
  # Test booleans exist and are non nil
  validates_inclusion_of :out_on_loan_or_hire, :in => [true, false]
  
  # relationships
  belongs_to :item_type
  belongs_to :manifestation
  belongs_to :resource
  belongs_to :status
  has_many :borrowed_items
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
			
  acts_as_dropdown :text => 'item_type_desc', :order => 'display_order'
  
  # returns the title of the manifestation or resource the item assigned to
  def item_title
    title = nil
    
    title = manifestation.manifestation_title unless manifestation.nil?
    title = resource.resource_title unless resource.nil?
    title = nil if !manifestation.nil? && !resource.nil?
    
    return title
  end

end
