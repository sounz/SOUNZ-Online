class ReminderNotice < ActionMailer::Base

def email_reminder( email_recipient, name,note,item_text)
    # Email header info MUST be added here
    recipients email_recipient
    from  Setting.get_value('ReminderNoticeSenderEmail')
    subject "SOUNZ Library Reminder Notice"
    body :note => note, :name => name, :items => item_text
end     
  

end
