require File.dirname(__FILE__) + '/../test_helper'
require 'prov_events_controller'

# Re-raise errors caught by the controller.
class ProvEventsController; def rescue_action(e) raise e end; end

class ProvEventsControllerTest < Test::Unit::TestCase
  fixtures :prov_events

  def setup
    @controller = ProvEventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_events)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_events
    old_count = ProvEvents.count
    post :create, :prov_events => { }
    assert_equal old_count+1, ProvEvents.count
    
    assert_redirected_to prov_events_path(assigns(:prov_events))
  end

  def test_should_show_prov_events
    get :show, :prov_event_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_event_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_events
    put :update, :prov_event_id => 1, :prov_events => { }
    assert_redirected_to prov_events_path(assigns(:prov_events))
  end
  
  def test_should_destroy_prov_events
    old_count = ProvEvents.count
    delete :destroy, :prov_event_id => 1
    assert_equal old_count-1, ProvEvents.count
    
    assert_redirected_to prov_events_path
  end
end
