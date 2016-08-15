class NomenController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @Nomens = Nomen.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @Nomen = Nomen.find(params[:id])
  end

  def new
    @Nomen = Nomen.new
  end

  def create
    @Nomen = Nomen.new(params[:Nomen])
    if @Nomen.save
      flash[:notice] = 'Nomen was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @Nomen = Nomen.find(params[:id])
  end

  def update
    @Nomen = Nomen.find(params[:id])
    if @Nomen.update_attributes(params[:Nomen])
      flash[:notice] = 'Nomen was successfully updated.'
      redirect_to :action => 'show', :id => @Nomen
    else
      render :action => 'edit'
    end
  end

  def destroy
    Nomen.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
