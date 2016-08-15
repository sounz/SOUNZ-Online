class ModesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @modes = Mode.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @mode = Mode.find(params[:id])
  end

  def new
    @mode = Mode.new
  end

  def create
    @mode = Mode.new(params[:mode])
    if @mode.save
      flash[:notice] = 'Mode was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @mode = Mode.find(params[:id])
  end

  def update
    @mode = Mode.find(params[:id])
    if @mode.update_attributes(params[:mode])
      flash[:notice] = 'Mode was successfully updated.'
      redirect_to :action => 'show', :id => @mode
    else
      render :action => 'edit'
    end
  end

  def destroy
    Mode.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
