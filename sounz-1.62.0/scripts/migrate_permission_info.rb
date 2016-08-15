#!/usr/bin/env ../sounz/script/runner

# This script migrates permission information from Work internal note
# to related manifestations internal notes as requested in WR#51526

# The use of the script: ruby migrate_permission_info.rb

# The script outputs permission_info_migration_results.csv showing the 
# transformed records

# RUN IT ONLY ONCE!!!!

puts "--- START SCRIPT ---"

results = Array.new
results.push("work_id \t\t work_internal_note \t\t permissions \t\t manifestation_id \t\t manifestation_internal_note")

works_with_permission_info = Work.find(:all, :conditions => ["internal_note ilike (?)", '%permissions%'])

works_with_permission_info.each do  |work|
	permissions = work.internal_note.match(/(permissions).*/i)

	permission_info = permissions[0]
	
	work.related_manifestations.each do |manifestation|
		# append permission info to manifestation internal note
		manifestation_internal_note = manifestation.internal_note
		manifestation_internal_note << " " << permission_info
		
		# save new internal note
		manifestation.update_attribute('internal_note', manifestation_internal_note)
		
		# for tracking purposes
		result = work.work_id.to_s + "\t\t" + work.internal_note.gsub(/[\r\n\t]/, ' ').strip + "\t\t" + permission_info.gsub(/[\r\n\t]/, ' ').strip
		result = result + "\t\t" + manifestation.manifestation_id.to_s + "\t\t" + manifestation.internal_note.gsub(/[\r\n\t]/, ' ').strip
	
		results.push(result)
	end
end



puts "================================================"
puts "============= TRANSFORMED RECORDS =============="

puts "Number of transformed records: " + (results.length-1).to_s

if results.length > 1
  file_name = "permission_info_migration_results.csv"
  puts "Transformed records are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  results.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "--- END SCRIPT ---"