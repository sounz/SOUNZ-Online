require File.dirname(__FILE__) + '/../test_helper'
require 'expressions_controller'

# Re-raise errors caught by the controller.
class ExpressionsController; def rescue_action(e) raise e end; end

class ExpressionsControllerTest < Test::Unit::TestCase

  def setup
    @controller = ExpressionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @login = Login.find(:first)
    @login_session_hash = {'login' => @login.login_id}

    @first_id = Expression.find(:first).expression_id
  end

  def test_index
    get :index, nil, @login_session_hash
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list,nil,  @login_session_hash

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:expressions)
  end

  def test_show
    get :show, {:id => @first_id}, @login_session_hash

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:expression)
    assert assigns(:expression).valid?
  end

  def test_new
    get :new, nil,  @login_session_hash

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:expression)
  end

  def test_create
    num_expressions = Expression.count

    post :create, {:expression => {}},  @login_session_hash

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_expressions + 1, Expression.count
  end

  def test_edit
    get :edit, {:id => @first_id},  @login_session_hash

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:expression)
    assert assigns(:expression).valid?
  end

  def test_update
    post :update, {:id => @first_id},  @login_session_hash
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Expression.find(@first_id)
    }

    post :destroy, {:id => @first_id},  @login_session_hash
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Expression.find(@first_id)
    }
  end
end
