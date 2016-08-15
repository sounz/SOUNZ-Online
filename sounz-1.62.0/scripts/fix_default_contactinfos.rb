#!/usr/bin/env ../sounz/script/runner

# This script deletes multiple default contactinfos that were product of previous processing
# where multiple default contact infos were allowed and leaves only one contactinfo to default
# for the roles that have a person and an organisation associated with it.

# Now for simplicity we limit a contactinfo to have only one contactinfo to default

contactinfos_with_multiple_default_contactinfos = ActiveRecord::Base.connection.execute(
	'SELECT contactinfo_id FROM 
	  (SELECT contactinfo_id, COUNT(contactinfo_id) AS count FROM default_contactinfos GROUP BY contactinfo_id) ci 
	 WHERE ci.count > 1'
	 )

no_contactinfo_to_default = Array.new

contactinfos_with_multiple_default_contactinfos.each do |result|
  contactinfo = Contactinfo.find(result[0])
  role_to_default = nil
  
  if !contactinfo.blank?
    # get role to get to an associated organisation 
  	role = contactinfo.role_contactinfo.role unless contactinfo.role_contactinfo.blank?
	
	contactinfo_type = contactinfo.role_contactinfo.contactinfo_type unless contactinfo.role_contactinfo.blank?
	
	if !role.blank?
	  organisation = role.organisation
	  
	  if !organisation.blank?
	    role_to_default = Role.get_organisation_primary_role(organisation.organisation_id)
		contactinfo_to_default = role_to_default.get_role_contactinfo_by_contactinfo_type(contactinfo_type).contactinfo
		
		associated_default_contactinfos = DefaultContactinfo.find(:all, :conditions => ['contactinfo_id =?', contactinfo.contactinfo_id])
		
		if !contactinfo_to_default.blank?
		  associated_default_contactinfos.each do |assoc_dc|
			assoc_dc.destroy unless assoc_dc.d_contactinfo_id == contactinfo_to_default.contactinfo_id
		  end

		else
		  # Error situation????
		  no_contactinfo_to_default.push(contactinfo)
	    end
		
	  else
		# Error situation????
		no_contactinfo_to_default.push(contactinfo)	  		
	  end
	  
    else
	  # Error situation????
	  no_contactinfo_to_default.push(contactinfo)    	
    end
			
  end

end

puts "----------- No contactinfo to default ----"
no_contactinfo_to_default.each do |ci|
	puts ci.contactinfo_id
end

	 