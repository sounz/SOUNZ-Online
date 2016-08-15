#
# The Role model fronts the roles table. There are three different types of
# roles
#
# * Person roles - if only the person_id is set, then the role is for that
#   person. Communications with people happen through these roles.
# * Organisation roles - if only the organisation_id is set, the the role is
#   for that organisation, and is either the default organisation role or the
#   (optional) contributor organisation role
# * Person-in-organisation roles - if both person_id and organisation_id are
#   set, then the role is for a person in a specific role in an organisation.
#   Organisation communications happen through these roles.
#
class Role < ActiveRecord::Base
  set_primary_key :role_id
  set_sequence_name "roles_role_id_seq"

  include FrbrHelper
  include FrbrMethodsRole

  #
  # Relationships
  #
  
  # Roles have a specific role type
  belongs_to :role_type

  # Roles can belong to people
  belongs_to :person
  
  belongs_to :status
  
  #Contributor data is assigned to a role
  has_one :contributor
  
  has_many :communications
  
  has_many :role_relationships
  has_many :relationships, :through => :role_relationships, :select => "role_relationships.relationship_type_id, relationships.*"

  
  acts_as_solr :fields => [ #:additional_fields => [
    :role_name_for_solr,
    :role_type_id_for_solr,
    :contributor_known_as_for_solr,
    :contributor_description_for_solr,
    :contributor_profile_for_solr,
    :contributor_pull_quote_for_solr,
    :marketing_subcategories_for_solr
    ]
  # Roles can belong to organisations
  belongs_to :organisation

  # Contact information is associated through roles. Each role can have a
  # postal, physical and billing address (later there may be more/less types).
  has_many   :role_contactinfos
  has_many   :contactinfos, :through => :role_contactinfos
  
  # Marketing Categorisation is associated through role_categorizations
  has_many  :role_categorizations
  has_many  :marketing_subcategories, :through => :role_categorizations
  
  #
  # Model validation
  # FIXME: need checking to see that they comply with reality now!
  #

  # validates_presence_of :communication_type, :message => 'must be specified'
  # validates_presence_of :communication_method, :message => 'must be specified'
  # validates_associated :communication_type, :communication_met
  
  # Check for key for role type
  validates_associated :role_type
  validates_presence_of :role_type
  
  
  # Check for key for contactinfo_id
  #validates_presence_of :contactinfo
  #validates_associated :contactinfo
  
  # Check organistaion if its not blank
  #validates_associated :organisation, :if => Proc.new {|role| !role.organisation.blank?}
  
  # Check only if person is not blank
  #validates_associated :person, :if => Proc.new {|role| !role.person.blank?}
  
  
  
  #FIXME: Awaiting info from Paul regarding role title optionality
  #validates_presence_of :role_title
  validates_presence_of :role_type_id, :message => 'is invalid'
  
  #
  # Initialises the role type if not specified (called by Role.new)
  # FIXME: maybe could be done with after_initialize
  #
  def initialize(*params)
    super(*params)
    if params[0] != nil
    self.role_type = RoleType::PERSON if @new_record and params[0][:role_type_id].blank?
    else
    self.role_type = RoleType::PERSON
    end
  end

  FRBR_LINKS_METHODS = [
                        "composite_influences",
                        "composite_publications",
                        "composite_performances",
                        "composite_broadcasts",
                        "composite_recordings",
                        "composite_works",
                        "arrangements",
                        "composite_distinctions",
                        "composite_collaborations",
                        "composite_commissions",
                        "composite_related_resources",
                        "composite_events",
                        "composite_media_on_demand"
                        ]
  #
  # Returns marketing subcategories for this role in a string format that
  # solr can store
  #
  def marketing_subcategories_for_solr
    marketing_subcategories.collect{|s| s.marketing_subcategory_id}.join(' ')
  end

  def role_name_for_solr
    FinderHelper.strip(role_name)
  end

  def role_type_id_for_solr
    role_type_id
  end

  def contributor_known_as_for_solr
    FinderHelper.strip(contributor_known_as)
  end

  def contributor_description_for_solr
    FinderHelper.strip(contributor_description)
  end

  def contributor_profile_for_solr
    FinderHelper.strip(contributor_profile)
  end

  def contributor_pull_quote_for_solr
    FinderHelper.strip(contributor_pull_quote)
  end
  
  #
  # Returns the name of this role. Either the custom role title assigned to
  # this particular role, or the title of the role type if no custom title is
  # set
  #
  def role_name
    return role_title if !role_title.blank?
    role_type.role_type_desc
  end

  def frbr_type
      "role"
    end

    def frbr_id
    role_id
    end

    def frbr_ui_desc
    
      description=nil
    
      if !contributor.blank?
        description="UNKNOWN"
        if contributor.known_as_public.blank?
          #use person or organisation description
          if person != nil
            description = person.full_name
          else
            description=organisation.organisation_name  
          end
        else
          description=contributor.known_as_public
        end
    
        description+=" ("+role_name+")"
      end
    
      return description
    
    end
    
    
    #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
    #The naming needs to be common to maintain a single partial for list rendering
    def frbr_list_title
      contributor_names
    end

    def frbr_list_description
      role_type.role_type_group.camelize
    end
    
    def is_a_contributor?
	  return is_contributor
    end
    
    
    #FIXME: looks like it has been directly pasted from work - shouldnt be here!
    def frbr_updateImplicitRelationships(login_id)
      #We need to pass in the login id as it is not accessible from the model scope
      #FIXME: relationship type should ideally not be hardcoded.
      implicitRelationshipId=1001 #child of
      #check to see if our associated superwork is already up to date
      updated=0
      for relationship in relationships
          #check this relationship is our implictly mapped relationship
          #e.g. 'is parent of'
          logger.info 'checking relationship: '+relationship.id.to_s+" "+relationship.relationship_type_id.to_s
          if relationship.relationship_type_id.to_i== implicitRelationshipId
          logger.info 'found relationship!'
          #we have our parent superwork. lets check it is the correct number
            for superwork_rel in relationship.superwork_relationships
              if superwork_rel.superwork_id != superwork_id
              #found our existing relationship, but linked to a different superwork. lets update it.
              superwork_rel.superwork_id=superwork_id
              superwork_rel.save()
              end
            end  
          updated=1
          end
        end
        
        if updated == 0
          #we need to create a new implicit relationship from scratch.
          relationship = Relationship.new()
          relationship.updated_by=login_id
          relationship.entity_type_id=EntityType.entityTypeToId('work')
          relationship.ent_entity_type_id=EntityType.entityTypeToId('superwork')
    
          if relationship.save
            invreltype=RelationshipType.find(implicitRelationshipId).inverse
            relationship.make_inter_relationship(relationship.id,EntityType.entityTypeToId("work"),work_id,implicitRelationshipId)
            relationship.make_inter_relationship(relationship.id,EntityType.entityTypeToId("superwork"),superwork.id,invreltype)
          end
    
        end
    end
    
    
    def frbr_relationships
      frbr_relationships=Array.new()
      for rel in relationships.uniq
        reltype=RelationshipType.find(rel.relationship_type_id)
        
        #Choose the entity_type that does not match this one.
        #Where both are the same, it does not matter which we pick
        logger.info("WHA?:" + rel.ent_entity_type_id.to_s)
        my_entity=EntityType.entityIdToType(rel.ent_entity_type_id)
        if EntityType.entityIdToType(rel.ent_entity_type_id) == frbr_type() then 
          my_entity= EntityType.entityIdToType(rel.entity_type_id)
        end
        
        related_objects=eval('rel.'+my_entity+'s')
        
        for related_object in related_objects
          if rel.entity_type_id == rel.ent_entity_type_id then
            if related_object.id != id then
              frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
            end
          else 
          frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
          end
        end
      end
    frbr_relationships
    end
    

  #Check that at least one of organisation and person id is set - having both nil is invalid
  def validate
    
    if person == nil and organisation== nil
      errors.add "At least one of person and organisation must be associated with a role"
    end
    #errors.add_to_base 'Must have at least one contactinfo' if role_contactinfos.blank?
  end
  
  
  #See WR50459
  def get_contributor_url
    result = []
    #This defaults to the required postal field
    default_rci = get_default_role_contactinfo
    result = default_rci.contactinfo.get_list_of_websites[0] if !default_rci.blank?
    result
  end
  
  #Get a list of all the websites
  def get_list_of_websites
    urls = []
    for ci in contactinfos
      urls  << ci.get_list_of_websites
    end
    urls.flatten
  end
  
  
  #solr query stuff
  def contributor_known_as
    if contributor != nil
      return contributor.known_as_public
    else
      #check to see we are defined as a contributor role before falling back to this
      if is_a_contributor?
        if person != nil
          return person.full_name
        else
          return organisation.organisation_name
        end
      end
    end
  end
  
  def contributor_description
    if contributor != nil
    return contributor_names
    else
      #check to see we are defined as a contributor role before falling back to this
      if is_a_contributor?
        if person != nil
        return person.full_name
        else
        return organisation.organisation_name
        end
      end
    end
    
    
  end
  
  
  def contributor_profile
    if contributor != nil
    return contributor.profile
    end
  end
  
  def contributor_pull_quote
    if contributor != nil
    return contributor.pull_quote
    end
  end
  
  
  #-------------------------------------------------------------------
  #- Save this role's information:                                   -
  #- - if a role is of contributor type,                             -
  #-   create an associated contributor record with 'Pending' status -
  #- - create role role_contactinfos and contactinfos                -
  #- - if an organisation is assigned to a role,                     -
  #-   create default_contactinfos                                   -
  #-------------------------------------------------------------------
  def create_self(login)
    saved = false
	begin
      transaction do
      	status = Status.find(:first, :conditions => ['lower(status_desc) =?', 'pending'])
		self.status = status if self.status.blank?
		
        if self.is_a_contributor?
          contributor = Contributor.new
          contributor.role = self
          contributor.updated_by = self.updated_by
          logger.info("UPDATED BY: "+contributor.updated_by.to_s)
          contributor.status = status
          if contributor.save
          	saved = true
          else
		    raise
          end 
        else
          if self.save
          	saved = true
          else
            raise
          end 
        end
     end
    rescue
      return false
    end
	
	
	if saved == true
	  # create role role_contactinfos and contactinfos
	  self.create_set_of_role_contactinfos
	  
	  # create default_contactinfos if appropriate
	  self.default_contactinfos_update
	  
	  # solr update
	  self.person.save if !self.person_id.blank? && !self.organisation_id.blank?
	  
	  RoleContactinfo.index_objects(self.role_contactinfos)
	end
    
	
	
	true
  end
  #-----------------------------------------------------------
  #- Return role_contactinfo based on contactinfo_type param -
  #-----------------------------------------------------------
  def get_role_contactinfo_by_contactinfo_type(contactinfo_type)
    role_contactinfo = nil
   
    if !contactinfo_type.blank?
      role_contactinfo = RoleContactinfo.find(:first, :conditions => ['role_id =? and contactinfo_type =?',
                                                                       self.role_id,
                                                                       contactinfo_type
                                                                      ]
                                              )
    end
   
    return role_contactinfo 
 
  end
  
  #-----------------------------------------------------
  #- Create a set of role_contactinfo and contactinfos -
  #- for a role                                        -
  #-----------------------------------------------------
  def create_set_of_role_contactinfos
  
    logger.debug "******* ROLE CREATE_SET_OF_ROLE_CONTACTINFOS *****"
  
    role_contactinfo_types = ['postal', 'physical', 'billing']
    
    for contactinfo_type in role_contactinfo_types
      
      role_contactinfo = self.get_role_contactinfo_by_contactinfo_type(contactinfo_type)
      
      # if role_contactinfo doesn't exist
      # create it
      if role_contactinfo.blank?
        contactinfo = Contactinfo.new
        contactinfo.updated_by = self.updated_by
        
        # create contactinfo first
        if contactinfo.save
          # assign params to new role_contactinfo
          role_contactinfo = RoleContactinfo.new
          role_contactinfo.role_id          = self.role_id
          role_contactinfo.contactinfo_id   = contactinfo.contactinfo_id
          role_contactinfo.contactinfo_type = contactinfo_type
          
          # create role_contactinfo
          if !role_contactinfo.save
            # FIXME do we need to implement error messages for a user in this case????
            logger.debug " Role_contactinfo saving of #{contactinfo_type} type has failed due to the following errors"
            logger.debug role_contactinfo.errors.to_yaml
          end
          
        else
          # FIXME do we need to implement error messages for a user in this case????
          logger.debug " Contactinfo saving has failed due to the following errors"
          logger.debug contactinfo.errors.to_yaml
        end
      end
    end
  end
  
  #- Create, update or delete default_contactinfos for every contactinfo of the role -
  #
  #  The following logic applies:
  #
  #  1) check if there is a contactinfo to default for a particular role contactinfo:
  #  if the role has an organisation associated with it, the contactinfo to default 
  #  will be the contactinfo of appropriate contactinfo type of 'Organisation' role
  #  (if exists)
  #  if the role has a person associated with it but no organisation, the contactinfo 
  #  to default will be the contactinfo of appropriate contactinfo type of 'Person' 
  #  role  (if exists) - later, once the new concept of 'preferred' role is implemented
  #  (as per WR#50281), 'Person' role can be replaced by 'preferred' role
  #
  #  2) check if the default_contactinfo of a particular role contactinfo exists: 
  #  if so and there is the contactinfo_to_default, update the default_contactinfo; 
  #  if not and there is the contactinfo_to_default, create a new default_contactinfo;
  #  else: delete the existent default_contactinfo
  #-
  def default_contactinfos_update#(prev_default_entity=nil)
  
    #logger.debug "DEBUG:******** ROLE DEFAULT_CONTACTINFOS_UPDATE ***" 
	
	# do we have an organisation previously assigned to the role?
	#prev_organisation = nil
	#prev_organisation = prev_default_entity if !prev_default_entity.blank? && prev_default_entity.class == Organisation
	
	#logger.debug "DEBUG: prev_organisation #{prev_organisation.id}" unless prev_organisation.blank?
	role_to_default = nil
	
	# get role_to_default ----------------------------------------------------
	
	# if an organisation exists for this role, default contactinfo to organisation 'Organisation' role
	if !self.organisation.blank?
			
	  role_to_default = Role.get_organisation_primary_role(self.organisation.organisation_id)
	  role_to_default.create_set_of_role_contactinfos
			 
	else
	  # if a person exists for this role, default contactinfo to person's 'Person' role role_contactinfos
	  if !self.person.blank? && self.role_type.role_type_desc != 'Person'
		
	  	# default to a 'Person' role without organisation
	  	# TODO the processing can be later replaced ty 'preferred' role when the concept of 'preferred' is changed 
	  	# as per WR#50281
		role_to_default = Role.get_role_by_role_type('Person', self.person.person_id, organisation_id = nil)		  
		
		
		# WR#42492 - as per Scilla's note 12:47 16-05-2008
		# if person does have one role (excluding current role), default contact info details to that role
		if role_to_default.blank?
		  person_roles_without_current_role = self.person.roles.select {|r| r.role_id != self.role_id}
		  role_to_default = person_roles_without_current_role[0] if person_roles_without_current_role.length == 1
		end
	  end
	  
	end	
	
	#logger.debug "DEBUG: role_to_default #{role_to_default}"
	
	# small check for those people/organisations
	# that have been imported to db without
	# creating all 3 sets of role_contactinfos	
	if !role_to_default.blank?
      role_to_default.create_set_of_role_contactinfos	
	end
	
	# iterate trough all role role_contactinfos to assign the appropriate default contactinfo for each of them
    for role_contactinfo in self.get_role_contactinfos
      
      default_contactinfo = nil
      
      contactinfo = role_contactinfo.contactinfo
      
	  contactinfo_to_default = nil
	  
      # previous organisation organisation role contactinfo of the same contactinfo_type if any
      #if !prev_organisation.blank?
		
      #  prev_organisation_role_contactinfo = self.get_organisation_primary_role_contactinfo( role_contactinfo.contactinfo_type, 
      #  	                                                                                 prev_organisation.organisation_id 
      #                                                                                      )
      #  prev_organisation_contactinfo = prev_organisation_role_contactinfo.contactinfo unless prev_organisation_role_contactinfo.blank?

      #  # we override an existing default_contactinfo
      #  default_contactinfo = DefaultContactinfo.find(:first, :conditions => ['contactinfo_id =? and d_contactinfo_id =?', 
      #                                                                         contactinfo.contactinfo_id,
      #                                                                         prev_organisation_contactinfo.contactinfo_id
      #                                                                        ]
      #                                                )
      #end # end if !prev_organisation.blank?
      
	  # get contactinfo_to_default
	  if !role_to_default.blank? && role_to_default != self 
	  	contactinfo_to_default = role_to_default.get_role_contactinfo_by_contactinfo_type(role_contactinfo.contactinfo_type).contactinfo
	  end
	  
	  # now, check that we do not have already the default contactinfo with the current contactinfo and contactinfo_to_default
	  # parameters
      #if default_contactinfo.blank?
	  default_contactinfo = DefaultContactinfo.find(:first, :conditions => ['contactinfo_id =?',# and d_contactinfo_id =?', 
	                                                                        contactinfo.contactinfo_id,
	  #																		contactinfo_to_default.contactinfo_id
																			]
									               )
	  #end	  
	  	  
      # create default_contactinfo
      if !contactinfo_to_default.blank?
      	#logger.debug "DEBUG: contactinfo_to_default #{contactinfo_to_default.id}"
		      	
	    if default_contactinfo.blank?
          default_contactinfo = DefaultContactinfo.new
          default_contactinfo.contactinfo_id = contactinfo.contactinfo_id
          if contactinfo_to_default != nil
            default_contactinfo.d_contactinfo_id = contactinfo_to_default.contactinfo_id
          end
          if !default_contactinfo.save
            #logger.debug "DEBUG: Default contactinfo is not saved due to the following errors "
            logger.debug default_contactinfo.errors.to_yaml 
          end
        
        # update existent default_contactinfo
        else
          default_contactinfo.self_create_from_existent_contactinfo(contactinfo, contactinfo_to_default) unless default_contactinfo.blank?
        end
	
	  else
	  	# if there is no contactinfo_to_default, delete existent default_contactinfo
		default_contactinfo.destroy unless default_contactinfo.blank?
	  end # end if !contactinfo_to_default.blank?
   
    end # end 'for role_contactinfo in self.get_role_contactinfos' loop
    
  end
  
  #-----------------------------------------
  #- Return just created role_contactinfos -
  #- Note: self.role_contactinfos do not   -
  #- return just created role_contactinfos -
  #- hence the need to use find here       -
  #-----------------------------------------
  def get_role_contactinfos
    role_contactinfos = RoleContactinfo.find(:all, :conditions =>['role_id =?', self.role_id])
    return role_contactinfos
  end
  
  #-------------------------------
  #- Delete default_contactinfos -
  #-------------------------------
  def delete_default_contactinfos(organisation_id)
    
    if !organisation_id.blank?
      self.role_contactinfos.each do |rc|
        contactinfo = rc.contactinfo
        # organisation organisation role contactinfo of the same contactinfo_type
        organisation_role_contactinfo = self.get_organisation_primary_role_contactinfo( rc.contactinfo_type, organisation_id )
        organisation_contactinfo = organisation_role_contactinfo.contactinfo unless organisation_role_contactinfo.blank?
        
        # find default_contactinfo based on contactinfo and d_contactinfo      
        default_contactinfo = DefaultContactinfo.find(:first, :conditions => ['contactinfo_id =? and d_contactinfo_id =?', 
                                                                             contactinfo.contactinfo_id,
                                                                             organisation_contactinfo.contactinfo_id
                                                                            ]
                                                    )
        default_contactinfo.destroy unless default_contactinfo.blank?
      end
    end
  end
  
  #-----------------------------------------------------------------------------------------------------
  #- Return role_contactinfo for a organisation primary role with a particular contactinfo_type if any -
  #-----------------------------------------------------------------------------------------------------  
  def get_organisation_primary_role_contactinfo(contactinfo_type, organisation_id = nil)
    role_contactinfo = nil
    
    if organisation_id == nil
      organisation_id = self.organisation_id unless self.organisation_id.blank?
    end
    
    if !organisation_id.blank?
      
      primary_role = Role.get_organisation_primary_role(organisation_id)
      role_contactinfo = primary_role.get_role_contactinfo_by_contactinfo_type(contactinfo_type) unless primary_role.blank?
    
    end
    
    return role_contactinfo
  
  end
  
  #------------------------------------
  #- Return primary organisation role -
  #------------------------------------
  def self.get_organisation_primary_role(organisation_id)
    organisation_role = nil
    
    # role_type_id for 'Organisation' role
    role_type = RoleType.find(:first, :conditions => ['LOWER(role_type_desc) =?', 'organisation'])
    
    if organisation_id != nil
      organisation_role = Role.find(:first, :conditions => ['organisation_id =? and role_type_id =?', 
                                                             organisation_id,
                                                             role_type.role_type_id
                                                            ]) unless role_type.blank?
    end
    return organisation_role
  end
  
  #-------------------------------------
  #- Return preferred role_contactinfo -
  #-------------------------------------
  def get_preferred_role_contactinfo
    role_contactinfo = nil
    
    role_contactinfo = RoleContactinfo.find(:first, :conditions => ['role_id =? and preferred =?', self.role_id, 't'])
    
    return role_contactinfo
  
  end
  
  
  #Get the prefererred contactinfo only for display purposes.  Avoid breaking when role contact info is nil
  def get_preferred_contactinfo
    rci = get_preferred_role_contactinfo
    result = nil
    result = rci.contactinfo if !rci.blank?
    result
  end

  #-----------------------------------
  #- Return default role_contactinfo -
  #- NOTE: currently it is 'postal'  -
  #-----------------------------------
  def get_default_role_contactinfo(default_contactinfo_type = 'postal')
    role_contactinfo = nil
    
    role_contactinfo = RoleContactinfo.find(:first, :conditions => ['role_id =? and contactinfo_type =?', 
                                                                     self.role_id, 
                                                                     default_contactinfo_type])
    
    return role_contactinfo
  
  end
  
  #-------------------------------------------
  #- Return a flag (currently only '(c)'     -
  #- if person/organisation is a contributor -
  #-------------------------------------------
  def contributor_flag
    contributor_flag = nil
    contributor_flag = '(c)' unless !self.is_a_contributor?
    return contributor_flag
  end
  
  #-----------------------------------------------------
  #- Return either person full_name or organisation    -
  #- name with the priority given to person, if he/she -
  #- is assigned to the role                           -
  #-----------------------------------------------------
  def role_contact_name
    contact_name = nil
    
    if !self.person.blank?
      contact_name = self.person.last_name.downcase + ' ' + self.person.first_names.downcase
    elsif !self.organisation.blank?
      contact_name = self.organisation.organisation_list_name.downcase
    end      
    
    return contact_name
    
  end
  
  #------------------------------------------------------------
  #- Return role associated contact entity type               -
  #- ('person' or 'organisation')                             -
  #- Note: the priority given to person contact, if he/she is -
  #- assigned to the role                                     -
  #- (used in UI)                                             -
  #------------------------------------------------------------
  def role_primary_contact_type
    primary_contact_type = nil
    
    if !self.person.blank?
      primary_contact_type = 'person'
    elsif !self.organisation.blank?
      primary_contact_type = 'organisation'
    end      
    
    return primary_contact_type
    
  end
  
  # ------------------------------------------
  # - Return contributor name if the role    -
  # - has contributor record associated with -
  # - it                                     -
  # ------------------------------------------
  def contributor_names
    result = nil
    
    if !self.contributor.blank?
      result = self.contributor.known_as_public
    
      #Deal with person case
      if result.blank? #default to contributor known as, otherwise go hunting
      
        if !self.person.blank?
          #puts "TRACE2, result=#{result}"
          #result = self.person.known_as if !self.person.known_as.blank?
          result = self.person.full_name if !self.person.blank?
          if result.blank?
            result = 'PERSON NAME NOT FOUND'
          end
        
        #This is the organisation case
        else
          result = self.organisation.organisation_name if !self.organisation.blank?
          if result.blank?
            result = 'ORGANISATION NAME NOT FOUND'
          end
        end
      end
    end
    
    return result
    
  end
  
  #
  # - Checks whether an editing user does have permission to publish CRM, 
  # - if not, sets the role status to 'Pending',
  # - then re-indexes associated role contactinfos
  #
  def self.crm_privileges_check(login, role)
     	
    if !PrivilegesHelper.has_permission?(login, 'CAN_PUBLISH_CRM')
	  role.update_attribute(:status_id, Status::PENDING.status_id) 
    end
	
	RoleContactinfo.index_objects(role.role_contactinfos)
	   
  end
  
  #
  # Return role based on role_type, person_id and organisation_id
  # params
  # Note: person_id or organisation_id can be specifically set to nil
  #
  def self.get_role_by_role_type(type_s, person_id, organisation_id)
    role_type = RoleType.roleTypeToId(type_s)
  	
	conditions = "role_type_id = " + role_type.role_type_id.to_s
	
	if person_id.blank? && organisation_id.blank?
	  logger.debug "DEBUG: ERROR in Role.get_role_by_role_type - both person_id and organisation_id cannot be blank"
	  return
	else
	  if person_id.blank? 
	   conditions += " AND person_id IS NULL"
	  else
	    conditions += " AND person_id = " + person_id.to_s
	  end
	
	  if organisation_id.blank?
	    conditions += " AND organisation_id IS NULL"
	  else
	    conditions += " AND organisation_id = " + organisation_id.to_s
	  end
	
	  return Role.find(:first, :conditions => conditions)
	end
  	
  end
  
  # Check if the associated contributor record has any info or relationships
  def contributor_info_empty?
  	result = true
	
  	result = contributor.is_empty?  if !contributor.blank?
	
	return result
  end
  
end
