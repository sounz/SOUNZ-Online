class StatusNotice < ActionMailer::Base

def email_status( email_recipient, name, note, order_id, new_status, old_status )
    # Email header info MUST be added here
    recipients email_recipient
    from  Setting.get_value('StatusNoticeSenderEmail')
    subject "SOUNZ Online Order Status Update Notice"
    body :note => note, :name => name, :id => order_id, :new_status => new_status, :old_status => old_status
end     
  

end