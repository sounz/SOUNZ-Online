class CommunicationMethodsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @communication_methods = CommunicationMethod.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @communication_method = CommunicationMethod.find(params[:id])
  end

  def new
    @communication_method = CommunicationMethod.new
  end

  def create
    @communication_method = CommunicationMethod.new(params[:communication_method])
    if @communication_method.save
      flash[:notice] = 'CommunicationMethod was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @communication_method = CommunicationMethod.find(params[:id])
  end

  def update
    @communication_method = CommunicationMethod.find(params[:id])
    if @communication_method.update_attributes(params[:communication_method])
      flash[:notice] = 'CommunicationMethod was successfully updated.'
      redirect_to :action => 'show', :id => @communication_method
    else
      render :action => 'edit'
    end
  end

  def destroy
    CommunicationMethod.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
