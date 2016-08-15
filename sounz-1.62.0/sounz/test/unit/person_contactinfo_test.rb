require File.dirname(__FILE__) + '/../test_helper'

class PersonContactinfoTest < Test::Unit::TestCase

  
def setup
  
end

  # Replace this with your real tests.
  def test_transaction
    #Create a new empty contact info object
    #Note once contactinfo has validation some of this might require changing to create a valid object
    contact_info = Contactinfo::new
    person_contact_info = PersonContactinfo::new
    person_contact_info.person = Person.find(100)
    person_contact_info.contactinfo = contact_info
    assert !person_contact_info.save
    
    #Check for nil IDs, i.e. that nothing has been saved
    assert person_contact_info.person_contactinfo_id == nil
    assert contact_info.contactinfo_id == nil
    
    #Make the contact info type valid
    person_contact_info.contactinfo_type = 'billing'
    assert person_contact_info.save
    
    #Check for non nil IDs, ie that the data has been saved
    assert contact_info.contactinfo_id != nil
    assert person_contact_info.person_contactinfo_id != nil
  end
end
