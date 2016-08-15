#!/usr/bin/env ../../sounz/script/runner

require 'csv'

GENRE=1

#Change Video to video
puts "TRACE0"
=begin
video_format = Format.find(:first, :conditions => ["format_id = 9"])
video_format.format_desc = "video"
video_format.save!

video_format = Format.find(:first, :conditions => ["format_id = 8"])
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
=end



csv = CSV::parse(File.open("resource_formats.csv") {|f|f.read})
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
      puts "FOUND FIELD:#{field.to_s}"
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
  if !field.blank?
    puts "FIELD:#{field} => #{hash[field]}"
    for val in hash[field]
      puts "....#{val}"
    end
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
    begin
      res_type = ResourceType.create(:resource_type_desc => field_name)
      res_type.save!
    rescue
      res_type = ResourceType.find(:first, :conditions => ["resource_type_desc = ?", field_name])
    end

  
    for associated_format in formats_for_field_name
      puts "Mapping #{field_name} to #{associated_format}"

      format = format_objects[associated_format]
      puts format.class
      format.resource_types << res_type
     # format.save!
    end
  end
  
  #res_type.save!
  
end

#Delete those not required
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "TYPES"]).destroy
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "Programme Note"]).destroy
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "Commentary or analysis"]).destroy
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "industrial manual - NZ"]).destroy
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "DUPLICATE"]).destroy
ResourceType.find(:first, :conditions => ["resource_type_desc = ?", "libretto"]).destroy


