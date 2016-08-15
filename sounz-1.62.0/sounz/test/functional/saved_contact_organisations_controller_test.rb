require File.dirname(__FILE__) + '/../test_helper'
require 'saved_contact_organisations_controller'

# Re-raise errors caught by the controller.
class SavedContactOrganisationsController; def rescue_action(e) raise e end; end

class SavedContactOrganisationsControllerTest < Test::Unit::TestCase

  def setup
    @controller = SavedContactOrganisationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = saved_contact_organisations(:first).id
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

    assert_not_nil assigns(:saved_contact_organisations)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:saved_contact_organisation)
    assert assigns(:saved_contact_organisation).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:saved_contact_organisation)
  end

  def test_create
    num_saved_contact_organisations = SavedContactOrganisation.count

    post :create, :saved_contact_organisation => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_saved_contact_organisations + 1, SavedContactOrganisation.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:saved_contact_organisation)
    assert assigns(:saved_contact_organisation).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      SavedContactOrganisation.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      SavedContactOrganisation.find(@first_id)
    }
  end
end
