module ProviderPagesHelper
    
  # ------------------------------------------------
  # - Send email notification about new submission -
  # - of one of the provider forms                 -
  # - Take one parameter in the form               -
  # - model name + '_' object id                   -
  # - Ex. prov_feedbacks_12                        -
  # ------------------------------------------------
  def self.email_notification(model_id_s)
    
    RAILS_DEFAULT_LOGGER.debug "PASSING IN VALUE:#{model_id_s}"
    
    bits = model_id_s.split("_")
    # get id
    id_s = bits.pop
    
    # get submission category
    submission_category = bits.join(' ')
    submission_category = submission_category.gsub('prov ', '')
    
    model_name_s = bits.join('_')
        
    # get recipient from 'settings' table
    submission_recipient = model_name_s.to_s + '_recipient'
    recipient = Setting.get_value(submission_recipient)
    
    # get sender from 'settings' table
    notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)
    
    email_subject = 'New web submission - ' + submission_category.camelize + ' Form'
    
    # email content
    # get submitted form url
    website_url = Setting.get_value(Setting::WEBSITE_URL)
    submission_url = 'http://' + website_url + '/' + model_name_s.pluralize + '/' + id_s + ';edit'
    submission_url_html = '<a href="' + submission_url + '">' + submission_url + '</a>'
    
    html_version = '<p>There is a new web submission - ' + submission_category.capitalize + ' form. </p>'
    html_version += '<p> The form URL is: </p><p>' + submission_url_html + '</p>'
    
    # use the same text for plain text version but without html tags
    text = html_version.strip || ''
    plain_text_version = text.gsub(/<(\/|\s)*[^>]*>/,'')
    
    
    # send mail
    mailing = Mailing::deliver_mail_mailout(recipient, notification_sender, email_subject, html_version, plain_text_version)
  end
  
end
