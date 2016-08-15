require File.dirname(__FILE__) + '/../test_helper'

class MarketingSubcategoryTest < Test::Unit::TestCase

 def setup
    @marketing_subcategory = marketing_subcategories(:one)
  end
  
  #----------------------------------------------------
  #- Test the compulsory nature of the field description
  #----------------------------------------------------
  def test_necessary_existence_of_description
    test_necessary_existence_of_model_field_multiple_errors(["cannot be empty", "is too short (minimum is 2 characters)"], @marketing_subcategory, :description)
  end
  
  
    #----------------------------------------------------
  #- Test the compulsory nature of the field abbreviation
  #----------------------------------------------------
  def test_necessary_existence_of_abbreviation
   # test_necessary_existence_of_model_field("cannot be empty", @marketing_subcategory, :abbreviation)
       test_necessary_existence_of_model_field_multiple_errors(["cannot be empty", "is too short (minimum is 2 characters)"], @marketing_subcategory, :abbreviation)
    
  end
  
  
  def test_abbreviation_size
    test_long_value_boundaries_of_model_field(@marketing_subcategory, :abbreviation, 2,100)
  end
  
    def test_description_size
    test_long_value_boundaries_of_model_field(@marketing_subcategory, :description, 2,300)
  end
end
