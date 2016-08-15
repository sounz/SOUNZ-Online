class Contactinfo < ActiveRecord::Base
  set_primary_key :contactinfo_id
  
  
  EMAIL_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
 
  # relationship with default_contactinfo
  # although db schema allows one to many relationship
  # we restrict it to one for simplicity
  has_one :default_contactinfo 

  # this is to show the relationship with organisation
  has_one :organisation
  belongs_to :region
  
  # this is to show the relationship with roles
  has_one :role_contactinfo
  
  has_one :event
    
  belongs_to :communication_method
  
  # this is to show the relationship with region and country
  belongs_to :region
  belongs_to :country
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
            
  
  # validation of the model
  validates_format_of(:email_1, 
                      :with => EMAIL_REGEX,
                      :message=> "has an invalid format",
                      :if => ModelHelper.only_check_if_not_empty(:email_1))
  validates_format_of(:email_2, 
                      :with => EMAIL_REGEX,
                      :message=> "has an invalid format",
                      :if => ModelHelper.only_check_if_not_empty(:email_2))
  validates_format_of(:email_3, 
                      :with => EMAIL_REGEX,
                      :message=> "has an invalid format",
                      :if => ModelHelper.only_check_if_not_empty(:email_3))
  

  # extra attributes for Contactinfo object
  # needed in failed orders processing - failed_orders_controller.rb
  attr_accessor :company, :name
  
    acts_as_solr :fields => [
      :locality_for_solr
    ]
    
    def locality_for_solr
      return FinderHelper.strip(locality)
    end
    
                        
                        
  ##  select = ["dur_sch", "dur_nonsch"]
# conditions = ["floor=1", "model=EPSON"]
#
# your_model.find(:all, :select => select.join(", "), :conditions => conditions.join(" and "))
#FIXME: GBA - I think this should be in a helper method

  def self.find_contacts(organisation_ids, people_ids)
    org_ids = ""
    for org_id in organisation_ids
     org_ids = org_ids +  org_id.to_s + ","
    end
   
    puts org_ids
    query = "select * from contactinfos, organisations, person_contactinfos where organisations.contactinfo_id in (#{org_ids})"
    puts "Query is #{query}"
    return find_by_sql(query)
  end
  
  #----------------------
  #- Details about full_address
  #----------------------
  def full_address
    return "#{street}, #{locality}"
  end
  
  #---------------------------------------------------------------------------
  #- obtain a phone number for search results, in this order
  #- <ul>
  #- <li>landline</li>
  #- <li>mobile</li>
  #- <li>landline alternative</li>
  #- <li>fax</li>
  #- </ul>                                                       -
  #---------------------------------------------------------------------------
  def get_a_phone_number
    result = phone.to_s
    logger.debug "PRETRACE: phone=#{phone}, phone_alt = #{phone_alt}, mobile = #{phone_mobile}, fax = #{phone_fax}"
    logger.debug "TRACE1 #{result}"
    if result.blank?
      result = phone_mobile.to_s
      logger.debug "TRACE2 #{result}"
      
      if result.blank?
        result = phone_alt.to_s
      end
      
      logger.debug "TRACE3 #{result}"
      if result.blank?
        if !phone_fax.to_s.blank?
          result = phone_fax.to_s + " (fax)"
        end
      end
      logger.debug "TRACE4 #{result}"
      
      if result.blank?
        result = "[No phone number]"
      end
      logger.debug "TRACE5 #{result}"
    end
    logger.debug "TRACE6 #{result}"
    result
  end

  #--------------------------------------
  #- Return an email for search results -
  #--------------------------------------
  def get_an_email
    result = email_1
    
    if result.blank?
      result = email_2
            
      if result.blank?
        result = email_3
      end
                 
      if result.blank?
        result = "[No email]"
      end
    end
    
    return result

  end
  
  # Determine whether this contactinfo includes a valid e-mail address
  def valid_email?
    not email_1.blank? or not email_2.blank? or not email_3.blank?
  end
  
  # Determine whether this contactinfo has an e-mail address
  def has_email?
    not email_1.blank? or not email_2.blank? or not email_3.blank?
  end
  
  # Determine whether this contactinfo has a phone
  # without taking into account prefixes or extensions
  def has_phone?
    not phone.blank? or not phone_alt.blank? or not phone_fax.blank? or not phone_mobile.blank?
  end
  
  #Parse the websites line by line and make them into an array
  def get_list_of_websites
    result = []
    result = website_urls.split("\r\n") if !website_urls.blank?
    #logger.debug result.class
    
    
    
    for r in result
      #puts "CHECKING:#{r} of length #{r.length}"
      result.delete(r) if r.strip.starts_with?('#')
      result.delete(r) if r.strip == ''
    end
    
    #puts result.to_yaml
    #puts result.length
    
    
    
    result
  end


