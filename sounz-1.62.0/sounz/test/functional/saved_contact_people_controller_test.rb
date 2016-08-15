require File.dirname(__FILE__) + '/../test_helper'
require 'saved_contact_people_controller'

# Re-raise errors caught by the controller.
class SavedContactPeopleController; def rescue_action(e) raise e end; end

class SavedContactPeopleControllerTest < Test::Unit::TestCase

  def setup
    @controller = SavedContactPeopleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = saved_contact_people(:first).id
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

    assert_not_nil assigns(:saved_contact_people)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:saved_contact_person)
    assert assigns(:saved_contact_person).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:saved_contact_person)
  end

  def test_create
    num_saved_contact_people = SavedContactPerson.count

    post :create, :saved_contact_person => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_saved_contact_people + 1, SavedContactPerson.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:saved_contact_person)
    assert assigns(:saved_contact_person).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      SavedContactPerson.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      SavedContactPerson.find(@first_id)
    }
  end
end
