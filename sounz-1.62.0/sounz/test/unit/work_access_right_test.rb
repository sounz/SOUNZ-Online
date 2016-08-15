require File.dirname(__FILE__) + '/../test_helper'

class WorkAccessRightTest < Test::Unit::TestCase

  def setup
    @work_access_right = WorkAccessRight::new
    @work_access_right.access_right = AccessRight.find(:first)
    @work_access_right.access_right_source = "composer"
    @work_access_right.work = Work.find(:first)
    
  end
  
  
  def test_required_valid_access_right_source
    @work_access_right.access_right_source = "composer"
    assert @work_access_right.save
    
    @work_access_right.access_right_source = nil
    assert !@work_access_right.save
  end
  
  
  def test_invalid_access_right_source
    @work_access_right.access_right_source = "hobbits"
    assert !@work_access_right.save
  end
  
  def test_access_right_required
    @work_access_right.access_right = nil
    assert !@work_access_right.save
  end
  
  def test_work_required
    @work_access_right.work = nil
    assert !@work_access_right.save
  end
  
  def test_duplicate_entries
    #Save the first one
    assert @work_access_right.save
    
    #Create an identical one
    @work_access_right2 = @work_access_right.clone
    
    #This will throw a db exception
    begin
      assert !@work_access_right2.save
      flunk "Should not have saved"
    rescue
      
    end
  end
  
  
end
