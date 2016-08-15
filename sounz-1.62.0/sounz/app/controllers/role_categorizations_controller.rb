require 'application_helper'
require 'session_storage_helper'

class RoleCategorizationsController < ApplicationController
  
  include ApplicationHelper
  include SessionStorageHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @role_categorizations = RoleCategorization.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @role_categorization = RoleCategorization.find(params[:id])
  end

  def new
    @role_categorization = RoleCategorization.new
  end

  def create
    @role_categorization = RoleCategorization.new(params[:role_categorization])
    if @role_categorization.save
      flash[:notice] = 'RoleCategorization was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @role_categorization = RoleCategorization.find(params[:id])
  end

  def update
    @role_categorization = RoleCategorization.find(params[:id])
    if @role_categorization.update_attributes(params[:role_categorization])
      flash[:notice] = 'RoleCategorization was successfully updated.'
      redirect_to :action => 'show', :id => @role_categorization
    else
      render :action => 'edit'
    end
  end

  def destroy
    RoleCategorization.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  #-------------------------------------------
  # Add marketing categorisation dynamically -
  # ------------------------------------------
  def add_categorization
    @new_cat_id = nil
    
    @role_categorization = RoleCategorization.new(params[:role_categorization])
    @role = Role.find(params[:role_id])
    @role_categorization.role_id = @role.role_id
    msc_id = params[:marketing_subcategory][:id]
    @empty_subcat = false
    
    if !msc_id.blank?
      logger.debug "*** TRACE 1 ***"
      @role_categorization.marketing_subcategory = MarketingSubcategory.find(msc_id)
                 
      if @role_categorization.save
      	
      	# special processing for general (primary) role
      	# of organisation - people that work in that organisation
      	# attract its marketing categorization
      	role = @role_categorization.role
		
		role_contactinfos_to_index = Array.new
		role_contactinfos_to_index = role.role_contactinfos
		
      	if !role.organisation.blank? && role == Role.get_organisation_primary_role(role.organisation.organisation_id)
          organisation_people_roles = role.organisation.get_organisation_roles(with_people='true')
		  organisation_people_role_contactinfos = organisation_people_roles.collect{|pr| pr.role_contactinfos}.flatten.compact
		  
		  role_contactinfos_to_index = role_contactinfos_to_index + organisation_people_role_contactinfos
		  
		end
		
        # update all role role_contactinfos for
        # solr indexing
        #RoleContactinfo.index_objects(role_contactinfos_to_index)
		
		Role.crm_privileges_check(@login, @role)
		
        @new_cat_id = generate_id(@role_categorization)
      end
     else
      logger.debug "*** TRACE 2 ***"
      @empty_subcat = true
    
    end
  end
  
  #-------------------------------------------------------------------------
  # Change different params on change of the marketing category select box -
  # ------------------------------------------------------------------------
  def marketing_category_change
    
    @marketing_category = MarketingCategory.find(params[:id])
    
    @role = Role.find(params[:role_id])
        
    @marketing_subcategories = @marketing_category.marketing_subcategories
    
    #Check if there are subcategories - the dropdown and submit button are not rendered if there are none
    @has_subcategories = (@marketing_subcategories.length > 0)
  end
  
  #-----------------------------------
  #- Destroy a single categorisation -
  #-----------------------------------
  def destroy_categorization_for_role
    
    role_categorization = RoleCategorization.find(params[:id])
    role = role_categorization.role
    
    role_categorization.destroy
    
	role_contactinfos_to_index = Array.new
	role_contactinfos_to_index = role.role_contactinfos	
	
	# special processing for general (primary) role
    # of organisation - people that work in that organisation
	# attract its marketing categorization
	if !role.organisation.blank? && role == Role.get_organisation_primary_role(role.organisation.organisation_id)
	  organisation_people_roles = role.organisation.get_organisation_roles(with_people='true')
	  organisation_people_role_contactinfos = organisation_people_roles.collect{|pr| pr.role_contactinfos}.flatten.compact
	  
	  role_contactinfos_to_index = role_contactinfos_to_index + organisation_people_role_contactinfos
	
	end	
	
    # update all role role_contactinfos for
    # solr indexing
    #RoleContactinfo.index_objects(role_contactinfos_to_index)
    
	Role.crm_privileges_check(@login, role)
	
    render :layout => false
      
  end

  #---------------------------------------------------
  #- This method is called after the popup is closed -
  #---------------------------------------------------
  def callback_categories_edit_role
    marketing_subcategory = MarketingSubcategory.find(params[:id])
    @marketing_category = marketing_subcategory.marketing_category
    @has_subcategories = true
    @marketing_subcategories = MarketingSubcategory.find(:all, :conditions => ["marketing_category_id = ?",@marketing_category ])
    
    # role
    role_id = session[:role_id]
    session[:role_id] = nil
    @role = Role.find(role_id)
    
    clear_popup_callback

    render :layout => false
  end
  
end
