class Status < ActiveRecord::Base
  set_primary_key "status_id"
  set_sequence_name "publishing_statuses_status_id_seq" 

  # this is to show relationship with person
  has_many :people  
  has_many :contributors
  has_many :expressions
  has_many :venues
  has_many :distinctions
  has_many :events
  has_many :manifestations
  has_many :organisations
  has_many :samples
  has_many :works
  has_many :superworks
  has_many :resources
  has_many :prov_contact_updates
  has_many :prov_contributor_profiles
  has_many :prov_composer_bio_id
  has_many :prov_feedbacks
  has_many :prov_events
  has_many :prov_work_updates

  acts_as_dropdown
  
  @@statuses = nil
  
  acts_as_solr :fields => [
    :name
  ]
 
 
  def self.table_name() "publishing_statuses" end
    
  #Helper for acts_as_dropdown
  def name
    status_desc
  end
  
  
  #- Find a relationship type by its symbol, e.g. 
  #- RelationshipType.find_by_symbol(:is_composed_by)
  def self.find_by_symbol(name)
    if @@statuses == nil
      @@statuses = {}
      rts = Status.find(:all, :order => :status_desc)
      for rt in rts
          d = rt.status_desc
          d.downcase!
          d.gsub!(' ','_')
          d.gsub!('(', '')
          d.gsub!(')', '')
          d.strip!
          puts d
          @@statuses[d.to_sym] = rt
      end

    end
    puts @@statuses
     return @@statuses[name]
  end

  # -------------------------------------------------------------
  # - Return status based on requested status description param -
  # -------------------------------------------------------------
  def self.get_status_by_desc(desc)
    Status.find(:first, :conditions => ['LOWER(status_desc) LIKE ?', '%' + desc.downcase + '%'])
  end
  
  PENDING   = Status.get_status_by_desc("Pending")
  PUBLISHED = Status.get_status_by_desc("Published")
  APPROVED  = Status.get_status_by_desc("Approved")
  WITHDRAWN = Status.get_status_by_desc("Withdrawn")
  MASKED    = Status.get_status_by_desc("Masked")
  
  def self.active_statuses
  	Status.find(:all, :conditions => ['status_desc NOT ILIKE ? AND status_desc NOT ILIKE ?', '%masked%', '%withdrawn%'])
  end
end
