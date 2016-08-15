#!/usr/bin/ruby
require 'list_reader.rb'

class OrganisationGenerator
  
  SECS_IN_YEAR = 31536000 
  FORMAT ="%d %b %Y %H:%M"
  
  
  
  
  #----------------------
  #- Details about intialise
  #----------------------
  def initialise
    @orgs = ListReader::new
    
    
    @orgs.loadfile('organisations.txt', 83,100, false)
    
    @ctr = 1
    
  end
  
  
  
  
  
  def generate_yml
    
    for organisation in @orgs.all_items
      puts "organisation#{@ctr}:"
      puts "  organisation_id: #{@ctr}"
      puts "  organisation_name: #{organisation}"
      puts "  organisation_abbrev: #{organisation}"
      puts "  internal_note: Generated automatically for test data"
      puts "  updated_by: 1"
      #Only use the first 10% of the 1000 addresses
      puts "  contactinfo_id: #{1+rand(100)}"
      puts "  status_id: 1"
      
      puts
      
      @ctr = @ctr + 1
    end
  end
  
end



# - This generators 2000 names for the peoples fixture
class ThingYML
  public
  def self.yml
    rng = OrganisationGenerator::new
    rng.initialise
    rng.generate_yml
    
  end
end


ThingYML.yml
