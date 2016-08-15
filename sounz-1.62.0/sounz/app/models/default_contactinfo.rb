class DefaultContactinfo < ActiveRecord::Base
  set_primary_key :default_contactinfo_id
  
  # this is to show the relationship with contactinfos
  belongs_to :contactinfo

  # model validation
  validates_presence_of :contactinfo_id,
                        :d_contactinfo_id,
            :message => "cannot be empty"
  
  # Test booleans exist and are non nil
  validates_inclusion_of :d_building,
                         :d_region,
                         :d_country,
                         :d_street,
                         :d_po_box,
                         :d_suburb,
                         :d_locality,
                         :d_postcode,
                         :d_email_1,
                         :d_email_2,
                         :d_email_3,
                         :d_website_urls,
                         :d_phone,
                         :d_phone_alt,
                         :d_phone_fax,
                         :d_phone_mobile,  
                     :in => [true, false]
                     
  # Return contactinfo to default already initialized to its contactinfo to default if any
  def contactinfo_to_default
    contactinfo_to_default = Contactinfo.find(self.d_contactinfo_id)
	
	if !contactinfo_to_default.default_contactinfo.blank? && !contactinfo_to_default.default_contactinfo.contactinfo_to_default.blank?
	  contactinfo_to_default.initialize_contactinfo_associated_with_another_contactinfo(contactinfo_to_default.default_contactinfo) 
	end
	return contactinfo_to_default
  end
  
  # Return all contactinfos that have the d_contactinfo_id as per param
  def self.depending_contactinfos(contactinfo_id)
  	depending_contactinfos = Array.new
  	default_contactinfos = DefaultContactinfo.find(:all, :conditions => ['d_contactinfo_id =?', contactinfo_id])
	
	default_contactinfos.each do |dc|
	  dc_contactinfo = Contactinfo.find(dc.contactinfo_id)
	  depending_contactinfos.push(dc_contactinfo)
	  
	  depending_contactinfos = depending_contactinfos + dc_contactinfo.defaulting_contactinfos
	end
	
	return depending_contactinfos
  end
  
  #- Update default_contactinfo boolean field by field based on params - 
  def self_update(params)
    #logger.debug "*** DEFAULT_CONTACTINFO SELF_UPDATE"
    
	self.attribute_names.each do |attribute|
	  
	  if attribute.to_s.match(/\b(d_)/)  	
	  	if params[attribute.to_sym] && (self.send(attribute) == true || self.send(attribute) == false)
		  	self.send("#{attribute}=", 't')
			
		elsif params[attribute.to_sym] != true && (self.send(attribute) == true || self.send(attribute) == false)
		  	self.send("#{attribute}=", 'f')
		end 
	  end
	
	end   	
       
    #logger.debug self.to_yaml
    self.save
  end
  
  # - Set object values based on params
  #   the method does not save the object
  def set_values(params)
      #logger.debug "***** SET VALUES params #{params} ***"
	  params.each do |parameter|
		attribute_name  = parameter[0]
		parameter_value = parameter[1]
		
		if attribute_name.to_s.match(/\b(d_)/)
		  logger.debug "DEBUG: attribute_name.to_s.match(/\b(d_)/) #{attribute_name.to_s.match(/\b(d_)/)}"
		  if parameter_value == "1"
		  	self.send("#{attribute_name}=", 't')
		  else
		  	self.send("#{attribute_name}=", 'f')
		  end
		end
	  end
	  
	  #logger.debug self.to_yaml
	  return self
  end

  
  #----------------------------------
  #- Create new default_contactinfo -
  #----------------------------------
  def self_create_from_existent_contactinfo(contactinfo, d_contactinfo)
    if !contactinfo.blank? && !d_contactinfo.blank?
      self.contactinfo_id   = contactinfo.contactinfo_id
      self.d_contactinfo_id = d_contactinfo.contactinfo_id
      
      # check every contactinfo field
      # if it is not empty set 
      # appropriate default_contactinfo field to 'false'
      self.d_building     = 'f' unless contactinfo.building.blank?
      self.d_region       = 'f' unless contactinfo.region_id.blank?
      self.d_country      = 'f' unless contactinfo.country_id.blank?
      self.d_street       = 'f' unless contactinfo.street.blank?
      self.d_po_box       = 'f' unless contactinfo.po_box.blank?
      self.d_suburb       = 'f' unless contactinfo.suburb.blank?
      self.d_locality     = 'f' unless contactinfo.locality.blank?
      self.d_postcode     = 'f' unless contactinfo.postcode.blank?
      self.d_email_1      = 'f' unless contactinfo.email_1.blank?
      self.d_email_2      = 'f' unless contactinfo.email_2.blank?
      self.d_email_3      = 'f' unless contactinfo.email_3.blank?
      self.d_website_urls = 'f' unless contactinfo.website_urls.blank?
      # FIXME precise the logic for phones
      self.d_phone        = 'f' unless contactinfo.phone.blank?
      self.d_phone_alt    = 'f' unless contactinfo.phone_alt.blank?
      self.d_phone_fax    = 'f' unless contactinfo.phone_fax.blank?
      self.d_phone_mobile = 'f' unless contactinfo.phone_mobile.blank?
      
      logger.debug self.errors.to_yaml unless self.save
      #self.save
    end
  end
  
end