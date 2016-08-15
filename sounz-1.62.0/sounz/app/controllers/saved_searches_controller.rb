class SavedSearchesController < ApplicationController
  
  include ApplicationHelper
  require 'yaml'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @saved_searches = SavedSearch.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @saved_search = SavedSearch.find(params[:id])
  end

  def new
    @saved_search = SavedSearch.new
  end

  def create
    @saved_search = SavedSearch.new(params[:saved_search])
    if @saved_search.save
      flash[:notice] = 'SavedSearch was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @saved_search = SavedSearch.find(params[:id])
  end

  def update
    @saved_search = SavedSearch.find(params[:id])
    if @saved_search.update_attributes(params[:saved_search])
      flash[:notice] = 'SavedSearch was successfully updated.'
      redirect_to :action => 'show', :id => @saved_search
    else
      render :action => 'edit'
    end
  end

  def destroy
    SavedSearch.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def delete_search_ajax
    search_id=params[:id]
    mySearch=SavedSearch.find(search_id)
    if mySearch.saved_by_login_id==get_user.id
      #invoke the appropriate search action.
      mySearch.destroy()
    else
      logger.info("SECURITY PROBLEM - CAN'T DELETE OTHER USERS SEARCH")
      #and do nothing
    end 
    render :partial => 'saved_search_list'
  end

  def do_search
    #check we have permission to do this search.
    search_id=params[:id]
    mySearch=SavedSearch.find(search_id)
    if mySearch.saved_by_login_id==get_user.id
      #invoke the appropriate search action.
      
      #find our session var based on the type
      if mySearch.search_type == 'advanced_work'
        #load the saved search into our session var
      
        #require all the frbr objects we will be attempting to deserialise
      
        mySearch.search_data.scan(/!ruby\/object:(.*) \n/).uniq.each { |c| Work.logger.debug("REQUIRING #{c[0].underscore}") 
        require c[0].underscore }
        session[:work_search_details]=YAML::load(mySearch.search_data)
        logger.info(session[:work_search_details])
        redirect_to :action => 'search_works', :controller => :advanced_finder, :search_details=>[]
      
      elsif mySearch.search_type == 'advanced_contributor'
      session[:contributor_search_details]=YAML::load(mySearch.search_data)
      redirect_to :action => 'search_contributors', :controller => :advanced_finder, :search_details=>[]
      
      elsif mySearch.search_type == 'advanced_man_res'
      session[:man_res_search_details]=YAML::load(mySearch.search_data)
	  redirect_to :action => 'search_manifestations_resources', :controller => :advanced_finder, :search_details=>[]
      
      elsif mySearch.search_type == 'advanced_event'
      session[:event_search_details]=YAML::load(mySearch.search_data)
	  redirect_to :action => 'search_events', :controller => :advanced_finder, :search_details=>[]
      
	  elsif mySearch.search_type == 'advanced_expressions'
		session[:expression_advanced_search_details]=YAML::load(mySearch.search_data)
	    redirect_to :action => 'search_expressions', :controller => :advanced_finder, :search_details=>[]
				  
      elsif mySearch.search_type == 'advanced_crm_contacts'
      session[:adv_crm_contacts_search_details] = YAML::load(mySearch.search_data)
      redirect_to :action => 'advanced', :controller => :search_contacts, :search => []
      
      elsif mySearch.search_type == 'crm_communications'
        session[:crm_communication_search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'index', :controller => :search_communications, :search => []

      elsif mySearch.search_type == 'crm_borrowed_items'
        session[:crm_borrowed_items_search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'index', :controller => :search_borrowed_items, :search => []
      
      elsif mySearch.search_type == 'work_resource_advanced_search'
        session[:work_resource_search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'search_works_resources', :controller => :advanced_finder, :search_details => []
        
      #-- deal with faceted searches --
      elsif mySearch.search_type == 'faceted_work_search'
        session[:facet_details] = {} if session[:facet_details].blank?
        session[:facet_details]['works'] = {} if session[:facet_details]['works'].blank?
        session[:facet_details]['works'][:search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'shows', :controller => :finder, :id => 'works', :search => []
      
      elsif mySearch.search_type == 'faceted_people_search'
        session[:facet_details] = {} if session[:facet_details].blank?
        session[:facet_details]['people'] = {} if session[:facet_details]['people'].blank?
        
        session[:facet_details]['people'][:search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'shows', :controller => :finder, :id => 'people', :search => []
        
      elsif mySearch.search_type == 'faceted_event_search'
        session[:facet_details] = {} if session[:facet_details].blank?
        session[:facet_details]['events'] = {} if session[:facet_details]['events'].blank?
        session[:facet_details]['events'][:search_details] = YAML::load(mySearch.search_data)
        redirect_to :action => 'shows', :controller => :finder, :id => 'events', :search => []
        
      else
        logger.info("PROBLEM - unrecognised saved search type #{mySearch.search_type}")
        raise ArgumentError, "PROBLEM - unrecognised saved search type #{mySearch.search_type}"
      end
      
    else
      logger.info("SECURITY PROBLEM - CAN'T EXECUTE OTHER USERS SEARCH")
      #and do nothing
    end
    
  end
  
 def save_search_from_form
   #determine search_data from source
   #default redirect to advanced work
   redirectLocation='work'
   redirectController = 'advanced_finder'
   sessionVar=nil
   save_search_details=params[:save_search_form]
 
   #logger.debug save_search_details.to_yaml()
   #select our session var based on our type
   if save_search_details['search_type']=='advanced_work'
     sessionVar=session[:work_search_details]
     redirectLocation='work' 
   
   elsif save_search_details['search_type']=='advanced_contributor'
     sessionVar=session[:contributor_search_details]
     redirectLocation='contributor'
   
   elsif save_search_details['search_type']=='advanced_man_res'
     sessionVar=session[:man_res_search_details]
     redirectLocation='manifestation_resource'
   
   elsif save_search_details['search_type']=='advanced_event'
     sessionVar=session[:event_search_details]
     redirectLocation='event'
	 
   elsif save_search_details['search_type']=='advanced_expressions'
	 sessionVar=session[:expression_advanced_search_details]
	 redirectLocation='expression'   
   
   elsif save_search_details['search_type'] == 'advanced_crm_contacts'
     sessionVar         = session[:adv_crm_contacts_search_details]
     redirectController = 'search_contacts'
     redirectLocation   = 'advanced'
   
   elsif save_search_details['search_type'] == 'crm_communications'
     sessionVar         = session[:crm_communication_search_details]
     redirectController = 'search_communications'
     redirectLocation   = 'index'

   elsif save_search_details['search_type'] == 'crm_borrowed_items'
     sessionVar         = session[:crm_borrowed_items_search_details]
     redirectController = 'search_borrowed_items'
     redirectLocation   = 'index'
   
   elsif save_search_details['search_type'] == 'work_resource_advanced_search'
     sessionVar         = session[:work_resource_search_details]
     redirectLocation   = 'sonline_music'
     
   elsif save_search_details['search_type'] == 'faceted_work_search'
       sessionVar = session[:facet_details]['works'][:search_details]
       redirectController = 'finder'
       redirectLocation = 'shows'
       redirect_id = "works"
       
  elsif save_search_details['search_type'] == 'faceted_people_search'
   sessionVar = session[:facet_details]['people'][:search_details]
   redirectController = 'finder'
   redirectLocation = 'shows'
   redirect_id = "people"

  elsif save_search_details['search_type'] == 'faceted_event_search'
     sessionVar = session[:facet_details]['events'][:search_details]
     redirectController = 'finder'
     redirectLocation = 'shows'
     redirect_id = "events"
     
    else
     logger.debug("UNRECOGNISED SEARCH TYPE!")
     raise ArgumentError, "Unrecognise search type for save:#{save_search_details['search_type']}"
   end
 
   if sessionVar != nil
     if save_search(save_search_details['search_name'],save_search_details['search_type'],sessionVar,nil) != nil
       #display a successful message
     else
      logger.debug("PROBLEM SAVING SEARCH!")
     end
   else
     logger.debug("PROBLEM SAVING SEARCH - type not recognised or nil data")
     #determine redirect location from source
   end
   
  if redirect_id.blank?
     redirect_to :controller => redirectController, :action => redirectLocation
  else
    redirect_to :controller => redirectController, :action => redirectLocation, :id => redirect_id
  end
   
 end
 
  
  
  
  # ---- private methods ----
  
  
  
  private
  
  #save a search
  def save_search(search_name,search_type, search_data,search_id)
  @login=get_user()
  logger.debug "SAVING SEARCH NAME:#{search_name}"
  if search_id != nil
    #see if we can find an existsing saved search
    foundSearch=SavedSearch.find(search_id)
    if foundSearch != nil 
      #check this user has permission to access search data.
      if foundSearch.saved_by_login_id == @login.id or PrivilegesHelper.has_permission?(@login,'CAN_EDIT_TAP')
        #we found our searched id. now we can update our data
        foundSearch.search_name=search_name
        foundSearch.search_data=search_data.to_yaml()
        foundSearch.updated_by=@login.id
        foundSearch.save()
        return foundSearch
      end
    end
  else
    #we need to create a new saved search
    #check permissions - are we allowed to save searches?
    if PrivilegesHelper.has_permission?(@login,'CAN_SAVE_SEARCH')
    
  
      mySearch=SavedSearch.new()
      mySearch.search_name=search_name
      mySearch.saved_by_login_id = @login.id
      mySearch.updated_by = @login.id
      mySearch.search_type=search_type
      mySearch.search_data=search_data.to_yaml()
      if mySearch.save()
        return mySearch
      else
        logger.debug("SAVING SEARCH FAILED!")
      end
   
    end
  return nil
  end
 end

end
