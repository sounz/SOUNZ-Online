#!/usr/bin/env ../sounz/script/runner
require 'yaml'

data = YAML.load_file("../sounz/test/fixtures/marketing_categories.yml")
puts data.keys
for key in data.keys
myObject=data[key]
puts myObject['description']

foundCategory=MarketingCategory.find(myObject['marketing_category_id']) rescue nil

if foundCategory == nil
mycategory=MarketingCategory.new(data[key])
mycategory.save()
else
foundCategory.update_attributes(data[key])
end
end






#puts data.methods.sort