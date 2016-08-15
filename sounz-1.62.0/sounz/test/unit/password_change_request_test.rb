require File.dirname(__FILE__) + '/../test_helper'

class PasswordChangeRequestTest < Test::Unit::TestCase
  
  
  def setup
    @pcr = PasswordHelper.create_password_change_request(Login.find_by_username("batch"))
  end

  # Replace this with your real tests.
  def test_expiry_is_one_week
    @pcr.created_at = Time.now
    assert @pcr.save
    assert_equal false, @pcr.expired?
    
    @pcr.created_at = Time.now-1.day
    assert @pcr.save
    assert_equal false, @pcr.expired?
    
    
    
    
    @pcr.created_at = Time.now-1.week
    assert @pcr.save
    assert_equal true, @pcr.expired?
    
    
  end
end
