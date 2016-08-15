#!/usr/bin/env ../sounz/script/runner
for ca in ContributorAttachment.find(:all)
  known_as = ca.contributor.known_as
  caption = ca.media_item.caption
  if caption.include?('(')
    puts "update media_items set caption = '#{known_as}' where caption = '#{caption}';" 
  end
end