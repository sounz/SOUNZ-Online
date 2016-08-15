require File.dirname(__FILE__) + '/../test_helper'
require 'works_controller'

# Re-raise errors caught by the controller.
class WorksController; def rescue_action(e) raise e end; end

class WorksControllerTest < Test::Unit::TestCase

  def setup
    @controller = WorksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = Work.find(:first)
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

    assert_not_nil assigns(:works)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:work)
    assert assigns(:work).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:work)
  end

  def test_create
    num_works = Work.count

    post :create, :work => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_works + 1, Work.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:work)
    assert assigns(:work).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Work.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Work.find(@first_id)
    }
  end
end
