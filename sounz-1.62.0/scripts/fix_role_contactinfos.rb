#!/usr/bin/env ../sounz/script/runner

# This script deletes multiple role contactinfos of the same contact type.
# Each role should have only 3 role contactinfos, one of each type:
# postal, physical, billing
# so if a 'duplicated'-type role contactinfo and associated contactinfo are
# empty and do not have any dependencies, they get deleted
# all other role contactinfos are written into a multiple_role_contactinfos_in_doubt_[now].csv file
# with the urls for an administrator

puts "---------- START SCRIPT -------------"

multiple_role_contactinfos_to_fix = ActiveRecord::Base.connection.execute(
	'SELECT role_id, contactinfo_type FROM 
	  (SELECT role_id, COUNT(role_contactinfo_id) AS counts, contactinfo_type FROM role_contactinfos GROUP BY role_id, contactinfo_type ORDER BY contactinfo_type) rc 
	    WHERE counts > 1;'
	 )

# the array to keep all role_contactinfos that are hard to decide 
# whether they should be deleted as they do contain some data or dependencies
# and require administrator attention
role_contactinfos_in_doubt = Array.new

if !multiple_role_contactinfos_to_fix.blank?
  
  # for reporting purposes and checks
  file_name = "roles_with_extra_role_contactinfos_" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + ".csv"
  
  csv_file = File.open(file_name, 'w')

  # column headers
  csv_file << ["role_id", "\t", "person_id", "\t", "organisation_id", "\t", "contact_name", "\t", "role_type_desc", "\r\n"]
    
  multiple_role_contactinfos_to_fix.each do |result|
    role_contactinfos = RoleContactinfo.find(:all, :conditions => ['role_id =? and contactinfo_type =?', result[0], result[1]])
	
    # role_contactinfos with empty contactinfo - to delete
    role_contactinfos_to_delete = role_contactinfos.select{ |rc| rc.contactinfo.is_empty? }
  
    role_contactinfos_with_nonempty_contactinfo = role_contactinfos.select{ |rc| !rc.contactinfo.is_empty? }
  
    # if there is at least one role contactinfo with non-empty contactinfo
    # delete all role_contactinfos_to_delete if they do not have any associations
    # with mailout_contacts and saved_contact_lists and contactinfo does not have any
    # depending contactinfos through default_contactinfos
    if !role_contactinfos_with_nonempty_contactinfo.blank?
  	  role_contactinfos_to_delete.each do |rc|
  	  
  	  	role = rc.role
  	  	# "role_id", "\t", "person_id", "\t", "organisation_id", "\t", "contact_name", "\t", "role_type_desc", "\r\n"
  	  	csv_file << [role.role_id, "\t", role.person_id, "\t", role.organisation_id, "\t", role.role_contact_name, "\t", role.role_type.role_type_desc, "\r\n"]
		
	    if rc.mailout_contacts.blank? && rc.saved_contact_lists.blank? && rc.contactinfo.defaulting_contactinfos.blank?
  	  	  contactinfo = rc.contactinfo
		
		  rc_ready_to_delete = true
		  # if there is any associated default contactinfos delete it
		  if !contactinfo.default_contactinfo.blank?
		    rc_ready_to_destroy = false if !contactinfo.default_contactinfo.destroy 
		  end
		
		  if rc_ready_to_delete
		    contactinfo.destroy if rc.destroy
		  else
		    role_contactinfos_in_doubt.push(rc)
  	      end	
		
  	    else
  	  	  role_contactinfos_in_doubt.push(rc)
  	    end
	  
      end
  
    else
  	  # it is hard to decide programmatically which one should be deleted in this case
  	  # put them all in role_contactinfos_in_doubt for manual actioning of an administrator
  	  role_contactinfos_in_doubt = role_contactinfos_in_doubt + role_contactinfos_to_delete
    end
  
  end
  
  csv_file.close
  
  puts "=============================================================="
  puts "Roles with extra role contactinfos are written to: #{file_name}"
end

puts "================================================"
puts "============= Role Contactinfos in doubt========"

puts "Number of role_contactinfos_in_doubt: " + role_contactinfos_in_doubt.length.to_s

if role_contactinfos_in_doubt.length > 0
  file_name = "multiple_role_contactinfos_in_doubt_" + Time.now.strftime("%Y-%m-%d %H:%M:%S") + ".csv"
  
  puts "role_contactinfos_in_doubt are in " + file_name
  
  csv_file = File.open(file_name, 'w')

  # column headers
  csv_file << ["role_id", "\t", "role_contactinfo_id", "\t", "url", "\r\n"]

  website_url = 'http://' + Setting.get_value(Setting::WEBSITE_URL) + '/'

  role_contactinfos_in_doubt.each do |rc|
    record = "#{rc.role_id}\t#{rc.role_contactinfo_id}\t#{website_url}role_contactinfos/edit/#{rc.role_id}?role_contactinfo=#{rc.role_contactinfo_id}"  
  
    csv_file << [record, "\r\n"]

  end

  csv_file.close

end

puts "---------- END SCRIPT -------------"
	 