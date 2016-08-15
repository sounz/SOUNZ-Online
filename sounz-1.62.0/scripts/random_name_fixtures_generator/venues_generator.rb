#!/usr/bin/ruby
require 'list_reader.rb'

class VenuesGenerator
  
  #----------------------
  #- Details about intialise
  #----------------------
  def initialise
    @venues = ListReader::new
    
    
    @venues.loadfile('venues.txt',200, 100, false)
    @ctr = 1
    
    
  end
  


  
  #----------------------
  #- Get a random surname, ocassionaly double barrelling it
  #----------------------
  def random_venue_yml
    puts "venue#{@ctr}:"
    @ctr = @ctr+1
    
    puts "  venue_id: #{@ctr}"
    puts "  venue_name: #{@venues.random_item.to_s}"
    puts "  venue_description: Description for #{@venues.random_item.to_s}"
    puts "  contactinfo_id: 1"
    puts
   
    
   
  end
  
  
end


# - This generators 2000 names for the peoples fixture
class VenuesYML
  public
  def self.yml
    rng = VenuesGenerator::new
    rng.initialise
    
    
    for i in 1..200
      rng.random_venue_yml
    end
  end
end

VenuesYML.yml