#!/usr/bin/env ../sounz/script/runner
require 'yaml'

data = YAML.load_file("../sounz/test/fixtures/work_categories.yml")
puts data.keys
for key in data.keys
myObject=data[key]
puts myObject['work_category_desc']

foundCategory=WorkCategory.find(myObject['work_category_id']) rescue nil

if foundCategory == nil
mycategory=WorkCategory.new(data[key])
mycategory.save()
else
foundCategory.update_attributes(data[key])
end
end



data = YAML.load_file("../sounz/test/fixtures/work_subcategories.yml")
puts data.keys
for key in data.keys
myObject=data[key]
puts myObject['work_subcategory_desc']

foundSubcategory=WorkSubcategory.find(myObject['work_subcategory_id']) rescue nil

if foundSubcategory == nil
mycategory=WorkSubcategory.new(data[key])
mycategory.save()
else
foundSubcategory.update_attributes(data[key])
end
end


#puts data.methods.sort