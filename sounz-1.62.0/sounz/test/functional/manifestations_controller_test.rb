require File.dirname(__FILE__) + '/../test_helper'
require 'manifestations_controller'

# Re-raise errors caught by the controller.
class ManifestationsController; def rescue_action(e) raise e end; end

class ManifestationsControllerTest < Test::Unit::TestCase

  def setup
    @controller = ManifestationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = manifestations(:first).id
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

    assert_not_nil assigns(:manifestations)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:manifestation)
    assert assigns(:manifestation).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:manifestation)
  end

  def test_create
    num_manifestations = Manifestation.count

    post :create, :manifestation => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_manifestations + 1, Manifestation.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:manifestation)
    assert assigns(:manifestation).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Manifestation.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Manifestation.find(@first_id)
    }
  end
end
