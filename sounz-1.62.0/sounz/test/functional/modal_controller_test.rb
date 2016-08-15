require File.dirname(__FILE__) + '/../test_helper'
require 'modal_controller'

# Re-raise errors caught by the controller.
class ModalController; def rescue_action(e) raise e end; end

class ModalControllerTest < Test::Unit::TestCase
  def setup
    @controller = ModalController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
