require File.dirname(__FILE__) + '/../test_helper'

class ManifestationAccessRightTest < Test::Unit::TestCase

  def setup
    @manifestation_access_right = ManifestationAccessRight::new
    @manifestation_access_right.access_right = AccessRight.find(:first)
    @manifestation_access_right.access_right_source = "composer"
    @manifestation_access_right.manifestation = Manifestation.find(:first)
    
  end
  
  
  def test_required_valid_access_right_source
    @manifestation_access_right.access_right_source = "composer"
    assert @manifestation_access_right.save
    
    @manifestation_access_right.access_right_source = nil
    assert !@manifestation_access_right.save
  end
  
  
  def test_invalid_access_right_source
    @manifestation_access_right.access_right_source = "hobbits"
    assert !@manifestation_access_right.save
  end
  
  def test_access_right_required
    @manifestation_access_right.access_right = nil
    assert !@manifestation_access_right.save
  end
  
  def test_manifestation_required
    @manifestation_access_right.manifestation = nil
    assert !@manifestation_access_right.save
  end
  
  def test_duplicate_entries
    #Save the first one
    assert @manifestation_access_right.save

    #Create an identical one
    @manifestation_access_right2 = @manifestation_access_right.clone


    assert !@manifestation_access_right2.save
    puts @manifestation_access_right2.errors.to_yaml
  end
  
  
  
end
