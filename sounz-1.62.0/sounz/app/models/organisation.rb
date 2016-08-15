#
# Organisations are part of the CRM. Organisations have either one or two roles
# associated with them. The first role is hidden from the users, and is used to
# link contact information with the organisation. The second role is optional,
# and is for if the organisation is a Contributor.
#
class Organisation < ActiveRecord::Base
  set_primary_key :organisation_id
  
  acts_as_solr :fields => [
                           :organisation_name_for_solr,
                          {:organisation_name_for_solr_as_string => :string},
                          {:organisation_abbrev_for_solr_as_string => :string},
                           :organisation_abbrev_for_solr,
						               :known_as_for_solr,
						               :related_organisation_names_for_solr,
						               :related_organisation_abbrev_for_solr,
                           :internal_note_for_solr,
                           :status_for_solr]

  # used by solr indexing
  def organisation_name_for_solr
    return FinderHelper.strip(organisation_name)
  end
  
  def organisation_name_for_solr_as_string
    return FinderHelper.strip(organisation_name.downcase)
  end
  
  def organisation_abbrev_for_solr
    return FinderHelper.strip(organisation_abbrev)
  end
  
  def organisation_abbrev_for_solr_as_string
    return FinderHelper.strip(organisation_abbrev.downcase) unless organisation_abbrev.blank?
  end
  
  def known_as_for_solr
  	knows_as_for_solr = nil
	organisation_contributor_roles = roles.select{|r| !r.contributor.blank? && r.person.blank?}
	knows_as_for_solr = organisation_contributor_roles.map{|cr| FinderHelper.strip(cr.contributor.known_as_public)}.join(', ') unless organisation_contributor_roles.blank?
	return knows_as_for_solr
  end  
  
  def related_organisation_names_for_solr
    organisation_related_organisations.map{|ro| FinderHelper.strip(ro.organisation_name)}.join(', ')
  end
  
  def related_organisation_abbrev_for_solr
  	organisation_related_organisations.map{|ro| FinderHelper.strip(ro.organisation_abbrev)}.join(', ')  	
  end
  
  def internal_note_for_solr
    return FinderHelper.strip(internal_note)
  end
  
  def status_for_solr
	return status_id
  end
    
  #
  # - Return organisation related organisations if any
  # 
  def organisation_related_organisations
  	organisation_related_organisations = []
    org_related_organisations_ids = related_organisations.collect{|ro| ro.org_organisation_id}.flatten.compact
	
	org_related_organisations_ids.each do |id|
	  related_organisation = Organisation.find(id)
	  organisation_related_organisations.push(related_organisation)
	end
	
	return organisation_related_organisations
  end
  
  #
  # Relationships
  #
  
  # When we say 'many', we mean either one or two. See the class comment
  has_many :roles


  has_many :logins
  
  # Organisations can be related to other organisations
  has_many :related_organisations
     
  # Organisations can have many attachments stored against their record
  has_many :organisation_attachments
  has_many :media_items, :through => :organisation_attachments

  belongs_to :status
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  validates_presence_of :status
  validates_associated :status
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
            
  validates_length_of :organisation_name, :in => 2..100,
    :allow_nil => false,
    :message => "is not between 2 and 100 chars"

  validates_uniqueness_of :legacy4d_identity_code,
    :allow_nil => true,
    :if => ModelHelper.only_check_if_not_empty( :legacy4d_identity_code)
    
  #
  # Creates a new organisation, making sure that it has a default role
  #
  def create_self(role, c_role=nil, login=nil)
    logger.debug "***************************** CS:"
    begin
      transaction do
        puts "**** T1"
        role.organisation = self
        role.updated_by = self.updated_by
        raise if !role.create_self(login)
        #logger.debug "**** T2"
        # create role role_contactinfos and contactinfos
        #role.create_set_of_role_contactinfos
        #if c_role
        #  logger.debug "**** T3"
        #  c_role.organisation = self
        #  saved = c_role.save
        #  logger.debug "Saved c_role:#{saved}"
        #  logger.debug c_role.errors
        #  raise if !c_role.save
        #  logger.debug "**** T4"
        #  # create role role_contactinfos and contactinfos
        #  c_role.create_set_of_role_contactinfos
        #end
      end
    rescue Exception => e
      logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      logger.debug "**** T5"
      return false
    end
    logger.debug "**** T6"
    true
  end

  #
  # Updates an organisation, making sure to add or remove the contributor role
  # as required
  #
  def update_self(organisation, contributor)
    begin
      transaction do
        raise if !update_attributes(organisation)
        #if contributor and !is_contributor?
        #  role = Role.new(:role_type_id => RoleType::CONTRIBUTOR.role_type_id)
        #  role.organisation = self
        #  raise if !role.save
        #elsif !contributor and is_contributor?
        #  Role.delete(contributor_role.role_id)
        #end
      end
    rescue
      return false
    end
    true
  end


  #
  # Return the contributor role for this person, if there is one
  #
  def contributor_role
    roles.select{|r| r.role_type_id == RoleType::CONTRIBUTOR.role_type_id}[0]
  end

  #
  # Returns whether this person is a contributor
  #
  def is_contributor?
    !contributor_role.nil?
  end

  def unrelated_organisations
    related_organisation_ids = related_organisations.collect {|r| r.org_organisation_id}.flatten.uniq.push(organisation_id).join(',')
    if related_organisation_ids.length > 0
      Organisation.find(:all, :conditions => ['organisation_id NOT IN (' + related_organisation_ids + ')'], :order => 'organisation_name')
    else
      Organisation.find(:all, :order => 'organisation_name')
    end
  end

  #
  # Update the contributor record for this person, creating it if it does not
  # yet exist
  #
  def update_contributor_details(data)
    return false if !contributor.update_attributes(data)
    self.contributor = contributor
    save
  end

  #-------------------------------------------------
  #- Return an organisation abbreviation if exists -
  #- or organisation name                          -
  #- NOTE: use of abbreviation is preferred for    -
  #- SOUNZ internal administration                 -
  #-------------------------------------------------
  def organisation_list_name(abbreviation=false)

    if abbreviation
      organisation_list_name = self.organisation_abbrev
    end  
    organisation_list_name = self.organisation_name unless !organisation_list_name.blank?
    
    return organisation_list_name
    
  end

  #-------------------------------------------
  #- Return organisation roles that have or  -
  #- do not have people associated with them -
  #------------------------------------------- 
  def get_organisation_roles(with_people=false)
    if with_people
      roles = Role.find(:all, :conditions => ['organisation_id =? and person_id IS NOT NULL', self.organisation_id])
    else
      roles = Role.find(:all, :conditions => ['organisation_id =? and person_id IS NULL', self.organisation_id])
    end
    return roles
  end
  
  # ----------------------------------------
  # - Update all role role_contactinfos for
  # - solr indexing
  #-----------------------------------------  
  def role_contactinfo_solr_update
	logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: organisation name #{self.organisation_name} roles: #{roles.length}"
	associated_role_contactinfos = Array.new
	
	roles.each do |r|
	  logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: role name #{r.role_name}"
	  #if !r.person.blank?
      #  # save person for solr indexing
      #  r.person.save
      #end
	  r.role_contactinfos.each do |rc|
	    logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: role contactinfo #{rc.contactinfo_type}"
	    associated_role_contactinfos.push(rc)
	  end
	end
	
	logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: associated_role_contactinfos - #{associated_role_contactinfos.length}"
	RoleContactinfo.index_objects(associated_role_contactinfos)	  
	logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE:==================================="
	
  end
  
  #
  # - The sorting order is:
  # - organisation primary role
  # - organisation roles without people associated with them (by role name in alphabetical ASC)
  # - organisation roles with people associated with them (by person's surname in alphabetical ASC)
  #
  def organisation_roles_sorted(active_only=false)
    organisation_roles_sorted = Array.new
	
	organisation_roles_sorted.push(Role.get_organisation_primary_role(self.organisation_id))
	
	organisation_roles_without_people = self.get_organisation_roles.sort_by{ |r| r.role_name}
		
	organisation_roles_without_people.each do |r|
	  organisation_roles_sorted.push(r) unless organisation_roles_sorted.include?(r)
	end
		
	organisation_people_roles = self.get_organisation_roles(with_people='true').sort_by{ |r| r.person.last_name}
	
	organisation_roles_sorted = organisation_roles_sorted + organisation_people_roles
	
	if active_only == true
	 organisation_roles_sorted = organisation_roles_sorted.select{|r| Status.active_statuses.map{|as| as.status_id}.include?(r.status_id)} 
	end
		
	return organisation_roles_sorted
	
  end
  #------------------------------------
  #- A common method for contributors -
  #------------------------------------
  # FIXME; commented out until a need is found for it
  #def contributor_name
  #    organisation_name
  #end
  
  
    #-----------------------------------------------------------------------------------
  #- Using the roles table, find all the people who belong to this organisations
  #-----------------------------------------------------------------------------------
  #def people
  #      return Person.find(:all, :include => :roles, :conditions => ["roles.organisation_id = ?", organisation_id], :order => 'people.person_id')
  #    #    return Person.find(:all, :include => :roles, :conditions => ["roles.organisation_id = ?", 33], :order => :person _id)
  #end

  #def regions
  #  Region.find(:all, :conditions => ['region_id IN (?)', [contactinfo.region_id, roles.collect {|r| r.role_id}].flatten.uniq])
  #end

  #def countries
  #  Country.find(:all, :conditions => ['country_id IN (?)', [contactinfo.country_id, roles.collect {|r| r.role_id}].flatten.uniq])
  #end

  #def valid_email?
  #  contactinfo.valid_email?
  #end

  #  
  ## Java like to string method mainly used for testing
  #def to_string
  #  "ORGANISATION:#{organisation_name}"
  #end
  
  def isLibraryMember
	for login in logins
	  for membership in login.memberships
		if membership.member_type.member_type_desc=='Library Member'
		  return true
		end
	  end
	end
	return false
  end
  
  #find an email address suitable to send library notifications to.
  def getLibraryEmailAddress
	emails=Hash.new()
	
	for role_contactinfo in Role.get_organisation_primary_role(self.id).role_contactinfos
	  contactinfo=role_contactinfo.contactinfo
	  if ! contactinfo.get_an_email.blank?
		if role_contactinfo.preferred
		  emails['preferred']=contactinfo.get_an_email
		else
		  emails['alt']=contactinfo.get_an_email
		end  
	  end 
	end
	  
	if !emails['preferred'].blank?
	  return emails['preferred']
	end
	if !emails['alt'].blank?
	  return emails['alt']
	end
	
	return nil
	
  end

end
