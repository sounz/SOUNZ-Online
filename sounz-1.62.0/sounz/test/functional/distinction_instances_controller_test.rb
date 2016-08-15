require File.dirname(__FILE__) + '/../test_helper'
require 'distinction_instances_controller'

# Re-raise errors caught by the controller.
class DistinctionInstancesController; def rescue_action(e) raise e end; end

class DistinctionInstancesControllerTest < Test::Unit::TestCase
  fixtures :distinction_instances

  def setup
    @controller = DistinctionInstancesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = distinction_instances(:first).id
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

    assert_not_nil assigns(:distinction_instances)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:distinction_instance)
    assert assigns(:distinction_instance).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:distinction_instance)
  end

  def test_create
    num_distinction_instances = DistinctionInstance.count

    post :create, :distinction_instance => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_distinction_instances + 1, DistinctionInstance.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:distinction_instance)
    assert assigns(:distinction_instance).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      DistinctionInstance.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      DistinctionInstance.find(@first_id)
    }
  end
end
