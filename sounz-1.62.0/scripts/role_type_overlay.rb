#!/usr/bin/env ../sounz/script/runner

include FinderHelper

data = YAML.load_file("../sounz/test/fixtures/role_types.yml")
#puts data.keys
for key in data.keys
  myObject=data[key]
  puts myObject['role_type_desc']

  foundRoleTypes=RoleType.find(:all, :conditions => ["role_type_desc=?",myObject['role_type_desc']] ) rescue nil

  if foundRoleTypes.first == nil
    puts "ERROR: Can't find roletype with desc "+myObject['role_type_desc'].to_s
  else
    #fill in our new work fields
    foundRoleTypes.first.display_order=myObject['display_order']
    foundRoleTypes.first.save()
  end
end



