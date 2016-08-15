require File.dirname(__FILE__) + '/../test_helper'

class LoginTest < Test::Unit::TestCase
  
  #Set user 1 password to wibble
  def setup
    @login = Login.find(1) # This is the gordon user
    @login.new_password="wibble"
    @login.save
  end
  
  
  #Test a valid login
  def test_valid_login
    login_user = Login.authenticate("gordon", "wibble")
    assert login_user == @login
  end
  
  #Test an invalid login
  def test_invalid_login
    for int in  1..1000
      begin
        login_user = Login.authenticate("gordon", get_string_of_length(rand(10)))
        assert false
      rescue LoginException
        assert true
      end
    end
  end
end
