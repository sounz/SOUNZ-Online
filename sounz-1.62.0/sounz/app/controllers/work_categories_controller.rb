class WorkCategoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @work_categories = WorkCategory.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @work_category = WorkCategory.find(params[:id])
  end

  def new
    @work_category = WorkCategory.new
  end

  def create
    @work_category = WorkCategory.new(params[:work_category])
    if @work_category.save
      flash[:notice] = 'WorkCategory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @work_category = WorkCategory.find(params[:id])
  end

  def update
    @work_category = WorkCategory.find(params[:id])
    if @work_category.update_attributes(params[:work_category])
      flash[:notice] = 'WorkCategory was successfully updated.'
      redirect_to :action => 'show', :id => @work_category
    else
      render :action => 'edit'
    end
  end

  def destroy
    WorkCategory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
