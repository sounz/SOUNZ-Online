require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < Test::Unit::TestCase

  
  def setup
    @role = roles(:role1)
    @contact = contactinfos(:contact1)
    
    assert @role.person_id != nil
    assert @role.organisation_id != nil
  end
  
  
  # - Test fields that can be optional -
  def test_optional
    check_optional_fields(@role, [:general_note, :role_title])
  end
  
  
  #=Test combinations of organisation and person id=
  #
  #Note that the combination of organisation and person id has been implicitly tested
  
  
  def test_role_with_person_and_no_organisation
    @role.organisation = nil
    x =  @role.save
    puts @role.errors.to_xml
    assert x
  end
  
  
  def test_role_with_organisation_and_no_person
    @role.person = nil
    assert @role.save
  end
  
  # A role with no person or organisation should fail to save
    def test_role_with_no_organisation_and_no_person
    @role.organisation = nil
    @role.person = nil
    assert !@role.save
  end
  
  
  
  
  #============= Tests for role type ========================================
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field role type
  #----------------------------------------------------
  def test_necessary_existence_of_role_type
    @role.role_type = nil
    assert !@role.save
  end
  
  
  def test_foreign_key_role_type
    check_foreign_key(@role, :role_type)
  end
  
  

  
  
  #============================= Tests for contactinfo ================================
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field contactinfo_id
  #----------------------------------------------------
  def test_necessary_existence_of_contactinfo_id
    @role.contactinfo_id = nil
    assert !@role.save
  end
  
  def test_foreign_key_contactinfo
    check_foreign_key(@role, :contactinfo)
  end
  
  
    def test_other_contactinfo_scenarios
  raise NotImplementedError, 'Not sure what the conditions are here for testing'
  end
  
  
  
end
