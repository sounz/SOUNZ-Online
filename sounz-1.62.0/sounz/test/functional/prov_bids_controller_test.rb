require File.dirname(__FILE__) + '/../test_helper'
require 'prov_bids_controller'

# Re-raise errors caught by the controller.
class ProvBidsController; def rescue_action(e) raise e end; end

class ProvBidsControllerTest < Test::Unit::TestCase
  fixtures :prov_bids

  def setup
    @controller = ProvBidsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_bids)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_bid
    old_count = ProvBid.count
    post :create, :prov_bid => { }
    assert_equal old_count+1, ProvBid.count
    
    assert_redirected_to prov_bid_path(assigns(:prov_bid))
  end

  def test_should_show_prov_bid
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_prov_bid
    put :update, :id => 1, :prov_bid => { }
    assert_redirected_to prov_bid_path(assigns(:prov_bid))
  end
  
  def test_should_destroy_prov_bid
    old_count = ProvBid.count
    delete :destroy, :id => 1
    assert_equal old_count-1, ProvBid.count
    
    assert_redirected_to prov_bids_path
  end
end
