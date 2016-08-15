class WorkSubcategoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @work_subcategories = WorkSubcategory.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @work_subcategory = WorkSubcategory.find(params[:id])
  end

  def new
    @work_subcategory = WorkSubcategory.new
    @work_categories=WorkCategory.find(:all)
  end

  def create
    @work_subcategory = WorkSubcategory.new(params[:work_subcategory])
    if @work_subcategory.save
      flash[:notice] = 'WorkSubcategory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @work_subcategory = WorkSubcategory.find(params[:id])
    @work_categories=WorkCategory.find(:all)
  end

  def update
    @work_subcategory = WorkSubcategory.find(params[:id])
    if @work_subcategory.update_attributes(params[:work_subcategory])
      flash[:notice] = 'WorkSubcategory was successfully updated.'
      redirect_to :action => 'show', :id => @work_subcategory
    else
      render :action => 'edit'
    end
  end

  def destroy
    WorkSubcategory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
