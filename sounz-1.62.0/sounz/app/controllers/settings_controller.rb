class SettingsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @settings = Setting.paginate( :page => params[:page], :per_page => 50, :order => :setting_name)
  end

  def show
    @setting = Setting.find(params[:id])
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(params[:setting])
    if @setting.save
      flash[:notice] = 'Setting was successfully created.'
      redirect_to :action => 'edit', :id => @setting
    else
      render :action => 'new'
    end
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    if @setting.update_attributes(params[:setting])
      flash[:notice] = 'Setting was successfully updated.'
      redirect_to :action => 'edit', :id => @setting
    else
      render :action => 'edit'
    end
  end

  def destroy
    Setting.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
