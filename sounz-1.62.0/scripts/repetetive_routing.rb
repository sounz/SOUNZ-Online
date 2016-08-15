#!/usr/bin/env ../sounz/script/runner

#used in generating the routes config file, for all the FRBR methods


for entity_type_name in ["concept", "work", "manifestation", "event", "resource","role"]
entity_type = EntityType.find(:first, :conditions => ["entity_type = ?", "role" ])

veers3 = ValidEntityEntityRelationship.find(:all, :conditions => ["entity_type_from_id=?",entity_type.entity_type_id])
veers = veers3.sort_by{|v|v.ruby_method_name}
for veer in veers
  method_name = veer.page_title.tableize.gsub(' ', '_')
  
  puts "#Route to represent #{veer.page_title}"
  puts "map.concept_#{method_name} '#{entity_type.entity_type.pluralize}/#{method_name}/:id',"
  puts ":controller => '#{entity_type.entity_type.pluralize}',"
  puts ":action => 'related',"
  puts ":mode => 'frbr_#{method_name}'"
  puts
end


puts veers.map{|v| "\"#{v.ruby_method_name}\""}.join(',')
puts "=========\n\n\n\n\n\n\n\n"

end