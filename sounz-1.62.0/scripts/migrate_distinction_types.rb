#!/usr/bin/env ../sounz/script/runner

# This script migrates distinction types from distinction internal note into distinction_distinction_types
# table as per WR#50291 and DISTINCTIONS rev 300308.doc of WR#50294

# The use of the script: ruby migrate_distinction_types.rb

# The script outputs distinction_types_not_migrated.csv if there are any of the distinction types 
# that failed migration

not_migrated   = Array.new

puts "--- START MIGRATION ---"

distinctions_with_types = Distinction.find(:all, :conditions => ['internal_note IS NOT NULL'])

distinction_types = DistinctionType.find(:all)

distinctions_with_types.each do  |distinction|
  distinction_types.each do |type|
  	if distinction.internal_note.downcase.strip.split(', ').include? type.distinction_type_name.downcase || distinction.internal_note.downcase.match(type.distinction_type_name.downcase) 
  	  d_distinction_type = DistinctionDistinctionType.new(:distinction_id => distinction.id, 
  	  	                                                  :distinction_type_id => type.id
  	                                                     )
	  not_migrated.push(distinction.id.to_s + ",," + type.distinction_type_name) if !d_distinction_type.save
  	end
  end

end

puts "--- END MIGRATION ---"

puts "================================================"
puts "============= NOT MIGRATED RECORDS ================"

puts "Number of not-migrated: " + not_migrated.length.to_s

if not_migrated.length > 0
  file_name = "distinction_types_not_migrated.csv"
  puts "Not-migrated are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  not_migrated.each do |r|
    csv_file << [r, "\r\n"]
  end
end
