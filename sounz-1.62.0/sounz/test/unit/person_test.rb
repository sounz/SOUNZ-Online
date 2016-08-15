require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < Test::Unit::TestCase
  
  def setup
    @person = Person.find(:first)
    
  end
  
  
  #----------------------------------------------------
  #- Check the first names are between 2 and 100 chars -
  #----------------------------------------------------
  def test_length_of_first_names
    test_long_value_boundaries_of_model_field(@person, :first_names, 2, 100)
  end
  
  
  #----------------------------------------------------
  #- Check the person is known as a field between 2 and 100 chars -
  #----------------------------------------------------
  def test_length_of_known_as
    test_long_value_boundaries_of_model_field(@person, :known_as, 2, 100)
  end
  
  
  #Test the compulsory fields
  
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field last_name
  #----------------------------------------------------
  def test_necessary_existence_of_last_name
    @person.last_name = nil
    assert !@person.save
    check_for_error_messages(["cannot be empty","is too short (minimum is 2 characters)"], @person, :last_name)
  end
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field nomen
  #----------------------------------------------------
  def test_necessary_existence_of_nomen
    @person.nomen = nil
    assert @person.save
    
  end
  
  #----------------------------------------------------
  #- Check the description is between 2 and 100 chars -
  #----------------------------------------------------
  def test_length_of_last_name
    test_long_value_boundaries_of_model_field(@person, :last_name, 2, 100)
  end
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field deceased
  #----------------------------------------------------
  def test_necessary_existence_of_deceased
    puts "*** START OF TEST DECEASED ***"
    puts "PERSON DEC FLAG is #{@person.deceased}"
    @person.deceased = nil
    assert !@person.save
    check_for_error("is not included in the list", @person, :deceased)
    
    
  end
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field apra_member
  #----------------------------------------------------
  def test_necessary_existence_of_apra_member
    @person.apra_member = nil
    assert !@person.save
    check_for_error("is not included in the list", @person, :apra_member)
  end
  
  
  def test_good_gender
    @person.gender = 'M'
    assert @person.save
    
    @person.gender = 'F'
    assert @person.save
  end
  
  
  def test_bad_gender
    @person.gender = 'T'
    assert !@person.save
    check_for_error("is not included in the list", @person, :gender)
    
  end
  
  def test_optional_existence_of_known_as
    @person.known_as = nil
    assert @person.save    
    @person.known_as = 'Snoopy'
    assert @person.save
  end
  
  
  
  def test_length_of_known_as  
    #This is too short
    @person.known_as = 'S'
    
    saved_ok = !@person.save
    puts "*** SAVED OK = #{saved_ok}"
    puts @person.attributes
    assert saved_ok
    
    
  end
  
  #- Check the list of organisations associated with this person -
  def test_organisations
    spod=Person.find(33)
    orgs = spod.organisations
    puts "===="
    #For each organisation we get its people and check that they exist in the organisatiion.people method
    for org in orgs
      puts org.organisation_id.to_s+":"+org.organisation_name
      spods = org.people
      assert spods.include?(spod)
    end
    
    #Now check all the organisations and do a total count
    ctr = 0
    for org in Organisation.find(:all)
      if org.people.include?(spod)
        ctr = ctr + 1
      end
    end
    
    #There should be the same number
    assert ctr == orgs.length
    puts "===="
  end
  
  
  #FIXME: This test does not pass, why!
  def test_legacy_codes_unique
    spods = Person.find(:all, :limit => 2)
    person1 = spods[0]
    person2 = spods[1]
    
    new_leg_code = "AAAA"
    assert person1.legacy4d_identity_code !=person2.legacy4d_identity_code
    person1.legacy4d_identity_code = new_leg_code
    person2.legacy4d_identity_code = new_leg_code
    assert !person1.save
    assert !person2.save
    
  end
  
  def test_legacy_code_optional
    @person.legacy4d_identity_code = nil
    assert @person.save
  end
  
  
  
  #Test that a person cant die before they are born
  def test_death_after_life
    @person.date_of_birth = Time.now
    @person.date_of_death = Time.now-1000000
    assert !@person.save
  end
  
  def test_valid_lifespan
    @person.date_of_birth = Time.now
    @person.date_of_death = Time.now+1000000
    assert @person.save
  end
  
  
  def test_date_of_death_not_deceased
    @person.deceased = false
    @person.date_of_death = Time.now
    assert true, !@person.save
  end
  
  
  
end
