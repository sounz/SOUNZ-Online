require File.dirname(__FILE__) + '/../test_helper'
require 'find_communications_controller'

# Re-raise errors caught by the controller.
class FindCommunicatonsController; def rescue_action(e) raise e end; end

class FindCommunicatonsControllerTest < Test::Unit::TestCase
  def setup
    @controller = FindCommunicatonsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
