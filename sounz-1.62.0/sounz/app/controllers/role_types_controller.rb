class RoleTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @role_types = RoleType.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @role_type = RoleType.find(params[:id])
  end

  def new
    @role_type = RoleType.new
  end

  def create
    @role_type = RoleType.new(params[:role_type])
    if @role_type.save
      flash[:notice] = 'RoleType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @role_type = RoleType.find(params[:id])
  end

  def update
    @role_type = RoleType.find(params[:id])
    if @role_type.update_attributes(params[:role_type])
      flash[:notice] = 'RoleType was successfully updated.'
      redirect_to :action => 'show', :id => @role_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    RoleType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
