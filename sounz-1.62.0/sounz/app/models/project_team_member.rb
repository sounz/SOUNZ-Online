class ProjectTeamMember < ActiveRecord::Base
  set_primary_key :project_team_member_id
  
  belongs_to :project
  
  belongs_to :person
  
  has_many :marketing_campaigns
  
  # Model validation
  validates_presence_of :project_id,
                        :person_id,                        
                        :message => "cannot be empty"
  # booleans validation
  validates_inclusion_of :manager, :in => [true, false]
  
  # ---------------------------
  # - Return member full name -
  # ---------------------------
  def member_full_name
    return person.full_name
  end
  
end
