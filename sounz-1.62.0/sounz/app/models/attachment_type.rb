class AttachmentType < ActiveRecord::Base
  set_primary_key "attachment_type_id"
  
  # model relationships
  has_many :sample_attachments, :dependent => :destroy
  has_many :samples, :through => :sample_attachments

  has_many :manifestation_attachments
  has_many :manifestations, :through => :manifestation_attachments

  has_many :work_attachments
  has_many :works, :through => :work_attachments

  has_many :resource_attachments
  has_many :resources, :through => :resource_attachments

  has_many :contributor_attachments
  has_many :contributors, :through => :contributor_attachments

   
  has_many :person_attachments
  has_many :people, :through => :person_attachments

  has_many :organisation_attachments
  has_many :organisations, :through => :organisation_attachments

  has_many :event_attachments
  has_many :events, :through => :event_attachments

  has_many :mailout_attachments
  has_many :campaign_mailouts, :through => :mailout_attachments
  
  # model validation
  validates_presence_of :attachment_type_desc,
                        :display_order,
            :message => "cannot be empty"
            
  #Some constants to avoid wiring code against ids
  SAMPLE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Sample"])
  CAMPAIGN_MAILOUT = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Campaign mailout"])
  MAIN_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Main Image"])
  ICON_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Icon Image"])
  LOGO = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Logo"])
  SUPPLEMENTARY_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Supplementary Image"])
  TINY_MCE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Tiny MCE"])
  PDF = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Pdf"])

end
