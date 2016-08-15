class Project < ActiveRecord::Base
  set_primary_key :project_id
  has_many :project_team_members, :dependent => :destroy
  has_many :people, :through => :project_team_members
  
  has_many :marketing_campaigns, :order => 'created_at DESC', :dependent => :destroy
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  
  # Model validation
  validates_presence_of :project_status,
                        :project_title,
                        :updated_by,                        
                        :message => "cannot be empty"
                        
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
             :class_name => 'Login',
             :foreign_key => :updated_by
  
  STATUS_NAMES = ['Started', 'In Progress', 'Finished']
  
  def status_name
    STATUS_NAMES[project_status]
  end
  
  #-----------------------------
  #- Add person to the project -
  #-----------------------------
  def add_person(person, is_manager)
    new_project_team_member = ProjectTeamMember.create(:manager => is_manager,
    :person_id => person.person_id,
    :project_id => project_id
    )
    
    person.project_team_members << new_project_team_member
    project_team_members << new_project_team_member
    save
  end
  
  
  #------------------------------
  #- Delete project team member -
  #------------------------------
  def delete_person(person)
    join = ProjectTeamMember.find(:first, :conditions => ["project_id = ? and person_id = ?", project_id , person.person_id])
    join.destroy   
  end
  
  #---------------------------------------
  #- Set(saves) selected project manager -
  #---------------------------------------
  def set_project_manager(person_id)
    for member in project_team_members
      if member.person_id.to_i == person_id.to_i
        member.update_attribute(:manager, true)
      else
        member.update_attribute(:manager, false)
      end
    end
  end
  
  #- Check if the project can be deleted
  def can_be_deleted?
  	result = true
	
	marketing_campaigns_with_mailouts         = self.marketing_campaigns.select {|mc| !mc.campaign_mailouts.blank?}
	marketing_campaigns_with_campaign_manager = self.marketing_campaigns.select {|mc| !mc.campaign_manager.blank?}
	
	if marketing_campaigns_with_mailouts.length > 0 || marketing_campaigns_with_campaign_manager.length > 0
	  result = false
	end
	
	return result
  end
  
end
