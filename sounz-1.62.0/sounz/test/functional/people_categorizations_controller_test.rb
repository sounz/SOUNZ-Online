require File.dirname(__FILE__) + '/../test_helper'
require 'people_categorizations_controller'

# Re-raise errors caught by the controller.
class PeopleCategorizationsController; def rescue_action(e) raise e end; end

class PeopleCategorizationsControllerTest < Test::Unit::TestCase

  def setup
    @controller = PeopleCategorizationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = people_categorizations(:first).id
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

    assert_not_nil assigns(:people_categorizations)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:people_categorization)
    assert assigns(:people_categorization).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:people_categorization)
  end

  def test_create
    num_people_categorizations = PeopleCategorization.count

    post :create, :people_categorization => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_people_categorizations + 1, PeopleCategorization.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:people_categorization)
    assert assigns(:people_categorization).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PeopleCategorization.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PeopleCategorization.find(@first_id)
    }
  end
end
