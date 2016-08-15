#!/usr/bin/ruby
require 'list_reader.rb'

class RandomPeopleGenerator
  
  SECS_IN_YEAR = 31536000 
  FORMAT ="%d %b %Y %H:%M"
  
  
  
  
  #----------------------
  #- Details about intialise
  #----------------------
  def initialise
    @males = ListReader::new
    @females = ListReader::new
    @surnames = ListReader::new
    
    @males.loadfile('male.names.first.txt', 600)
    @females.loadfile('female.names.first.txt', 600)
    @surnames.loadfile('surnames.txt', 600)
    @ctr = 1
    
    puts @males
    puts @females
    puts @surnames
  end
  
  
  
  #----------------------
  #- Details about random_male_name
  #----------------------
  def random_male_first_name
    random_first_name(@males)
  end
  
  #----------------------
  #- Details about random_first_name(array_of_names)
  #----------------------
  def random_first_name(array_of_names)
    first_names = ""
    
    # 1 or 2 first names
    for i in 1..(1+rand(2))
      first_names = first_names + array_of_names.random_item.to_s + ' '
    end
    
    first_names.strip!
  end
  
  #----------------------
  #- Details about random_female_first_name
  #----------------------
  def random_female_first_name
    random_first_name(@females)
  end
  
  #----------------------
  #- Details about random_status
  #----------------------
  def random_male_nomenation
    valid = [1,4,6,8] # male values
    puts "  nomenation_id: #{valid[rand(4)]}"
  end
  
  #----------------------
  #- Details about random_female_nomenation
  #----------------------
  def random_female_nomenation
    valid = [2,3,4,5,6,7,9] # female values
    puts "  nomenation_id: #{valid[rand(7)]}"
  end
  
  
  #----------------------
  #- Get a random surname, ocassionaly double barrelling it
  #----------------------
  def random_surname
    result = @surnames.random_item.to_s
    
    #Do a 2 % double barrel
    if rand(50) > 48
      result = result+'-'+@surnames.random_item.to_s
    end
    
    return result
  end
  
  #----------------------
  #- Details about random_name
  #----------------------
  def random_female_yml
    
    first_names = random_female_first_name
    
    last_name = random_surname
    
    
    
    puts "name#{@ctr}:"
    puts "  person_id: #{@ctr}"
    puts "  first_names: #{first_names}"
    puts "  last_name: #{last_name}"
    puts "  gender: F"
    puts "  status_id: 1"
    random_female_nomenation
    puts "  apra_member: false"
    
    dob = Time.now-(18+rand(80))*SECS_IN_YEAR + rand(SECS_IN_YEAR)  
    puts "  date_of_birth: #{dob.strftime(FORMAT)}"  
    if (rand(100) > 90)
      puts "  deceased: true"
      delta = Time.now-dob
      dok = dob+rand(18*SECS_IN_YEAR+delta)
      puts "  date_of_death: #{dok.strftime(FORMAT)}"
    else
      puts "  deceased: false"
    end
    
    puts "  updated_by: 1"
    puts
    
    @ctr = @ctr + 1
  end
  
  
  def random_male_yml
    first_names = random_male_first_name
    
    last_name = @surnames.random_item
    
    puts "name#{@ctr}:"
    puts "  person_id: #{@ctr}"
    puts "  first_names: #{first_names}"
    puts "  last_name: #{last_name}"
    puts "  gender: M"
    puts "  status_id: 1"
    random_male_nomenation
    dob = Time.now-(18+rand(80))*SECS_IN_YEAR + rand(SECS_IN_YEAR)  
    puts "  date_of_birth: #{dob.strftime(FORMAT)}"  
    if (rand(100) > 90)
      puts "  deceased: true"
      delta = Time.now-dob
      dok = dob+rand(18*SECS_IN_YEAR+delta)
      puts "  date_of_death: #{dok.strftime(FORMAT)}"
    else
      puts "  deceased: false"
    end
    puts "  apra_member: false"
    puts "  updated_by: 1"
    puts
    
    @ctr = @ctr + 1
  end
  
end


# - This generators 2000 names for the peoples fixture
class PeopleYML
  public
  def self.yml
    rng = RandomPeopleGenerator::new
    rng.initialise
    
    
    for i in 1..1000
      rng.random_male_yml
      rng.random_female_yml
    end
  end
end

PeopleYML.yml
