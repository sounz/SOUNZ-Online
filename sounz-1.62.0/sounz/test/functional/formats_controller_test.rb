require File.dirname(__FILE__) + '/../test_helper'
require 'formats_controller'

# Re-raise errors caught by the controller.
class FormatsController; def rescue_action(e) raise e end; end

class FormatsControllerTest < Test::Unit::TestCase

  def setup
    @controller = FormatsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = formats(:first).id
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

    assert_not_nil assigns(:formats)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:format)
    assert assigns(:format).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:format)
  end

  def test_create
    num_formats = Format.count

    post :create, :format => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_formats + 1, Format.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:format)
    assert assigns(:format).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Format.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Format.find(@first_id)
    }
  end
end
