class SounzService < ActiveRecord::Base

  set_primary_key 'sounz_service_id'
  set_sequence_name 'manifestations_manifestation_id_seq'

  has_many :memberships
  
  STANDARD_LIBRARY_MEMBERSHIP = SounzService.find(:first, :conditions => ['sounz_service_name ilike ?', '%SOUNZ Standard Library Membership%'])

  #
  # Return services with subscription count
  # 
  def self.subscription_count_services(sounz_service = nil)
        conditions = "subscription_item_count <> 0"
        conditions += "  AND sounz_service_name ilike '%#{sounz_service}%'" unless sounz_service.blank?
  	return SounzService.find(:all, :conditions => conditions)
  end
  
  def subscription_duration_hash
  	subscription_duration_array = self.subscription_duration.split(' ')
	interval = subscription_duration_array[1]
	interval = interval.gsub('mon', 'month') # special case for month
	subscription_duration_hash = { :number => subscription_duration_array[0], :interval => interval }
	
	logger.debug "DEBUG: subscription_duration_hash #{subscription_duration_hash}"
	return subscription_duration_hash
  end
  
end
