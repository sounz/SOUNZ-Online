class MemberTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @member_types = MemberType.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @member_type = MemberType.find(params[:id])
  end

  def new
    @member_type = MemberType.new
  end

  def create
    @member_type = MemberType.new(params[:member_type])
    if @member_type.save
      flash[:notice] = 'MemberType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @member_type = MemberType.find(params[:id])
  end

  def update
    @member_type = MemberType.find(params[:id])
    if @member_type.update_attributes(params[:member_type])
      flash[:notice] = 'MemberType was successfully updated.'
      redirect_to :action => 'show', :id => @member_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    MemberType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
