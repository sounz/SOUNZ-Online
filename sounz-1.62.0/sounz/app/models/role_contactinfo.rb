class RoleContactinfo < ActiveRecord::Base
  set_primary_key :role_contactinfo_id
  
  # this is to show the relationship with role and contact info
  belongs_to :role
  belongs_to :contactinfo
  
  has_and_belongs_to_many :saved_contact_lists, :join_table => :saved_role_contactinfos, :order => 'list_name'

  has_many :mailout_contacts
  
  ROLE_CONTACTINFO_TYPES_ARRAY = ['postal', 'physical', 'billing']
  
  # MODEL VALIDATIONS
  # check that 'not null' fields are not nil
  validates_presence_of :role, 
                        :contactinfo,
                        :contactinfo_type,
             :message => "cannot be empty"
  
  # test booleans exist and are non nil
  validates_inclusion_of :preferred, :in => [true, false]
  

  # 
  # Fields that should be stored for role_contactinfos in solr
  #
  # To add a new field:
  #  1) Add data to the fixtures that you want to store. It only has to be
  #     related to role_contactinfos, it doesn't have to be in the role_contactinfos table.
  #  2) Create a method to return this data (optional), and a method named
  #     'fieldname_to_solr' to return it in a string form that solr can index
  #  3) Re-index role_contactinfos, by running RoleContactinfo.rebuild_solr_index in the console
  #  4) Search on the new data
  #
  acts_as_solr :fields => [
    :person_full_name_for_solr,
    {:person_first_names_for_solr_as_string => :string},
    {:person_last_name_for_solr_as_string => :string},
    :organisation_name_for_solr,
    :organisation_abbrev_for_solr,
    {:organisation_name_for_solr_as_string => :string},
    {:organisation_abbrev_for_solr_as_string => :string},
    # NOTE: it's ugly doing these fields as space separated text lists, as this
    # relies on no stemming happening. They should be done as a multivalued
    # integer, but acts_as_solr won't index those.
    :marketing_subcategories_for_solr,
    #:marketing_categories_for_solr,
    :role_type_for_solr,
    :country_for_solr,
    :region_for_solr,
    :locality_for_solr,
    :postcode_for_solr,
    :created_at_for_solr,
    :updated_at_for_solr,
    :role_title_for_solr,
    :saved_contact_lists_for_solr,
    :marketing_campaigns_for_solr,
    :has_person_for_solr,
    :has_contributor_for_solr,
    :has_email_for_solr,
    :has_website_for_solr,
    :has_phone_for_solr,
    :role_contactinfo_membership_types_for_solr,
    :contributor_status_for_solr,
    :role_status_for_solr,
    :contactinfo_is_empty_for_solr,
    #:person_status_for_solr,
    #:organisation_status_for_solr,
    #:person_membership_types_for_solr,
    #:organisation_membership_types_for_solr,
    :internal_note_for_solr,
    :person_internal_note_for_solr,
	:types_for_solr   
  ]  

  #
  # Returns role_contactinfo person first name
  #
  def person_full_name_for_solr
    return FinderHelper.strip(role.person.full_name) unless role.person.blank?
  end 
  
  #
  # Returns role_contactinfo person first name
  #
  def person_first_names_for_solr_as_string
    return FinderHelper.strip(role.person.first_names.downcase)  unless role.person.blank?
  end
  
  #
  # Returns role_contactinfo person last name
  #  
  def person_last_name_for_solr_as_string
    return FinderHelper.strip(role.person.last_name.downcase)  unless role.person.blank?
  end
  
  #
  # Returns role contactinfo organisation name if any
  #
  def organisation_name_for_solr
    return FinderHelper.strip(role.organisation.organisation_name) unless role.organisation.blank?
  end
  
  #
  # Returns role_contactinfo organisation_abbrev if any
  #
  def organisation_abbrev_for_solr_as_string
    if !role.organisation.blank?
      return FinderHelper.strip(role.organisation.organisation_abbrev.downcase) unless role.organisation.organisation_abbrev.blank?
    end
  end
  
  def organisation_name_for_solr_as_string
    return FinderHelper.strip(role.organisation.organisation_name.downcase) unless role.organisation.blank?
  end
  
  #
  # Returns role_contactinfo organisation_abbrev if any
  #
  def organisation_abbrev_for_solr
    if !role.organisation.blank?
      return FinderHelper.strip(role.organisation.organisation_abbrev) unless role.organisation.organisation_abbrev.blank?
    end
  end
  
  #
  # Returns role type for this role contactinfo
  #
  def role_type_for_solr
    role.role_type_id
  end

 
  #
  # Returns role_contactinfo country
  #
  def country_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return contactinfo.country.country_id unless contactinfo.country.blank?
  end

  #
  # Returns role_contactinfo region
  #
  def region_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return contactinfo.region.region_id unless contactinfo.region.blank?
  end

  #
  # Returns what locality this role_contactinfo is in
  #
  def locality_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return FinderHelper.strip(contactinfo.locality) unless contactinfo.locality.blank?
  end

  #
  # Returns role_contactinfo postcode
  #
  def postcode_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return FinderHelper.strip(contactinfo.postcode) unless contactinfo.postcode.blank?
  end
  
  #
  # Returns marketing subcategories this role_contactinfo is assigned to through role
  #
  def marketing_subcategories
    role.role_categorizations.collect{|rc| rc.marketing_subcategory}.flatten.compact
  end
  
  #
  # Returns marketing subcategories for this role_contactinfo in a string format that
  # solr can store
  #
  def marketing_subcategories_for_solr
    
  	# if the person's role has an organisation
  	# the role contactinfo gets organisation marketing categorisation
  	if !role.person.blank? && !role.organisation.blank?
  	  organisation_primary_role = Role.get_organisation_primary_role(role.organisation.organisation_id)
	  categorisation = organisation_primary_role.role_categorizations.collect{|rc| rc.marketing_subcategory}.flatten.compact.collect{|s| s.marketing_subcategory_id}.join(' ')
  	else
  	  categorisation = marketing_subcategories.collect{|s| s.marketing_subcategory_id}.join(' ')
	end
	
	return FinderHelper.strip(categorisation)
  end
  
  #
  # Returns marketing categories this role_contactinfo is assigned to through role
  #
  #def marketing_categories
  #  marketing_subcategories.collect{|ms| ms.marketing_category}.flatten.compact
  #end
  
  #
  # Returns marketing categories for this role_contactinfo in a string format that
  # solr can store
  #
  #def marketing_categories_for_solr
  #  marketing_categories.collect{|s| s.marketing_category_id}.join(' ')
  #end
    
  #
  # Returns the created_at data of the role_contactinfo contactinfo in a form that solr can store
  #
  def created_at_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return FinderHelper.strip(contactinfo.created_at.to_i)
  end
  
  #
  # Returns the last updated data of the role_contactinfo contactinfo in a form that solr can store
  #
  def updated_at_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    return FinderHelper.strip(contactinfo.updated_at.to_i)
  end
  
  #
  # Returns the role_contactinfo role_title
  #
  def role_title_for_solr
    return FinderHelper.strip(role.role_title)
  end
  
  #
  # Returns the role_contactinfo saved_contact_list in a form that solr can store
  #
  def saved_contact_lists_for_solr
    return saved_contact_lists.collect{ |scl| FinderHelper.strip(scl.list_name)}.join(' ')
  end
  
  #
  # Returns marketing campaigns this role_contactinfo is assigned to through mailout_contacts
  #
  def marketing_campaigns_for_solr
    return mailout_contacts.collect{ |mc| FinderHelper.strip(mc.campaign_mailout.marketing_campaign.campaign_name)}.flatten.compact.join(', ')
  end
  

  #
  # Returns whether this role_contactinfo has a person associated with it in a form that solr can store
  #
  def has_person_for_solr
    role.person.blank? ? 0 : 1
  end
  
    
  #
  # Returns whether this role_contactinfo has a contributor associated with it in a form that solr can store
  #
  def has_contributor_for_solr
    role.contributor.blank? ? 0 : 1
  end
  
  #
  # Returns whether this role_contactinfo has an email associated with it in a form that solr can store
  #
  def has_email_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    contactinfo.has_email? ? 1 : 0
  end

  
  #
  # Returns whether this role_contactinfo has an email associated with it in a form that solr can store
  #
  def has_website_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    contactinfo.get_list_of_websites.blank? ? 0 : 1
  end
  
  #
  # Returns whether this role_contactinfo has a phone associated with it in a form that solr can store
  #
  def has_phone_for_solr
    # if there is a default_contactinfo for that role_contactinfo contactinfo
    # initialize contactinfo based on default_contactinfo fields and then
    # index the contactinfo field to default
    if contactinfo.default_contactinfo
      contactinfo.initialize_contactinfo_associated_with_another_contactinfo( contactinfo.default_contactinfo )
    end
    contactinfo.has_phone? ? 1 : 0
  end
  
  #
  # Returns role_contactinfo person status if a person is associated with that it 
  # in a form that solr can store
  # 
  def person_status_for_solr
    return FinderHelper.strip(role.person.status.status_id) unless role.person.blank?
  end
  
  #
  # Returns role_contactinfo organisation status if an organisation is associated with it
  # in a form that solr can store
  # 
  def organisation_status_for_solr
    return FinderHelper.strip(role.organisation.status.status_id) unless role.organisation.blank?
  end
  
  #
  # Returns role_contactinfo person membership types if a person is associated with it
  # 
  def person_membership_types
    if !role.person.blank?
      if !role.person.logins.blank?
        role.person.logins.collect{ |pl| pl.memberships.collect{ |pm| pm.member_type}}.flatten.compact
      end
    end
  end
  
  #
  # Returns person_membership_types
  # in a form that solr can store
  #
  def person_membership_types_for_solr
    return person_membership_types.collect{ |pm| FinderHelper.strip(pm.member_type_id)}.join(' ') unless person_membership_types.blank?
  end
  
  #
  # Returns role_contactinfo organisation membership types if an organisation is associated with it
  #
  def organisation_membership_types
    if !role.organisation.blank?
      if !role.organisation.logins.blank?
        role.organisation.logins.collect{ |pl| pl.memberships.collect{ |pm| pm.member_type}}.flatten.compact
      end
    end
  end
  
  #
  # Returns organisation_membership_types
  # in a form that solr can store
  #
  def organisation_membership_types_for_solr
    return organisation_membership_types.collect{ |pm| FinderHelper.strip(pm.member_type_id)}.join(' ') unless organisation_membership_types.blank?
  end
  
  #
  # Returns role_contactinfo membership types by combining related person and organisation
  # membership types in a form that solr can store
  #
  def role_contactinfo_membership_types_for_solr
    role_contactinfo_membership_types = []
    if !organisation_membership_types_for_solr.blank?
      role_contactinfo_membership_types.push(organisation_membership_types_for_solr)
    end
    if !person_membership_types_for_solr.blank?
      role_contactinfo_membership_types.push(person_membership_types_for_solr)
    end
    role_contactinfo_membership_types = role_contactinfo_membership_types.join(' ')
    return role_contactinfo_membership_types unless role_contactinfo_membership_types.blank?
  end
  
  #
  # Returns status of the role associated with this role_contactinfo in a form that solr can store
  #
  def role_status_for_solr
    return role.status_id
  end
  
  #
  # Determines whether the role contactinfo contacinfo is empty or not
  # (for definition of 'emptyness' in regards with contactinfo, see
  # is_empty? in contactinfo.rb)
  # 
  def contactinfo_is_empty_for_solr
    contactinfo.is_empty? ? 1 : 0 
  end
  
  #
  # Returns role_contactinfo contactinfo internal note
  # in a form that solr can store
  # 
  def internal_note_for_solr
    return FinderHelper.strip(contactinfo.internal_note) unless contactinfo.internal_note.blank?
  end
  
  #
  # Returns role.person.internal_note
  # in a form that solr can store
  # 
  def person_internal_note_for_solr
    return FinderHelper.strip(role.person.internal_note) unless role.person.nil?
  end
  
  #
  # Returns status of the contributor role associated with that role_contactinfo if any
  # in a form that solr can store
  # 
  def contributor_status_for_solr
    return FinderHelper.strip(role.contributor.status.status_id) unless role.contributor.blank?
  end
  
  # WR#50306
  def types_for_solr
  	types = Array.new
	types.push(FinderHelper.strip(contactinfo_type))
	
	types.push('preferred') if preferred == true
    
	return types.join(', ')
  end
    
  def self.get_role_contactinfo_types_array
    return ROLE_CONTACTINFO_TYPES_ARRAY
  end

  #-------------------------------------------
  #- Return a flag (currently only '(c)'     -
  #- if person/organisation is a contributor -
  #-------------------------------------------
  def preferred_role_contactinfo_flag
    preferred_role_contactinfo_flag = nil
    preferred_role_contactinfo_flag = '(p)' unless !self.preferred
    return preferred_role_contactinfo_flag
  end
  
  # - Return a flag-icon (html) based on the contactinfo type
  def contactinfo_type_icon
	result = ""
	result = "/icons/#{self.contactinfo_type}.gif"
		  
	if !result.blank?
	  icon_message = result.gsub('/icons/', '')
	  icon_message.gsub!('.gif', '')
	  
	  html ='<img src="'
	  html << result
	  html << " \" alt = \"#{icon_message}\""
	  html << "title = \"#{icon_message}\""
	  html << ' >'
	  result = html
	end
	return result  
  end
  
end
