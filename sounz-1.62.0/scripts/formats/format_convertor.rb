#!/usr/bin/env ../../sounz/script/runner

require 'csv'

GENRE=1



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
    format.save!
    
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
    res_type = ResourceType.create(:resource_type_desc => field_name)
    res_type.save!

  
    for associated_format in formats_for_field_name
      puts "Mapping #{field_name} to #{associated_format}"

      format = format_objects[associated_format]
      puts format.class
      format.resource_types << res_type
      format.save!
    end
  end
  
  res_type.save!
  
end

