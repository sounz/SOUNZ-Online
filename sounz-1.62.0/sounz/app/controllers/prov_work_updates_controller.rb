class ProvWorkUpdatesController < ApplicationController
  include StatusesHelper
  include ApplicationHelper
  
  # GET /prov_work_updates
  # GET /prov_work_updates.xml
  def index
  	
	if !params[:mode].blank? && params[:mode].match('show_all')
	  @prov_work_updates = ProvWorkUpdates.find(:all, :order => 'created_at desc')
    else
	  month_ago = 1.month.ago
	  @prov_work_updates = ProvWorkUpdates.find(:all, :order => 'created_at desc',
		  :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
								  Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	end  	

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_work_updates.to_xml }
    end
  end

  # GET /prov_work_updates/1
  # GET /prov_work_updates/1.xml
  def show
    @prov_work_updates = ProvWorkUpdates.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_work_updates.to_xml }
    end
  end

  # GET /prov_work_updates/new
  def new
    @prov_work_updates = ProvWorkUpdates.new
    get_statuses(@prov_work_updates)
  end

  # GET /prov_work_updates/1;edit
  def edit
    @prov_work_updates = ProvWorkUpdates.find(params[:id])
    get_statuses(@prov_work_updates)
  end

  # POST /prov_work_updates
  # POST /prov_work_updates.xml
  def create
    #Add a pending status id
    params[:prov_work_updates][:status_id]= Status::PENDING.status_id
    @prov_work_updates = ProvWorkUpdates.new(params[:prov_work_updates])
    @prov_work_updates.submitted_by = @login.login_id
    set_default_status(@prov_work_updates)

    respond_to do |format|
      if @prov_work_updates.save
        ProviderPagesHelper.email_notification(generate_id(@prov_work_updates))
        format.html { redirect_to show_confirmation_prov_work_update_url(@prov_work_updates) }
        format.xml  { head :created, :location => prov_work_updates_url(@prov_work_updates) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_work_updates.errors.to_xml }
      end
    end
  end

  # PUT /prov_work_updates/1
  # PUT /prov_work_updates/1.xml
  def update
    @prov_work_updates = ProvWorkUpdates.find(params[:id])

    respond_to do |format|
      if @prov_work_updates.update_attributes(params[:prov_work_updates])
        flash[:notice] = 'Work Update was successfully updated.'
        format.html { redirect_to edit_prov_work_update_path(@prov_work_updates) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_work_updates.errors.to_xml }
      end
    end
  end

  # DELETE /prov_work_updates/1
  # DELETE /prov_work_updates/1.xml
  def destroy
    @prov_work_updates = ProvWorkUpdates.find(params[:id])
    @prov_work_updates.destroy

    respond_to do |format|
      format.html { redirect_to prov_work_updates_url }
      format.xml  { head :ok }
    end
  end
  
end
