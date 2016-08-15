class ProvContributorProfilesController < ApplicationController
  
  include StatusesHelper
  include ModelAsStringHelper
  
  # GET /prov_contributor_profiles
  # GET /prov_contributor_profiles.xml
  def index
    
	if !params[:mode].blank? && params[:mode].match('show_all')
	  @prov_contributor_profiles = ProvContributorProfiles.find(:all, :order => 'created_at desc')
	else
	  month_ago = 1.month.ago
	  @prov_contributor_profiles = ProvContributorProfiles.find(:all, :order => 'created_at desc',
					 :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
						Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
    end

      
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_contributor_profiles.to_xml }
    end
  end

  # GET /prov_contributor_profiles/1
  # GET /prov_contributor_profiles/1.xml
  def show
    @prov_contributor_profiles = ProvContributorProfiles.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_contributor_profiles.to_xml }
    end
  end

  # GET /prov_contributor_profiles/new
  def new
    @prov_contributor_profiles = ProvContributorProfiles.new
  end

  # GET /prov_contributor_profiles/1;edit
  def edit
    @prov_contributor_profiles = ProvContributorProfiles.find(params[:id])
    get_statuses(@prov_contributor_profiles)
  end

  # POST /prov_contributor_profiles
  # POST /prov_contributor_profiles.xml
  def create
    @prov_contributor_profiles = ProvContributorProfiles.new(params[:prov_contributor_profiles])
    @prov_contributor_profiles.submitted_by = @login.login_id
    set_default_status(@prov_contributor_profiles)
    respond_to do |format|
      if @prov_contributor_profiles.save
        #flash[:notice] = 'ProvContributorProfiles was successfully created.'
        format.html { 
          redirect_to show_confirmation_prov_contributor_profile_url(@prov_contributor_profiles)
          }
        format.xml  { head :created, :location => prov_contributor_profiles_url(@prov_contributor_profiles) }
        
        #Now try to email
        begin
          ProviderPagesHelper.email_notification(generate_id(@prov_contributor_profiles))
        rescue Exception => e
          logger.error "FAILED TO DELIVER MAIL NOTIFICATION REGARDING FORM SUBMISSION: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        end
  
        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_contributor_profiles.errors.to_xml }
        get_statuses(@prov_contributor_profiles)
      end
    end
  end

  # PUT /prov_contributor_profiles/1
  # PUT /prov_contributor_profiles/1.xml
  def update
    @prov_contributor_profiles = ProvContributorProfiles.find(params[:id])

    respond_to do |format|
      if @prov_contributor_profiles.update_attributes(params[:prov_contributor_profiles])
        flash[:notice] = 'ProvContributorProfiles was successfully updated.'
        format.html { redirect_to prov_contributor_profile_url(@prov_contributor_profiles) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_contributor_profiles.errors.to_xml }
      end
    end
  end

  # DELETE /prov_contributor_profiles/1
  # DELETE /prov_contributor_profiles/1.xml
  def destroy
    @prov_contributor_profiles = ProvContributorProfiles.find(params[:id])
    @prov_contributor_profiles.destroy

    respond_to do |format|
      format.html { redirect_to prov_contributor_profiles_url }
      format.xml  { head :ok }
    end
  end
end
