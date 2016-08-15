require File.dirname(__FILE__) + '/../test_helper'
require 'person_contactinfos_controller'

# Re-raise errors caught by the controller.
class PersonContactinfosController; def rescue_action(e) raise e end; end

class PersonContactinfosControllerTest < Test::Unit::TestCase

  def setup
    @controller = PersonContactinfosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = person_contactinfos(:first).id
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

    assert_not_nil assigns(:person_contactinfos)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:person_contactinfo)
    assert assigns(:person_contactinfo).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:person_contactinfo)
  end

  def test_create
    num_person_contactinfos = PersonContactinfo.count

    post :create, :person_contactinfo => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_person_contactinfos + 1, PersonContactinfo.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:person_contactinfo)
    assert assigns(:person_contactinfo).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      PersonContactinfo.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      PersonContactinfo.find(@first_id)
    }
  end
end
