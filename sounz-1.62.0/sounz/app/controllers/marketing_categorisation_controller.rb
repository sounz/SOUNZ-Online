require 'session_storage_helper'



class MarketingCategorisationController < ApplicationController
  
  
  
  include SessionStorageHelper
  
  
  
  
  def index
    list
    render :action => 'list'
  end
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :list }
  
  def list
    @marketing_subcategories = MarketingSubcategory.paginate( :page => params[:page], :per_page => 10)
    @marketing_categories = MarketingCategory.paginate( :page => params[:page], :per_page => 10)
  end
  
  def show
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    @marketing_category = @marketing_subcategory.marketing_category
  end
  
  #This is the new method for the popup from role
  def new_subcategory_in_popup_from_role
    
    msc_id = params[:id]
    set_popup_callback(:role_categorizations, :callback_categories_edit_role, :role_categorization_form)
    
    if msc_id.to_i != 0
      @marketing_category = MarketingCategory.find(msc_id)
    else
      @marketing_category = nil
    end
    
    session[:role_id] = params[:role_id]
    session[:selected_marketing_category_id] = @marketing_category
    
    redirect_to :action => 'new_subcategory'
  end
  
  
  
  def new_subcategory
    get_selected_marketing_category_from_session
    
    #do we have a person
    #possible_person_id = session[:selected_person_id]
    
  end
  
  
  
  
  
  #Get the selected marketing category from the session
  def get_selected_marketing_category_from_session
    marketing_category_id = session[:selected_marketing_category_id]
    
    #do we have a category_id
    if marketing_category_id != nil
      @marketing_category = MarketingCategory.find(marketing_category_id)
    else
      @marketing_category = MarketingCategory.new
    end
  end
  
  
  
  
  def show_subcategory_in_popup
    #get the market sub object
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    @marketing_category = @marketing_subcategory.marketing_category
    #person_id = session[:selected_person_id]
    #@person = Person.find(person_id)
    render  :layout => 'popup' # If you forget this you cant close the popup!
  end
  
  
  
  
  def new_category
    @marketing_category = MarketingCategory.new
  end
  
  
  #------------------------------------------------------------------
  #- Create subcategory used in role marketing categorisation popup -
  #------------------------------------------------------------------
  def create_subcategory
    debug_message "CREATE SUBCAT"
    show_params(params)
        
    mc_found = false # true if a marketing category is found
    
    if session[:selected_marketing_category_id] != nil
      marketing_category_id = session[:selected_marketing_category_id]
      @marketing_category = MarketingCategory.find(:first, :conditions => ["marketing_category_id =?", marketing_category_id])
      session[:selected_marketing_category_id] = nil
      @mc_found = true
      #try and find from
    else
      mc_id = params[:marketing_category][:id]
      if !mc_id.blank?
        @marketing_category = MarketingCategory.find(mc_id)
        @mc_found=true
      end
    end
    
    if @mc_found
      
      @marketing_subcategory = MarketingSubcategory.new(params[:marketing_subcategory])
      
      #Set parent category from previously saved objects
      @marketing_subcategory.marketing_category = @marketing_category
      @abbreviation = @marketing_subcategory.abbreviation
      
      if @marketing_subcategory.save
        flash[:notice] = 'Marketing Subcategory was successfully created.'
        
        # if role id data doesn't exist, redirect to list
        if session[:role_id].blank?
          redirect_to :action => 'list'
        elsif
          # assign the categorisation to the role
          @role_categorization = RoleCategorization.new(params[:role_categorization])
          @role_categorization.role_id = session[:role_id]
          @role_categorization.marketing_subcategory = MarketingSubcategory.find(@marketing_subcategory.marketing_subcategory_id)
          
          # saving the role's marketing categorisation
          if @role_categorization.save
            role_id = session[:role_id]
            flash[:notice] = 'New categorisation was successfully added.'
          else
            flash[:notice] = 'An error has occured. Try again'
          end
                    
          redirect_to(:action => 'edit_subcategory', :id => @marketing_subcategory)
        end
      else
        render :action => 'new_subcategory'
      end
    else
      flash[:notice] = 'Please select a category'
      render :action => 'new_subcategory'
    end
    
  end
  
  
  def create_category
    @marketing_category = MarketingCategory.new(params[:marketing_category])
    
    if @marketing_category.save
      flash[:notice] = 'Marketing category was successfully created.'
      
      session[:selected_marketing_category_id] = @marketing_category.marketing_category_id
      
      # return to the new subcategory screen
      redirect_to(:action => 'new_subcategory')
    else
      render :action => 'new_category'
    end
  end
  
  #--------------------
  #- Edit subcategory -
  #--------------------
  def edit_subcategory
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    @marketing_category = @marketing_subcategory.marketing_category
    render  :layout => 'popup'
  end
  
  #--------------------
  #- Update subcategory -
  #--------------------
  def update_subcategory
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    
    if @marketing_subcategory.update_attributes(params[:marketing_subcategory])
      flash[:notice] = 'Marketing Subcategory was successfully updated.'
      redirect_to :action => 'edit_subcategory', :id => @marketing_subcategory.marketing_subcategory_id
    else
      render :action => 'edit_subcategory'
    end
  end
  
  def destroy
    @marketing_subcategory = MarketingSubcategory.find(params[:id])
    @marketing_category = @marketing_subcategory.marketing_category
    MarketingSubcategory.find(params[:id]).destroy
    
    redirect_to :action => 'list'
  end
  
  
  
  # Change different params on change of the marketing category select box
  def change
    session[:selected_marketing_category_id] == nil
    @marketing_category = MarketingCategory.find(params[:id])
    session[:selected_marketing_category_id] = @marketing_category.marketing_category_id
    @rails_version = Rails::VERSION::STRING
  end  
end
