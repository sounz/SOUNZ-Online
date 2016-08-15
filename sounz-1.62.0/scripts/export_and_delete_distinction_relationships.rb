#!/usr/bin/env ../sounz/script/runner

# This script exports distinction instance relationships data into distinction_instance_relationships_to_migrate.csv
# from distinction_relationships table that has been used previously for recording disctinction_instance
# relationship - mistake when designing the db schema
# Now as we need to be able to add relationships to Distinction entity itself, we have to vacate the 
# distinction_relationships table for that.
# RUN this script BEFORE the deployment of sounz 1.16 release!!!

relationships_to_export = DistinctionRelationship.find(:all)

file_name = "distinction_instance_relationships_to_migrate.csv"
csv_file = File.open(file_name, 'w')

relationships_to_export.each do |r|
  
  csv_file << ["#{r.distinction_relationship_id}", ",,", "#{r.relationship_id}", ",,", "#{r.relationship_type_id}", ",,", "#{r.distinction_instance_id}", ",,", "#{r.is_dominant_entity}", "\r\n"]

  # delete record from distinction_relationships
  r.destroy

end

csv_file.close

puts "Export is finished. The records are now in #{file_name}"
