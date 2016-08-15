require File.dirname(__FILE__) + '/../test_helper'
require 'prov_work_updates_controller'

# Re-raise errors caught by the controller.
class ProvWorkUpdatesController; def rescue_action(e) raise e end; end

class ProvWorkUpdatesControllerTest < Test::Unit::TestCase
  fixtures :prov_work_updates

  def setup
    @controller = ProvWorkUpdatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_work_updates)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_work_updates
    old_count = ProvWorkUpdates.count
    post :create, :prov_work_updates => { }
    assert_equal old_count+1, ProvWorkUpdates.count
    
    assert_redirected_to prov_work_updates_path(assigns(:prov_work_updates))
  end

  def test_should_show_prov_work_updates
    get :show, :prov_work_update_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_work_update_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_work_updates
    put :update, :prov_work_update_id => 1, :prov_work_updates => { }
    assert_redirected_to prov_work_updates_path(assigns(:prov_work_updates))
  end
  
  def test_should_destroy_prov_work_updates
    old_count = ProvWorkUpdates.count
    delete :destroy, :prov_work_update_id => 1
    assert_equal old_count-1, ProvWorkUpdates.count
    
    assert_redirected_to prov_work_updates_path
  end
end
