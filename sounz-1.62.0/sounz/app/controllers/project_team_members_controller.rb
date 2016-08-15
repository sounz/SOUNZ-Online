class ProjectTeamMembersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @project_team_member_pages, @project_team_members = paginate :project_team_members, :per_page => 10
  end

  def show
    @project_team_member = ProjectTeamMember.find(params[:id])
  end

  def new
    @project_team_member = ProjectTeamMember.new
  end

  def create
    @project_team_member = ProjectTeamMember.new(params[:project_team_member])
    if @project_team_member.save
      flash[:notice] = 'ProjectTeamMember was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @project_team_member = ProjectTeamMember.find(params[:id])
  end

  def update
    @project_team_member = ProjectTeamMember.find(params[:id])
    if @project_team_member.update_attributes(params[:project_team_member])
      flash[:notice] = 'ProjectTeamMember was successfully updated.'
      redirect_to :action => 'show', :id => @project_team_member
    else
      render :action => 'edit'
    end
  end

  def destroy
    ProjectTeamMember.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
