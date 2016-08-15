#!/usr/bin/env ../sounz/script/runner

# This script migrates distinction instance relationship data into distinction_instance_relationships table
# The data should be first exported from distinction_relationships table (!!!BEFORE the the deployment of 
# the SOUNZ 1.16 release) (that has been used previously for recording disctinction_instance relationship 
# - mistake when designing the db schema, and now as we need to be able to add relationships to Distinction 
# entity itself, we have to vacate the distinction_relationships table for that) by using: 
# ruby export_and_delete_distinction_relationships.rb, which outputs distinction_instance_relationships_to_migrate.csv
# Then, run this script after the deployment of the sounz 1.16 release

# The use of the script: ruby migrate_distinction_instances.rb > distinction_instances_migration_output.txt

# The script outputs distinction_relationships_not_migrated.csv if there are any of the distinction instance 
# relationships that failed migration

require 'csv'



csv = CSV::parse(File.open("distinction_instance_relationships_to_migrate.csv") {|f|f.read})

line_number = 1

not_migrated   = Array.new

puts "--- START MIGRATION ---"

csv.each do |record|
  r_to_migrate_s = "#{record[0]},,#{record[2]},,#{record[4]},,#{record[6]},,#{record[8]}" 
  
  if record[2] != nil || record[4] != nil || record[6] != nil || record[8] != nil
    puts "---------------------------"
	
    puts "record #{line_number}: #{r_to_migrate_s}"

	distinction_instance_relationship = DistinctionInstanceRelationship.new
	
	distinction_instance_relationship.relationship_id         = record[2]
	distinction_instance_relationship.relationship_type_id    = record[4]
	distinction_instance_relationship.distinction_instance_id = record[6]
	distinction_instance_relationship.is_dominant_entity      = record[8]	

	
	not_migrated.push(r_to_migrate_s) if !distinction_instance_relationship.save
  else
  	not_migrated.push(r_to_migrate_s)
  end
  line_number = line_number + 1
  
end

puts "--- END MIGRATION ---"

puts "================================================"
puts "============= NOT MIGRATED RECORDS ================"

puts "Number of not-migrated: " + not_migrated.length.to_s

if not_migrated.length > 0
  file_name = "distinction_relationships_not_migrated.csv"
  puts "Not-migrated are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  not_migrated.each do |r|
    csv_file << [r, "\r\n"]
  end
end
