class Mailing < ActionMailer::Base

  def mail_mailout( email_recipients, sender, email_subject, content_html, content_plain, bcc_recipients=[], salutation='' )

    body "content_html" => content_html, "content_plain" => content_plain, "salutation" => salutation
   
    # Email header info MUST be added here
    recipients email_recipients
    bcc bcc_recipients
    from  sender
    subject email_subject
    
  end

end
