require File.dirname(__FILE__) + '/../test_helper'
require 'work_categories_controller'

# Re-raise errors caught by the controller.
class WorkCategoriesController; def rescue_action(e) raise e end; end

class WorkCategoriesControllerTest < Test::Unit::TestCase

  def setup
    @controller = WorkCategoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = work_categories(:first).id
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

    assert_not_nil assigns(:work_categories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:work_category)
    assert assigns(:work_category).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:work_category)
  end

  def test_create
    num_work_categories = WorkCategory.count

    post :create, :work_category => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_work_categories + 1, WorkCategory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:work_category)
    assert assigns(:work_category).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      WorkCategory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      WorkCategory.find(@first_id)
    }
  end
end
