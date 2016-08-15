#!/usr/bin/ruby
#
require 'csv'

class CSV_Reader

  

  
  
  
    
  
  # Load a file of line separated items into the array @items
  def loadfile(filename)
    @items = CSV.open(filename, 'r', '|').collect 
    
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



