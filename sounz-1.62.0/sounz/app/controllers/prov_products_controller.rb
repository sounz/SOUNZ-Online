class ProvProductsController < ApplicationController
	
	include StatusesHelper
	include ApplicationHelper

  # GET /prov_products
  # GET /prov_products.xml
  def index
	if !params[:mode].blank? && params[:mode].match('show_all')
		@prov_products = ProvProducts.find(:all, :order => 'created_at desc')
	else
		month_ago = 1.month.ago
		@prov_products = ProvProducts.find(:all, :order => 'created_at desc',
					 :conditions => ["status_id = ? OR (status_id = ? AND updated_at >= ?)", 
									Status::PENDING.status_id, Status::APPROVED.status_id, month_ago ])
	end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @prov_products.to_xml }
    end
  end

  # GET /prov_products/1
  # GET /prov_products/1.xml
  def show
    @prov_products = ProvProducts.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @prov_products.to_xml }
    end
  end

  # GET /prov_products/new
  def new
    @prov_products = ProvProducts.new
	get_statuses(@prov_products)
  end

  # GET /prov_products/1;edit
  def edit
    @prov_products = ProvProducts.find(params[:id])
	get_statuses(@prov_products)
  end

  # POST /prov_products
  # POST /prov_products.xml
  def create
  	
	#Add a pending status id
	params[:prov_products][:status_id]= Status::PENDING.status_id
	@prov_products = ProvProducts.new(params[:prov_products])
	@prov_products.submitted_by = @login.login_id
	set_default_status(@prov_products)
 
    respond_to do |format|
      if @prov_products.save
      	ProviderPagesHelper.email_notification(generate_id(@prov_products))
        format.html { redirect_to show_confirmation_prov_product_url(@prov_products) }
        format.xml  { head :created, :location => prov_products_url(@prov_products) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prov_products.errors.to_xml }
      end
    end
  end

  # PUT /prov_products/1
  # PUT /prov_products/1.xml
  def update
    @prov_products = ProvProducts.find(params[:id])

    respond_to do |format|
      if @prov_products.update_attributes(params[:prov_products])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to edit_prov_product_url(@prov_products) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prov_products.errors.to_xml }
      end
    end
  end

  # DELETE /prov_products/1
  # DELETE /prov_products/1.xml
  def destroy
    @prov_products = ProvProducts.find(params[:id])
    @prov_products.destroy

    respond_to do |format|
      format.html { redirect_to prov_products_url }
      format.xml  { head :ok }
    end
  end
end
