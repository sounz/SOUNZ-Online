require File.dirname(__FILE__) + '/../test_helper'
require 'prov_feedbacks_controller'

# Re-raise errors caught by the controller.
class ProvFeedbacksController; def rescue_action(e) raise e end; end

class ProvFeedbacksControllerTest < Test::Unit::TestCase
  fixtures :prov_feedbacks

  def setup
    @controller = ProvFeedbacksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_feedbacks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_feedbacks
    old_count = ProvFeedbacks.count
    post :create, :prov_feedbacks => { }
    assert_equal old_count+1, ProvFeedbacks.count
    
    assert_redirected_to prov_feedbacks_path(assigns(:prov_feedbacks))
  end

  def test_should_show_prov_feedbacks
    get :show, :prov_feedback_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_feedback_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_feedbacks
    put :update, :prov_feedback_id => 1, :prov_feedbacks => { }
    assert_redirected_to prov_feedbacks_path(assigns(:prov_feedbacks))
  end
  
  def test_should_destroy_prov_feedbacks
    old_count = ProvFeedbacks.count
    delete :destroy, :prov_feedback_id => 1
    assert_equal old_count-1, ProvFeedbacks.count
    
    assert_redirected_to prov_feedbacks_path
  end
end
