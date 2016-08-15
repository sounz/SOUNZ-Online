class CommunicationTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @communication_types = CommunicationType.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @communication_type = CommunicationType.find(params[:id])
  end

  def new
    @communication_type = CommunicationType.new
  end

  def create
    @communication_type = CommunicationType.new(params[:communication_type])
    if @communication_type.save
      flash[:notice] = 'CommunicationType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @communication_type = CommunicationType.find(params[:id])
  end

  def update
    @communication_type = CommunicationType.find(params[:id])
    if @communication_type.update_attributes(params[:communication_type])
      flash[:notice] = 'CommunicationType was successfully updated.'
      redirect_to :action => 'show', :id => @communication_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    CommunicationType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
