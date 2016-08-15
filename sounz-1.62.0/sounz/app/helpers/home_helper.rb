require "RMagick"

module HomeHelper
  
  DESIRED_WIDTH = 105
  DESIRED_HEIGHT = 120
  
  
  
  
  #Resize a media item image to fit onto the home page, ie must be at least DESIRED_WIDTHx100 pixels.  Note due to
  #the CSS masking it can be bigger, the objective is to ensure the hole is filled .
  def size_to_fit_into_home_page(media_item)
    width = media_item.width
    height = media_item.height
        puts "\tWIDTH:#{width}"
    puts "\tHEIGHT:#{height}"

    
    result = [DESIRED_WIDTH,DESIRED_WIDTH] # this is the result for the width == height case
    if width > height
     result = [DESIRED_WIDTH, height*DESIRED_WIDTH/width ]
    elsif width < height
       result = [width*DESIRED_WIDTH/height, DESIRED_WIDTH]
    end
    
    aspect_before = width/height.to_f
    aspect_after = result[0] / result[1].to_f
    
    puts "#{aspect_before} ==> #{aspect_after}"
    
    
    return result
  end
  
  
  # Create an image that is at least DESIRED_WIDTHxDESIRED_WIDTH pixels, and then cache it.
  def get_random_spotlight_image(media_item, gravity = Magick::CenterGravity)
    result = "error.jpg"
    begin
      result = "NOT DEFINED YET"
      #no point creating the thumbnail from a possibly huge original image
      prefix = "#{RAILS_ROOT}/public"
      source_filepath = prefix+media_item.public_filename
      
      puts source_filepath
      
      
      
      target_file_name = source_filepath.gsub('.jpg',"_rotator_portrait_full.jpg")
      
      cached = FileTest.exist?(target_file_name)
      
      
      if !cached
        image = Magick::Image.read(source_filepath).first
         image.crop_resized!(DESIRED_WIDTH,DESIRED_HEIGHT, gravity)
          image.write(target_file_name)
=begin       
        #Get it to fit in the box
        image.resize_to_fit!(DESIRED_WIDTH,DESIRED_HEIGHT)
        
        #if the original source image is too small, pad it out with a black background to the required size
        if image.columns < DESIRED_WIDTH || image.rows < DESIRED_HEIGHT
         

This adds the background
          face = image.crop(Magick::CenterGravity, 0, 0,DESIRED_WIDTH,DESIRED_HEIGHT)
          background = Magick::Image.new(DESIRED_WIDTH,DESIRED_HEIGHT) {self.background_color = 'black'}
          xpos = (DESIRED_WIDTH-face.columns)/2
          overlay = background.composite(face, xpos, 0, Magick::OverCompositeOp)
          overlay.write(target_file_name)                              
          #
          puts "+++++++++++++++"

        end
=end
      end
    
      result = target_file_name[prefix.length, target_file_name.length]
    rescue Exception => e
      #We have already set the result to be error.jpg
      logger.debug "HomeHelper: Image shrink problem, error was :: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      
    end
    
    result
    
  end
  
  private

end
