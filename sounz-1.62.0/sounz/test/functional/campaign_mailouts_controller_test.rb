require File.dirname(__FILE__) + '/../test_helper'
require 'campaign_mailouts_controller'

# Re-raise errors caught by the controller.
class CampaignMailoutsController; def rescue_action(e) raise e end; end

class CampaignMailoutsControllerTest < Test::Unit::TestCase

  def setup
    @controller = CampaignMailoutsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = campaign_mailouts(:first).id
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

    assert_not_nil assigns(:campaign_mailouts)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:campaign_mailout)
    assert assigns(:campaign_mailout).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:campaign_mailout)
  end

  def test_create
    num_campaign_mailouts = CampaignMailout.count

    post :create, :campaign_mailout => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_campaign_mailouts + 1, CampaignMailout.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:campaign_mailout)
    assert assigns(:campaign_mailout).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CampaignMailout.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CampaignMailout.find(@first_id)
    }
  end
end
