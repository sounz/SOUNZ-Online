require File.dirname(__FILE__) + '/../test_helper'
require 'samples_controller'

# Re-raise errors caught by the controller.
class SamplesController; def rescue_action(e) raise e end; end

class SamplesControllerTest < Test::Unit::TestCase

  def setup
    @controller = SamplesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:samples)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_sample
    old_count = Sample.count
    post :create, :sample => { }
    assert_equal old_count+1, Sample.count
    
    assert_redirected_to sample_path(assigns(:sample))
  end

  def test_should_show_sample
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_sample
    put :update, :id => 1, :sample => { }
    assert_redirected_to sample_path(assigns(:sample))
  end
  
  def test_should_destroy_sample
    old_count = Sample.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Sample.count
    
    assert_redirected_to samples_path
  end
end
