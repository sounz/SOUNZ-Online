require File.dirname(__FILE__) + '/../test_helper'
require 'prov_composer_bios_controller'

# Re-raise errors caught by the controller.
class ProvComposerBiosController; def rescue_action(e) raise e end; end

class ProvComposerBiosControllerTest < Test::Unit::TestCase
  fixtures :prov_composer_bios

  def setup
    @controller = ProvComposerBiosController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:prov_composer_bios)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_prov_composer_bios
    old_count = ProvComposerBios.count
    post :create, :prov_composer_bios => { }
    assert_equal old_count+1, ProvComposerBios.count
    
    assert_redirected_to prov_composer_bios_path(assigns(:prov_composer_bios))
  end

  def test_should_show_prov_composer_bios
    get :show, :prov_composer_bio_id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :prov_composer_bio_id => 1
    assert_response :success
  end
  
  def test_should_update_prov_composer_bios
    put :update, :prov_composer_bio_id => 1, :prov_composer_bios => { }
    assert_redirected_to prov_composer_bios_path(assigns(:prov_composer_bios))
  end
  
  def test_should_destroy_prov_composer_bios
    old_count = ProvComposerBios.count
    delete :destroy, :prov_composer_bio_id => 1
    assert_equal old_count-1, ProvComposerBios.count
    
    assert_redirected_to prov_composer_bios_path
  end
end
