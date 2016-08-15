#
# A Communication is an instance of dialog between Sounz and a Role. This is
# because Roles are associated either with people or a person in a specific
# role for an Organisations.
# 
class Communication < ActiveRecord::Base
  include ApplicationHelper
  include ModelAsStringHelper
  
  set_primary_key :communication_id
  
  #
  # Relationships
  #

  belongs_to :communication_type
  belongs_to :communication_method
  belongs_to :role

  def self.priorities
    {
      :not_applicable => 0,
      :highest => 1,
      :high => 2,
      :normal => 3,
      :low => 4,
      :unimportant => 5
    }
  end
  
  def self.statuses
    {
      :open => 'o',
      :closed => 'c'
    }
  end

  #
  # Model validation
  # FIXME: need checking to see that they comply with reality now!
  #
  validates_presence_of(:communication_subject, :message => "cannot be empty")
  validates_presence_of(:communication_note, :message => "cannot be empty")
  
  validates_presence_of :communication_type,
                        :communication_method,
                        :role_id,
            :message => 'must be specified'
  
  validates_associated :communication_type, :communication_method
  
  validates_inclusion_of :priority, :in => self.priorities.values, :message => 'is not valid'
  validates_inclusion_of :status, :in => self.statuses.values, :message => 'is not valid'
  

  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
  
  #validates_associated :communication_type, :communication_method
    
  #validates_inclusion_of :priority, :in => self.priorities.values, :message => 'is not valid'
  #validates_inclusion_of :status, :in => self.statuses.values, :message => 'is not valid'
  
  acts_as_solr :fields => [
    :communication_subject_for_solr,
    :created_at_for_solr,
    :closed_at_for_solr, 
    :communication_note_for_solr,
    :communication_type_for_solr,
    :communication_method_for_solr,
    :communication_priority_for_solr,
    :communication_status_for_solr, 
    :associated_organisation_name_for_solr,
    :associated_organisation_abbrev_for_solr,
    :associated_person_name_for_solr
  ]
  
  #
  # Returns the communication_subject data of the communication in a form that solr can store
  #
  def communication_subject_for_solr
    return FinderHelper.strip(communication_subject)
  end
  
  #
  # Returns the created_at data of the communication in a form that solr can store
  #
  def created_at_for_solr
    return FinderHelper.strip(created_at.to_i)
  end
  
  #
  # Returns the closed_at data of the communication in a form that solr can store
  #
  def closed_at_for_solr
    return FinderHelper.strip(closed_at.to_i)
  end
  
  #
  # Returns the communication_note data of the communication in a form that solr can store
  #
  def communication_note_for_solr
    return FinderHelper.strip(communication_note)
  end
  
  #
  # Returns the communication_type data of the communication in a form that solr can store
  #
  def communication_type_for_solr
    return communication_type_id
  end
  
  #
  # Returns the communication_method data of the communication in a form that solr can store
  #
  def communication_method_for_solr
    return communication_method_id
  end
  
  #
  # Returns the communication_status data of the communication in a form that solr can store
  #
  def communication_status_for_solr
    return status
  end
  
  #
  # Returns the communication priority data of the communication in a form that solr can store
  #
  def communication_priority_for_solr
    return priority
  end
  
  #
  # Returns the associated organisation of the communication in a form that solr can store
  #
  def associated_organisation_name_for_solr
    return FinderHelper.strip(role.organisation.organisation_name) if !role.organisation.blank?
  end
  
  #
  # Returns the associated organisation of the communication in a form that solr can store
  #
  def associated_organisation_abbrev_for_solr
    return FinderHelper.strip(role.organisation.organisation_abbrev) if !role.organisation.blank? && !role.organisation.organisation_abbrev.blank?
  end
  
  #
  # Returns he associated person of the communication in a form that solr can store
  #
  def associated_person_name_for_solr
    return FinderHelper.strip(role.person.full_name) if !role.person.blank?
  end
  
  # -----------------------------------------------------------------
  # - Return associated contact in the 'person_49' format           -
  # - based on entity_string ('person' or 'organisation') parameter -
  # -----------------------------------------------------------------
  def associated_contact_string(entity_string)
    associated_contact_string = nil
    
    if !role.person.blank? && entity_string.match('person')
      associated_contact = role.person
    elsif !role.organisation.blank? && entity_string.match('organisation')
      associated_contact = role.organisation
    else
      # other case, priority is given to person
      if !role.person.blank?
        associated_contact = role.person
      else
        associated_contact = role.organisation
      end
    end
    
    associated_contact_string = generate_id(associated_contact) unless associated_contact.blank?
    
    return associated_contact_string
    
  end
  
  # -------------------------------------------------------
  # - Return the name of associated contact if it exists  -
  # - based on a string parameter in the form of 'person' -
  # - or 'organisation' (used in UI)                     -
  # -------------------------------------------------------
  def get_associated_contact_name(contact_type)
    contact_name = nil
    
    if contact_type.match('person')
      contact_name = role.person.full_name unless role.person.blank?
    end
    
    if contact_type.match('organisation')
      contact_name = role.organisation.organisation_list_name(true) unless role.organisation.blank?
    end
    
    return contact_name
  end
  
  #String for search results 
  #def to_string
  #  result = ', "'+communication_subject+'" '+dby_date(updated_at)
  #  if !role.person.blank?
  #    result = associated_person_name_for_solr + " " +result
  #  else
  #    result = associated_organisation_name_for_solr + " " +result
  #  end
  #  result
  #end

#- Store statuses here
#class CommunicationStatus
#  @@OPEN = 'o'
#  @@CLOSED = 'c'
#end

end