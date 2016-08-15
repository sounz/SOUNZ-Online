#!/usr/bin/ruby
class SentenceReader
  
  #----------------------
  #- Details about say_hello
  #----------------------
  def say_hello
    puts "hello"
  end
  
  #-----------------------------------------------------------------
  # Load a file of paragraph separated items into the array @items -
  # ----------------------------------------------------------------
  def loadfile(filename, maximum_number_of_items)
    @items = []
    
    para = ""
  #  puts "filename is "+filename
    file = File.new(filename, "r")
    ctr = 0
    para_lines = 0
    while (line = file.gets)
      
      if ctr > maximum_number_of_items
        break;
      end
      
      line.strip!
      if line.length == 0
        if para.length > 0
          ctr = ctr + 1
          
          #ignore short paragraphs
      
            para.strip!
            #not split the paragaph into sentence
            
            for sentence in para.split('.')
                if sentence.length > 10
                s = sentence.gsub("\n", ' ')+ '.'
                @items << [s.strip]
                
                end
            end
            
            
        
        
          para_lines = 0
          para = ""
        end
        
      else
        para << "\n"
        para << line
        para_lines = para_lines + 1
      end
      #Using @items = @items + [name] is *REALLY* slow.
      #Use this syntax for speed
      
    end
    
    
  end
  
  #----------------------
  #- Get the number of random items stored
  #----------------------
  def size
    return @items.size
  end
  
  #----------------------
  #- Get a random name
  #----------------------
  def random_sentence
     @items[rand(@items.length)].to_s
     
  end
  
  def all_items
    return @items
  end
  
  
  
end


