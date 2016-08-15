require 'digest/sha2'
require 'digest/md5'

class Login < ActiveRecord::Base
  set_primary_key :login_id
  
  belongs_to :person
  belongs_to :organisation
  
  has_many :memberships, :dependent => :destroy
  has_many :member_types, :through =>  :memberships
  
  #The updated by relationships
  has_many :superworks, :foreign_key => :updated_by
  has_many :works, :foreign_key => :updated_by
  has_many :contributors, :foreign_key => :updated_by
  has_many :expressions, :foreign_key => :updated_by
  has_many :manifestations, :foreign_key => :updated_by
  has_many :events, :foreign_key => :updated_by
  has_many :venues, :foreign_key => :updated_by
  has_many :distinctions, :foreign_key => :updated_by
  has_many :items, :foreign_key => :updated_by
  has_many :resources, :foreign_key => :updated_by
  has_many :samples, :foreign_key => :updated_by
  has_many :concepts, :foreign_key => :updated_by
  has_many :distinction_instances, :foreign_key => :updated_by
  has_many :contactinfos, :foreign_key => :updated_by
  has_many :people, :foreign_key => :updated_by
  has_many :organisations, :foreign_key => :updated_by
  has_many :communications, :foreign_key => :updated_by
  has_many :marketing_campaigns, :foreign_key => :updated_by
  has_many :campaign_mailouts, :foreign_key => :updated_by
  has_many :projects, :foreign_key => :updated_by
  has_many :saved_contact_lists, :foreign_key => :updated_by
  has_many :mailout_contacts, :foreign_key => :updated_by
  has_many :saved_searches, :foreign_key => :updated_by
  has_many :media_items, :foreign_key => :updated_by
  has_many :news_articles, :foreign_key => :updated_by
  
  has_many :password_change_requests, :foreign_key => :requested_by_login_id
  
  
  acts_as_solr :fields => [
    :username_for_solr,
    :name_for_solr
  ]

def username_for_solr
  FinderHelper.strip(username)
end

def name_for_solr
  FinderHelper.strip(name)
end
  
def new_password=(pass)
    #salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    myMD5=Digest::MD5.hexdigest(pass)
    salt=myMD5[0..2]
    self.salt, self.password =salt, Digest::MD5.hexdigest(salt+pass)+":"+salt
    logger.debug("PWD, SALT: #{self.password},#{self.salt}")
    save
  end
  
  def self.authenticate(username, pass)
    user = Login.find(:first, :conditions => ['username ILIKE ?', "#{username}"])
    
    
    
    if user == nil
      raise LoginException.new("Username or password invalid")
    else
      if user.blank?
        raise LoginException.new("Username or password invalid")
      else 
        passwd,salt=user.password.split(':')
      #  logger.debug("PWD,SALT: #{passwd} #{salt}")
       # logger.debug("DIGEST PWD: #{Digest::MD5.hexdigest(salt+passwd)}")
        if Digest::MD5.hexdigest(salt+pass) != passwd
        failed_logins = user.login_fail_count
        user.login_fail_count = failed_logins +1
        user.save
        raise LoginException.new("Username or password invalid")
        else
        #do nothing
        end
      end
    end
    user
    
  end
  
  #Check if a logged in user has rights to edit - this will involve the optional addition of links to
  # a page.  Usage example:  has_rights_to_edit?(:works)
  def has_rights_to_edit?(type_symbol)
    return true
  end
  
  
  #Check if the login is a superuser
  def is_superuser?
    #FIXME - this line results in the following queries:
    #[sounz_development, 2007-11-19 22:33:31 NZDT] LOG:  statement: SELECT * FROM memberships WHERE (memberships.login_id = 1) 
    #[sounz_development, 2007-11-19 22:33:31 NZDT] LOG:  duration: 0.435 ms
    #[sounz_development, 2007-11-19 22:33:31 NZDT] LOG:  statement: SELECT * FROM member_types WHERE (member_types.member_type_id = 6) 
    #[sounz_development, 2007-11-19 22:33:31 NZDT] LOG:  duration: 0.258 ms
    types = self.memberships.map{|m| m.member_type}.flatten.uniq
    
    #The login is a superuser
    return types.include?(MemberType::SUPERUSER)
   # return true
  end
  
  # -------------------------------------------
  # - Check if a logged in user has requested -
  # - member_type                             -
  # -------------------------------------------
  def has_membership?(member_type_desc)
    has_member_type = false
    
    member_types.each do |mt|
      if mt.member_type_desc.downcase.match(member_type_desc.downcase)
        has_member_type = true
      end
    end

    return has_member_type
  end
  
  # --------------------------
  # - Return all user emails -
  # --------------------------
  def get_user_emails
    emails = Hash.new
    if !person.blank?
      user_contactinfos = person.roles.collect{ |r| r.role_contactinfos.collect{|rc| rc.contactinfo }}.flatten.compact
      user_contactinfos.each do |c|
        emails.store(c.email_1, c.email_1) unless c.email_1.blank?
        emails.store(c.email_2, c.email_2) unless c.email_2.blank?
        emails.store(c.email_3, c.email_3) unless c.email_3.blank?
      end
    end
    logger.debug "******** LOGIN: GET USER EMAILS array:  #{emails} ***"
    return emails
  end

