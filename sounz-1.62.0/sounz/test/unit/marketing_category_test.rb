require File.dirname(__FILE__) + '/../test_helper'

class MarketingCategoryTest < Test::Unit::TestCase
  


  def setup
    @marketing_category = marketing_categories(:one)
  end
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field description
  #----------------------------------------------------
  def test_necessary_existence_of_description
    test_necessary_existence_of_model_field_multiple_errors(["cannot be empty", "is too short (minimum is 2 characters)"], @marketing_category, :description)
  end
  
  
    #----------------------------------------------------
  #- Test the compulsory nature of the field abbreviation
  #----------------------------------------------------
  def test_necessary_existence_of_abbreviation
   # test_necessary_existence_of_model_field("cannot be empty", @marketing_category, :abbreviation)
       test_necessary_existence_of_model_field_multiple_errors(["cannot be empty", "is too short (minimum is 2 characters)"], @marketing_category, :abbreviation)
    
  end
  
  
  def test_abbreviation_size
    test_long_value_boundaries_of_model_field(@marketing_category, :abbreviation, 2,100)
  end
  
    def test_description_size
    test_long_value_boundaries_of_model_field(@marketing_category, :description, 2,300)
  end

  
end
