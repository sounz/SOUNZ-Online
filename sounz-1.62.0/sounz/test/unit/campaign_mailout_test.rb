require File.dirname(__FILE__) + '/../test_helper'

class CampaignMailoutTest < Test::Unit::TestCase

# 


  def setup
    @campaign_mailout = campaign_mailouts(:campaign_mailout1)
  end
  
  def test_add_valid_person
   
    contacts_before = @campaign_mailout.mailout_contacts.length
    person = Person.find(100)
    role = Role.find(:first, :conditions => ["person_id = ?",person.person_id])
    
    puts "Person is #{person.full_name}"
    puts "Role is #{role.to_string}"
    
    @campaign_mailout.add_contact_person(person,role)

    contacts_after = @campaign_mailout.mailout_contacts.length
    
    puts "Before size is #{contacts_before}"
    puts "After size is #{contacts_after}"
    
    #Check an increment of one
    assert contacts_after == (contacts_before + 1)
    
    for mc in @campaign_mailout.mailout_contacts
      print mc.full_name
    end
  end
  
  
  
  def test_invalid_person
    todo
  end
  
  def test_add_person_twice
   
    contacts_before = @campaign_mailout.mailout_contacts.length
    person = Person.find(100)
    role = Role.find(:first, :conditions => ["person_id = ?",person.person_id])
    
    puts "Person is #{person.full_name}"
    puts "Role is #{role.to_string}"
    
    @campaign_mailout.add_contact_person(person,role)
    begin
      @campaign_mailout.add_contact_person(person,role)
      assert false
    rescue CampaignMailoutException
      # This line should be reached
      assert true
    end
    contacts_after = @campaign_mailout.mailout_contacts.length
        
    puts "Before size is #{contacts_before}"
    puts "After size is #{contacts_after}"
    
    #Check an increment of one
    assert contacts_after == (contacts_before + 1)

  end
  
end

# Number of errors detected: 41
