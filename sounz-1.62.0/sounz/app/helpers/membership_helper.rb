module MembershipHelper

  def self.expired_membership_notification_email_to_members(recipients, member_type)
  	
	  email_subject = "SOUNZ " + member_type + "ship"	
		
	  # get membership_page url
	  website_url              = Setting.get_value(Setting::WEBSITE_URL)  
	  membership_page_url      = 'http://' + website_url + '/content/library'
	  membership_page_url_html = '<a href="' + membership_page_url + '">' + membership_page_url + '</a>'  
    contact_url              = 'http://' + website_url + '/content/contact'
    contact_url_html         = '<a href="' + contact_url + '">contact us</a>' 
	   
	  # email content
	  html_version = "According to our records your "+ member_type + "ship has expired.<br/><br/>"
	  
	  if member_type.match('Library Member')
	  html_version += "This may be for one of two reasons:<br/><br/>" +
                      "1. It is a year since you joined.<br/>" +
                      "2. You have reached the limit of items that can be borrowed through your membership.<br/><br/>"
	  end
	  
	  html_version += "You can purchase a new membership by clicking on this link, " + membership_page_url_html + " or " + contact_url_html + " if you have any questions.<br/><br/>" +
	                  "Kind regards,<br/>" +
	                  "SOUNZ Membership Services<br/>" +
					  "Centre for New Zealand Music<br/><br/>" +
            "--- This is an automated message. If you have received this message in error, please contact us. ---<br/><br/>" +
					  "<hr style=\"margin: 1em 0; border: 1px solid #ccc;\"/>" +
	                  "Mail: PO Box 27347, Marion Square, Wellington 6141<br/>" +
	                  "Visit: Level 3, Toi Poneke Arts Centre, 61 Abel Smith Street, Te Aro,  Wellington 6011<br/>" +
	                  "Phone: (64 4) 801 8602 Fax: (64 4) 801 8604<br/>" +
	                  "Website: www.sounz.org.nz<br/><br/>" +
	                  "SOUNZ receives major funding from Creative New Zealand, APRA and through PPNZ Ltd.<br/><br/>" +
	                  "SOUNZ - created in New Zealand, heard around the world!<br/>" + 
	                  "Toi Te Arapuoru - tipua i Aotearoa, rangona e te ao!" 
	  
	  # use the same text for plain text version but without html tags
	  text = html_version.strip || ''
	  plain_text_version = text.gsub('<br/>',"\r\n").gsub(/<(\/|\s)*[^>]*>/,'')
		
	  # get sender from 'settings' table
	  notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)  
		
	  # send mail
	  recipients.each do |recipient|
	  	# prepare salutation
	  	login = Login.find(:first, :conditions => ['username =?', recipient])
      person = login.person

      salutation = "Dear "
      if !person.blank?
        salutation += person.nomen.nomen + " " unless person.nomen.blank?
        salutation += person.full_name
      else
        salutation += "Sir/Madam"
      end
		
	    mailing = Mailing::deliver_mail_mailout(recipient, notification_sender, email_subject, html_version, plain_text_version, [], salutation=salutation)
	  end	  
  
  end
  
  def self.expired_membership_notification_email_to_administrators(logins, member_type)
  	
	 # generating email to SOUNZ administrators
	 # get recipients from 'settings' table
	 administrators = Setting.get_value(Setting::EXPIRING_MEMBERSHIP_NOTIFICATION_RECIPIENT).split(',')  	 
	   
	 if member_type.match(' expired by count of subscription items')
	   email_subject = member_type
	 else
	   email_subject = "Expired " + member_type + "s"	
	 end
	 
	 # email content
	 html_version = "<p>" + email_subject + " are:</p>"
	 html_version += logins.map{|l| l.username}.join('<br/>')  
	 
	 # use the same text for plain text version but without html tags
	 text = html_version.strip || ''
   plain_text_version = text.gsub('<br/>',"\r\n").gsub(/<(\/|\s)*[^>]*>/,'')
	
	 # get sender from 'settings' table
	 notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)  
	
	 # send mail
	 administrators.each do |recipient|
	   mailing = Mailing::deliver_mail_mailout(recipient, notification_sender, email_subject, html_version, plain_text_version)
	 end
  
  end  
  
end