validates_uniqueness_of :username,
  :allow_nil => false,
  :message => "Your username is already taken. Please choose another"
  
validates_presence_of :password,
  :message => "is not acceptable."


  def name
    return Login.get_name(self.login_id)
  end

  # -------------------------------------------------------------------------
  # - Return:
  # - person full name if a person is associated with the login or
  # - organisation abbrev/name if an organisation associated with the login
  # - else
  # - return username
  # -------------------------------------------------------------------------
  def self.get_name(login_id)
    name = ''
    if !login_id.blank?
      login = Login.find(login_id)
      
      if !login.person.blank?
        name = login.person.full_name
      else
        if !login.organisation.blank?
          name = login.organisation.organisation_list_name(true)
        else
          name = login.username
        end
      end

    end
    
    return name 
  end
  
  #
  # Return personal salutation if login is associated with a person
  # else return 'Dear Sir/Madam'
  #
  def get_salutation
    salutation = 'Dear '
	
	# personal salutation if possible
	if !self.person.blank?
	  name  = self.person.full_name
	  nomen = self.person.nomen.nomen unless self.person.nomen.blank?
	  
	  salutation += nomen + " " unless nomen.blank?
		
	  salutation += name
	else
	  salutation += "Sir/Madam"
	end
	
	return salutation
  end

  # Return the url to the associated contact general details
  def get_contact_url

    contact_url = ''

    website_url = Setting.get_value(Setting::WEBSITE_URL)

    if !self.person.blank?
      contact_url = "http://#{website_url}/people/edit/#{person_id}"
    elsif !self.organisation.blank?
      contact_url = "http://#{website_url}/organisations/edit/#{organisation_id}"
    end

    return contact_url

  end

  #- Return all the roles that can be associated with this login, this is either
  #- organisation roles
  #- OR
  #- people roles
  
  def associated_roles
    result = []
    if !person.blank?
      result << person.roles
    end
    
    if !organisation.blank?
      result << organisation.roles
    end
    result.flatten
  end
  
  #Obtain an array of all the unique role type groups a logins roles belong to.  Delete the empty one,
  #which is a non contributor role type.  This method is used in the content managed pages to ascertain which
  #form links to show
  def associated_contributor_role_type_groups
    # WR#61000 - select only those roles that are flagged as a contributor
    contributor_roles = associated_roles.select{|r| r.role_type.role_type_group if r.is_a_contributor?}
    result = contributor_roles.map{|r| r.role_type.role_type_group}.uniq
    result.delete "" #Remove empty value
    result
  end
  
  
  def privileges_cache_key
    result = ''
    if is_superuser?
      result = 'superuser'
    else
      member_types = memberships.map{|m| m.member_type}.flatten.uniq
      member_type_privileges = member_types.map{|mt| mt.member_type_privileges}
      assigned_privileges = member_type_privileges.flatten.map{|mtp| mtp.privilege}.uniq.sort_by{|p| p.privilege_name}
      result = assigned_privileges.join('|')
    end
    

    
    result
  end

  def create_moneyworks_file
    filename="Name_#{DateTime::now().strftime('%Y-%m-%d')}_#{login_id}.csv"
    filepath=Setting.get_value('MONEYWORKS_EXPORT_FOLDER')
  
    logger.debug("MONEYWORKS: CREATING MONEYWORKS FILENAME: #{filepath}/#{filename}")
    File.open("#{filepath}/#{filename}", "wb") do |f| 
      f.write("#{id},#{username},#{Time.now()}\n")
    end
  end

  def borrowedMusicItems
  
    borrowedItems = BorrowedItem.find(:all, :joins => 'inner join items using (item_id)', 
  	  :conditions =>['borrowed_items.login_id=? AND manifestation_id IS NOT NULL AND active IS TRUE AND out_on_loan_or_hire=true AND reserved IS NOT TRUE', self.login_id],
  	  :order => 'date_due')
  
  end

  def borrowedResourceItems
  
    borrowedItems=BorrowedItem.find(:all, :include => [ :item ], 
  	  :conditions =>['borrowed_items.login_id=? AND items.resource_id IS NOT NULL AND borrowed_items.active IS TRUE AND items.out_on_loan_or_hire=true AND reserved IS NOT TRUE', self.login_id],
  	  :order => 'date_due')

  end

  def hasBorrowedItems
    if !self.borrowedMusicItems.blank? || !self.borrowedResourceItems.blank?
      logger.debug(self.borrowedMusicItems.to_yaml)
      return true
     end
  
    return false
  end
  
  # If the logged in user has a default role contactinfo -
  # (role contactinfo of 'postal' type of 'Person'/'Organisation'
  # role), add this role contactinfo to the saved contact list requested;
  # else send an email-notification to a SOUNZ administrator
  def add_to_saved_list(saved_list_name)
    success = false
	
	saved_list = SavedContactList.get_saved_list_by_name(saved_list_name)
			
	# if the list does not exist, create it
	if saved_list.blank?
	  saved_list = SavedContactList.new(:list_name => saved_list_name, :updated_by => 1000)
	  saved_list.save
	end
	
	default_role_contactinfo = self.get_default_role_contactinfo
	
	if !default_role_contactinfo.blank?
	  success = saved_list.add_contact(default_role_contactinfo)
	end
		
	# send notification email to SOUNZ admin in case of failure
	if success == false
	  # get recipient from 'settings' table
	  admin = Setting.get_value(Setting::CAMPAIGN_MAILOUT_SENDER_EMAIL)	 
			   
	  email_subject = saved_list_name
	  
	  saved_list_url = "http://#{Setting.get_value(Setting::WEBSITE_URL)}/saved_contact_lists/edit/#{saved_list.saved_contact_list_id}"
	  
	  # email content
	  html_version  = "<p>User '" + self.username + "' has requested to be added to '" + saved_list_name + "' saved contact list:</p>"
	  html_version += '<p><a href="' + saved_list_url + '">' + saved_list_url + '</a> </p>'
	  html_version += "But adding this user to the list has failed.</p><p>Please add the user manually to the list.</p>"
			 
	  # use the same text for plain text version but without html tags
	  text = html_version.strip || ''
	  plain_text_version = text.gsub(/<(\/|\s)*[^>]*>/,'')  
			
	  # get sender from 'settings' table
	  notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)  
			
	  # send mail
	  mailing = Mailing::deliver_mail_mailout(admin, notification_sender, email_subject, html_version, plain_text_version)  
	end
  end
  
  # Return the login's default role contactinfo - role contactinfo of 'postal' type of 
  # 'Person'/'Organisation' role if any
  def get_default_role_contactinfo
  	default_role_contactinfo = nil
	
	if ! self.person.blank?
		role_type = 'Person'
				
		person_id = self.person.person_id
				
		organisation_id = nil
		organisation_id = self.organisation.organisation_id unless self.organisation.blank?
				
	elsif ! self.organisation.blank?
		role_type = 'Organisation'
				
		person_id = nil
				
		organisation_id = self.organisation.organisation_id
	  
	else
		role_type = nil		
	end
	  
	if !role_type.blank?
	    default_role = Role.get_role_by_role_type(role_type, person_id, organisation_id)
			
		if !default_role.blank?
		  # 'postal' contactinfo type
		  default_role_contactinfo = default_role.get_default_role_contactinfo
		end
    end
	
	return default_role_contactinfo
	 
  end
  
  # Return true if a login contact (person/organisation)
  # has a 'Person'/'Organisation' role that is necessary
  # for ecommerce processing (without that role the contact
  # does not exist as a zencart customer - details are in
  # zencart_views.sql)
  def ecommerce_role_exists?
  	result = false
	
	person       = self.person
	person_id    = nil
	person_id    = person.person_id unless person.blank?
	
	organisation    = self.organisation
	organisation_id = nil
	organisation_id = organisation.organisation_id unless organisation.blank?	
	
	# the role type needed for ecommerce functionning
	ecommerce_role_type = nil
	if !person.blank?
	  ecommerce_role_type = 'Person'
	
	elsif !organisation.blank?
	  ecommerce_role_type = 'Organisation'
	end
	
	role = Role.get_role_by_role_type(ecommerce_role_type, person_id, organisation_id) unless ecommerce_role_type.blank?
	
	result = true unless role.blank?
	
	return result
	
  end

  # Return contact info of the contact info type requested
  # of the contact ecommerce ('Person'/'Organisation') role contactinfo
  def get_ecommerce_contactinfo(editor_login_id = nil, contactinfo_type = 'postal')

    contactinfo = ''

    if !self.person.blank?
      role_type = 'Person'
      person_id = self.person_id
      organisation_id = nil
    elsif !self.organisation.blank?
      role_type = 'Organisation'
      person_id = nil
      organisation_id = self.organisation_id
    end

    role = Role.get_role_by_role_type(role_type, person_id, organisation_id)

    if role.blank?
      role = Role.new

      role.person_id = person_id
      role.organisation_id = organisation_id

      updated_by = editor_login_id
      updated_by = Login.find(:first, :conditions => ['username =?', 'batch']).login_id if editor_login_id.blank?

      user_login = Login.find(updated_by)
      role.updated_by = updated_by

      role.create_self(user_login)
    end

    role_contactinfo = role.get_role_contactinfo_by_contactinfo_type(contactinfo_type)

    contactinfo = role_contactinfo.contactinfo

    return contactinfo

  end

end

class LoginException < Exception
end

