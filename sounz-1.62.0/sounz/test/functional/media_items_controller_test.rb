require File.dirname(__FILE__) + '/../test_helper'
require 'media_items_controller'

# Re-raise errors caught by the controller.
class MediaItemsController; def rescue_action(e) raise e end; end

class MediaItemsControllerTest < Test::Unit::TestCase

  def setup
    @controller = MediaItemsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:media_items)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_media_item
    old_count = MediaItem.count
    post :create, :media_item => { }
    assert_equal old_count+1, MediaItem.count
    
    assert_redirected_to media_item_path(assigns(:media_item))
  end

  def test_should_show_media_item
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_media_item
    put :update, :id => 1, :media_item => { }
    assert_redirected_to media_item_path(assigns(:media_item))
  end
  
  def test_should_destroy_media_item
    old_count = MediaItem.count
    delete :destroy, :id => 1
    assert_equal old_count-1, MediaItem.count
    
    assert_redirected_to media_items_path
  end
end
