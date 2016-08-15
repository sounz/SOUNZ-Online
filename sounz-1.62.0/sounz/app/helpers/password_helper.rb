module PasswordHelper
  
  # Request a password change 
  def self.request_change_for_login(login)
    

    
    pcr = create_password_change_request(login)
    
    
    notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)
    
    email_subject = 'Password Change Request Made'
    
    # email content
    # get submitted form url
    website_url = Setting.get_value(Setting::WEBSITE_URL)
    submission_url = 'http://' + website_url + '/password/change/' + pcr.activation_key
    submission_url_html = '<a href="' + submission_url + '">' + submission_url + '</a>'
    
    
    
    text_note_template = ERB.new <<-EOF
A request to change your password has been initiated for SOUNZ.  

To change your password please click on the following link:

<%=submission_url%>

If you do not wish to change your password then ignore this email.
EOF

  html_version_template = ERB.new <<-EOF
<p>A request to change your password has been initiated for SOUNZ.</p>  

<p>To change your password please click on the following link:</p>
<%=submission_url_html%>
<p>If you do not wish to change your password then ignore this email.</p>
EOF

      plain_text_version = text_note_template.result(binding)
      html_version = html_version_template.result(binding)
      
      name = "SOUNZ Administrator"
      email_recipient = login.username
      
      mailing = Mailing::deliver_mail_mailout(login.username,
       notification_sender,
        email_subject, 
        html_version, 
        plain_text_version
      )
      
=begin
mailing = Mailing::deliver_mail_mailout(
"gordon@catalyst.net.nz",
  "gordon.b.anderson@gmail.com",
   "EMail subject", 
   "<h1>HTML Version</h1>", 
   "Plain version"
 )
=end
      
  end
  
  
=begin 
      # Email header info MUST be added here
      recipients email_recipient
      from  Setting.get_value('ReminderNoticeSenderEmail')
      subject "SOUNZ Online Library Reminder Notice"
      body :note => note, :name => name, :items => item_text
  end
  
  password_change_request_id | integer                     | not null default nextval('password_change_request_id_seq'::regclass)
  requested_by_login_id      | integer                     | not null
  created_at                 | timestamp without time zone | not null
  updated_at                 | timestamp without time zone | not null
  processed                  | boolean                     | not null default false
  activation_key             | text                        |
  
=end


  def self.create_password_change_request(login)
    pcr = PasswordChangeRequest::new
    pcr.requested_by_login_id = login.login_id
    pcr.processed=false
    random_string = Time.now.to_i.to_s + login.salt+login.password+login.updated_at.to_i.to_s
    pcr.activation_key=Digest::MD5.hexdigest(random_string).upcase
    pcr.processed = false
    pcr.save! #This will fail if the save does not work
    pcr
  end
  
end
