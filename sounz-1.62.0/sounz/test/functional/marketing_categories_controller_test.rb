require File.dirname(__FILE__) + '/../test_helper'
require 'marketing_categories_controller'

# Re-raise errors caught by the controller.
class MarketingCategoriesController; def rescue_action(e) raise e end; end

class MarketingCategoriesControllerTest < Test::Unit::TestCase

  def setup
    @controller = MarketingCategoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = marketing_categories(:first).id
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

    assert_not_nil assigns(:marketing_categories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:marketing_category)
    assert assigns(:marketing_category).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:marketing_category)
  end

  def test_create
    num_marketing_categories = MarketingCategory.count

    post :create, :marketing_category => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_marketing_categories + 1, MarketingCategory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:marketing_category)
    assert assigns(:marketing_category).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MarketingCategory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MarketingCategory.find(@first_id)
    }
  end
end
