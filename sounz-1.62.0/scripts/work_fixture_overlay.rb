#!/usr/bin/env ../sounz/script/runner

include FinderHelper

data = YAML.load_file("../sounz/test/fixtures/works.yml")
#puts data.keys
for key in data.keys
  myObject=data[key]
  #puts myObject['work_title']

  foundWork=Work.find(myObject['work_id']) rescue nil

  if foundWork == nil
    puts "ERROR: Can't find work with ID "+myObject['work_id'].to_s
  else
    #fill in our new work fields
    foundWork.contents_note=myObject['contents_note']
    foundWork.dedication_note=myObject['dedication_note']
    foundWork.internal_note=myObject['internal_note']
    foundWork.text_note=myObject['text_note']
    foundWork.programme_note=myObject['programme_note']
    foundWork.save()
  end
end



