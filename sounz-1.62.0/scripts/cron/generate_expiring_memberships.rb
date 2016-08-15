#!/usr/bin/env ../../sounz/script/runner

# Script that:
# creates the saved contact lists of the role contactinfos of memberships
# that expire in the requested period - currently between 21 days
# from now and 28 days from now -
# and sends the notification email to SOUNZ administrators with the links
# to those saved contact lists
# If the process fails - sends emails about failure to Catalyst administrators
# (email values are in settings table)

# prepare date from and date to range for expiring memberships
from_i = Setting.get_value('ExpiringMembershipsDayFromNowFrom').to_i
to_i   = Setting.get_value('ExpiringMembershipsDayFromNowTo').to_i

from   = from_i.day.from_now.strftime("%Y-%m-%d")
to     = to_i.day.from_now.strftime("%Y-%m-%d")

from_s = from.to_s + " 00:00:00"
to_s   = to.to_s + " 23:59:59"

all_expiring_memberships_by_date = Membership.get_expiring_memberships(from_s, to_s)

all_expiring_memberships = all_expiring_memberships_by_date

all_expiring_memberships.each { |key, value|

  # create saved_contact_list
  saved_contact_list            = SavedContactList.new
  saved_contact_list.list_name  = key + "s expiring " + from.to_s + " -- " + to.to_s
  saved_contact_list.updated_by = Login.find(:first, :conditions => ['username ilike ?', '%batch%'])

  # role_contactinfos array for saved_contact_list
  role_contactinfos = Array.new

  # get logins
  logins = value.map {|v| v.login}

  # get 'Postal' role contactinfos
  logins.each do |l|
    if !l.person.blank?
      # for consistency with ERP processing
      # get 'Person' role contactinfo of the
      # associated person
      # TODO maybe logins person_id/organisation_id
      # should be replaced by role_id??? then change
      # processing in the script
      person = l.person
      role   = Role.get_role_by_role_type(type_s='Person', person_id=person.person_id, organisation_id='')

    elsif !l.organisation.blank?
      # currently get 'Organisation' role contactinfo of 
      # the associated organisation
      # TODO maybe logins person_id/organisation_id
      # should be replaced by role_id??? then change
      # processing in the script
      role = Role.get_organisation_primary_role(l.organisation.organisation_id)
    end

    # 'Postal' role contactinfo of 'Person' or 'Organisation' role is selected for saved_contact_list
    # as this is the role contactinfo used in ERP
    if !role.blank?
      role_contactinfo = role.get_role_contactinfo_by_contactinfo_type('postal') 

      role_contactinfos.push(role_contactinfo)
    end
  end

  saved_contact_list.role_contactinfos = role_contactinfos

  if saved_contact_list.save()
    puts "SUCCESS: generate_expiring_memberships.rb - saved_contact_list #{saved_contact_list.list_name} is created"  

    # generating email to SOUNZ administrators
    # get recipients from 'settings' table
    recipients = Setting.get_value(Setting::EXPIRING_MEMBERSHIP_NOTIFICATION_RECIPIENT).split(',')

    # email content
    # get saved_contact_list url
    website_url = Setting.get_value(Setting::WEBSITE_URL)
    saved_contact_list_url = 'http://' + website_url + '/saved_contact_lists/edit/' + saved_contact_list.saved_contact_list_id.to_s
    saved_contact_list_url_html = '<a href="' + saved_contact_list_url + '">' + saved_contact_list_url + '</a>'

    html_version = '<p>'+ saved_contact_list.list_name + ':</p>'
    html_version += '<p>' + saved_contact_list_url_html + '</p>'

  else
    puts "ERROR: generate_expiring_memberships.rb - saved_contact_list #{saved_contact_list.list_name} IS NOT CREATED"

    # generating email to Catalyst administrators
    # get recipients from 'settings' table
    recipients   = Setting.get_value(Setting::ERROR_RECIPIENT).split(',')

    html_version = '<p>Generation of ' + saved_contact_list.list_name + ' has failed</p>'
  end

  # COMMON PARAMETERS
  email_subject = saved_contact_list.list_name

  # use the same text for plain text version but without html tags
  text = html_version.strip || ''
  plain_text_version = text.gsub(/<(\/|\s)*[^>]*>/,'')  

  # get sender from 'settings' table
  notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)  

  # send mail
  recipients.each do |recipient|
    mailing = Mailing::deliver_mail_mailout(recipient, notification_sender, email_subject, html_version, plain_text_version)  
  end
}



