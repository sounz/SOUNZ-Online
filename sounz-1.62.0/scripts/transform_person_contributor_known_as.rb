#!/usr/bin/env ../sounz/script/runner

# This script transforms the 'known as' field of people contributors to 
# 'Last name (any additional info), First Names' as per WR#53473

# The use of the script: ruby transform_person_contributor_known_as.rb

# Outputs: transform_person_contributor_known_as_results.csv

# RUN this script ONLY ONCE!!!!

puts "--- START SCRIPT ---"

results = Array.new
results.push("contributor_id" + "\t\t" + "previous_known_as" + "\t\t" + "transformed_known_as")

people_contributors = Contributor.find(:all, :select => 'contributor_id', 
	                                         :joins => 'inner join roles using (role_id)', 
											 :conditions => ['person_id > 0']
									   )

people_contributors.each do |c|								   									    
  
  transformed_known_as = nil
  
  contributor = Contributor.find(c)
  
  if !contributor.blank? && !contributor.known_as.blank?
    if !contributor.role.person.blank?
      # addition to the name info in brackets
	  splits = contributor.known_as.split('(')
	  addition_info = nil
	  addition_info = splits[1] unless splits[1].blank?
	
	  name_info = splits[0].split(' ')
         
      first_name = name_info[0]
      name_info.shift
		 
	  # if one letter followed by dot, we treat it as initials
	  initials = name_info.select{|s| s.to_s.downcase =~ /\b([a-zA-Z]){1}\b/}.join(' ')
		 
	  name_string_without_initials = name_info.reject{|s| s.to_s.downcase =~ /\b([a-zA-Z]){1}\b/}.join(' ')
		 
      transformed_known_as = name_string_without_initials
	  transformed_known_as << ' (' << addition_info unless addition_info.blank?
      transformed_known_as << ', ' unless transformed_known_as.blank?
      transformed_known_as << first_name
	  transformed_known_as << ' ' << initials
      transformed_known_as.strip!
    end
  
    previous_known_as = contributor.known_as
  
    contributor.update_attribute('known_as', transformed_known_as) unless transformed_known_as.blank?
    results.push(contributor.contributor_id.to_s + "\t\t" + previous_known_as + "\t\t" + contributor.known_as)
	
	# for testing
	#results.push(contributor.contributor_id.to_s + "\t\t" + previous_known_as + "\t\t" + transformed_known_as)
  end
  
end

puts "================================================"
puts "============= TRANSFORMED RECORDS ================"

puts "Number of transformed: " + results.length.to_s

if results.length > 0
  file_name = "transform_person_contributor_known_as_results.csv"
  puts "Results of transformation are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  results.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "--- END SCRIPT ---"