#!/usr/bin/env ../sounz/script/runner
require 'csv'

# This script migrates manifestation codes from manifestation_codes_to_import.csv file
# The use of the script: ruby migrate_manifestation_codes.rb > manifestation_codes_migration.txt

csv = CSV::parse(File.open("manifestation_codes_to_import.csv") {|f|f.read})

line_number = 1

unmatched   = Array.new

puts "--- START MIGRATION ---"

csv.each do |record|
  if record[0] != nil

    puts "---------------------------"
    puts "record #{line_number}: #{record[0]}"
  
	cells = record[0].split(' ')
	manifestation_id = cells[0]
    manifestation = Manifestation.find(manifestation_id)
	manifestation_code = cells[1]
	
	if !manifestation.blank? && !manifestation_code.blank?
	  puts "MIGRATED" if manifestation.update_attribute('manifestation_code', manifestation_code)
	else
	  puts "UNMATCHED"
	  unmatched.push("#{record[0]}")
	end
  end
  line_number += 1
end
puts "--- END MIGRATION ---"

# output unmatched records
puts "================================================"
puts "============= UNMATCHED RECORDS ================"
unmatched.each do |r|
  puts r
end
