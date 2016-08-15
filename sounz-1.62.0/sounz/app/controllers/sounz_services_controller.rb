class SounzServicesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @sounz_services = SounzService.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @sounz_service = SounzService.find(params[:id])
  end

  def new
    @sounz_service = SounzService.new
  end

  def create
    @sounz_service = SounzService.new(params[:sounz_service])
    if @sounz_service.save
      flash[:notice] = 'SounzService was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @sounz_service = SounzService.find(params[:id])
  end

  def update
    @sounz_service = SounzService.find(params[:id])
    if @sounz_service.update_attributes(params[:sounz_service])
      flash[:notice] = 'SounzService was successfully updated.'
      redirect_to :action => 'show', :id => @sounz_service
    else
      render :action => 'edit'
    end
  end

  def destroy
    SounzService.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
