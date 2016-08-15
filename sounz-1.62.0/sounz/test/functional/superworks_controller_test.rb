require File.dirname(__FILE__) + '/../test_helper'
require 'superworks_controller'

# Re-raise errors caught by the controller.
class SuperworksController; def rescue_action(e) raise e end; end

class SuperworksControllerTest < Test::Unit::TestCase

  def setup
    @controller = SuperworksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = superworks(:first).id
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

    assert_not_nil assigns(:superworks)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:superwork)
    assert assigns(:superwork).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:superwork)
  end

  def test_create
    num_superworks = Superwork.count

    post :create, :superwork => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_superworks + 1, Superwork.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:superwork)
    assert assigns(:superwork).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Superwork.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Superwork.find(@first_id)
    }
  end
end