# - more complex validation
  def ignore_validate
    #This also fixes the all blank case
    errors.add(:country,"or a region must be specified") if country_id.blank? and region_id.blank?
    
    errors.add(:country,"and a region cant both be specified, one or ther other!") if !country_id.blank? and !region_id.blank?
    
    
    errors.add(:phone, "is not a valid number") if !valid_phone?(phone)
    errors.add(:phone_alt, "is not a valid number") if !valid_phone?(phone_alt)
    errors.add(:phone_mobile, "is not a valid number") if !valid_phone?(phone_mobile)
    errors.add(:phone_fax, "is not a valid number") if !valid_phone?(phone_fax)
    
    
  end
  
  
  def valid_phone?(number)
    result = true
    if !number.blank?
      number.each_char do |character|
        if !'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .+'.include?(character)
          result = false
          break;
        end
      end
    end
    result
  end
  
  # ----------------------------------------------------------------------------
  # - Blank contactinfo fields if appropriate default_contactinfo fields are   -
  # - set to true, as they are going to be read from an associated contactinfo -                                                     -
  # ----------------------------------------------------------------------------
  def override_contactinfo_with_null_values(default_contactinfo)
    
    logger.debug "******** OVERRIDE PERSON CONTACT INFO ***"
    
    self.building               = nil unless !default_contactinfo.d_building
    self.street                 = nil unless !default_contactinfo.d_street
    self.po_box                 = nil unless !default_contactinfo.d_po_box
    self.suburb                 = nil unless !default_contactinfo.d_suburb
    self.locality               = nil unless !default_contactinfo.d_locality
    self.postcode               = nil unless !default_contactinfo.d_postcode
    self.region_id              = nil unless !default_contactinfo.d_region
    self.country_id             = nil unless !default_contactinfo.d_country
    self.email_1                = nil unless !default_contactinfo.d_email_1
    self.email_2                = nil unless !default_contactinfo.d_email_2
    self.email_3                = nil unless !default_contactinfo.d_email_3
    self.website_urls           = nil unless !default_contactinfo.d_website_urls
    # FIXME it is unclear how to deal with phone prefixes and extension, do we just also default them to associated 
    # contactinfo details???
    self.phone_prefix           = nil unless !default_contactinfo.d_phone
    self.phone                  = nil unless !default_contactinfo.d_phone
    self.phone_extension        = nil unless !default_contactinfo.d_phone
    # FIXME currently if d_phone_alt is set to true, extensions and prefixes are also overridden by associated default
    # contactinfo details
    self.phone_alt_prefix       = nil unless !default_contactinfo.d_phone_alt
    self.phone_alt              = nil unless !default_contactinfo.d_phone_alt
    self.phone_alt_extension    = nil unless !default_contactinfo.d_phone_alt
    # FIXME currently if d_phone_fax is set to true, extensions and prefixes are also overridden by associated default
    # contactinfo details
    self.phone_fax_prefix       = nil unless !default_contactinfo.d_phone_fax
    self.phone_fax              = nil unless !default_contactinfo.d_phone_fax
    self.phone_fax_extension    = nil unless !default_contactinfo.d_phone_fax
    # FIXME currently if d_phone_fax is set to true, extensions and prefixes are also overridden by associated default
    # contactinfo details
    self.phone_mobile_prefix    = nil unless !default_contactinfo.d_phone_mobile
    self.phone_mobile           = nil unless !default_contactinfo.d_phone_mobile
    self.phone_mobile_extension = nil unless !default_contactinfo.d_phone_mobile
                  
    logger.debug self.to_yaml
    logger.debug self.errors.to_yaml unless self.save
  
  end
  
  # -------------------------------------------------------------------------------
  # - Clone the contactinfo-to-default data (d_contactinfo_id) into contactinfo   -
  # - based on default_contactinfo fields                                         -
  # - NOTE: it only creates an instance with appropriate fields but does not save -
  # -------------------------------------------------------------------------------
  def initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo )
        
    if !default_contactinfo.blank?
      contactinfo_to_default = self.default_contactinfo.contactinfo_to_default
	  
	  self.get_contactinfo_details_based_on_default_contactinfo(contactinfo_to_default)

   end
   
   return self
   
  end
  
  def get_contactinfo_details_based_on_default_contactinfo(contactinfo_to_default)
	if !contactinfo_to_default.blank?
  		
      self.building               = contactinfo_to_default.building            unless self.default_contactinfo.d_building == false
      self.street                 = contactinfo_to_default.street              unless self.default_contactinfo.d_street == false 
      self.po_box                 = contactinfo_to_default.po_box              unless self.default_contactinfo.d_po_box == false
      self.suburb                 = contactinfo_to_default.suburb              unless self.default_contactinfo.d_suburb == false
      self.locality               = contactinfo_to_default.locality            unless self.default_contactinfo.d_locality == false
      self.postcode               = contactinfo_to_default.postcode            unless self.default_contactinfo.d_postcode == false
      self.region_id              = contactinfo_to_default.region_id           unless self.default_contactinfo.d_region == false
      self.country_id             = contactinfo_to_default.country_id          unless self.default_contactinfo.d_country == false
      self.email_1                = contactinfo_to_default.email_1             unless self.default_contactinfo.d_email_1 == false
      self.email_2                = contactinfo_to_default.email_2             unless self.default_contactinfo.d_email_2 == false
      self.email_3                = contactinfo_to_default.email_3             unless self.default_contactinfo.d_email_3 == false
      self.website_urls           = contactinfo_to_default.website_urls        unless self.default_contactinfo.d_website_urls == false
      self.phone_prefix           = contactinfo_to_default.phone_prefix        unless self.default_contactinfo.d_phone == false
      self.phone                  = contactinfo_to_default.phone               unless self.default_contactinfo.d_phone == false
      self.phone_extension        = contactinfo_to_default.phone_extension     unless self.default_contactinfo.d_phone == false
      self.phone_alt_prefix       = contactinfo_to_default.phone_alt_prefix    unless self.default_contactinfo.d_phone_alt == false
      self.phone_alt              = contactinfo_to_default.phone_alt           unless self.default_contactinfo.d_phone_alt == false
      self.phone_alt_extension    = contactinfo_to_default.phone_alt_extension unless self.default_contactinfo.d_phone_alt == false
      self.phone_fax_prefix       = contactinfo_to_default.phone_fax_prefix    unless self.default_contactinfo.d_phone_fax == false
      self.phone_fax              = contactinfo_to_default.phone_fax           unless self.default_contactinfo.d_phone_fax == false
      self.phone_fax_extension    = contactinfo_to_default.phone_fax_extension unless self.default_contactinfo.d_phone_fax == false
      self.phone_mobile_prefix    = contactinfo_to_default.phone_mobile_prefix    unless self.default_contactinfo.d_phone_mobile == false
      self.phone_mobile           = contactinfo_to_default.phone_mobile           unless self.default_contactinfo.d_phone_mobile == false
      self.phone_mobile_extension = contactinfo_to_default.phone_mobile_extension unless self.default_contactinfo.d_phone_mobile == false  	
    end
	return self
  end
  
  
  #-- Helpers for the views--
  
  #Check whether the contactinfo has some address info, if not dont dont bother rendering a div
  def has_address_information?
    return !(building.blank? and po_box.blank? and suburb.blank? and local.blank? and postcode.blank?)
  end

  
  
  
  #-- Helpers for the views--
  
  #Check whether the contactinfo has some address info, if not dont dont bother rendering a div
  def has_address_information?
    return !(building.blank? and po_box.blank? and suburb.blank? and local.blank? and postcode.blank?)
  end
  
  #-----------------------------------------------------
  #- Return false if any fields except default ones    -
  #- (created_at, updated_at, updated_by, etc) are     -
  #- not empty, this to check if any data has been     -
  #- entered by user and that particular contactinfo   -
  #- was not just creation of the system process       -
  #- as all contactinfos are created automatically with-
  #- role_contactinfos when a role is created          -
  #-----------------------------------------------------
  def is_empty?(check_visual_only = false)
    result = true
              

    result = false unless self.building.blank?
    result = false unless self.street.blank?                 
    result = false unless self.po_box.blank?               
    result = false unless self.suburb.blank?               
    result = false unless self.locality.blank?
    result = false unless self.postcode.blank?
    result = false unless self.region_id.blank?
    result = false unless self.country_id.blank?
    result = false unless self.email_1.blank?
    result = false unless self.email_2.blank?
    result = false unless self.email_3.blank?
    result = false unless self.website_urls.blank?
    result = false unless self.phone_prefix.blank?
    result = false unless self.phone.blank?
    result = false unless self.phone_extension.blank?
    result = false unless self.phone_alt_prefix.blank?
    result = false unless self.phone_alt.blank?
    result = false unless self.phone_alt_extension.blank?
    result = false unless self.phone_fax_prefix.blank?
    result = false unless self.phone_fax.blank?
    result = false unless self.phone_fax_extension.blank?
    result = false unless self.phone_mobile_prefix.blank?
    result = false unless self.phone_mobile.blank?
    result = false unless self.phone_mobile_extension.blank?
    
    if !check_visual_only
      result = false unless self.preferred_comm_method.blank?  
      result = false unless self.internal_note.blank?
    end
    
    return result
    
  end
  
  
  def is_region_and_country_combination_valid?
    result = true
    if !region.blank? and !country.blank?
      result = (region.country_id == country.country_id)
    end
    result
  end
  
  #Create something that might be parseable by google geocoder
  def human_readable_address
    result = ""
    result << street if !street.blank?
    result << ' '
    result << locality if !locality.blank?
    result << ' '
    result << suburb if !suburb.blank?
    result << ' '
    result << region.region_name if !region.blank?
    result << ' '
    x = ContactinfosHelper.get_country_from_country_or_region(self)
    result << x.country_name if !x.blank?
    result << ' '
    
    result

  end
  
  # Processiong that happens after contactinfo is saved:
  # 1) index related objects: Events/RoleContactinfos
  def after_save
  	related_objects = Array.new
	
	related_objects.push(role_contactinfo) unless role_contactinfo.blank?
	related_objects.push(event) unless event.blank?
	
	defaulting_contactinfos.each do |dc|
		related_objects.push(dc.role_contactinfo) unless dc.role_contactinfo.blank?
		related_objects.push(dc.event) unless dc.event.blank?
	end
	
	RoleContactinfo.index_objects(related_objects) unless related_objects.blank?
	
  end
  
  # Return contactinfos that default to that contactinfo
  def defaulting_contactinfos
  	  defaulting_contactinfos = Array.new
	  	    	
	  defaulting_contactinfos = defaulting_contactinfos + DefaultContactinfo.depending_contactinfos(self.contactinfo_id)
	  
      return defaulting_contactinfos
  end

  def before_save
    # if region does not associated with the country, set to nil
    self.send('region_id=', nil) if !is_region_and_country_combination_valid?
  end

end
