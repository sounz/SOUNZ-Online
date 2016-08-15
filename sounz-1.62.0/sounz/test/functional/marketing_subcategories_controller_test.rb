require File.dirname(__FILE__) + '/../test_helper'
require 'marketing_subcategories_controller'

# Re-raise errors caught by the controller.
class MarketingSubcategoriesController; def rescue_action(e) raise e end; end

class MarketingSubcategoriesControllerTest < Test::Unit::TestCase

  def setup
    @controller = MarketingSubcategoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = marketing_subcategories(:first).id
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

    assert_not_nil assigns(:marketing_subcategories)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:marketing_subcategory)
    assert assigns(:marketing_subcategory).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:marketing_subcategory)
  end

  def test_create
    num_marketing_subcategories = MarketingSubcategory.count

    post :create, :marketing_subcategory => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_marketing_subcategories + 1, MarketingSubcategory.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:marketing_subcategory)
    assert assigns(:marketing_subcategory).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MarketingSubcategory.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MarketingSubcategory.find(@first_id)
    }
  end
end
