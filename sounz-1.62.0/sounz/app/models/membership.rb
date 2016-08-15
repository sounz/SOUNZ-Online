class Membership < ActiveRecord::Base

  set_primary_key :membership_id
  set_sequence_name "memberships_membership_id_seq"

  belongs_to :login
  belongs_to :member_type
  belongs_to :sounz_service

  def valid_membership?
  	
	if !self.sounz_service_id.blank? && self.member_type_id != SounzService.find(self.sounz_service_id).member_type_id
      return false
	else
	  return true
	end
	
  end
  
  #
  # Return the memberships that expire between the date range requested
  # as a Hash where key is member_type_desc and value is the membership 
  # objects
  #
  def self.get_expiring_memberships(date_from, date_to)
      
	member_types = MemberType.find(:all, :select => 'member_type_id, member_type_desc', :conditions => ["member_type_desc ilike ?", '%member%'])
	  
	#logger.debug "DEBUG: Membership.get_expiring_memberships - member_types: #{member_types.map{|mt| mt.member_type_desc}.join(', ')}"
	  
	all_expiring_memberships = Hash.new
	  
	member_types.each do |mt|
	  conditions = ''
	  	  
	  conditions = "expiry_date >= '" +  date_from.to_s + "' AND " unless date_from.blank?
	  
	  conditions += "expiry_date <= '" + date_to.to_s + "' AND member_type_id = " + mt.member_type_id.to_s
	  
	  #logger.debug "DEBUG: Membership.get_expiring_memberships - conditions: #{conditions}"
	  
	  expiring_memberships = Membership.find(:all, #:joins => 'inner join member_types using (member_type_id)', 
	  	                                     :conditions => conditions )
	  all_expiring_memberships.store(mt.member_type_desc, expiring_memberships) unless expiring_memberships.blank?
		
	end
	 
	return all_expiring_memberships
  end

  #
  # Decreament the loan count by number requested
  # if the membership is a subscription count membership
  #
  def decrease_loan_count(decrease_no=1)
    if self.is_subscription_item_count_membership?
      self.loan_count = self.loan_count - decrease_no
	  self.save
    end
  end
  
  #
  # Return 'true' if membership is the one with subscription count applicable,
  # currently only one membership - 'SOUNZ Standard Library Membership'
  # 
  def is_subscription_item_count_membership?
    check = false
	
	subscription_count_services_ids = SounzService.subscription_count_services.map{|ss| ss.sounz_service_id}
	check = true if subscription_count_services_ids.include? self.sounz_service_id
	
	return check
	
  end
  
  #
  # Return the subscription count applicable membership,
  # currently only one membership - 'SOUNZ Standard Library Membership'
  #
  def self.get_subscription_item_count_membership(login, sounz_service=nil)
    
  	subscription_count_services_ids = SounzService.subscription_count_services(sounz_service).map{|ss| ss.sounz_service_id}.join(',')
	return Membership.find(:first, :conditions => ['login_id =? AND sounz_service_id IN (?)', login.login_id, subscription_count_services_ids])
  
  end
  
  #
  # Return expired by count memberships
  # as a Hash where key is member_type_desc and value is the membership 
  # objects
  # 
  def self.get_expired_by_count_memberships
	  
	expired_by_count_memberships = Hash.new
	
	subscription_count_services_ids = SounzService.subscription_count_services.map{|ss| ss.sounz_service_id}.join(',')
    
	member_types = MemberType.find(:all, :select => 'member_type_id, member_type_desc', :conditions => ["member_type_desc ilike ?", '%member%'])
	
	member_types.each do |mt|
	  expired_memberships = Membership.find(:all, :conditions => ['sounz_service_id IN (?) AND loan_count < 1 AND member_type_id =?', 
	  	                                                           subscription_count_services_ids, mt.member_type_id] )
	
	
	  expired_by_count_memberships.store(mt.member_type_desc + 's expired by count of subscription items', expired_memberships) unless expired_memberships.blank?
	
	end
	logger.debug "DEBUG: Membership.get_expired_by_count_memberships - expired_by_count_memberships: #{expired_by_count_memberships}"
	
	return expired_by_count_memberships
  end
  
  #
  # Return true if the membership is expired either by date or number of subscribed items
  #
  def is_expired?
  	
	result = false
  		
	subscription_count_services_ids = SounzService.subscription_count_services.map{|ss| ss.sounz_service_id}
		
	if (!self.expiry_date.blank? && self.expiry_date < Time.now) || ((subscription_count_services_ids.include?self.sounz_service_id) && self.loan_count.to_i < 1)
	  result = true
	end
  
	return result
  end
  
  #
  # Set expiry_date, loan_count membership attributes for memberships associated with sounz_services
  # based on parameters or sounz_service_id if the params are blank
  # 
  def set_subscription_attributes(params)
    	
  	if !params[:sounz_service_id].blank?
  	  sounz_service = SounzService.find(params[:sounz_service_id]) 
	  
	  self.sounz_service_id = sounz_service.sounz_service_id
	  
	  # set loan_count only if it is appropriate for that sounz_service
	  if (!self.loan_count.blank? && sounz_service.subscription_item_count.blank?) || self.loan_count.blank?
	    self.loan_count     = sounz_service.subscription_item_count
	  end 
	  
	  start_date            = self.purchased_date
	  start_date            = Time.now if start_date.blank?
	  self.expiry_date      = start_date + sounz_service.subscription_duration_hash[:number].to_i.send(sounz_service.subscription_duration_hash[:interval]) if self.expiry_date.blank? 
	  
	end
	
	logger.debug self.to_yaml
	
	return self

  end
  
end
