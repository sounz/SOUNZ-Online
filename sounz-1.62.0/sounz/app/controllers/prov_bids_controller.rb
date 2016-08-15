class ProvBidsController < ApplicationController
  include StatusesHelper
  include ApplicationHelper
  
  # GET /prov_bids
  # GET /prov_bids.xml
  def index
    if !params[:mode].blank? && params[:mode].match('show_all')
	    @prov_bids = ProvBid.find(:all, :order => 'created_at desc')

  	else
	    month_ago = 1.month.ago
      @prov_bids = ProvBid.find(:all, :order => 'created_at desc',
        :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)",
        	Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_bids.to_xml }
    end
  end

  # GET /prov_bids/1
  # GET /prov_bids/1.xml
  def show
    @prov_bid = ProvBid.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_bid.to_xml }
    end
  end

  # GET /prov_bids/new
  def new
    @prov_bid = ProvBid.new
    get_statuses(@prov_bid)
  end

  # GET /prov_bids/1;edit
  def edit
    @prov_bid = ProvBid.find(params[:id])
    get_statuses(@prov_bid)
  end

  # POST /prov_bids
  # POST /prov_bids.xml
  def create
    #Add a pending status id
    params[:prov_bid][:status_id] = Status::PENDING.status_id
    @prov_bid = ProvBid.new(params[:prov_bid])
    @prov_bid.submitted_by = @login.login_id unless @login.blank?
    set_default_status(@prov_bid)
    captcha_was_valid = simple_captcha_valid?

    respond_to do |format|

     if captcha_was_valid && @prov_bid.save
        ProviderPagesHelper.email_notification(generate_id(@prov_bid))
        flash[:notice] = 'Your bid was successfully submitted.'
        format.html { redirect_to show_confirmation_prov_bid_url(@prov_bid) }
        format.xml  { head :created, :location => prov_bid_url(@prov_bid) }
      else
        if !captcha_was_valid
          @prov_bid.valid? # validate ProvBid object to get all validation errors
          @prov_bid.errors.add_to_base("The Captcha is not valid")
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_bid.errors.to_xml }
      end
    end
  end

  # PUT /prov_bids/1
  # PUT /prov_bids/1.xml
  def update
    @prov_bid = ProvBid.find(params[:id])

    respond_to do |format|
      if @prov_bid.update_attributes(params[:prov_bid])
        flash[:notice] = 'Bidding form was successfully updated.'
        format.html { redirect_to prov_bid_url(@prov_bid) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_bid.errors.to_xml }
      end
    end
  end

  # DELETE /prov_bids/1
  # DELETE /prov_bids/1.xml
  def destroy
    @prov_bid = ProvBid.find(params[:id])
    @prov_bid.destroy

    respond_to do |format|
      format.html { redirect_to prov_bids_url }
      format.xml  { head :ok }
    end
  end
end
