require File.dirname(__FILE__) + '/../test_helper'
require 'home_controller'
require File.dirname(__FILE__) + '/sounz_function_test_helper'

# Re-raise errors caught by the controller.
class HomeController; def rescue_action(e) raise e end; end

class HomeControllerTest < Test::Unit::TestCase
  
  include SounzFunctionTestHelper

  def setup
    @controller = HomeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_authenticated_home
    login_as_gordon

  end
end
