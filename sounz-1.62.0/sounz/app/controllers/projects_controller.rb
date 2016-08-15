require 'application_helper'

class ProjectsController < ApplicationController

  include ApplicationHelper

  #before_filter :hide_finish_date

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :list }

  #
  # Shows all projects paginated, sorted and categorised as appropriate
  #
  def list
    @title = "Project List"

    conditions = nil
    @status = nil
    @sortby = nil

    if params[:status]
      conditions = [ "project_status = ?", params[:status] ]
      @status = params[:status]
    end

    sortbylookup = {
      'name'  => "project_title",
      'start' => "start_date",
      'end'   => "actual_finish_date"
    }

    if sortbylookup[params[:sortby]]
      order = sortbylookup[params[:sortby]]
      @sortby = params[:sortby]
    else
      order = 'project_title'
    end
    order += ' DESC'

    @projects = Project.paginate( :page => params[:page], :per_page => 20, :conditions => conditions, :order => order)
  end

  #---------------------------------------------------------------------
  #- Show project generate by scaffolding, currently not used anywhere -
  #---------------------------------------------------------------------
  def show
    @project = Project.find(params[:id])
  end

  #---------------
  #- New project -
  #---------------
  def new
    @project = Project.new
    # date/time transformations
    convert_db_datetime_to_display
  end

  #----------------------
  #- Create new project -
  #----------------------
  def create
    @project = Project.new(params[:project])

    # combine date/time fields: date and time - into one
    convert_datetime_to_db_format

    # updated by
    @project.updated_by = get_user.login_id

    if @project.save
      flash[:notice] = 'Project was successfully created.'
      redirect_to :action => 'edit', :id => @project
    else
      @project.updated_by = nil
      # date/time transformations
      convert_db_datetime_to_display
      render :action => 'new'
    end
  end

  #------------------------
  #- Edit project details -
  #------------------------
  def edit
    @project = Project.find(params[:id])
    # date/time transformations
    convert_db_datetime_to_display
  end

  #---------------------------------
  #- Update (save) project details -
  #---------------------------------
  def update
    @project = Project.find(params[:id])

    # combine date/time fields: date and time - into one
    convert_datetime_to_db_format

    # updated by
    @project.updated_by = get_user.login_id

    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project was successfully updated.'
      redirect_to :action => 'edit', :id => @project
    else
      # date/time transformations
      convert_db_datetime_to_display
      render :action => 'edit'
    end
  end

  #---------------------------------------------
  #- Delete project and return to project list -
  #---------------------------------------------
  def destroy
  	project = Project.find(params[:id])
	if !project.blank? && project.can_be_deleted?
      project.destroy
      redirect_to :action => 'list'
	else
	  flash[:error] = 'Project cannot be deleted to protect the related data'
	  redirect_to :action => 'edit', :id => project.project_id
	end
  end

  #----------------------------------------
  #- Creates a clone of a project details -
  #----------------------------------------
  def copy
    project_to_clone = Project.find(params[:id])
    @project = project_to_clone.clone

    # FIXME add copying of project team members

    # date/time transformations
    convert_db_datetime_to_display
  end

  #------------------------------------------------------
  #- Combine date/time fields: date and time - into one -
  #------------------------------------------------------
  def convert_datetime_to_db_format
    if params[:project_start_date] && !params[:project_start_date][:start_date].empty?
      @project.start_date = date_time_to_db_format(params[:project_start_date][:start_date],
                                                   params[:project_start_date][:start_time]
      )
    end
    if params[:project_proposed_finish_date] && !params[:project_proposed_finish_date][:proposed_finish_date].empty?
      @project.proposed_finish_date = date_time_to_db_format(params[:project_proposed_finish_date][:proposed_finish_date],
                                                             params[:project_proposed_finish_date][:proposed_finish_time]
      )
    end
    if params[:project_actual_finish_date] && !params[:project_actual_finish_date][:actual_finish_date].empty?
      @project.actual_finish_date = date_time_to_db_format(params[:project_actual_finish_date][:actual_finish_date],
                                                           params[:project_actual_finish_date][:actual_finish_time]
      )
    end
  end

  #---------------------------------------------------------------
  #- Separate date/time db fields into date and time form fields -
  #---------------------------------------------------------------
  def convert_db_datetime_to_display
    # if a project doesn't have start and actual finish dates defined
    # the appropriate date/time text boxes contain 'now' by default
    # start date
    if @project.start_date == nil
      datetime = separate_date_time(Time.now)
    else
      datetime = separate_date_time(@project.start_date)
    end
    @start_time = datetime["time"]
    @start_date = datetime["date"]

    # proposed finish date
    if @project.proposed_finish_date != nil
      datetime = separate_date_time(@project.proposed_finish_date)
      @proposed_finish_time = datetime["time"]
      @proposed_finish_date = datetime["date"]
    end

    # actual finish date
    if @project.actual_finish_date == nil
      datetime = separate_date_time(Time.now)
    else
      datetime = separate_date_time(@project.actual_finish_date)
    end
    @actual_finish_time = datetime["time"]
    @actual_finish_date = datetime["date"]
  end

  #-------------------------------------------------------
  #- Display actual finish date text boxes if 'Finished' -
  #- (id = 2) is selected from Project Status            -
  #-------------------------------------------------------
  def actual_finish_date_boxes
    @finished = false
    if params[:id] == "2"
      @finished = true
      @actual_finish_time = Time.now.strftime("%H:%M")
      @actual_finish_date = Time.now.strftime("%d %b %Y")
    end
  end

  #--------------------------------------
  #- Find-as-you-type search for people -
  #--------------------------------------
  def find_people
    @query = '%' + params[:project_members_search] + '%'
    if @query.length > 3
      @project = Project.find(params[:id])
      people_ids = @project.people.map {|person| person.id }
      ids = ''
      people_ids.each do |id|
        ids << id.to_s << ','
      end
      logger.debug('***' + ids)
      ids = ids[0,ids.length-1]

      # if a project doesn't have a project team members
      # search results are not checked against
      # existing project team members
      ids_check = ''
      if !@project.people.empty?
        ids_check = 'AND person_id NOT IN (' + ids + ')'
      end
      @results = Person.find(:all,
                             :conditions => ["( LOWER(last_name) ILIKE ? OR LOWER(first_names) ILIKE ?) " + ids_check, @query.downcase, @query.downcase],
                             :limit => 10,
                             :order => 'last_name, first_names')
      render :layout => false
    else
      render :text => 'Please enter at least 3 characters'
    end
  end

  #--------------------------------------
  #- Add person to project team members -
  #--------------------------------------
  def add_person
    @project = Project.find(params[:project_id])
    @project.add_person(Person.find(params[:person_id]), false)
    render :layout => false
  end

  #-------------------------------------------
  #- Delete person from project team members -
  #-------------------------------------------
  def delete_person
    @project = Project.find(params[:project_id])
    person = Person.find(params[:person_id])
    @project.delete_person(person)
    @project.marketing_campaigns.each do |mc|
      mc.delete_manager(person)
    end
  end

  #-------------------------------------------
  #- Set new project manager on select from  -
  #- project members dropdown select box     -
  #-------------------------------------------
  def change_project_manager
    show_params(params)
    @project = Project.find(params[:project_id])
    @project.set_project_manager(params[:member_id])
  end

  #-------------------------------------
  #- Delete project marketing campaign -
  #-------------------------------------
  # note: this method is in projects controller
  # to make the response to delete quicker
  def delete_campaign
    MarketingCampaign.find(params[:id]).destroy
    render :layout => false
  end
end
