class ProvEventsController < ApplicationController
  
  include StatusesHelper
  include ApplicationHelper
  
  # GET /prov_events
  # GET /prov_events.xml
  def index
    
	if !params[:mode].blank? && params[:mode].match('show_all')
	  @prov_events = ProvEvents.find(:all, :order => 'created_at desc')
	else
	  month_ago = 1.month.ago
	  @prov_events = ProvEvents.find(:all, :order => 'created_at desc',
		           :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
								  Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_events.to_xml }
    end
  end

  # GET /prov_events/1
  # GET /prov_events/1.xml
  def show
    @prov_events = ProvEvents.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_events.to_xml }
    end
  end

  # GET /prov_events/new
  def new
    @prov_events = ProvEvents.new
    get_statuses(@prov_events)
  end

  # GET /prov_events/1;edit
  def edit
    @prov_events = ProvEvents.find(params[:id])
    get_statuses(@prov_events)
  end

  # POST /prov_events
  # POST /prov_events.xml
  def create
    #Add a pending status id
    params[:prov_events][:status_id]= Status::PENDING.status_id
    @prov_events = ProvEvents.new(params[:prov_events])
    @prov_events.submitted_by = @login.login_id
    set_default_status(@prov_events)

    respond_to do |format|
      if @prov_events.save
        ProviderPagesHelper.email_notification(generate_id(@prov_events))
        format.html { redirect_to show_confirmation_prov_event_url(@prov_events) }
        format.xml  { head :created, :location => prov_events_url(@prov_events) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_events.errors.to_xml }
      end
    end
  end

  # PUT /prov_events/1
  # PUT /prov_events/1.xml
  def update
    @prov_events = ProvEvents.find(params[:id])

    respond_to do |format|
      if @prov_events.update_attributes(params[:prov_events])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to edit_prov_event_url(@prov_events) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_events.errors.to_xml }
      end
    end
  end

  # DELETE /prov_events/1
  # DELETE /prov_events/1.xml
  def destroy
    @prov_events = ProvEvents.find(params[:id])
    @prov_events.destroy

    respond_to do |format|
      format.html { redirect_to prov_events_url }
      format.xml  { head :ok }
    end
  end
  
end
