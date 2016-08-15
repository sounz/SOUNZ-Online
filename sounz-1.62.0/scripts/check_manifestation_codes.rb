#!/usr/bin/env ../sounz/script/runner

# This script checks manifestation_code field of manifestation against the item ID number
# in the internal_note field of manifestation

# The use of the script: ruby check_manifestation_codes.rb

# The script outputs manifestations_with_not_found_item_id.txt and 
# manifestations_with_wrong_manifestation_code.txt

puts "--- START SCRIPT ---"

item_id_not_found   = Array.new
item_id_not_matched = Array.new

manifestations_to_check = Manifestation.find(:all)#, :conditions => ["internal_note ilike (?) or internal_note ilike (?)", '%itemid%', '%item id%'])


manifestations_to_check.each do  |manifestation|
  # get manifestation code from the internal note
  item_id = nil
  
  manifestation.internal_note.scan(/((Item)\s?(ID)(:)?(;)?(")?(\s)?(\|)?(,)?(\s)?[0-9]*)/) {|iid| 
    # get the code
	iid = iid.to_s.gsub(/[^0-9]/, '')
	iid = iid.gsub(/^(0*)/, '')
	item_id = iid.strip	
  }
  
  if !item_id.blank?
  	if !manifestation.manifestation_code.to_s.match(item_id)
  	  item_id_not_matched.push(manifestation.manifestation_id.to_s + "\t\t" + manifestation.manifestation_title + "\t\t" + manifestation.manifestation_code.to_s + "\t\t" + item_id.to_s)  	
  	end
  else
  	item_id_not_found.push(manifestation.manifestation_id.to_s + "\t\t"  + manifestation.manifestation_title + "\t\t" + manifestation.manifestation_code.to_s + "\t\t" + manifestation.internal_note.gsub(/[\r\n\t]/, ' ').strip)
  end

end



puts "================================================"
puts "============= NOT MATCHED RECORDS ================"

puts "Number of not-matched: " + item_id_not_matched.length.to_s

if item_id_not_matched.length > 0
  file_name = "manifestations_with_wrong_manifestation_code.txt"
  puts "Not-matched are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  item_id_not_matched.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "================================================"
puts "============= NOT FOUND RECORDS ================"

puts "Number of not-found: " + item_id_not_found.length.to_s

if item_id_not_found.length > 0
  file_name = "manifestations_with_not_found_item_id.txt"
  puts "Not-found are in #{file_name}"
  
  csv_file = File.open(file_name, 'w')
  item_id_not_found.each do |r|
    csv_file << [r, "\r\n"]
  end
end

puts "--- END SCRIPT ---"