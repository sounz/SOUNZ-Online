class ProvFeedbacksController < ApplicationController
  # GET /prov_feedbacks
  # GET /prov_feedbacks.xml
  
  include StatusesHelper
  include ApplicationHelper
  
  def index
  	if !params[:mode].blank? && params[:mode].match('show_all')
	  @prov_feedbacks = ProvFeedbacks.find(:all, :order => 'created_at desc')
	  #@link_mode = 'show_current'
	else
	  month_ago = 1.month.ago
      @prov_feedbacks = ProvFeedbacks.find(:all, :order => 'created_at desc',
        :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
        	Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	  #@link_mode = 'show_all'
	end
	
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_feedbacks.to_xml }
    end
  end

  # GET /prov_feedbacks/1
  # GET /prov_feedbacks/1.xml
  def show
    @prov_feedbacks = ProvFeedbacks.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_feedbacks.to_xml }
    end
  end

  # GET /prov_feedbacks/new
  def new
    @prov_feedbacks = ProvFeedbacks.new
    get_statuses(@prov_feedbacks)
  end

  # GET /prov_feedbacks/1;edit
  def edit
    @prov_feedbacks = ProvFeedbacks.find(params[:id])
    get_statuses(@prov_feedbacks)
  end

  # POST /prov_feedbacks
  # POST /prov_feedbacks.xml
  def create
    #Add a pending status id
    params[:prov_feedbacks][:status_id]= Status::PENDING.status_id
    @prov_feedbacks = ProvFeedbacks.new(params[:prov_feedbacks])
    @prov_feedbacks.submitted_by = @login.login_id unless @login.blank?
    set_default_status(@prov_feedbacks)
    captcha_was_valid = simple_captcha_valid?
 
    respond_to do |format|
      
     if captcha_was_valid && @prov_feedbacks.save
        ProviderPagesHelper.email_notification(generate_id(@prov_feedbacks))
        format.html { redirect_to show_confirmation_prov_feedback_url(@prov_feedbacks) }
        format.xml  { head :created, :location => prov_feedback_url(@prov_feedbacks) }
      else
        flash[:notice] = "The Captcha was not valid" if !captcha_was_valid
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_feedbacks.errors.to_xml }
      end
    end
  end

  # PUT /prov_feedbacks/1
  # PUT /prov_feedbacks/1.xml
  def update
    @prov_feedbacks = ProvFeedbacks.find(params[:id])

    respond_to do |format|
      if @prov_feedbacks.update_attributes(params[:prov_feedbacks])
        flash[:notice] = 'Feedback was successfully updated.'
        format.html { redirect_to edit_prov_feedback_path(@prov_feedbacks) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_feedbacks.errors.to_xml }
      end
    end
  end

  # DELETE /prov_feedbacks/1
  # DELETE /prov_feedbacks/1.xml
  def destroy
    @prov_feedbacks = ProvFeedbacks.find(params[:id])
    @prov_feedbacks.destroy

    respond_to do |format|
      format.html { redirect_to prov_feedbacks_url }
      format.xml  { head :ok }
    end
  end
  
end
