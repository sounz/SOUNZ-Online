require File.dirname(__FILE__) + '/../test_helper'
require 'cm_contents_controller'

# Re-raise errors caught by the controller.
class CmContentsController; def rescue_action(e) raise e end; end

class CmContentsControllerTest < Test::Unit::TestCase
  fixtures :cm_contents

  def setup
    @controller = CmContentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = cm_contents(:first).id
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

    assert_not_nil assigns(:cm_contents)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:cm_content)
    assert assigns(:cm_content).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:cm_content)
  end

  def test_create
    num_cm_contents = CmContent.count

    post :create, :cm_content => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_cm_contents + 1, CmContent.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:cm_content)
    assert assigns(:cm_content).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CmContent.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CmContent.find(@first_id)
    }
  end
end
