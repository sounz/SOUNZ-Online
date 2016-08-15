class MailoutContact < ActiveRecord::Base
  set_primary_key :mailout_contact_id
  
  belongs_to :campaign_mailout
  
  belongs_to :role_contactinfo
 
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
  
  # validation of the model
  validates_presence_of :campaign_mailout_id,
                        :updated_by,
                :message => "cannot be empty"
  
  # Test booleans exist and are non nil
  validates_inclusion_of :delivery_failed, :in => [true, false]
  
  # compares mailout_contacts by 'name' for sorting
  def <=>(other_mailout_contact)
    self.name <=> other_mailout_contact.name
  end
  
  # --------------------------------------------------------------------------
  # - Return a flag - either '(s)' to show that the email is sent to contact - 
  # - or '(f)' to show delivery failure                                      -
  # --------------------------------------------------------------------------
  def mailing_result_for_ui
    result = nil
    
    result = '(s)' unless delivery_timestamp.blank? || delivery_failed
    result = '<span class="errorExplanation">(f)</span>' if !delivery_timestamp.blank? && delivery_failed
    
    return result
  end
  
  # -------------------------------------------------------------
  # - Generate address lines based
  # - on the existent address and role info.
  # - 'address_line_*' fields are used to compose 
  # - an address with fields being filled top-downwards 
  # - with no blank fields except those left over at the bottom.
  # - Processing differs between person and company - 
  # - if a person is associated with an organisation
  # - we include a role title and organisation name
  # - Post code has also a special processing and is appended 
  # - either to suburb (if locality is blank) or locality
  # -------------------------------------------------------------
  def generate_address_lines
    
    address_lines = Array.new
    
    contact_name_s = [self.nomen, self.name].join(' ')
	
	# Scilla's note of 05/02/2008 WR#50406
	# role_title is added to contact's name
	contact_name_s = contact_name_s + ', ' + self.role_title unless self.role_title.blank?
    
	address_lines.push(contact_name_s.strip) if !contact_name_s.blank?
    
    #role_s = [self.role_title, self.organisation_name].join(' ')
    #address_lines.push(role_s.strip) if !role_s.blank?
        
    address_lines.push(self.organisation_name) unless self.organisation_name.blank?
    
    # po box exists?
    if self.po_box.blank?
      address_lines.push(self.building) unless self.building.blank?
      address_lines.push(self.street) unless self.street.blank?
    else
      address_lines.push(self.po_box)
    end
    
    if self.locality.blank?
      suburb_postcode_s = [self.suburb, self.postcode].join(' ')
      address_lines.push(suburb_postcode_s.strip) unless suburb_postcode_s.blank?
    else
      address_lines.push(self.suburb) unless self.suburb.blank?
      locality_postcode_s = [self.locality, self.postcode].join(' ')
      address_lines.push(locality_postcode_s.strip) unless locality_postcode_s.blank?
    end
    
    address_lines.push(self.country) unless self.country.blank? || self.country.match('New Zealand')
    
    #logger.debug "***** GENERATE ADDRESS LINES address_lines #{address_lines} "
    
    self.address_line1 = address_lines[0] 
    self.address_line2 = address_lines[1]
    self.address_line3 = address_lines[2]
    self.address_line4 = address_lines[3]
    self.address_line5 = address_lines[4]
    self.address_line6 = address_lines[5]
    self.address_line7 = address_lines[6]
    
    #logger.debug self.to_yaml
        
  
  end
  
  # ----------------------------------
  # - Update mailout contact details -
  # ----------------------------------
  def update_self(mailout_contact)
    
    if update_attributes(mailout_contact)
      self.generate_address_lines
      
      self.save
    end
    
  end
  
end
