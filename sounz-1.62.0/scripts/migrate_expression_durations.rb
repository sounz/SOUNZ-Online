#!/usr/bin/env ../sounz/script/runner
require 'csv'

# This script migrates 4D duration data into expression duration field
# The match is based on the following logic:
# - find Manifestation by manifestation code (column 1);
# - find Manifestation's expressions
# - Manifestation's Expression that belongs to a work with the work title (column 2) is the match
# and gets the record duration (column 3)
# The use of the script: ruby migrate_expression_durations.rb > expression_duration_migration_output.txt

csv = CSV::parse(File.open("expression_durations_to_import.csv") {|f|f.read})

line_number = 1

unmatched   = Array.new

puts "--- START MIGRATION ---"

csv.each do |record|
  if record[0] != nil || record[1] != nil || record[2] != nil || record[3] != nil || record[4] != nil || record[5] != nil
    puts "---------------------------"
    puts "record #{line_number}: #{record}"
  
    manifestation_code = record[0]
	
	# transform manifestation code where needed as
	# 4D data does not insert the '0' before codes in the 100s - 
	# eg in TAP it will be '0123'; in 4D it is just '123'
	if manifestation_code != nil && manifestation_code.match(/^(\d\d\d){1}$/)
	  puts "--- three digit match: #{manifestation_code}"
	  manifestation_code = "0" + manifestation_code
	  puts "--- transformed three digit match: #{manifestation_code}"
	end
  
    work_title         = record[1]
  
	duration           = record[2] + ":" + record[3] + ":" + record[4]
	
	legacy_duration    = record[5]
		
	if manifestation_code != nil && work_title != nil && record[3].to_i < 60 && record[4].to_i < 60
      puts "MATCHING manifestation_code: #{manifestation_code} work_title: #{work_title} duration: #{duration}"
		
	  matches = Expression.find(:all,
		:select => 'expression_id, expression_title, manifestation_code, manifestation_title, work_id, work_title',
		:joins => 'INNER JOIN expression_manifestations USING (expression_id) INNER JOIN manifestations USING (manifestation_id) INNER JOIN works USING (work_id)',
		:conditions => ['manifestation_code =? AND work_title =?', manifestation_code, work_title]
	     )
	
	  if !matches.blank? && matches.length == 1
	    expression = Expression.find(matches[0].expression_id)
	    if !expression.blank?
	     puts "MIGRATED" if expression.update_attribute('duration', duration)
	    end
	    puts "MATCH: expression #{expression.expression_id}"
	  else
	    # get unmatched records
		record_string = record[0].to_s + ",," + work_title.to_s + ",," + duration.to_s
	    puts "UNMATCH: record #{record_string}"
	    unmatched.push(record_string)
	  end
	else
	  # get unmatched records
	  record_string = record[0].to_s + ",," + work_title.to_s + ",," + duration.to_s + ",," + legacy_duration.to_s
	  puts "FIRST CHECK UNMATCH: record #{record_string}"
	  unmatched.push(record_string)
	end	  
	line_number = line_number + 1
  end
  
end
puts "--- END MIGRATION ---"

# output unmatched records
puts "================================================"
puts "============= UNMATCHED RECORDS ================"
unmatched.each do |r|
  puts r
end
