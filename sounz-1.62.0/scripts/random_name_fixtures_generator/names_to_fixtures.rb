#!/usr/bin/ruby

class ListRandomReader
  
  # Load a file of line separated items into the array @items
  def loadfile(filename, maximum_number_of_items)
    @items = []
    file = File.new(filename, "r")
    ctr = 0
    while (line = file.gets)
      ctr = ctr + 1
      if ctr > maximum_number_of_items
        break;
      end
      name = line[0..14].strip.downcase.capitalize
      
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
  
end


file = ARGV[0]
reader = ListRandomReader::new
reader.loadfile(file,2000)
puts "Read #{reader.size} items"
for i in 1..1000
  puts reader.random_item
end
