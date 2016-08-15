#!/usr/bin/env ../../sounz/script/runner

require 'csv'

GENRE=1


#Change Video to video
puts "TRACE0"

video_format = Format.find(:first, :conditions => ["format_id = 8"])
video_format.format_desc = "text"
video_format.save!

video_format = Format.find(:first, :conditions => ["format_id = 9"])
video_format.format_desc = "video"
video_format.save!


puts "TRACE1"

video_format = Format.find(:first, :conditions => ["format_id = 10"])
video_format.format_desc = "vinyl (LP or EP)"
video_format.save!

video_format = Format.find(:first, :conditions => ["format_id = 15"])
video_format.format_desc = "programme note"
video_format.save!
puts "TRACE2"
video_format = Format.find(:first, :conditions => ["format_id = 22"])
video_format.format_desc = "kit"
video_format.save!
puts "TRACE3"

#Change scores and part/s [up to 5 players] to match the spreadsheet
mt = ManifestationType.find(4)
mt.manifestation_type_desc = "score and part/s"
mt.save!



video_format = Format.find(:first, :conditions => ["format_id = 12"])
video_format.format_desc = "commentary or analysis"
video_format.save!
puts "TRACE4"


csv = CSV::parse(File.open("manifestation_formats.csv") {|f|f.read})
first_row = true
fields = []
hash = {}
formats = {} # Use keys as unique set
csv.each do |record|
  puts "================"
  puts record.size
  if first_row
    fields = record
    first_row = false
    for field in fields
      hash[field.to_s] = []
    end
  else
    puts "Processing row"
    format = record[0].to_s
    formats[format] = format
    puts "**** #{record.to_s} ****"
    puts formats.keys.map{|k| k.class}
    
    for i in 1..record.length
      field_name = fields[i]
      value = record[i]

      current_val = hash[field_name]          
      current_val << value if value != nil
      hash[field_name]  = current_val
    end
  end
end

for field in fields
  puts "FIELD:#{field} => #{hash[field]}"
  for val in hash[field]
    puts "....#{val}"
  end
end


for f in formats.keys
  val = formats[f]
  puts "#{f}, #{f.class} => #{val}, #{val.class}"
end


=begin

puts "============="
puts "TRACE1"
puts formats.keys.map{|k| k.class}
puts "vals"
puts formats.keys.map{|k| formats[k].class}
puts "============="

=end


#FIXME - resource types here also

format_objects =  Hash.new
#Create the format objects
for format_name in formats.keys
  puts format_name.class
  if format_name != "TYPE"

    format = Format.create(:format_desc => format_name)
    puts format
    begin
      format.save!
    rescue
      format = Format.find(:first, :conditions => ["format_desc = ?",format_name])
    end

    puts "Creating #{format_name} => #{format}"
    format_objects[format_name]= format #Put the format object into the hash so we can pull it out later (so to speak)
    # puts format_objects.keys.map{|k| k.class}
    puts "-"
  end
end

for f in format_objects.keys
  val = format_objects[f]
  puts "#{f}, #{f.class} => #{val}, #{val.class}"
end




=begin
puts "============="
puts "TRACE2"
puts format_objects.keys.map{|k| k.class}
puts format_objects.keys.map{|k| format_objects[k].class}
puts "============="

for key in format_objects.keys
  puts key.to_s+","+key.class.to_s
end
=end




for field_name in hash.keys
  puts "PROCESSING #{field_name}"
  formats_for_field_name = hash[field_name]
  if !field_name.blank?
    man_type = ManifestationType.create(:manifestation_type_desc => field_name)
    begin
      man_type.save!
    rescue
      man_type = ManifestationType.find(:first, :conditions => ["manifestation_type_desc = ?",field_name])
    end
  
    for associated_format in formats_for_field_name
      puts "Mapping #{field_name} to #{associated_format}"

      format = format_objects[associated_format]
      puts format.class
      format.manifestation_types << man_type
  #    format.save
    end
  end
  

  
end


 #Remove crud from csv file
# ManifestationType.find(:first, :conditions => ["manifestation_type_desc = ?", "TYPES"]).destroy
 
 #Weed out the cruft
 ManifestationType.find(:first, :conditions => ["manifestation_type_id = ?", 14]).destroy
# ManifestationType.find(:first, :conditions => ["manifestation_type_desc = ?", "part - CD/DVD"]).destroy
 ManifestationType.find(:first, :conditions => ["manifestation_type_desc = ?", "CD recording"]).destroy
 ManifestationType.find(:first, :conditions => ["manifestation_type_desc = ?", "cassette recording"]).destroy


