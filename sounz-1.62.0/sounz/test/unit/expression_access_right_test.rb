require File.dirname(__FILE__) + '/../test_helper'

class ExpressionAccessRightTest < Test::Unit::TestCase

  def setup
    @expression_access_right = ExpressionAccessRight::new
    @expression_access_right.access_right = AccessRight.find(:first)
    @expression_access_right.access_right_source = "composer"
    @expression_access_right.expression = Expression.find(:first)
  end
  
  
  def test_required_valid_access_right_source
    @expression_access_right.access_right_source = "composer"
    assert @expression_access_right.save
    
    @expression_access_right.access_right_source = nil
    assert !@expression_access_right.save
  end
  
  
  def test_invalid_access_right_source
    @expression_access_right.access_right_source = "hobbits"
    assert !@expression_access_right.save
  end
  
  def test_access_right_required
    @expression_access_right.access_right = nil
    assert !@expression_access_right.save
  end
  
  def test_expression_required
    @expression_access_right.expression = nil
    assert !@expression_access_right.save
  end
  
  def test_duplicate_entries
    #Save the first one
    assert @expression_access_right.save
    #Create an identical one
    @expression_access_right2 = @expression_access_right.clone
    assert !@expression_access_right2.save
    puts @expression_access_right2.errors.to_yaml
  end
  
end
