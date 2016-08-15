class PeopleCategorizationsController < ApplicationController
  
  include ApplicationHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @people_categorization_pages, @people_categorizations = paginate :people_categorizations, :per_page => 10
  end

  def show
    @people_categorization = PeopleCategorization.find(params[:id])
  end

  def new
    @people_categorization = PeopleCategorization.new
  end

  def create
    @people_categorization = PeopleCategorization.new(params[:people_categorization])
    @marketing_category = MarketingCategory.find(:all, :order => 'abbreviation')
    @marketing_subcategory = MarketingSubcategory.find(:all)
    if @people_categorization.save
      flash[:notice] = 'PeopleCategorization was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @people_categorization = PeopleCategorization.find(params[:id])
  end

  def update
    @people_categorization = PeopleCategorization.find(params[:id])
    if @people_categorization.update_attributes(params[:people_categorization])
      flash[:notice] = 'People Categorization was successfully updated.'
      redirect_to :action => 'show', :id => @people_categorization
    else
      render :action => 'edit'
    end
  end
  
  def change
    @marketing_category = MarketingCategory.find(params[:id])
    @marketing_subcategory = MarketingSubcategory.find(:all, :conditions => ["marketing_category_id = ?", @marketing_category])
    @rails_version = Rails::VERSION::STRING
  end


  #Destroy a single categorisation - called from people/edit
  def destroy_categorisation_for_person
    # session variables
    person_id = params[:id]
    marketing_subcategory = params[:subcatid]
    
    @person_categorisations = PeopleCategorization.find(:all, 
                             :conditions => ["person_id = ? and marketing_subcategory_id = ?", person_id, marketing_subcategory ])
    
    pc = @person_categorisations[0]
     @removed_id =  generate_id(pc)
     
    if pc.destroy
      flash[:notice] = 'The categorisation was deleted.'
    end
    
   


  end
end
