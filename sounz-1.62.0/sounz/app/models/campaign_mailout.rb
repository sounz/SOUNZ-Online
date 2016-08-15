class CampaignMailout < ActiveRecord::Base
  set_primary_key :campaign_mailout_id
  
  belongs_to :marketing_campaign
  
  has_many :mailout_contacts, :order => "name", :dependent => :destroy
  
  has_many :mailout_attachments, :dependent => :destroy
  has_many :media_items, :through => :mailout_attachments
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
             :class_name => 'Login',
             :foreign_key => :updated_by
  
  # validation of the model
  validates_presence_of :marketing_campaign_id,
                        :mailout_type,
                        :mailout_description, 
                        :mailout_status,
                        :updated_by,
  :message => "cannot be empty"
  
  # Test booleans exist and are non nil
  validates_inclusion_of :blind_send, :in => [true, false]
  validates_inclusion_of :mail_merge, :in => [true, false]
  
  # mailout_status:
  # 'n' - Not sent
  # 'r' - Send requested
  # 'i' - Send in progress
  # 's' - Sent
  validates_inclusion_of :mailout_status, :in => ['n', 'r', 'i', 's']
  
  #----------------------------------------------------
  #- Return campaign mailout status in display format -
  #----------------------------------------------------
  def mailout_status_display
    if self.mailout_status == 'n'
      return 'Not sent'
    end
    if self.mailout_status == 'r'
      return 'Send requested'
    end
    if self.mailout_status == 'i'
      return 'Send in progress'
    end
    if self.mailout_status == 's' 
      return 'Sent'
    end
  end
  
  # ------------------------------------------------------
  # - Add an organisation with a given role as a contact -
  # ------------------------------------------------------
  def add_mailout_contact( role_contactinfo, user_id )
    
    person       = role_contactinfo.role.person
    organisation = role_contactinfo.role.organisation
    
    # get details relevant only to person contact
    if !person.blank?
      contact_name = person.full_name
      salutation   = person.salutation
      nomen        = person.nomen.nomen unless person.nomen.blank?
      role_title   = role_contactinfo.role.role_title unless role_contactinfo.role.organisation.blank? || role_contactinfo.role.role_title.blank?
    #else
    #  contact_name = organisation.organisation_name unless organisation.blank?
    end
    
    # raise exception if an exact duplicate found (the same role_contactinfo_id)
    for contact in mailout_contacts
      if !role_contactinfo.blank? && contact.role_contactinfo_id == role_contactinfo.role_contactinfo_id
        errors.add "The contact #{ contact_name } already exists in the mailout"
        raise CampaignMailoutException.new("The contact #{ contact_name } already exists in the mailout")
      end
    end
    
    #puts "***** Adding contact #{role_contactinfo.role_contactinfo_id} "
            
    mailout_contact = MailoutContact.new
    mailout_contact.name                = contact_name
    mailout_contact.nomen               = nomen
    mailout_contact.role_title          = role_title
    mailout_contact.organisation_name   = organisation.organisation_name unless organisation.blank?
        
    # FIXME do we need salutation?
    mailout_contact.salutation          = salutation
       
    mailout_contact.role_contactinfo_id = role_contactinfo.role_contactinfo_id
    mailout_contact.campaign_mailout_id = campaign_mailout_id
    mailout_contact.updated_by          = user_id
        
    #puts "======="
    #puts mailout_contact.to_yaml
    
    mailout_contact                     = copy_address_details(mailout_contact, role_contactinfo.contactinfo)
    
    mailout_contacts << mailout_contact
    
	# WR#53662 - system performance issues:
	# solr re-indexing of role contactinfos takes a lot of time
	# for large lists, as per Scilla's note dated 12:44 23-05-2008
	# commented out solr re-indexing
		
    #if mailout_contact.save
    #  # for solr update
    #  mailout_contact.role_contactinfo.save
    #end
    
    #puts errors.to_yaml
    
  end
  
  # ----------------------------------------------------------------
  # - Clone the desired contact info data into the mailout contact -
  # ----------------------------------------------------------------
  def copy_address_details(mailout_contact, contactinfo)
    #mailout_contact = MailoutContact.new
    
    # as per db schema, the contact info can be empty
    contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo ) unless contactinfo.default_contactinfo.blank?
	
	if !contactinfo.blank?
      mailout_contact.building      = contactinfo.building
      mailout_contact.street        = contactinfo.street
      mailout_contact.po_box        = contactinfo.po_box
      mailout_contact.locality      = contactinfo.locality
      mailout_contact.suburb        = contactinfo.suburb
      mailout_contact.postcode      = contactinfo.postcode
      mailout_contact.region        = contactinfo.region.region_name unless contactinfo.region.blank?
      mailout_contact.country       = contactinfo.country.country_name unless contactinfo.country.blank?
      mailout_contact.fax           = contactinfo.phone_fax #FIXME add prefix 
      mailout_contact.mobile_sms    = contactinfo.phone_mobile
      
      # get existent email address to the model
      if contactinfo.email_1 != nil
        mailout_contact.email = contactinfo.email_1
      else
        if contactinfo.email_2 != nil
          mailout_contact.email = contactinfo.email_2
        else
          mailout_contact.email = contactinfo.email_3
        end
      end
      
      # get existent phone to the model
      if contactinfo.phone != nil
        mailout_contact.phone = contactinfo.phone
      else
        mailout_contact.phone = contactinfo.phone_alt
      end
    
    end
    
    mailout_contact.generate_address_lines
    
    return mailout_contact
  
  end
  
  # -----------------------------------
  # - Return an array of contacts     -
  # - that have failed email delivery -
  # -----------------------------------
  def failed_email_delivery_contacts
  
    failed_email_delivery_contacts = Array.new   
  
    mailout_contacts.each do |mc|
      failed_email_delivery_contacts.push(mc) if !mc.delivery_timestamp.blank? && mc.delivery_failed
    end
    
    return failed_email_delivery_contacts
  end

end

class CampaignMailoutException < Exception
end


