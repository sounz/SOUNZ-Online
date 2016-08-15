class SuperworksController < ApplicationController
  
  include StatusesHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @superworks = Superwork.paginate( :page => params[:page], :per_page => 50, :order => 'superwork_title')
  end

  def show
    @superwork = Superwork.find(params[:id])
    @page_title = "Superwork - #{@superwork.superwork_title}"
  end

  def new
    @superwork = Superwork.new
    @superwork.login_updated_by = @login
    get_statuses(@superwork)
    set_default_status(@superwork)
  end

  def create
    @superwork = Superwork.new(params[:superwork])
    @superwork.login_updated_by = @login
    if @superwork.save
      flash[:notice] = 'Superwork was successfully created.'
      redirect_to :action => 'show', :id => @superwork
    else
      get_statuses(@superwork)
      render :action => 'new'
    end
  end

  def edit
    @superwork = Superwork.find(params[:id])
    get_statuses(@superwork)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)

  end

  def update
    @superwork = Superwork.find(params[:id])
    @superwork.login_updated_by = @login
    if @superwork.update_attributes(params[:superwork])
      flash[:notice] = 'Superwork was successfully updated.'
      redirect_to :action => 'show', :id => @superwork
    else
      render :action => 'edit'
    end
  end

  def destroy
    Superwork.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
