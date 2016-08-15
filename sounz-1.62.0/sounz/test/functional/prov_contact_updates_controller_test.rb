require File.dirname(__FILE__) + '/../test_helper'
require 'prov_contact_updates_controller'

# Re-raise errors caught by the controller.
class ProvContactUpdatesController; def rescue_action(e) raise e end; end

class ProvContactUpdatesControllerTest < Test::Unit::TestCase
  fixtures :prov_contact_updates

  def setup
    @controller = ProvContactUpdatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_contact_updates)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_contact_updates
    old_count = ProvContactUpdates.count
    post :create, :prov_contact_updates => { }
    assert_equal old_count+1, ProvContactUpdates.count
    
    assert_redirected_to prov_contact_updates_path(assigns(:prov_contact_updates))
  end

  def test_should_show_prov_contact_updates
    get :show, :prov_contact_update_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_contact_update_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_contact_updates
    put :update, :prov_contact_update_id => 1, :prov_contact_updates => { }
    assert_redirected_to prov_contact_updates_path(assigns(:prov_contact_updates))
  end
  
  def test_should_destroy_prov_contact_updates
    old_count = ProvContactUpdates.count
    delete :destroy, :prov_contact_update_id => 1
    assert_equal old_count-1, ProvContactUpdates.count
    
    assert_redirected_to prov_contact_updates_path
  end
end
