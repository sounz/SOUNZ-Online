require File.dirname(__FILE__) + '/../test_helper'
require 'contactinfos_controller'

# Re-raise errors caught by the controller.
class ContactinfosController; def rescue_action(e) raise e end; end

class ContactinfosControllerTest < Test::Unit::TestCase

  def setup
    @controller = ContactinfosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = contactinfos(:first).id
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

    assert_not_nil assigns(:contactinfos)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:contactinfo)
    assert assigns(:contactinfo).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:contactinfo)
  end

  def test_create
    num_contactinfos = Contactinfo.count

    post :create, :contactinfo => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_contactinfos + 1, Contactinfo.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:contactinfo)
    assert assigns(:contactinfo).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Contactinfo.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Contactinfo.find(@first_id)
    }
  end
end
