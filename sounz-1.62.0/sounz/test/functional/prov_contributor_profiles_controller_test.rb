require File.dirname(__FILE__) + '/../test_helper'
require 'prov_contributor_profiles_controller'

# Re-raise errors caught by the controller.
class ProvContributorProfilesController; def rescue_action(e) raise e end; end

class ProvContributorProfilesControllerTest < Test::Unit::TestCase
  fixtures :prov_contributor_profiles

  def setup
    @controller = ProvContributorProfilesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_contributor_profiles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_contributor_profiles
    old_count = ProvContributorProfiles.count
    post :create, :prov_contributor_profiles => { }
    assert_equal old_count+1, ProvContributorProfiles.count
    
    assert_redirected_to prov_contributor_profiles_path(assigns(:prov_contributor_profiles))
  end

  def test_should_show_prov_contributor_profiles
    get :show, :prov_contributor_profile_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_contributor_profile_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_contributor_profiles
    put :update, :prov_contributor_profile_id => 1, :prov_contributor_profiles => { }
    assert_redirected_to prov_contributor_profiles_path(assigns(:prov_contributor_profiles))
  end
  
  def test_should_destroy_prov_contributor_profiles
    old_count = ProvContributorProfiles.count
    delete :destroy, :prov_contributor_profile_id => 1
    assert_equal old_count-1, ProvContributorProfiles.count
    
    assert_redirected_to prov_contributor_profiles_path
  end
end
