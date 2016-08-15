require File.dirname(__FILE__) + '/../test_helper'

class SavedContactListTest < Test::Unit::TestCase
  
  def setup
    @scl_people = saved_contact_lists(:list1) # This list has 4 people
    @scl_organisations = saved_contact_lists(:list3) # This list has 4 organisations
  end
  
  # Replace this with your real tests.
  def test_add_person
    person = Person.find(124)
    assert @scl_people.add_person(person)
    assert @scl_people.people.count == 5
    assert @scl_people.save
  end
  
  #------------------
  #- Description for method: test_add_organisation
  #------------------
  
  def test_add_organisation
    new_organisation = Organisation.find(23) # This organisation does not exist already
    @scl_organisations.add_organisation(new_organisation)
    assert @scl_organisations.organisations.count == 5
    assert @scl_people.save
  end
  
  
  #------------------
  #- Try adding the same person twice, ensure that the contact list does not save
  #  and check the numbers are happy
  #------------------
  
  def test_add_same_person_twice
    p = Person.find(120) #This person is already in the first contact list
    assert !@scl_people.add_person(p)
    assert @scl_people.people.count == 4
    assert @scl_people.save
  end
  
  
  #------------------
  #- Try adding the same person twice, ensure that the contact list does not save
  #  and check the numbers are happy
  #------------------
  
  def test_add_same_organisation_twice
    org = Organisation.find(20) #This person is already in the first contact list
    assert !@scl_organisations.add_organisation(org)
    assert @scl_organisations.organisations.count == 4
    assert @scl_people.save
  end
  
  
  #---------------------------------------------------
  #- Delete a person who exists already from a project
  #---------------------------------------------------
  def test_delete_existing_person
    p = Person.find(120) #This person is already in the first contact list
    assert @scl_people.remove_person(p)
    assert @scl_people.people.count == 3
    assert @scl_people.save
  end
  
  
    #---------------------------------------------------
  #- Delete a person who deos not exist in a project
  # <ul>
  # <li>Remove a person who does not exist</li>
  # <li>Check that fails</li>
  # <li>Check count is still the same</li>
  # </ul>
  #---------------------------------------------------
  def test_delete_non_existing_person
    p = Person.find(121) #This person does not already in the first contact list
    assert !@scl_people.remove_person(p)
    assert @scl_people.people.count == 4
    assert @scl_people.save
  end
  
  
  #-----------------------------------
  #- Delete an existing organisation -
  #-----------------------------------
  def test_delete_non_existing_organisation
    org = Organisation.find(44) #This person is already in the first contact list
    assert !@scl_organisations.remove_organisation(org)
    assert @scl_organisations.organisations.count == 4 # This should be 4 less the 1 original record
    assert @scl_organisations.save
  end
  
  
  
end
