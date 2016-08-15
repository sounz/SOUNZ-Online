#
# People are part of the CRM. People can have roles, that are optionally (but
# usually) attached to organisations. Communications can happen with these
# roles. People can also be contributors
#
class Person < ActiveRecord::Base
  set_primary_key :person_id
  
  # 
  # Fields that should be stored for people in solr
  #
  # To add a new field:
  #  1) Add data to the fixtures that you want to store. It only has to be
  #     related to people, it doesn't have to be in the people table.
  #  2) Create a method to return this data (optional), and a method named
  #     'fieldname_to_solr' to return it in a string form that solr can index
  #  3) Re-index people, by running Person.rebuild_solr_index in the console
  #  4) Search on the new data
  # FIXME: Eventually, should search all of the address information for the person as well
  #
  acts_as_solr :fields => [
                            :first_names_for_solr, 
							              :last_name_for_solr,
							             {:first_names_for_solr_as_string => :string},
						               {:last_name_for_solr_as_string => :string},
                            :full_name_for_solr,
							              :known_as_for_solr,
                            :organisations_for_solr,
							              :status_for_solr
    # TODO to delete later together with the appropriate methods -
    # currently we do not index the fields below as
    # advanced contacts search uses role_contactinfos indexes
    # 
    # NOTE: it's ugly doing these fields as space separated text lists, as this
    # relies on no stemming happening. They should be done as a multivalued
    # integer, but acts_as_solr won't index those.
    #:marketing_subcategories_for_solr,
    #:marketing_categories_for_solr,
    #:role_types_for_solr,
    #:countries_for_solr,
    #:regions_for_solr,
    #:valid_email_for_solr,
    #:created_at_for_solr,
    #:updated_at_for_solr,
    #:status_id,
    #:role_titles_for_solr,
    #:localities_for_solr,
    #:postcodes_for_solr
    #{:valid_email => :string},
  ]

  # used for solr indexing
  def first_names_for_solr
    return FinderHelper.strip(first_names)
  end
  
  def last_name_for_solr
    return FinderHelper.strip(last_name)
  end
  
  def first_names_for_solr_as_string
	return FinderHelper.strip(first_names.downcase)
  end
	
  def last_name_for_solr_as_string
	return FinderHelper.strip(last_name.downcase)
  end
  
  def known_as_for_solr
	knows_as_for_solr = nil
	person_contributor_roles = roles.select{|r| !r.contributor.blank? && !r.person.blank?}
	knows_as_for_solr = person_contributor_roles.map{|cr| FinderHelper.strip(cr.contributor.known_as_public)}.join(', ') unless person_contributor_roles.blank?
	return knows_as_for_solr
  end
  
  def status_for_solr
	return status_id
  end  

  def full_name_for_solr
    return FinderHelper.strip(full_name.downcase)
  end

  #
  # Relationships
  #
  
  # People have a published status
  belongs_to :status

  # People have a nomen
  belongs_to :nomen

  # People can optionally be a contributor
  #belongs_to :contributor

  # People can have many roles, which are usually connected to organisations
  has_many :roles, :order => :role_title

  # People can be in a project
  has_many :project_team_members
  has_many :projects, :through => :project_team_members

  # Not sure what this is for at this time
  has_many :logins

  # To be documented :)
  has_many :marketing_campaigns
     
  # People can have many items attached to their record
  has_many :person_attachments
  has_many :media_items, :through => :person_attachments
  


  # Old relationships
  #has_and_belongs_to_many :marketing_subcategories, :join_table => :people_categorizations
  
   
  #
  # Model validation
  # FIXME: need checking to see that they comply with reality now!
  #
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
             :class_name => 'Login',
             :foreign_key => :updated_by
  
  # validation of the model
  validates_presence_of :last_name, 
  :message => "cannot be empty" #:apra_member,
  
  #Test booleans exist and are non nil
  validates_inclusion_of :deceased, :in => [true, false]
  validates_inclusion_of :apra_member, :in => [true, false]
  
  
  #import data often does not specify gender, must be null-enabled
  validates_inclusion_of :gender, :allow_nil => true, :in => ['M','F', 'U']
  
  validates_uniqueness_of :legacy4d_identity_code,
  :allow_nil => true,
  :if => ModelHelper.only_check_if_not_empty( :legacy4d_identity_code)
  
  
  
  validates_length_of :first_names, :in => 2..100,
  :allow_nil => true,
  :message => "is not between 2 and 100 chars",
  :if => ModelHelper.only_check_if_not_empty( :first_names)
  #  :if => Proc.new {|model| (model.first_names.length > 0)}
  
  
  
  validates_length_of :known_as, :in => 2..100,
  :allow_nil => true,
  :message => "is not between 2 and 100 chars",
  :if => ModelHelper.only_check_if_not_empty( :known_as)
  
  
  validates_length_of :last_name, :in => 2..100,
  :allow_nil => false,
  :message => "is not between 2 and 100 chars"
  
  
  
  
  
  
  # FIXME: what is this method for anyway?
  #def self.testing(*args)
  #  puts "**** ARGS IS #{args}"
  #  return true
  #end
  
  #validates_numericality_of :name, :if => Proc.new { |item| (item.name.length > 0) }
  
  
 def validate
    if deceased
      if year_of_death == nil
        errors.add(:year_of_death, "cannot be deceased and have no date of death")
      end
    end
    
    if !year_of_birth.blank? and !year_of_death.blank?
      if year_of_death < year_of_birth
        errors.add(:year_of_death, "must be after date of birth")
      end
    end
 end
 
 
  
  #
  # Returns the full name of the person
  #
  def full_name
    result = ''
    result = first_names unless first_names.blank?
    result += ' ' if !result.blank?
    result += last_name
    result
  end

  # 
  # Returns organisations for this person
  #
  def organisations
    roles.collect{|r| r.organisation }.flatten.compact   
  end
  
  #
  # Returns person's organisations  in a string format that solr can store
  # 
  def organisations_for_solr
    return FinderHelper.strip(organisations.collect{ |o| o.organisation_id}.join(' '))
  end
  
  # This method refreshes person roles by including just created
  # roles (we need specifically define it, otherwise, person.roles
  # do not return newly created roles...)
  # DO NOT DELETE IT!!!! it is needed for solr idexing
  def roles
    roles = Role.find(:all, :conditions => ['person_id =?', self.person_id])
  end
  
  #
  # Returns roles for this person in a string format that solr can store
  #
  def role_types_for_solr
    roles.collect{|r| r.role_type_id}.join(' ')
  end

  #
  # Returns what countries this person is in
  #
  def countries
    roles.collect{|r| r.role_contactinfos.collect{|rc| rc.contactinfo}.collect{|c| c.country} }.flatten.compact
  end

  #
  # Returns countries for this person in a string format that solr can store
  #
  def countries_for_solr
    countries.collect{|c| c.country_id}.join(' ')
  end

  #
  # Returns what regions this person is in
  #
  def regions
    roles.collect{|r| r.role_contactinfos.collect{|rc| rc.contactinfo}.collect{|c| c.region} }.flatten.compact
  end

  #
  # Returns regions for this person in a string format that solr can store
  #
  def regions_for_solr
    regions.collect{|r| r.region_id}.join(' ')
  end

  #
  # Returns what localities this person is in in a string format that solr can store
  #
  def localities_for_solr
    roles.collect{|r| r.role_contactinfos.collect{|rc| rc.contactinfo}.collect{|c| FinderHelper.strip(c.locality)} }.join(' ')
  end

  #
  # Returns what postcodes this person is in in a string format that solr can store
  #
  def postcodes_for_solr
    roles.collect{|r| r.role_contactinfos.collect{|rc| rc.contactinfo}.collect{|c| c.postcode} }.join(' ')
  end
  
  #
  # Returns marketing subcategories this person is assigned to through roles
  #
  def marketing_subcategories
    roles.collect{ |r| r.role_categorizations.collect{|rc| rc.marketing_subcategory} }.flatten.compact
  end
  
  #
  # Returns marketing subcategories for this role in a string format that
  # solr can store
  #
  def marketing_subcategories_for_solr
    marketing_subcategories.collect{|s| s.marketing_subcategory_id}.join(' ')
  end
  
  #
  # Returns marketing subcategories this person is assigned to through roles
  #
  def marketing_categories
    roles.collect{ |r| r.role_categorizations.collect{|rc| rc.marketing_subcategory}.collect{|ms| ms.marketing_category} }.flatten.compact
  end
  
  #
  # Returns marketing subcategories for this role in a string format that
  # solr can store
  #
  def marketing_categories_for_solr
    marketing_categories.collect{|s| s.marketing_category_id}.join(' ')
  end
     
  #
  # Returns whether this person has a valid e-mail address associated with them
  def valid_email?
    not roles.collect{ |r| r.role_contactinfos.collect{|rc| rc.contactinfo}.select{|c| c.valid_email?} }.empty?
  end

  #
  # Returns whether this person has a valid e-mail address in a form that solr
  # can store
  #
  def valid_email_for_solr
    valid_email? ? 1 : 0
  end

  #
  # Returns the last updated data of this person in a form that solr can store
  #
  def created_at_for_solr
    created_at.to_i
  end
  
  #
  # Returns the last updated data of this person in a form that solr can store
  #
  def updated_at_for_solr
    updated_at.to_i
  end
  
  #
  # Returns the role_titles of this person in a form that solr can store
  #
  def role_titles_for_solr
   roles.collect{|r| FinderHelper.strip(r.role_title)}.uniq.join(' ')
  end

  # Adds a communication to this person
  #def add_communication(communication, role)
  #  
  #  transaction do
  #    #if the communication has not previously been saved in the database it will not have an id
  #    #and thus you cannot create a linking object
  #    return if !communication.save
  #    
  #    
  #    role_id = nil
  #    info = "None"
  #    if role != nil
  #      role_id = role.role_id
  #      info = Role.find(role_id).to_string
  #    end
  #    
  #    communication_people = CommunicationPerson.create(
  #                                                      :role_information => info,
  #                                                      :communication_id => communication.communication_id,
  #                                                      :person_id        => person_id
  #    );
  #    
  #    puts "Created cp with details #{communication_people.attributes}"
  #    # return if !communication_people.save
  #    
  #    save
  #  end
  #  
  #  return true
  #end
  #
  #
  ## Handle updating of communications
  ## This involves
  ## <ul><li>Saving the existing communication whose attributes have just been updated</li>
  ## <li>Updating the associated role</li>
  ## </ul>
  ## Note a person only has one role in conjucntion with a communication
  #def update_communication_waawaa(communication, role_id)
  #  transaction do
  #    return if !communication.save
  #    
  #    communication_person = communication.person
  #    if communication_person.role_id != role_id.to_i
  #      # Update the communication person record
  #      communication_person.role_id = role_id.to_i
  #      return if !communication_person.save
  #    end
  #    
  #    save
  #  end
  #  
  #  return true
  #end
  #
  #
  ##FIXME: GBA - this version does not use transactions but plays nicer with error messages.  
  #def update_communication(communication, role_id)
  #  communication_person_link = communication.person
  #  role_information = "None"
  #  if role_id != nil and role_id.to_i != 0
  #    role_information = Role.find(role_id).to_string
  #  end
  #  communication_person_link.role_information= role_information
  #  logger.debug "#### Communication person link set to '#{role_information}'"
  #  communication_person_link.save
  #end
  #
  #
  #
  #def jobs
  #  roles.collect {|r| [r.role_title + ' - ' + r.organisation.organisation_name, r.role_id]}
  #end


  #
  # Return the contributor role for this person, if there is one
  #
  def contributor_roles
    contrib_roles=[]
    for role in roles
      if role.contributor != nil
      contrib_roles << role
      end
    end
    return contrib_roles
  end
  
  #
  # Returns whether this person is a contributor
  #
  def is_contributor?
    has_contrib_role=false
    for role in roles
      if role.contributor != nil
      has_contrib_role = true  
      end
    end
    return has_contrib_role
  end

  # Return the persons age from time of now, or their age at time of death
  def age
    if deceased
      years = (year_of_death-year_of_birth).to_i / 365
    else
      years = (Time.now.year - year_of_birth.year)
    end
    
    return years
  end


  #
  # Save this person's information, including role and contact information if
  # this is a new person
  #
  def create_self(role, login)

    begin
      transaction do
        raise if !self.save
        role.person = self
        role.updated_by = self.updated_by
        raise if !role.create_self(login)
      end
    rescue
      return false
    end

    return true

  end

  # ----------------------------------------
  # - Update all role role_contactinfos for
  # - solr indexing
  #-----------------------------------------  
  def role_contactinfo_solr_update
    logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: person name #{self.full_name} roles: #{roles.length}"
    associated_role_contactinfos = Array.new
	
	roles.each do |r|
      logger.debug "DEBUG: ROLE_CONTACTINFO_SOLR_UPDATE: role name #{r.role_name}"
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
  # - person Person role
  # - person roles by role name in alphabetical ASC
  #
  def person_roles_sorted(active_only=false)
    person_roles_sorted = Array.new
	
    # role_type 'Person' role
    person_role = Role.find(:first, :joins => "inner join role_types using (role_type_id)",
    	                    :conditions => ['person_id =? and LOWER(role_type_desc) =?', 
    	                    	            self.person_id, 'person'])
	
	
    person_roles_sorted.push(person_role) if !person_role.blank?
    	
	person_roles = self.roles.sort_by{|pr| pr.role_name}
	
	for r in person_roles	
	  person_roles_sorted.push(r) unless person_roles_sorted.include?(r)
	end
	
	if active_only == true
	  person_roles_sorted = person_roles_sorted.select{|r| Status.active_statuses.map{|as| as.status_id}.include?(r.status_id)} 
	end
		
	return person_roles_sorted
	
  end
  
  # Create login record with 'Guest' memberships and person record with 'Person' role
  # and role contact infos for a new user
  def create_web_user(role, login)
  
    begin
	  transaction do
	  	
	  	raise if !self.save
		login.person = self
		raise if !login.save
		login.member_types << MemberType.find(MemberType.memberTypeToId('Guest').id)
		raise if !self.update_attribute('updated_by', login.login_id)
		role.person = self
		role.updated_by = self.updated_by
	    raise if !role.create_self(login)
			
	  end
	  
    rescue
	  return false
    end
    true
	
  end  
    
  #
  # Update the contributor record for this person, creating it if it does not
  # yet exist
  # DEPRECATED - Can't work with the new 'any role can be a contributor' plan
  #def update_contributor_details(data)
  #  return false if !contributor.update_attributes(data)
  #  self.contributor = contributor
  #  save
  #end
  
  #------------------------------------
  #- A common method for contributors -
  #------------------------------------
  # FIXME: Commented out until a need is found for it
  #def contributor_name
  #  #puts "PERSON: KA = #{known_as}"
  #  #puts "PERSON: FULLNAME = #{full_name}"
  #  result = known_as
  #  if result == nil
  #    result = full_name
  #  end
  #  result
  #end  
  
  # TODO move this method from the person model (if the search for person and 
  # address is still needed) 
  # as person doesn't have relationships with contactinfos
  # directly. The current logic is:
  # person has many roles, roles has many role_contactinfos,
  # role_contactinfos belong to contactinfos
  #------------------
  #- This is used for searching: join all of hte contact info fields together
  #------------------
  
  #def all_addresses_as_text
  #  result =""
  #  #FIXME - correct line breaks for solar
  #  for ci in contactinfos
  #    result = result + ci.street+", "+ ci.locality+", "+ci.region.region_name+", "+ci.region.country.country_name + ' FIXME '
  #  end
  #  result
  #end
  
  #-----------------------------------------------------------------------------------
  #- Using the roles table, find all the people who have roles for this organisation -
  #-----------------------------------------------------------------------------------
  # FIXME: Commented out until a need is found for it
  #def organisations
  #  #Organisation.find(:all, :distinct => true, :include => :roles, :conditions => ["roles.person_id = ?", 33], :order => 'organisations.organisation_id')
  #  puts "Finding all roles.person_id = #{person_id}"
  #  return Organisation.find(:all, :include => :roles, :conditions => ["roles.person_id = ?", person_id])
  #end

  # FIXME: Commented out until a need is found for it
  #def regions
  #   Region.find(:all, :conditions => [ 'region_id IN (?)', contactinfos.collect {|c| c.region_id} ])
  #end

  #def countries
  #  Country.find(:all, :conditions => [ 'country_id IN (?)', contactinfos.collect {|c| c.country_id} ])
  #end

  #def valid_email?
  #  not contactinfos.select{|c| c.valid_email?}.empty?
  #end
  

  #-----------------------------------------------------------------------------------
  # Adds a contact info to this person
  #-----------------------------------------------------------------------------------
  #def add_contactinfo_to_person(contactinfo, contactinfo_type, preferred)
    
  #  transaction do
      # if the contactinfo has not previously been saved in the database it will not have an id
      # and thus you cannot create a linking object
  #    return if !contactinfo.save
      
  #    puts contactinfo.contactinfo_id
  #    puts contactinfo_type
  #    puts preferred
            
  #    person_contactinfo = PersonContactinfo.create( :person_id        => person_id,
  #                                                   :contactinfo_id   => contactinfo.contactinfo_id,
  #                                                   :contactinfo_type => contactinfo_type,
  #                                                   :preferred        => preferred   
  #                                                  );
  #    save
  #  end
    
  #  return true
  #end
   
  #-----------------------------------------------------------------------------------
  # Adds a contact info to this person
  #-----------------------------------------------------------------------------------
  #def update_person_contactinfo(person_contactinfo_id, contactinfo, contactinfo_type, preferred)
    
  #  transaction do
      # if the contactinfo has not previously been saved in the database it will not have an id
      # and thus you cannot create a linking object
  #    return if !contactinfo.save
      
  #    puts contactinfo.contactinfo_id
  #    puts contactinfo_type
  #    puts preferred
            
  #    person_contactinfo = PersonContactinfo.update(person_contactinfo_id,
  #                                                  {:person_id        => person_id,
  #                                                   :contactinfo_id   => contactinfo.contactinfo_id,
  #                                                   :contactinfo_type => contactinfo_type,
  #                                                   :preferred        => preferred 
  #                                                   }   
  #                                                 );
            
  #    save
  #  end
    
  #  return true
  #end
  
  # Java like to string method mainly used for testing
  #def to_string
  #  "PERSON:#{full_name}"
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
  for role in roles
    for role_contactinfo in role.role_contactinfos
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

end