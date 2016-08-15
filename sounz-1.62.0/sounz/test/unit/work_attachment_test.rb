require File.dirname(__FILE__) + '/../test_helper'

class WorkAttachmentTest < Test::Unit::TestCase
 
 def setup
   @work = Work.find(16837) #Arapatiki
 end
 
 def test_attachment
   puts "=== Attaching an image for #{@work.work_title} ==="
   puts "Media items before: #{@work.media_items}"
   fdata = fixture_file_upload('/files/sheep-wine.jpg', 'image/jpeg')
   
   puts "Media items after: #{@work.media_items}"
   
   @media_item = MediaItem::new
   @media_item.uploaded_data = fdata
   @media_item.save
   puts @media_item.to_yaml
   puts @media_item.public_filename(:thumb)
   puts @media_item.public_filename(:normal)
   puts @media_item.size
   puts @media_item.content_type
 end
end
