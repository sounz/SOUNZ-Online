class RoleType < ActiveRecord::Base
  set_primary_key 'role_type_id'
  
  


  has_many :roles
  
  validates_presence_of(:role_type_desc)
   validates_length_of :role_type_desc, :in => 2..100,
  :allow_nil => false,
  :message => "is not between 2 and 100 chars"
  
  validates_uniqueness_of(:role_type_desc, :message => 'already exists')

  PERSON = find(:first, :conditions => "role_type_desc = 'Person'")
  ORGANISATION = find(:first, :conditions => "role_type_desc = 'Organisation'")
  CONTRIBUTOR  = find(:first, :conditions => "role_type_desc = 'Contributor'")
  
  
  VENUE  = find(:first, :conditions => "role_type_desc = 'Venue (c)'")
  
  COMPOSER_ROLE_TYPE_NAMES=['Arranger (c)', 'Composer (c)']
  PERFORMER_ROLE_TYPE_NAMES=['Performer - Music (c)','Musical Director (c)','Artist/Dancer/Actor (c)',
                             'Artistic Director (c)','Choreographer (c)' ]
  COMMISSIONER_ROLE_TYPE_NAMES=['Commissioner (c)', 'Funder (c)']
  PRESENTER_ROLE_TYPE_NAMES=['Venue (c)','Broadcaster (c)','Presenter (c)']
  PUBLISHER_ROLE_TYPE_NAMES=['Recording Company (c)','Publisher (c)' ]
  WRITER_ROLE_TYPE_NAMES=['Writer (c)','Reviewer (c)','Researcher (c)']
  
  
  def is_venue?
    self == VENUE
  end
  
  #----------------------------------------
  #- Return 'contributor' role types      -
  #- (containing '(c)' in role_type_desc) -
  #----------------------------------------
  def self.contributor_role_types
    RoleType.find(:all, :conditions => ['role_type_desc ILIKE ?', '%(c)%'], :order => 'display_order')
  end
  
  #---- these are used for facettings ----
  def facet_role_type
    result = ""
    result = "composer" if COMPOSER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result = "performer" if PERFORMER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result = "commissioner" if COMMISSIONER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result = "presenter" if PRESENTER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result = "publisher" if PUBLISHER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result = "writer" if WRITER_ROLE_TYPE_NAMES.include?(role_type_desc)
    result
  end
  
  #Same as facets except separate venue as special case
  def role_type_group
    if is_venue?
      result = "venue"
    else
      result = facet_role_type
    end
    result
  end

 def self.roleTypeToId(typename)
   matchingtypes=RoleType.find(:all, :conditions => ['role_type_desc=?',typename])
  if matchingtypes != nil
    logger.debug("returning #{matchingtypes.first.to_s} from roleTypeToId")
    return matchingtypes.first
  end
return nil
 end
 
end
