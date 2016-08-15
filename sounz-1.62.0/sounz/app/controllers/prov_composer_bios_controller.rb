class ProvComposerBiosController < ApplicationController
  
  include StatusesHelper
  include ModelAsStringHelper
  
  # GET /prov_composer_bios
  # GET /prov_composer_bios.xml
  def index

	if !params[:mode].blank? && params[:mode].match('show_all')
      @prov_composer_bios = ProvComposerBios.find(:all, :order => 'created_at desc')
	else
	  month_ago = 1.month.ago
	  @prov_composer_bios = ProvComposerBios.find(:all, :order => 'created_at desc',
		           :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
					  Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_composer_bios.to_xml }
    end
  end

  # GET /prov_composer_bios/1
  # GET /prov_composer_bios/1.xml
  def show
    @prov_composer_bios = ProvComposerBios.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_composer_bios.to_xml }
    end
  end

  # GET /prov_composer_bios/new
  def new
    @prov_composer_bios = ProvComposerBios.new
  end

  # GET /prov_composer_bios/1;edit
  def edit
    @prov_composer_bios = ProvComposerBios.find(params[:id])
    get_statuses(@prov_composer_bios)
  end

  # POST /prov_composer_bios
  # POST /prov_composer_bios.xml
  def create
    @prov_composer_bios = ProvComposerBios.new(params[:prov_composer_bios])
    @prov_composer_bios.submitted_by = @login.login_id
    set_default_status(@prov_composer_bios)
    
    respond_to do |format|
      if @prov_composer_bios.save
        #flash[:notice] = 'ProvComposerBios was successfully created.'
        format.html { redirect_to show_confirmation_prov_composer_bio_url(@prov_composer_bios) }
        format.xml  { head :created, :location => prov_composer_bios_url(@prov_composer_bios) }
        
        #Now try to email
        begin
          ProviderPagesHelper.email_notification(generate_id(@prov_composer_bios))
        rescue Exception => e
          logger.error "FAILED TO DELIVER MAIL NOTIFICATION REGARDING FORM SUBMISSION: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        end
        
      else
        get_statuses(@prov_composer_bios)
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_composer_bios.errors.to_xml }
      end
    end
  end

  # PUT /prov_composer_bios/1
  # PUT /prov_composer_bios/1.xml
  def update
    @prov_composer_bios = ProvComposerBios.find(params[:id])

    respond_to do |format|
      if @prov_composer_bios.update_attributes(params[:prov_composer_bios])
        flash[:notice] = 'ProvComposerBios was successfully updated.'
        format.html { redirect_to prov_composer_bio_url(@prov_composer_bios) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_composer_bios.errors.to_xml }
      end
    end
  end

  # DELETE /prov_composer_bios/1
  # DELETE /prov_composer_bios/1.xml
  def destroy
    @prov_composer_bios = ProvComposerBios.find(params[:id])
    @prov_composer_bios.destroy

    respond_to do |format|
      format.html { redirect_to prov_composer_bios_url }
      format.xml  { head :ok }
    end
  end
end
