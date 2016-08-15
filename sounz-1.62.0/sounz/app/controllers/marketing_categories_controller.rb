class MarketingCategoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @marketing_categories = MarketingCategory.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @marketing_category = MarketingCategory.find(params[:id])
  end

  def new
    @marketing_category = MarketingCategory.new
  end
  
  


  def create
    @marketing_category = MarketingCategory.new(params[:marketing_category])
    if @marketing_category.save
      flash[:notice] = 'MarketingCategory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @marketing_category = MarketingCategory.find(params[:id])
  end

  def update
    @marketing_category = MarketingCategory.find(params[:id])
    if @marketing_category.update_attributes(params[:marketing_category])
      flash[:notice] = 'MarketingCategory was successfully updated.'
      redirect_to :action => 'show', :id => @marketing_category
    else
      render :action => 'edit'
    end
  end

  def destroy
    MarketingCategory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
