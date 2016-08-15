require File.dirname(__FILE__) + '/../test_helper'
require 'duration_as_interval_controller'

# Re-raise errors caught by the controller.
class DurationAsIntervalController; def rescue_action(e) raise e end; end

class DurationAsIntervalControllerTest < Test::Unit::TestCase
  def setup
    @controller = DurationAsIntervalController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
