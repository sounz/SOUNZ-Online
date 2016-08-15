require File.dirname(__FILE__) + '/../test_helper'

class RoleTypeTest < Test::Unit::TestCase
  
  def setup
  @composer = role_types(:r1)
  end
  
  
  def test_uniqueness_of_role_title
    @new_composer = RoleType.new({:role_type_desc => 'Composer'})
    assert !@new_composer.save
  end

  #----------------------------------------------------
  #- Test the compulsory nature of the field role_type_desc (description)
  #----------------------------------------------------
  def test_necessary_existence_of_description
    @composer.role_type_desc = nil
    assert !@composer.save
    check_for_error_messages(["can't be blank", "is too short (minimum is 2 characters)"], @composer, :role_type_desc)
  end
  
  #----------------------------------------------------
  #- Check the description is between 2 and 100 chars -
  #----------------------------------------------------
  def test_length_of_description
  test_long_value_boundaries_of_model_field(@composer, :role_type_desc, 2, 100)
  end
  
  
  #---------------------------------------------
  #- Placeholder - not sure if we will need it -
  #---------------------------------------------
  def test_camel_case
  raise NotImplementedError, 'Undecided as to whether to check camel case or not'
  end
end
