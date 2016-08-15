#!/usr/bin/env ../../sounz/script/runner

# Script that:
# deletes all expired by date (expiry_date is less than now) and by count of subscription items
# memberships


# get expired by date memberships
now  = Time.now.strftime("%Y-%m-%d %H:%M:%S")
all_expired_memberships_by_date = Membership.get_expiring_memberships(from=nil, now)

# merge them with expired by count memberships
all_expired_memberships = all_expired_memberships_by_date.merge(Membership.get_expired_by_count_memberships)

#RAILS_DEFAULT_LOGGER.debug "DEBUG: delete_expired_memberships.rb all_expired_memberships #{all_expired_memberships}"

all_expired_memberships.each { |key, value|
    
  logins = Array.new

  # memberships
  memberships = value
  
  memberships.each do |m|
  	logins.push(m.login)
    logins.pop if !m.destroy
  end
  
  # send a standard email-notification to SOUNZ administrators
  MembershipHelper.expired_membership_notification_email_to_administrators(logins, key)
  
  # get expired members usernames (emails)
  recipients = Array.new
  logins.each do |l|
	
	username = l.username
	
	username = l.username.to_s + "<info@sounz.org.nz>" unless username.to_s=~/\@/
  	
	recipients.push(username)
  end
  
  #RAILS_DEFAULT_LOGGER.debug "DEBUG: delete_expired_memberships.rb recipients #{recipients}"
  
  member_type = key.gsub('s expired by count of subscription items', '').strip
  
  #RAILS_DEFAULT_LOGGER.debug "DEBUG: recipients #{recipients.inspect}"
  # send a standard email-notification to the expired members
  MembershipHelper.expired_membership_notification_email_to_members(recipients, member_type)

}


