#!/usr/bin/env ../sounz/script/runner

# This script creates a role of 'Person' role type for person records
# that do have a login assigned to them but are missing the role of 
# 'Person' role type that is necessary for Ecommerce processing

# The use of the script: ruby create_person_role_for_person_logins.rb

# The script outputs people_with_person_role_created.csv and 
# failed_person_role_creation_records.csv showing the 
# transformed and failed records

puts "--- START SCRIPT ---"

people_with_person_role_created     = Array.new
failed_person_role_creation_records = Array.new

updated_by = Login.find(:first, :conditions => ['username =?', 'batch']) # updated by batch

person_logins = Login.find(:all, :conditions => ['person_id is not null'])

person_logins.each do  |login|
	person = login.person
	
	if !person.roles.map{|r| r.role_type.role_type_desc}.include?('Person')
	  
	  role = Role.new(:person_id => person.person_id, :updated_by => updated_by.login_id)
	
	  if role.create_self(updated_by)	  
	    people_with_person_role_created.push(person.person_id)
	  else
	  	failed_person_role_creation_records.push(person.person_id)
	  end
	   
	end

end



puts "================================================"
puts "====== People with person role created ========="

puts "Number of results: " + (people_with_person_role_created.length).to_s

if people_with_person_role_created.length > 1
  file_name = "people_with_person_role_created.csv"
  puts "People with person role created are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  people_with_person_role_created.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "================================================"
puts "====== Failed person role creation records ====="

puts "Number of results: " + (failed_person_role_creation_records.length).to_s

if failed_person_role_creation_records.length > 1
  file_name = "failed_person_role_creation_records.csv"
  puts "Failed person role creation records are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  failed_person_role_creation_records.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "--- END SCRIPT ---"