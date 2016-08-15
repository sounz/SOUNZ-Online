require File.dirname(__FILE__) + '/../test_helper'
require 'project_team_members_controller'

# Re-raise errors caught by the controller.
class ProjectTeamMembersController; def rescue_action(e) raise e end; end

class ProjectTeamMembersControllerTest < Test::Unit::TestCase

  def setup
    @controller = ProjectTeamMembersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = project_team_members(:first).id
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

    assert_not_nil assigns(:project_team_members)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:project_team_member)
    assert assigns(:project_team_member).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:project_team_member)
  end

  def test_create
    num_project_team_members = ProjectTeamMember.count

    post :create, :project_team_member => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_project_team_members + 1, ProjectTeamMember.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:project_team_member)
    assert assigns(:project_team_member).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      ProjectTeamMember.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ProjectTeamMember.find(@first_id)
    }
  end
end
