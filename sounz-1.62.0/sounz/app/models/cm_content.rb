class CmContent < ActiveRecord::Base


  
  validates_uniqueness_of :cm_content_name
  
  #Updated by relationship
  set_primary_key 'cm_content_id'
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :status
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
            
  validates_presence_of :cm_content_title, :cm_content
  
  has_many :cm_content_attachments
  has_many :media_items, :through => :cm_content_attachments
  
  # -------------------------
  # - Return user-friendly 
  # - page url
  # -------------------------
  def cm_page_url
    website_url = Setting.get_value(Setting::WEBSITE_URL)
    cm_page_url = 'http://' + website_url + '/content/' + self.cm_content_name.to_s
    
    return cm_page_url
  end
            
end
