require File.dirname(__FILE__) + '/../test_helper'

class ResourceAccessRightTest < Test::Unit::TestCase

  def setup
    @resource_access_right = ResourceAccessRight::new
    @resource_access_right.access_right = AccessRight.find(:first)
    @resource_access_right.access_right_source = "composer"
    @resource_access_right.resource = Resource.find(:first)
    
  end
  
  
  def test_required_valid_access_right_source
    @resource_access_right.access_right_source = "composer"
    assert @resource_access_right.save
    
    @resource_access_right.access_right_source = nil
    assert !@resource_access_right.save
  end
  
  
  def test_invalid_access_right_source
    @resource_access_right.access_right_source = "hobbits"
    assert !@resource_access_right.save
  end
  
  def test_access_right_required
    @resource_access_right.access_right = nil
    assert !@resource_access_right.save
  end
  
  def test_resource_required
    @resource_access_right.resource = nil
    assert !@resource_access_right.save
  end
  
  def test_duplicate_entries
    #Save the first one
    assert @resource_access_right.save
    
    #Create an identical one
    @resource_access_right2 = @resource_access_right.clone
    
    puts @resource_access_right.to_yaml
    puts "======="
    puts @resource_access_right2.to_yaml
    
    assert !@resource_access_right2.save
  end
  
  
end
