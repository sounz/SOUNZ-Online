require File.dirname(__FILE__) + '/../test_helper'
require 'marketing_campaigns_controller'

# Re-raise errors caught by the controller.
class MarketingCampaignsController; def rescue_action(e) raise e end; end

class MarketingCampaignsControllerTest < Test::Unit::TestCase

  def setup
    @controller = MarketingCampaignsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = marketing_campaigns(:first).id
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

    assert_not_nil assigns(:marketing_campaigns)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:marketing_campaign)
    assert assigns(:marketing_campaign).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:marketing_campaign)
  end

  def test_create
    num_marketing_campaigns = MarketingCampaign.count

    post :create, :marketing_campaign => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_marketing_campaigns + 1, MarketingCampaign.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:marketing_campaign)
    assert assigns(:marketing_campaign).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MarketingCampaign.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MarketingCampaign.find(@first_id)
    }
  end
end
