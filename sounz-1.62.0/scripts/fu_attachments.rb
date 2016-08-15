#!/usr/bin/env ../sounz/script/runner

require 'tempfile'
require 'net/http'

class TestUploadedFile
  # The filename, *not* including the path, of the "uploaded" file
  attr_reader :original_filename
  
  # The content type of the "uploaded" file
  attr_reader :content_type
  
  def initialize(path, content_type = 'text/plain')
    raise "#{path} file does not exist" unless File.exist?(path)
    @content_type = content_type
    @original_filename = path.sub(/^.*#{File::SEPARATOR}([^#{File::SEPARATOR}]+)$/) { $1 }
    @tempfile = Tempfile.new(@original_filename)
    FileUtils.copy_file(path, @tempfile.path)
  end
  
  def path #:nodoc:
    @tempfile.path
  end
  
  alias local_path path
  
  def method_missing(method_name, *args, &block) #:nodoc:
    @tempfile.send(method_name, *args, &block)
  end
end


#== start of script here ==

mime_types = {
  :jpg => 'image/jpeg',
  :jpeg => 'image/jpg',
  :pdf => 'application/pdf',
  :mp3 => 'audio/mpeg'
  
}

ignored = 0
ctr = 0
media_items = MediaItem.find(:all, :conditions => ["parent_id is null and media_item_path is not null"])
puts "Media items len is #{media_items}"
total = media_items.length
bad_media_items = []

for media_item in media_items
  ctr = ctr +1
  
  #Items of zero size have not been attachment_fu'd
  if media_item.media_item_path != nil
  	
    address = "http://192.168.2.233/sounz#{media_item.media_item_path}"
    if address.ends_with? '.'
      bad_media_items << media_item
     next 
    end

    if address.ends_with?(".DS_Store")
      puts "Ignoring mac file extension"
      bad_media_items << media_item
      next
    end

    puts "#{ctr}/#{total} - #{address}"
    puts "media_item_id: #{media_item.media_item_id}"
    filename= address.split('/')[-1]
    @tempfile = '/tmp/'+filename

    server_path = address[26, address.length-1]     
    server_path = '/sounz'+server_path
    puts server_path
    server_path.gsub!(' ', '%20')

   #  asdfsadsdsdf
     
    extension = server_path.split('.')[-1]
    puts "EXT:#{extension}"
     
    puts "Saving to #{@tempfile}"
    Net::HTTP.start("192.168.2.233") { |http|
       resp = http.get(server_path)
       open(@tempfile, "wb") { |file|
         file.write(resp.body)
        }
    }

    #fdata = TestUploadedFile.new(@tempfile.path, 'image/jpg')
    puts extension
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
    fsdata = TestUploadedFile.new(@tempfile, mime_type)
    media_item.uploaded_data = fsdata
    saved = media_item.save.to_s
    if !saved
       bad_media_items << media_item
    end
          
    puts "SAVED? "+saved    
    puts "SIZE:#{media_item.size}"

    puts "ERRORS:#{bad_media_items.length}"
    puts "IGNORED:#{ignored}"
    puts
    
 
  else
    puts "IGNORING #{ctr}" 
    ignored = ignored + 1 
  end

end


  
  puts "======= ERRONEOUS MEDIA ITEMS ====="
  bad_media_items.map{|m| puts m.media_item_path}
