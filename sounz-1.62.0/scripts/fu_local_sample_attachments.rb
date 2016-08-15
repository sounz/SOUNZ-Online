#!/usr/bin/env ../sounz/script/runner

require 'tempfile'
require 'net/http'


#== start of script here ==

mime_types = {
  :jpg => 'image/jpeg',
  :jpeg => 'image/jpg',
  :pdf => 'application/pdf',
  :mp3 => 'audio/mpeg'
  
}

ignored = 0
ctr = 0
media_items = MediaItem.find(:all, :conditions => ["parent_id is null and media_item_path is not null and filename ilike ?",'%smp%'])
#puts "Media items len is #{media_items}"
total = media_items.length
bad_media_items = []

for media_item in media_items
	ctr = ctr +1
    
    extension = media_item.filename.split('.')[-1]
    puts "EXT:#{extension}"
     
    mime_type = mime_types[extension.to_sym]
        
    if mime_type == nil
       bad_media_items << media_item
       next
    end
        
    puts extension +' => '+mime_type
    if mime_type == nil
    	bad_media_items << media_item
      	nextPE
    end

        
      
    puts "** PROCESS ME **"
    media_item.content_type=mime_type
    #note - for production
    media_item.temp_path="/data/sounz/htdocs/test/#{media_item.media_item_path}"
    saved = media_item.save.to_s
    
	if !saved
       bad_media_items << media_item
    end
          
    puts "SAVED? "+saved    
    puts "SIZE:#{media_item.size}"

    puts "ERRORS:#{bad_media_items.length}"
    puts "IGNORED:#{ignored}"
    
 
  end



  
  puts "======= ERRONEOUS MEDIA ITEMS ====="
  bad_media_items.map{|m| puts m.media_item_path}
