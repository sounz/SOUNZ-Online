require File.dirname(__FILE__) + '/../test_helper'
require 'mailout_attachments_controller'

# Re-raise errors caught by the controller.
class MailoutAttachmentsController; def rescue_action(e) raise e end; end

class MailoutAttachmentsControllerTest < Test::Unit::TestCase
  fixtures :mailout_attachments

  def setup
    @controller = MailoutAttachmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = mailout_attachments(:first).id
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

    assert_not_nil assigns(:mailout_attachments)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:mailout_attachment)
    assert assigns(:mailout_attachment).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:mailout_attachment)
  end

  def test_create
    num_mailout_attachments = MailoutAttachment.count

    post :create, :mailout_attachment => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_mailout_attachments + 1, MailoutAttachment.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:mailout_attachment)
    assert assigns(:mailout_attachment).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MailoutAttachment.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MailoutAttachment.find(@first_id)
    }
  end
end
