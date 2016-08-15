require File.dirname(__FILE__) + '/../test_helper'
require 'association_controller'

# Re-raise errors caught by the controller.
class AssociationController; def rescue_action(e) raise e end; end

class AssociationControllerTest < Test::Unit::TestCase
  def setup
    @controller = AssociationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
