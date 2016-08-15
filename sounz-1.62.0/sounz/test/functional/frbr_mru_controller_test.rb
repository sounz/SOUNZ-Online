require File.dirname(__FILE__) + '/../test_helper'
require 'frbr_mru_controller'

# Re-raise errors caught by the controller.
class FrbrMRUController; def rescue_action(e) raise e end; end

class FrbrMRUControllerTest < Test::Unit::TestCase
  def setup
    @controller = FrbrMRUController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
