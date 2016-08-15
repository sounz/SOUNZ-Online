class ResourceTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @resource_types = ResourceType.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @resource_type = ResourceType.find(params[:id])
  end

  def new
    @resource_type = ResourceType.new
  end

  def create
    @resource_type = ResourceType.new(params[:resource_type])
    if @resource_type.save
      flash[:notice] = 'ResourceType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @resource_type = ResourceType.find(params[:id])
  end

  def update
    @resource_type = ResourceType.find(params[:id])
    if @resource_type.update_attributes(params[:resource_type])
      flash[:notice] = 'ResourceType was successfully updated.'
      redirect_to :action => 'show', :id => @resource_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    ResourceType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
