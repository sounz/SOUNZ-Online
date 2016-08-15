class FormatsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @formats = Format.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @format = Format.find(params[:id])
  end

  def new
    @format = Format.new
  end

  def create
    @format = Format.new(params[:format])
    if @format.save
      flash[:notice] = 'Format was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @format = Format.find(params[:id])
  end

  def update
    @format = Format.find(params[:id])
    if @format.update_attributes(params[:format])
      flash[:notice] = 'Format was successfully updated.'
      redirect_to :action => 'show', :id => @format
    else
      render :action => 'edit'
    end
  end

  def destroy
    Format.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
