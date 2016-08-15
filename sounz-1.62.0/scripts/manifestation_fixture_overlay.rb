#!/usr/bin/env ../sounz/script/runner

include FinderHelper

data = YAML.load_file("../sounz/test/fixtures/manifestations.yml")
#puts data.keys
for key in data.keys
  myObject=data[key]
  #puts myObject['work_title']

  foundMani=Manifestation.find(myObject['manifestation_id']) rescue nil

  if foundMani == nil
    puts "ERROR: Can't find work with ID "+myObject['manifestation_id'].to_s
  else
    #fill in our new work fields
    foundMani.publication_year=myObject['publication_year']
    foundMani.internal_note=myObject['internal_note']
    foundMani.general_note=myObject['general_note']
    foundMani.mw_code=myObject['mw_code']
    foundMani.manifestation_type_id=myObject['manifestation_type_id']
    foundMani.save()
  end
end



