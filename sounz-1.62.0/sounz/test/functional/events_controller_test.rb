require File.dirname(__FILE__) + '/../test_helper'
require 'events_controller'

# Re-raise errors caught by the controller.
class EventsController; def rescue_action(e) raise e end; end

class EventsControllerTest < Test::Unit::TestCase

  def setup
    @controller = EventsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = events(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:events)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:event)
    assert assigns(:event).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:event)
  end

  def test_create
    num_events = Event.count

    post :create, :event => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_events + 1, Event.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:event)
    assert assigns(:event).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Event.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Event.find(@first_id)
    }
  end
end
