module CampaignMailoutsHelper

  #-----------------------------------------
  #- Return mailout type in display format -
  #-----------------------------------------
  def mailout_type_display(type)
    if type == 'p'
      return 'Postal'
    end
    if type == 'e'
      return 'Email'
    end
  end
  
  # - Return the Hash of emails of the project team members
  def get_test_email_recipients(campaign_mailout)
	
  	project_team_emails = Hash.new
	
	marketing_campaign = campaign_mailout.marketing_campaign
	project = marketing_campaign.project
	
	project_team_members = project.project_team_members.map{|pm| pm.person}.uniq
		
	project_team_members.each do |person|
	  user_contactinfos = person.roles.collect{ |r| r.role_contactinfos.collect{|rc| rc.contactinfo }}.flatten.compact
	  
	  user_contactinfos.each do |c|
		  project_team_emails.store(c.email_1, c.email_1) unless c.email_1.blank?
		  project_team_emails.store(c.email_2, c.email_2) unless c.email_2.blank?
		  project_team_emails.store(c.email_3, c.email_3) unless c.email_3.blank?
	  end
	end
	project_team_emails = project_team_emails  	
  	
	return project_team_emails
  end
end
