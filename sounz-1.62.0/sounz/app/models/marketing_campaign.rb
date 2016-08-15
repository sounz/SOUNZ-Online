class MarketingCampaign < ActiveRecord::Base
  set_primary_key :marketing_campaign_id
  
  belongs_to :project
  
  belongs_to :project_team_member
  
  has_many :campaign_mailouts, :order => 'created_at DESC', :dependent => :destroy
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by 
  
  # validation of the model
  validates_presence_of :project_id,
                        :campaign_name,
                        :updated_by,
                        :message => "cannot be empty"
  validates_inclusion_of(:campaign_status, :in => %w{i f}, :message => "cannot be empty")

  # compares marketing_campaigns by finished_at for sorting
  def <=>(other_marketing_campaign)
    self.finished_at <=> other_marketing_campaign.finished_at
  end

  #---------------------------
  #- Delete campaign manager -
  #---------------------------
  def delete_manager(person)
    # check if the person is the campaign manager (exists in marketing_campaign) 
    # and delete the person
    if !person.blank? && person.person_id == campaign_manager
      update_attribute(:campaign_manager, nil)
    end
  end
  
  # -------------------------------------------
  # - Return true if any of campaign mailouts -
  # - does not have 'not sent' mailout status -
  # -------------------------------------------
  def any_mailouts_sent?
    sent = false
    
    campaign_mailouts.each do |cm|
      sent = true if !cm.mailout_status.match('n')
    end
    
    return sent
  end
end
