class HireNotice < ActionMailer::Base

def email_hire_notice( email_sender,user_login,obj_type,obj_id,obj_description, note, method='hire')
    logger.info("Sending mail!")
    # Email header info MUST be added here
    recipients Setting.get_value('HireNoticeEmail')
    #recipients 'pete@catalyst.net.nz'
    from  email_sender
    subject "SOUNZ " + method.capitalize + " Request"
    body :user_login => user_login, :user_email => email_sender, :method => method, :type => obj_type, :id => obj_id, :description => obj_description, :note => note
end     
  
end