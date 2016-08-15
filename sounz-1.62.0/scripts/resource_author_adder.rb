#!/usr/bin/env ../sounz/script/runner

include FinderHelper
require 'yaml'



data = YAML.load_file("../sounz/test/fixtures/works.yml")



#we need to go through each resource, remove any 'authored by' relationships should they exist, then create a new one, based on the contents of the 'author note' field

resources=Resource.find(:all)

for resource in resources

if ! resource.author_note.blank?



query=resource.author_note.clone()
query.gsub!(/'/,'')
query.gsub!(/,/,'')
query.gsub!(/;/,'')
puts "QUERY: "+query

foundRoles=solr_query("type_t:Role "+query, {})

for result in foundRoles[0][:docs]
#puts result.to_s
RelationshipHelper.delete_all_frbr_relationships(:resource, resource.resource_id, :is_written_by)
RelationshipHelper.add_frbr_relationship(:resource, resource.resource_id, :is_written_by, :role, result.objectData.id.to_s, login=1)


end
else
puts "Author_note is empty!"
end
end