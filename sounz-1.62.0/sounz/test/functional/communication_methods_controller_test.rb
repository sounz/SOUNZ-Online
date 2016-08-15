require File.dirname(__FILE__) + '/../test_helper'
require 'communication_methods_controller'

# Re-raise errors caught by the controller.
class CommunicationMethodsController; def rescue_action(e) raise e end; end

class CommunicationMethodsControllerTest < Test::Unit::TestCase

  def setup
    @controller = CommunicationMethodsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = communication_methods(:first).id
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

    assert_not_nil assigns(:communication_methods)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:communication_method)
    assert assigns(:communication_method).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:communication_method)
  end

  def test_create
    num_communication_methods = CommunicationMethod.count

    post :create, :communication_method => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_communication_methods + 1, CommunicationMethod.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:communication_method)
    assert assigns(:communication_method).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CommunicationMethod.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CommunicationMethod.find(@first_id)
    }
  end
end
