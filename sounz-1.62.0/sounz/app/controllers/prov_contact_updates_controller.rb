class ProvContactUpdatesController < ApplicationController
  # GET /prov_contact_updates
  # GET /prov_contact_updates.xml
  
  include StatusesHelper
  include ModelAsStringHelper
  
  
  def index
	if !params[:mode].blank? && params[:mode].match('show_all')
	  @prov_contact_updates = ProvContactUpdates.find(:all, :order => 'created_at desc')
	  #@link_mode = 'show_current'
	else
	  month_ago = 1.month.ago
	  @prov_contact_updates = ProvContactUpdates.find(:all, :order => 'created_at desc',
			  :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
			  Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	  #@link_mode = 'show_all'
	end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_contact_updates.to_xml }
    end
  end

  # GET /prov_contact_updates/1
  # GET /prov_contact_updates/1.xml
  def show
    @prov_contact_updates = ProvContactUpdates.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_contact_updates.to_xml }
    end
  end

  # GET /prov_contact_updates/new
  def new
    @prov_contact_updates = ProvContactUpdates.new
    get_statuses(@prov_contact_updates)
  end

  # GET /prov_contact_updates/1;edit
  def edit
    @prov_contact_updates = ProvContactUpdates.find(params[:id])
    get_statuses(@prov_contact_updates)
  end

  # POST /prov_contact_updates
  # POST /prov_contact_updates.xml
  def create
    #Add a pending status id
    params[:prov_contact_updates][:status_id]= Status::PENDING.status_id
    @prov_contact_updates = ProvContactUpdates.new(params[:prov_contact_updates])
    @prov_contact_updates.submitted_by = @login.login_id
    set_default_status(@prov_contact_updates)
    
    respond_to do |format|
      if @prov_contact_updates.save
        #flash[:notice] = 'ProvContactUpdates was successfully created.'
        format.html { 
          #redirect_to prov_contact_updates_url(@prov_contact_updates)
      #    download_media_item_path(media_item)%
          redirect_to show_confirmation_prov_contact_update_url(@prov_contact_updates)
           }
        format.xml  { head :created, :location => prov_contact_updates_url(@prov_contact_updates) }
        #Now try to email
        begin
          logger.debug "SENDING NOTIFICATION"
          ProviderPagesHelper.email_notification(generate_id(@prov_contact_updates))
        rescue Exception => e
          logger.error "FAILED TO DELIVER MAIL NOTIFICATION REGARDING FORM SUBMISSION: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        end
      else
        get_statuses(@prov_contact_updates)
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_contact_updates.errors.to_xml }
      end
    end
  end

  # PUT /prov_contact_updates/1
  # PUT /prov_contact_updates/1.xml
  def update
    @prov_contact_updates = ProvContactUpdates.find(params[:id])

    respond_to do |format|
      if @prov_contact_updates.update_attributes(params[:prov_contact_updates])
        flash[:notice] = 'ProvContactUpdates was successfully updated.'
        format.html { redirect_to edit_prov_contact_update_path(@prov_contact_updates) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_contact_updates.errors.to_xml }
      end
    end
  end

  # DELETE /prov_contact_updates/1
  # DELETE /prov_contact_updates/1.xml
  def destroy
    @prov_contact_updates = ProvContactUpdates.find(params[:id])
    @prov_contact_updates.destroy

    respond_to do |format|
      format.html { redirect_to prov_contact_updates_url }
      format.xml  { head :ok }
    end
  end
  
  
  def show_confirmation
    @prov_contact_updates = ProvContactUpdates.find(params[:id])
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_contact_updates.to_xml }
    end
  end
end
