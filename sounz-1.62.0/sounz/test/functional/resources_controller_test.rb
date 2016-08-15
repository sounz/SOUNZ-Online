require File.dirname(__FILE__) + '/../test_helper'
require 'resources_controller'

# Re-raise errors caught by the controller.
class ResourcesController; def rescue_action(e) raise e end; end

class ResourcesControllerTest < Test::Unit::TestCase

  def setup
    @controller = ResourcesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = resources(:first).id
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

    assert_not_nil assigns(:resources)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:resource)
    assert assigns(:resource).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:resource)
  end

  def test_create
    num_resources = Resource.count

    post :create, :resource => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_resources + 1, Resource.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:resource)
    assert assigns(:resource).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Resource.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Resource.find(@first_id)
    }
  end
end
