#!/usr/bin/env ../../sounz/script/runner
#Sanity check on format loading
for resource_type in ResourceType.find(:all)
  puts "===== RESOURCE: #{resource_type.resource_type_desc} (#{resource_type.formats.length}) ===="
  for format in resource_type.formats
    puts "\t"+format.format_desc
  end
end

puts "******************"
for man_type in ManifestationType.find(:all)
  puts "===== MANIFESTATION: #{man_type.manifestation_type_desc} (#{man_type.formats.length}) ===="
  for format in man_type.formats
    puts "\t"+format.format_desc
  end
end