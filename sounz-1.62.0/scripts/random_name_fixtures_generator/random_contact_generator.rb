#!/usr/bin/ruby
require 'list_reader.rb'
require 'csv_reader.rb'

class RandomContactGenerator
  
  SECS_IN_YEAR = 31536000 
  FORMAT ="%d %b %Y %H:%M"
  
  
  
  
  #----------------------
  #- Details about intialise
  #----------------------
  def initialise
    @linz_streets = CSV_Reader::new
    @linz_streets.loadfile('street300.txt')
    @ctr = 1
    
  end
  
  
  
  
  

  
  def random_postcode
    return (rand(8999)+1000).to_s
  end
  
  
  #Generate a plausible random phone number
  def random_mobile_number
    prefixes = ['021 ', '027 ']
    return prefixes[rand(1)]+some_random_numbers(6+rand(2))
  end
  
  
  
  #Generate a plausible landline
  def random_landline_number
    return '0'+(1+rand(9)).to_s + ' ' +some_random_numbers(6+rand(1))
  end
  
    #Generate a plausible free number
  def random_freephone_number
    return '0800 '+some_random_numbers(6+rand(1))
  end
  
  
  
  def some_random_numbers(amount)
    result = ""
    for i in 0..amount
      result << rand(10).to_s
    end
    
    result
  end
  
  
  def random_website_url
    return 'http://www.randomwebsite.com'
  end
  
  def random_urls
    result = ''
    for i in 1..(1+rand(4))
      if i > 1
        result << ','
      end
      result << random_website_url
    end
    result
  end
  
  def random_contact_yml
    
    street_data = @linz_streets.random_item
    
    puts "contact#{@ctr}:"
    puts "  contactinfo_id: #{@ctr}"
    puts "  region_id: #{1+rand(50)}"
    puts "  country_id: 158"
    puts "  street: #{1+rand(200)} #{street_data[2]}"
    puts "  locality: #{street_data[3]}"
    puts "  postcode: #{random_postcode}"
    
    puts "  phone: #{random_freephone_number}"
    puts "  phone_alt: #{random_landline_number}"
    puts "  phone_fax: #{random_landline_number}"
    puts "  phone_mobile: #{random_mobile_number}"
    puts "  website_urls: #{random_urls}" 
    puts "  email_1: email@example.org" if rand(2) == 1
    
    #FIXME ADD phone numbers
    puts "  internal_note: Test data"
    puts "  updated_by: "+(1+rand(3)).to_s
    
    
    
    puts
    
    @ctr = @ctr + 1
  end
  
end



rng = RandomContactGenerator::new
rng.initialise


for i in 1..1000
  rng.random_contact_yml
end
