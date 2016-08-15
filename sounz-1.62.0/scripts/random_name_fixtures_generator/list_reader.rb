#!/usr/bin/ruby
class ListReader
  
  #----------------------
  #- Details about say_hello
  #----------------------
  def say_hello
    puts "hello"
  end
  
  
  # Load a file of line separated items into the array @items
  def loadfile(filename, maximum_number_of_items, fixed_width=14, do_caps=true)
    @items = []
    file = File.new(filename, "r")
    ctr = 0
    while (line = file.gets)
      ctr = ctr + 1
      if ctr > maximum_number_of_items
        break;
      end
        name = line[0..fixed_width].strip
      if do_caps

        name = name.downcase.capitalize
      end
      #Using @items = @items + [name] is *REALLY* slow.
      #Use this syntax for speed
      @items << [name]
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
  def random_item
    return @items[rand(@items.length)]
  end
  
  def all_items
    return @items
  end
  
  
  
end