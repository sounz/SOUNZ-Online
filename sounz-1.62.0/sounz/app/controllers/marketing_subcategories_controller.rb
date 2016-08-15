class MarketingSubcategoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @marketing_subcategories = MarketingSubcategory.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
  end

  def new
    @marketing_subcategory = MarketingSubcategory.new
  end

  def create
    @marketing_subcategory = MarketingSubcategory.new(params[:marketing_subcategory])
    if @marketing_subcategory.save
      flash[:notice] = 'MarketingSubcategory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
  end

  def update
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    if @marketing_subcategory.update_attributes(params[:marketing_subcategory])
      flash[:notice] = 'MarketingSubcategory was successfully updated.'
      redirect_to :action => 'show', :id => @marketing_subcategory
    else
      render :action => 'edit'
    end
  end

  def destroy
    MarketingSubcategory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
