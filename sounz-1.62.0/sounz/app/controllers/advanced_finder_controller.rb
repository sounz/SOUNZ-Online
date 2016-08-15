class AdvancedFinderController < ApplicationController
  
  include FinderHelper #needed in order to tweak the page objects
  include PrivilegesHelper #needed for saved searches
  include ApplicationHelper
  require 'yaml'
  
  #Render the advanced finder work form
  def work
    #clear our cached result set on visiting this page
    session[:work_advanced_search_results]=[]
    
    if session[:work_search_details] != nil
      @search_details = session[:work_search_details]
    else
    @search_details = WorkAdvancedSearchDetails.new
    end
    prepare_work_search_form
  end
  
  def sonline_music
    session[:work_resource_search_results]=[]
    
    if !session[:work_resource_search_details].blank?
      @search_details = session[:work_resource_search_details]
    else
      @search_details = WorkResourceSearchDetails.new
    end
    prepare_work_search_form
	@page_title = 'search for NZ Music'
  end
  
  def expression
    session[:expression_advanced_search_results]=[]
    
    if !session[:expression_advanced_search_details].blank?
      @search_details = session[:expression_advanced_search_details]
    else
      @search_details = ExpressionAdvancedSearchDetails.new
    end
    
	@statuses = Status.find(:all, :conditions => ['status_desc NOT ILIKE ?', '%approved%'], :order => 'status_desc')
	 
	@page_title = 'search for expressions'
  end
    
  #Render the events search form
  def event
    session[:event_advanced_search_results]=[]
    if session[:event_search_details] != nil
      @search_details = session[:event_search_details]
    else
      @search_details = EventAdvancedSearchDetails.new
    end
    prepare_event_search_form
  end

  #
  # Display a list of appropriate regions on the country selection
  #
  def country_chosen
    if !params[:id].blank?
      @country = Country.find(params[:id])
      @regions = Region.find(:all, :conditions => ['country_id =?', @country.country_id], :order => 'region_order')
    else
      @country = @regions = nil
    end
    render :layout => false
  end
  
  #Perform the contributor search and display the results
  def search_events
    @search_details = use_session_search_details_or_create_new(
      session[:event_search_details], EventAdvancedSearchDetails
    )

    new_search = new_search_details?(params[:search_details], @search_details)
    
    if new_search
      sdp = params[:search_details]
      session[:event_advanced_search_results]=[]
      sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
      session[:event_search_details] = @search_details
      ids = AdvancedFinderHelper.find_events(@search_details)
      #logger.debug "IDS FROM ADV HELPER:#{ids}, #{ids.length}"
      session[:event_advanced_search_results]=convert_db_ids_to_objects('Event',ids)
    end
       
    @results = paginate_collection(session[:event_advanced_search_results], {:page => params[:page], :per_page => 20})
  end
  
  
  
  #Obtain the parameters from the search form
  def search_works
    if session[:work_search_details] != nil
      @search_details = session[:work_search_details]
    else
      @search_details = WorkAdvancedSearchDetails.new
    end
    
    
    @page = (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;
    
    
    
    #make a pass through our cached search details to ensure we arent doing a new search
    newSearch=false
    sdp = params[:search_details]
          
    if !sdp.blank?
      sdp.keys.map{ |k| 
      if @search_details.send(k) != sdp[k]
        newSearch=true
       
      end
      }
    else
      newSearch=true
    end
    
    if newSearch
      logger.debug "SEARCH WORKS: NEW SEARCH!"
      session[:work_advanced_search_results]=[]
      if !sdp.blank?
      sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
      end
      logger.debug @search_details.to_yaml
      session[:work_search_details]=@search_details
    end
    
	solrResults=[]
    @results=[]
      
    @lucene_query = AdvancedFinderHelper.build_advanced_work_query(@search_details)
    logger.debug "SEARCH WORKS: LUCENE QUERY: #{@lucene_query}"
	  
	# add additional search params if present
	options = {:q => []}
	if @search_details.has_sample_recording.to_s=='yes'
	  options[:q] << 'AND (available_as_samples_for_solr_t:(audio OR video))'
    elsif @search_details.has_sample_recording.to_s=='no'
      options[:q] << 'NOT (available_as_samples_for_solr_t:(audio OR video))'
    end
	  
	if @search_details.has_sample_score.to_s=='yes'
	  options[:q] << 'AND (available_as_samples_for_solr_t:(scores))'
	elsif @search_details.has_sample_score.to_s=='no'
	  options[:q] << 'NOT (available_as_samples_for_solr_t:(scores))'
	end
	      
	@results = FinderHelper.execute_advanced_solr_query(@lucene_query, options)[:docs]
      
	logger.debug(@results.to_yaml)
    #  solrResults= @results[0][:docs]
            
    if @results != nil
      solrResults= @results
    end
    logger.debug "SEARCH WORKS: RESULTS:#{@results.to_yaml}"
      
    sqlResults=[]
    relationshipResults=[]
    
    #now filter our results 
    #if we have SQL filters defined, then run our result list through the filter
    
    #do we need to run SQL filters?
    sqlSearch=false
    if @search_details.has_score.blank? and @search_details.has_recording.blank? and @search_details.has_not_applicable.blank? and @search_details.programme_note_exists.blank?
      #do nothing, we don't need to search via SQL
    else
      sqlSearch=true  
      sqlResults=AdvancedFinderHelper.findWorksBySQL(@search_details)
    end
    
    if solrResults.length > 0 and sqlSearch
      logger.debug("SEARCH WORKS: RUNNING SQL SEARCH")
      @filteredResults = solrResults & sqlResults
    elsif solrResults.length > 0 and ! sqlSearch
      logger.debug("SEARCH WORKS: ONLY SOLR RESULTS")
      @filteredResults = solrResults
    else
      if !@search_details.contains_solr_query_data?
        logger.debug("SEARCH WORKS: ONLY SQL RESULTS")
        @filteredResults = sqlResults
      else
        @filteredResults = []
      end
    end
    
    relationshipResults=[]
    relationshipResults1=[]
    relationshipResults2=[]
    
    if  @search_details.relationship1_type.blank? or @search_details.relationship1_filter.blank?
     #do nothing
    else
      logger.debug "SEARCH WORKS: FINDING FIRST RELATIONSHIP QUERY!"
      relationshipResults1 = AdvancedFinderHelper.findWorksByRelationships(@search_details.relationship1_type,@search_details.relationship1_filter,@search_details.relationship1_text)
    end
    
    if  @search_details.relationship2_type.blank? or @search_details.relationship2_filter.blank?
      #do nothing
    else
      logger.debug "SEARCH WORKS: FINDING SECOND RELATIONSHIP QUERY!"
      relationshipResults2 = AdvancedFinderHelper.findWorksByRelationships(@search_details.relationship2_type,@search_details.relationship2_filter,@search_details.relationship2_text)
    end
      
    # filter the relationship results if needed    
    if relationshipResults1.length > 0 && relationshipResults2.length == 0
      relationshipResults = relationshipResults1
    elsif relationshipResults1.length == 0 && relationshipResults2.length > 0
      relationshipResults = relationshipResults2
    elsif relationshipResults1.length > 0 && relationshipResults2.length > 0
      relationshipResults = relationshipResults1 & relationshipResults2
    else
      relationshipResults = []
    end
    
    if relationshipResults.length >0 and @filteredResults.length > 0
      @filteredResults = @filteredResults & relationshipResults  
    elsif relationshipResults.length >0 and @filteredResults.length == 0
      @filteredResults=relationshipResults
    end
    
    logger.debug "SEARCH WORKS: CORE RESULTS count #{solrResults.length}"
    logger.debug solrResults
    logger.debug "SEARCH WORKS: END CORE RESULTS"
    
    logger.debug "SEARCH WORKS: SQL RESULTS count #{sqlResults.length}"
    logger.debug sqlResults
    logger.debug "SEARCH WORKS: END SQL RESULTS"

    logger.debug "SEARCH WORKS: RELATIONSHIP RESULTS count #{relationshipResults.length}"
    logger.debug relationshipResults
    logger.debug "SEARCH WORKS: END RELATIONSHIP RESULTS"

    logger.debug "SEARCH WORKS: INTERSECTION RESULTS count #{@filteredResults.length}"
    logger.debug @filteredResults
    logger.debug "SEARCH WORKS: END INTERSECTION RESULTS"
    
    session[:work_advanced_search_results]=@filteredResults
    
    
    
    logger.debug "Pre paging,  results are #{@filteredResults}"
    logger.debug "****RES IN SESSION:#{session[:work_advanced_search_results]}"
    @results = paginate_collection(session[:work_advanced_search_results], {:page => params[:page], :per_page => 20})
    logger.debug "Post paging, solr results are #{@results}"
    
    @result_frbr_objects=[]  
    #Get the frbr objects for rendering purposes
    for result in @results
      myType,myId=result.split(':')
      myObject=FrbrObject.new('work',Work.find(myId))
      @result_frbr_objects.push(myObject)
    end
    
    
    
  end
  
  #An example call to this would be convert_solr_ids_to_objects("Work", [10,50,100])
  def convert_db_ids_to_objects(model_name,database_ids)
    result=[]  
    #Get the frbr objects for rendering purposes
    for id in database_ids
      #Yuk - good old generic Ruby coding time
      myObject=FrbrObject.new(model_name.tableize.singularize, model_name.constantize.find(id))
      result << myObject
    end
    result
  end
  
  

    
    
  #----------- contributor search methods ----------------------
  
  #Render the advanced finder contributor form
  def contributor
    prepare_contributor_search_form
  end
  
  
  #Perform the contributor search and display the results
  def search_contributors
    if session[:contributor_advanced_search_results] == nil
      session[:contributor_advanced_search_results]=[]
    end
    @search_details = use_session_search_details_or_create_new(
      session[:contributor_search_details], ContributorAdvancedSearchDetails
    )
    @page = calculate_page(params)
    new_search = new_search_details?(params[:search_details], @search_details)

    logger.debug "SEARCH DETAILS:#{@search_details.to_yaml}"
    
   if new_search
     sdp = params[:search_details]
     session[:contributor_advanced_search_results]=[]
     sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
     session[:contributor_search_details] = @search_details
   end
   
   ids = AdvancedFinderHelper.find_contributors(@search_details)
   logger.debug "IDS FROM ADV HELPER:#{ids}, #{ids.length}"
   session[:contributor_advanced_search_results]=ids
   
    
    logger.debug "SIZE OF CONT ADV SEARCH RESULTS:#{session[:contributor_advanced_search_results].length}"
    #convert for rendering purposes
    @results = paginate_collection(session[:contributor_advanced_search_results], {:page => params[:page], :per_page => 20})
    
    #As we are returning only contributors, just the ids are returned
    @result_frbr_objects = convert_db_ids_to_objects('Contributor',@results)
  end
  
  
  #Reset the search details and render the form
  def reset_contributors
    @search_details = ContributorAdvancedSearchDetails.new
    session[:contributor_search_details] = @search_details
    redirect_to :action => :contributor
  end
  
  def reset_manifestation_resource
    @search_details = ManifestationResourceSearchDetails.new
	@search_details.entity_to_search = 'both'
    session[:man_res_search_details] = @search_details
    redirect_to :action => :manifestation_resource
  end
  
  def reset_event
    @search_details = EventAdvancedSearchDetails.new
    session[:event_search_details] = @search_details
    redirect_to :action => :event
  end
  
  def reset_sonline_music
    @search_details = WorkResourceSearchDetails.new
    session[:work_resource_search_details] = @search_details
    redirect_to :action => :sonline_music
  end
  
  def reset_expressions
    @search_details = ExpressionAdvancedSearchDetails.new
    session[:expression_advanced_search_details] = @search_details
    redirect_to :action => :expression
  end
    
  def reset_work
    @search_details = WorkAdvancedSearchDetails.new
    session[:work_search_details] = @search_details
    redirect_to :action => :work
  end
  
  def findSubcategories
    text="<option value=''>-- Select a category in the box above --</option>"
    if params[:category]!=""
    matchingSubcategories=WorkSubcategory.find(:all, :order => :display_order, :conditions => ["work_category_id= ?",params[:category].to_i])
    
    for subcategory in matchingSubcategories
    text+="<option value=\"#{subcategory.id}\" >#{subcategory.work_subcategory_desc}</option>"
    end
    else
    #do nothing
    end   
  render:text => text
  end
  
  
  
  # ---- search resource and manifestation methods ----
  #Render the advanced form for finding a manifestation or resource
  def manifestation_resource
    #clear our cached result set on visiting this page
    #session[:man_res_advanced_search_results]=[]
    if session[:man_res_search_details] != nil
      @search_details = session[:man_res_search_details] #get from session if avail
    else
      @search_details = ManifestationResourceSearchDetails.new
	  @search_details.entity_to_search = 'both'
      session[:man_res_search_details] = @search_details
    end
    prepare_manifestation_resource_search_form
  end
  
  
  #Perform the contributor search and display the results
  def search_manifestations_resources
    @search_details = use_session_search_details_or_create_new(
      session[:man_res_search_details], ManifestationResourceSearchDetails
    )
    @page = calculate_page(params)
    new_search = new_search_details?(params[:search_details], @search_details)

    logger.debug "SEARCH DETAILS:#{@search_details.to_yaml}"
    
    # if new_search
    if new_search
      sdp = params[:search_details]
      session[:man_res_search_results]=[]
      sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
      session[:man_res_search_details] = @search_details
    end
	
	  ids = AdvancedFinderHelper.find_manifestations_and_resources(@search_details)
    logger.debug "IDS FROM ADV HELPER:#{ids}, #{ids.length}"
    session[:man_res_search_results]=ids

    #convert for rendering purposes
    @all_results = AdvancedFinderHelper.convert_solr_ids_to_objects(session[:man_res_search_results])
    @all_results.sort! { |a,b| a.objectTitle.downcase <=> b.objectTitle.downcase }
    
    @result_frbr_objects = paginate_collection(@all_results, {:page => params[:page], :per_page => 20})
  end
  
  
 #def save_search_from_form
 #determine search_data from source
 #default redirect to advanced work
 #redirectLocation='work'
 #sessionVar=nil
 #save_search_details=params[:save_search_form]
 
 #logger.debug save_search_details.to_yaml()
 #select our session var based on our type
 #if save_search_details['search_type']=='advanced_work'
 #  sessionVar=session[:work_search_details]
 #  redirectLocation='work' 
 #elsif save_search_details['search_type']=='advanced_contributor'
 #  sessionVar=session[:contributor_search_details]
 #  redirectLocation='contributor'
 #elsif save_search_details['search_type']=='advanced_man_res'
 #  sessionVar=session[:man_res_search_details]
 #  redirectLocation='manifestation_resource'
 #elsif save_search_details['search_type']=='advanced_event'
 #  sessionVar=session[:event_search_details]
 #  redirectLocation='event'
 #else
 #logger.debug("UNRECOGNISED SEARCH TYPE!")
 #end
 
 #if sessionVar != nil
 #if save_search(save_search_details['search_name'],save_search_details['search_type'],sessionVar,nil) != nil
   #display a successful message
# else
 #logger.debug("PROBLEM SAVING SEARCH!")
 #end
 #else
 #logger.debug("PROBLEM SAVING SEARCH - type not recognised or nil data")
 #determine redirect location from source
  
 #end
 #redirect_to :action => redirectLocation 
 #end

  
  
  # Perform the sonline music (work & resource) search and display the results
  def search_works_resources
    @search_details = use_session_search_details_or_create_new(
      session[:work_resource_search_details], WorkResourceSearchDetails
    )
    @page = calculate_page(params)
    logger.debug "SEARCH DETAILS:#{@search_details.to_yaml}"
    
    new_search = new_search_details?(params[:search_details], @search_details)
    
    # if new_search
    if new_search
      params[:search_details][:status_id] = Status.get_status_by_desc('published').status_id.to_s
      sdp = params[:search_details]
      session[:work_resource_search_results]=[]
      sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
      session[:work_resource_search_details] = @search_details
    end
    
	ids = AdvancedFinderHelper.find_works_and_resources(@search_details)
    logger.debug "IDS FROM ADV HELPER:#{ids}, #{ids.length}"
    session[:work_resource_search_results]=ids
        
    logger.debug "SIZE OF SONLINE MUSIC SEARCH RESULTS:#{session[:work_resource_search_results].length}"
    # convert for rendering purposes
    @results = paginate_collection(session[:work_resource_search_results], {:page => params[:page], :per_page => 20})
    @result_frbr_objects = AdvancedFinderHelper.convert_solr_ids_to_objects(@results)
  end 
  
  def search_expressions
    @search_details = use_session_search_details_or_create_new(
      session[:expression_advanced_search_details], ExpressionAdvancedSearchDetails
    )
    @page = calculate_page(params)
    logger.debug "SEARCH DETAILS:#{@search_details.to_yaml}"
    
    new_search = new_search_details?(params[:search_details], @search_details)
    
    # if new_search
    if new_search
      sdp = params[:search_details]
      session[:expression_advanced_search_results] = []
      sdp.keys.map{|k| @search_details.send(k+'=', sdp[k])}
      session[:expression_advanced_search_details] = @search_details
    end
    
	ids = AdvancedFinderHelper.find_expressions(@search_details)
    logger.debug "DEBUG: IDS FROM ADV HELPER:#{ids}, #{ids.length}"
    session[:expression_advanced_search_results]= ids
        
    logger.debug "DEBUG: SIZE OF EXPRESSION SEARCH RESULTS:#{session[:expression_advanced_search_results].length}"
    # convert for rendering purposes
    @results = paginate_collection(session[:expression_advanced_search_results], {:page => params[:page], :per_page => 20})
    @result_frbr_objects = AdvancedFinderHelper.convert_solr_ids_to_objects(@results)
  end
   
  # populates concept drop-down on UI - sonline music search
  def concept_main_categories
    concept_type = params[:type]
    concept_id   = params[:concept]   
    render :partial => 'concept_main_categories', :locals => { :concept_type => concept_type, :concept_id => concept_id.to_i }
  end
  
  # populates work subcategories drop-down on UI - sonline music search
  def work_subcategories
    category_id = params[:category]
    subcategory_id = params[:subcategory]   
    render :partial => 'work_subcategories', :locals => { :work_category_id => category_id, :work_subcategory_id => subcategory_id.to_i}
    
  end
  
  # populates manifestation/resource type formats drop-down on UI - manifestation resource advanced search
  def type_formats
  	show_params(params)
  	if !params[:resource_type_id].blank?
  	  object_type_id = generate_id(ResourceType.find(params[:resource_type_id]))
	elsif !params[:manifestation_type_id].blank?
	  object_type_id = generate_id(ManifestationType.find(params[:manifestation_type_id]))
	elsif params[:manifestation_type_id].blank? && params[:resource_type_id].blank?
      object_type_id = nil
    end
	type_format_id_s      = params[:type_format_id]
	object_type_format_id = params[:selected_type_format]
	
	render :partial => 'type_formats', :locals => { :object_type_id => object_type_id, :object_type_format_id => object_type_format_id, :type_format_id_s => type_format_id_s}
  end
  
  # ---- private methods ----
  
  
  
  private
  
  #save a search
  def save_search(search_name,search_type, search_data,search_id)
  @login=get_user()
  if search_id != nil
    #see if we can find an existsing saved search
    foundSearch=SavedSearch.find(search_id)
    if foundSearch != nil 
      #check this user has permission to access search data.
      if foundSearch.saved_by_login_id == @login.id or PrivilegesHelper.has_permission?(@login,:edit)
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
    if PrivilegesHelper.has_permission?(@login,:edit)
    
  
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
  
  
  
  
  
  
 #Get values required to populate the work search form
 def prepare_work_search_form
   @statuses = Status.find(:all, :conditions => ['status_desc NOT ILIKE ?', '%approved%'], :order => 'status_desc')
   @sub_categories = WorkSubcategory.find(:all, :order => 'work_subcategory_desc')   
   @categories=WorkCategory.find(:all, :order => :work_category_desc, :conditions => ["additional is not TRUE"],:order => 'display_order')
   @additional_subcategories=WorkSubcategory.find(:all, :order => :work_subcategory_desc, :conditions => ["additional is TRUE"],:order => 'display_order')
   @languages = Language.find(:all, :order => :language_name)
 end
 
 #Get values required to populate the event form
 def prepare_event_search_form
   @statuses = Status.find(:all, :conditions => ['status_desc NOT ILIKE ?', '%approved%'], :order => 'status_desc')
   @event_types = EventType.find(:all, :order => :event_type_desc)
   @regions = Region.find(:all)
 end
  
  #Get values required to populate the work search form
  def prepare_manifestation_resource_search_form
    @statuses = Status.find(:all, :conditions => ['status_desc NOT ILIKE ?', '%approved%'], :order => 'status_desc')
    @sub_categories = WorkSubcategory.find(:all, :order => 'work_subcategory_desc')   
    @categories=WorkCategory.find(:all, :order => :work_category_desc, :conditions => ["additional is not TRUE"],:order => 'display_order')
    @additional_subcategories=WorkSubcategory.find(:all, :order => :work_subcategory_desc, :conditions => ["additional is TRUE"],:order => 'display_order')
    @languages = Language.find(:all, :order => :language_name)
    
    #@manifestation_types=ManifestationType.find(:all, :order => 'manifestation_type_id')      
    #@formats = Format.find(:all, :order => :format_desc)
    @resource_types = ResourceType.find(:all, :order => :resource_type_id)
  

  end
  
  
  #Get values required to populate the contributor search form
  def prepare_contributor_search_form
    @statuses = Status.find(:all, :conditions => ['status_desc NOT ILIKE ?', '%approved%'], :order => 'status_desc')
      @sub_categories = WorkSubcategory.find(:all, :order => 'work_subcategory_desc')   
      @categories=WorkCategory.find(:all, :order => :work_category_desc, :conditions => ["additional is not TRUE"],:order => 'display_order')
      @additional_subcategories=WorkSubcategory.find(:all, :order => :work_subcategory_desc, :conditions => ["additional is TRUE"],:order => 'display_order')
      @languages = Language.find(:all, :order => :language_name)
      @roles = RoleType.contributor_role_types
      @composer_statuses = DropDown.composer_tiers
      @genders = DropDown.genders
      @regions = Region.find(:all)
      #use the view to render the form
      @search_details = use_session_search_details_or_create_new(
         session[:contributor_search_details], ContributorAdvancedSearchDetails
       )
       logger.debug "**** PREP FORM, search details are #{@search_details.to_yaml}"
  end
  
  
  
  #Use the search details in session, failing that create a new one.  This is used to 
  #ensure pagination is happy and the search is not recreated unless the search details in 
  #session ahve changed
  # An example call would be use_session_search_details_or_create_new(
  #  session[:work_search_details, WorkAdvancedSearchDetails] 
  #  )
  def use_session_search_details_or_create_new(search_details_in_session, klass)
    result = search_details_in_session
    if result.blank?
      result = klass.new
    end
    result
  end
  
  #Calculate the page from the params, this is either already in params or set to 1
  def calculate_page(params)
    (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;
  end
  
  
  def new_search_details?(search_details_param, stored_search_details)
    newSearch=false
    if !search_details_param.blank?
      logger.debug "TRACE3"
      sdp = search_details_param
      sdp.keys.map{ |k| 
      if stored_search_details.send(k) != sdp[k]
        logger.debug "TRACE4"
        newSearch=true
      end
      }

    end
    
    newSearch
  end

end
