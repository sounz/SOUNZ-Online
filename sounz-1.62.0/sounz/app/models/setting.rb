# This model keeps track of the applications settings like, for example, 
# website url, administrator email, etc 
class Setting < ActiveRecord::Base
  set_primary_key "setting_id"
  
  HOME_PAGE_CONTRIBUTORS_LIST = "front_page_contributors"
  HOME_PAGE_CTR_KEY = "front_page_ctr"
  
  HOME_PAGE_MANIFESTATIONS_LIST = "front_page_manifestations"
  HOME_PAGE_EVENTS_LIST = "front_page_events"
  
  HOME_PAGE_SOUNZMEDIA_LIST = "front_page_sounzmedia"
  
  WEBSITE_URL = "WebsiteURL"
  
  SUBMISSION_NOTIFICATION_SENDER_EMAIL = "SubmissionNotificationSenderEmail"
  
  CAMPAIGN_MAILOUT_SENDER_EMAIL = "CampaignMailoutSenderEmail"
  
  EXPIRING_MEMBERSHIP_NOTIFICATION_RECIPIENT = "ExpiringMembershipsNotificationRecipient"
  
  ERROR_RECIPIENT = "ErrorRecipient"

  FAILED_ORDERS_NOTIFICATION_RECIPIENT = "FailedOrdersNotificationRecipient"

  # model validation
  validates_presence_of :setting_name,
                        :setting_value,
            :message => "cannot be empty"
 
  validates_uniqueness_of :setting_name,
              :message => "Must be unique"

  #Set a value: Setting.set_value(key,value)
  def self.set_and_possibly_create(name,value)
    setting_instance = Setting.find(:first, :conditions => ["setting_name = ?", name])
    if setting_instance.blank?
      setting_instance = Setting::new
      setting_instance.setting_name = name
    end
    setting_instance.setting_value = value
    setting_instance.save
  end
  
  
  #Set a value: Setting.set_value(key,value)
  def self.set_value(name,value)
    setting_instance = Setting.find(:first, :conditions => ["setting_name = ?", name])
    raise ArgumentError, "Unable to find a setting of name #{name}" if setting_instance.blank?
    setting_instance.setting_value = value
    setting_instance.save
  end
  
  
  #Get a setting value
  def self.get_value(name)
    setting_instance = Setting.find(:first, :conditions => ["setting_name = ?", name])
    raise ArgumentError, "Unable to find a setting of name #{name}" if setting_instance.blank?
    return setting_instance.setting_value
  end
  
  #Increment a numerical value
  def self.increment_value_by_key(name)
    setting_instance = Setting.find(:first, :conditions => ["setting_name = ?", name])
    raise ArgumentError, "Unable to find a setting of name #{name}" if setting_instance.blank?
    setting_instance.setting_value = (setting_instance.setting_value.to_i + 1).to_s
    setting_instance.save
    return setting_instance.setting_value.to_i
  end
end
