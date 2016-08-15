#!/usr/bin/env ../sounz/script/runner

# This script adds sounz_service_id data as well as loan_counts into memberships created 
# before the field 'loan_count' was added to the memberships table to the appropriate 
# ('Standard Library Membership') memberships records

# get all library memberships
library_memberships_to_check = Membership.find(:all, :joins => 'inner join member_types using (member_type_id)', 
	                                           :conditions => ['member_type_desc ilike ?', '%library member%'])

puts "== library_memberships_to_check =========== "
puts "library_memberships_to_check count: " + library_memberships_to_check.length.to_s
puts library_memberships_to_check.to_yaml

library_memberships_to_check.each do |lm|
      
  if lm.sounz_service_id.blank?
      # get sounz_service_id from zencartorders and zencartorders_products
      product_id = ActiveRecord::Base.connection.execute("SELECT products_id FROM zencartorders INNER JOIN zencartorders_products " + 
  	                                                      " USING (orders_id) INNER JOIN sounz_services ON sounz_service_id = products_id" + 
		                                                  " WHERE customers_id = #{lm.login_id}" +
				    									  #"  AND date_purchased = '#{lm.purchased_date}'" +
					    								  "  AND sounz_service_name ILIKE '%standard library membership%'"
	                                                      )
	  RAILS_DEFAULT_LOGGER.debug "DEBUG: add_sounz_service_id_to_memberships.rb - product_id #{product_id[0]}"
	
	  # if service is found in orders
	  if !product_id[0].blank?
	    membership = Membership.find(lm.membership_id)
	    service_id = product_id[0].to_s
	  
	    # update memberships relevant attributes
	    membership.sounz_service_id = service_id.to_i
	    membership.loan_count = membership.loan_count.to_i + 25 if membership.loan_count.to_i <= 0
	  
	    membership.save
	  end
  end
end

