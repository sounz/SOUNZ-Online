require File.dirname(__FILE__) + '/../test_helper'
require 'logins_controller'

# Re-raise errors caught by the controller.
class LoginsController; def rescue_action(e) raise e end; end

class LoginsControllerTest < Test::Unit::TestCase

  def setup
    @controller = LoginsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = logins(:first).id
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

    assert_not_nil assigns(:logins)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:login)
    assert assigns(:login).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:login)
  end

  def test_create
    num_logins = Login.count

    post :create, :login => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_logins + 1, Login.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:login)
    assert assigns(:login).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Login.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Login.find(@first_id)
    }
  end
end
