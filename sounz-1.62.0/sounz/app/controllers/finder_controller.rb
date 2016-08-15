#Note the following: Due to stickiness requirements the search state has to be stored in session
#It is stored in session[:facet_details][:works/people/events][:search_details]
#Note this object has a bunch of bean like properties representing search state, and a hash containing
#facet id to true / false, true being open, false being closed
class FinderController < ApplicationController
  
  include FacetHelper
  include ApplicationHelper
  include SounzmediaHelper
  require 'yaml'

  def index
    redirect_to :action => 'show', :id => 'works'
  end


def addToSelectedSession
    type = Inflector.camelize(params[:type])
    selectedHash = session[:selected]
    selectedHash[params[:type] + "/" + params[:object_id]] = FrbrObject.new(params[:type], eval(type + ".find(" + params["object_id"] + ")"))
    render :partial => 'selected'
  end
  
  def removeFromSelectedSession
    selectedHash = session[:selected]
    selectedHash.delete(params[:type] + "/" + params[:object_id])
    render :partial => 'selected'
  end
  
  def clearSelectedSession
    session[:selected] = Hash.new()
    render :partial => 'selected'
  end
  
  
  def addToSelected
    type = Inflector.camelize(params[:type])
    myUser=get_user().id
    mySearches=[]
    mySearches=SavedSearch.find(:all,:conditions => ['search_type=? AND saved_by_login_id=?',"selected_results",myUser])
    if mySearches.length >0
      mySearch=mySearches.first
      if mySearch != nil
        selectedHash=YAML::load(mySearch.search_data)
        selectedHash[params[:type] + "/" + params[:object_id]] = FrbrObject.new(params[:type], eval(type + ".find(" + params["object_id"] + ")"))
        mySearch.search_data=selectedHash.to_yaml
        mySearch.save()
      end
    else
      #create a new saved search for this user
      selectedHash=Hash.new()
      selectedHash[params[:type] + "/" + params[:object_id]] = FrbrObject.new(params[:type], eval(type + ".find(" + params["object_id"] + ")"))
      mySearch=SavedSearch.new()
      if mySearch != nil
        mySearch.updated_by=myUser
        mySearch.saved_by_login_id=myUser
        mySearch.search_name="Selected results for user: #{myUser}"
        mySearch.search_type="selected_results"
        mySearch.search_data=selectedHash.to_yaml
        mySearch.save()
      end
    end
    render :partial => 'selected'
  end

  def removeFromSelected
    mySearches=[]
    myUser=get_user().id
    mySearches=SavedSearch.find(:all,:conditions => ['search_type=? AND saved_by_login_id=?',"selected_results",myUser])
    mySearch=mySearches.first
    if mySearch != nil
      selectedHash=YAML::load(mySearch.search_data)
      #logger.debug("SELECTED HASH!")
      #logger.debug selectedHash.to_s
      selectedHash.delete(params[:type] + "/" + params[:object_id])
      mySearch.search_data=selectedHash.to_yaml
      #logger.debug("FROM removeSELECTED")
      #logger.debug(mySearch.search_data)
      mySearch.save()
    end  
    render :partial => 'selected'
  end
    
  def clearSelected
    mySearches=[]
    myUser=get_user().id
    mySearches=SavedSearch.find(:all,:conditions => ['search_type=? AND saved_by_login_id=?',"selected_results",myUser])
    mySearch=mySearches.first()
    if mySearch != nil
      selectedHash=Hash.new()
      mySearch.search_data=selectedHash.to_yaml
      mySearch.save()
    end  
    render :partial => 'selected'
  end
  
  
  #This is the entry point where we wish the session var holding search details to be used in rendering the search
  def shows
    search_type = params[:id]
    #params[:query]="fred"
    search_details = get_or_create_search_details_from_session(search_type)
    
    logger.debug "SEARCH DETAILS IN SHOWS " + search_details.to_yaml
    logger.debug "SEARCH TYPE:#{search_type}"
    
    
    hash = {:action => :show, :id => search_type}
    #now populate the values of the params using the above
    for instance_var in search_details.instance_variables
      instance_var_name = instance_var.gsub('@', '')
      value = search_details.send(instance_var_name)
      hash[instance_var_name.to_sym] = value
    end
    redirect_to hash

  end
  
  

  
  
  #This is the entry point where we assume nothing is in the session
  def show
    if params[:id].blank?
      redirect_to :action => 'show', :id => 'works'
    else
      if session[:selected] == nil
        session[:selected] = Hash.new()
      end

      if params[:id] == 'people'
        find_people
        @page_title = 'search for people in NZ music'
        @page_to_link_to='people'
        render :action => 'show_people'
      elsif params[:id] == 'events'
        @page_title = 'search for NZ music events'
        @page_to_link_to='events'
        find_events
        render :action => 'show_events'
      elsif params[:id] == 'sounzmedia'
        @page_title = 'search for NZ Media On Demand'
        @page_to_link_to='sounzmedia'
        find_sounzmedia
        render :action => 'show_sounzmedia'
      else
        @page_title = 'search for NZ Music'
        @page_to_link_to='works'
        
        begin
          find
      render :action => 'show'
        rescue Exception => e
          logger.error "SolrException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
          @tab = :works
          render :action => 'solr_error'
        end
        
        
        
      end
    end
  end
  
  

  def find_people
    logger.debug "****** FINDING PEEPS ******* "
    @search_page = 'people'
    @query = params[:query]
    @query = '' if !@query

    @page = (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;

     @born_key = params[:born]
    @last_name_key = params[:last_name]
    @person_organisation_key = params[:person_organisation]
    @fully_represented_key = params[:fully_represented]
    
    #country
    @country_facet_key = params[:country]

    #region
    @region_facet_key = params[:region]
    @region = Region.find(@region_facet_key) if !@region_facet_key.blank?
    logger.debug "REGION FACET KEY:#{@region_facet_key} is nil? #{@region_facet_key == nil}"
    @role_group_key = params[:role_group]
    @role_type_id = params[:role_type]
    @role_type = RoleType.find(@role_type_id) if !@role_type_id.blank?
    @where = params[:where]
    @last_name = params[:last_name]
    @status = params[:status]
    
    if @where == 'inside_nz'
      @inside_nz_key = 'inside_nz'
    elsif @where == 'outside_nz'
      @outside_nz_key = 'outside_nz'
    end
    
  # distinction types
  @distinction_type_id = params[:distinction_type]
  @distinction_type = DistinctionType.find(@distinction_type_id) if ! @distinction_type_id.blank?	
    
    #Get search details either anew or from within the session, and reset bar the toggle state
    @search_details = get_or_create_search_details_from_session('people')
    @search_details = reset_search_details_in_session('people') 
    
    #ah the pain
    @search_details.born = @born_key if !@born_key.blank?
    @search_details.query = @query if !@query.blank?
    @search_details.last_name = @last_name_key if !@last_name_key.blank?
    @search_details.person_organisation = @person_organisation_key if !@person_organisation_key.blank?
    @search_details.fully_represented_key = @fully_represented_key if !@fully_represented_key.blank?
    @search_details.country = @country_facet_key if !@country_facet_key.blank?
    @search_details.region = @region_facet_key if !@region_facet_key.blank?
    @search_details.role_group = @role_group_key if !@role_group_key.blank?
    @search_details.role_type = @role_type_id if !@role_type_id.blank?
    @search_details.where = @where if !@where.blank?
    @search_details.status = @status if !@status.blank?
  @search_details.distinction_type = @distinction_type_id if ! @distinction_type_id.blank?
     
   
    


    #These are the values passed in to the facets
    facets_chosen_by_key = {
      :born_key => @born_key,
      :last_name_key => @last_name_key,
      :person_organisation_key => @person_organisation_key,
      :fully_represented_key => @fully_represented_key,
      :inside_nz_key => @inside_nz_key,
      :outside_nz_key => @outside_nz_key,
      :country_facet_key => @country_facet_key,
      :region_facet_key => @region_facet_key,
      :role_group_key => @role_group_key,
      :role_type_key => @role_type_id,
      :status => @status,
    :distinction_type_key => @distinction_type_id,
      :page => @page
    }
    
    logger.debug "===== FACET KEYS CHOSEN ===="
    logger.debug facets_chosen_by_key.to_yaml

    #Search using the provided, or an empty query if its too short
    actual_search_term = @query
    actual_search_term = "" if @query.length < 3  
    
   
    
    

    
    begin
      @results, @paginator = people_facet_query(@login, @query, facets_chosen_by_key)
    rescue Exception => e
      logger.error "SolrException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      @tab = :people
      @error_message = "An error occurred in trying to connect to the information retrieval server"
    end
    
  end




  # Later, this needs to search both Events and Venues
  def find_events
    @search_page = 'events'
    @query = params[:query]
    @query = '' if !@query

    @page = (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;

    
    #Country
    @country_id = params[:country]
    @country = Country.find(@country_id) if !@country_id.blank?
    
    #Region
    @region_id = params[:region]
    @region = Region.find(@region_id) if !@region_id.blank?
    
    #year grouping
    @year_group = params[:year_group]
    
    #the month
    @month = params[:month]
    
    #the day
    @day = params[:day]
    
    logger.debug "IN FIND @day is #{@day}"
    
    
    #event type
    @event_type_id = params[:event_type]
    @event_type = EventType.find(@event_type_id) if !@event_type_id.blank?
    
    @previous_year_groups = params[:prev_years_group]
    
  # distinction types
  @distinction_type_id = params[:distinction_type]
      
  #These are the values passed in to the facets
    facets_chosen_by_key = {
      :country_key => @country_id,
      :region_key => @region_id,
      :year_group_key => @year_group,
      :month_key => @month,
      :day_key => @day,
      :prev_year_subgroup_key => @previous_year_groups,
      :event_type_key => @event_type_id,
    :distinction_type_key => @distinction_type_id,
      :page => @page,
      :q => []
    }
    
    
    #:query, :country, :region, :year_group, :month, :event_type, :prev_years_group
    
    #Get search details either anew or from within the session, and reset bar the toggle state
    @search_details = get_or_create_search_details_from_session('events')
    @search_details = reset_search_details_in_session('events')
    @search_details.day = @day if !@day.blank?
    @search_details.query = @query if !@query.blank?
    @search_details.country = @country_id if !@country_id.blank?
    @search_details.region = @region_id if !@region_id.blank?
    @search_details.year_group = @year_group if !@year_group.blank?
    @search_details.month = @month if !@month.blank?
    @search_details.event_type = @event_type_id if !@event_type_id.blank?
    @search_details.prev_years_group = @previous_year_groups if !@previous_year_groups.blank?
    @search_details.distinction_type = @distinction_type_id if ! @distinction_type_id.blank?
    
    
    # quicklinks params
    if !params[:search_details].blank?
      # parameter from search form
      @search_details.quicklink = params[:search_details][:quicklink]
    else
      # parameter from facets
      @search_details.quicklink = params[:quicklink]
    end
      
    # Quicklink search
    unless @search_details.quicklink.blank?
      @quicklink_search = true
      today = (@user_time_zone.blank? ? Time.now : Time.now.in_time_zone(@user_time_zone))
      quicklink_param = ''
      if @search_details.quicklink == 'today'
        quicklink_param = today.strftime("%Y%m%d")
      elsif @search_details.quicklink == 'week'
        quicklink_param = get_dates_between(today, (today + 7.days), "%Y%m%d").join(" OR ")
      elsif @search_details.quicklink == 'month'
        quicklink_param = get_dates_between(today, (today + 28.days), "%Y%m%d").join(" OR ")
      end
      facets_chosen_by_key[:q] = "AND event_dates_for_solr_t:(#{quicklink_param})"
    end
    
    #Search using the provided, or an empty query if its too short
    actual_search_term = @query
    actual_search_term = "" if @query.length < 3  
    
    logger.debug "PASING IN #{@query} is nil? #{@query == nil}, #{facets_chosen_by_key.to_yaml}"
    
        
    begin
      @results, @paginator = event_facet_query(@login, @query, facets_chosen_by_key)
    rescue Exception => e
      logger.error "SolrException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      @tab = :events
      @error_message = "An error occurred in trying to connect to the information retrieval server"
    end
        


    
  end


  #
  # Find works with facet data
  #
  def find
   
    # Get parameters for the find
    @search_page = 'works'
    @query = params[:query]
    @query = '' if !@query
    
  @sort_by = params[:sort_by]
  @sort_by = '' if ! @sort_by
  
  @year_subgroup = params[:year_subgroup]
    @year_group = (@year_subgroup.blank?) ? params[:year_group] : FinderHelper.year_group(@year_subgroup.sub('before-', ''))

    @duration = params[:duration]

    @subcategory = params[:subcategory].to_i
    @category = (@subcategory < 1) ? params[:category].to_i : FinderHelper.category(@subcategory)
    
    #theme / influence / genre
    @concept_type = params[:concept_type]
    
    #An actual concept if its been chosen
    @concept_id = params[:concept]
    @concept = Concept.find(@concept_id) if !@concept_id.blank?


    @suitable_for = params[:suitable_for].to_i
    
    @available_for= params[:available_for]
    
    @page = (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;
    
    @available_as = params[:available_as]
    
    @recording_format = params[:recording_format]
    @sample_type = params[:sample_type]
    @score_type = params[:score_type]
  @resource_type = params[:resource_type]
      @audio_type = params[:audio_type]
    @video_type = params[:video_type]
    
    @popular_category = params[:popular_category]
    @popular_subcategory = params[:popular_subcategory]
    
  @special_subcategory = params[:special_subcategory].to_i
    
  #Get search details either anew or from within the session, and reset bar the toggle state
    @search_details = get_or_create_search_details_from_session('works')
    @search_details = reset_search_details_in_session('works') 
    
    logger.debug '+++++++++'
    logger.debug session.to_yaml
    logger.debug '+++++++++'
    
    
    #ah the pain
    @search_details.concept_type = @concept_type if !@concept_type.blank?
    @search_details.category = @category if !@category.blank?
    @search_details.subcategory = @subcategory if !@subcategory.blank?
    @search_details.query = @query if !@query.blank?
    @search_details.year_subgroup = @year_subgroup if !@year_subgroup.blank?
    @search_details.year_group = @year_group if !@year_group.blank?
    @search_details.duration = @duration if !@duration.blank?
    @search_details.concept = @concept_id if !@concept_id.blank?
    @search_details.suitable_for = @suitable_for if !@suitable_for.blank?
    @search_details.available_as = @available_as if !@available_as.blank?
    @search_details.recording_format = @recording_format if !@recording_format.blank?
    @search_details.sample_type = @sample_type if !@sample_type.blank?
    @search_details.score_type = @score_type if !@score_type.blank?
  @search_details.resource_type = @resource_type if !@resource_type.blank?
  @search_details.audio_type = @audio_type if !@audio_type.blank?
    @search_details.video_type = @video_type if !@video_type.blank?
    @search_details.popular_category = @popular_category if !@popular_category.blank?
    @search_details.popular_subcategory = @popular_subcategory if !@popular_subcategory.blank?
    @search_details.available_for = @available_for if !@available_for.blank?
    @search_details.special_subcategory = @special_subcategory if ! @special_subcategory.blank?
  @search_details.sort_by = @sort_by if !@sort_by.blank?
  
  # quicklinks params
  if !params[:search_details].blank?
    @search_details.quicklink = params[:search_details][:quicklink]
  else
    @search_details.quicklink = params[:quicklink]
  end
      
  # Quicklink search
    if ! @search_details.quicklink.blank?
      @quicklink_search = true
    else
      @quicklink_search = false
    end
  
    #Note the toggles are maintained above ^^^^
    save_search_details_in_session('works', @search_details)


    # Base options
    options = {
      :page          => @page,
      :rows          => LISTING_PAGE_SIZE,
      :facet         => true,
      :facet_zeroes  => true,
      :fq            => [],
      :facet_fields  => [ :year_group_for_solr_s, 
                          :year_subgroup_for_solr_s, 
                          :category_ids_for_solr_t,
                          :subcategory_ids_for_solr_t,
                          :has_genres_for_solr_s,
              :has_influences_for_solr_s,
              :has_themes_for_solr_s, 
                          :genres_for_solr_t, 
              :influences_for_solr_t, 
              :themes_for_solr_t,
                          :available_as_recordings_for_solr_t,
                          :available_as_scores_sheets_for_solr_t,
                          :available_as_samples_for_solr_t,
              :available_as_resource_types_facet_for_solr_t,
                          :available_as_top_level_facet_for_solr_t,
                          :available_as_sounzmedia_audio_for_solr_t,
                          :available_as_sounzmedia_video_for_solr_t,
                          :suitable_for_youth_for_solr_t,
                          :difficulty_for_solr_t,
                          :popular_facets_for_solr_t,
                          :popular_subfacets_for_solr_t,
                          :can_be_bought_for_solr_t,
                          :can_be_hired_for_solr_t,
                          :can_be_loaned_for_solr_t,
              :taonga_puoro_special_subcategory_ids_for_solr_t,
              :music_for_stage_special_subcategory_ids_for_solr_t
                          ],
      :facet_queries => [],
    :q => []
    }
    
    #logger.debug "T1: OPTIONS:#{options} YAML=#{options.to_yaml}"

    # Now get facet data as necessary
    
    # Year group facet data
    if !@year_subgroup.blank?
      options[:fq] << 'year_subgroup_for_solr_s:' + @year_subgroup
    elsif !@year_group.blank?
      options[:fq] << 'year_group_for_solr_s:' + @year_group
    end
    
    #Concepts

    #add search restrictions if concept type chosen
    if !@concept_type.blank?
      options[:fq] << "has_genres_for_solr_s:\"1\"" if @concept_type == 'genre'
      options[:fq] << "has_influences_for_solr_s:\"1\"" if @concept_type == 'influence'
      options[:fq] << "has_themes_for_solr_s:\"1\"" if @concept_type == 'theme'
    end
    
    #search search restriction if concept chosen
    if !@concept.blank?
      options[:fq] << "genres_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'genre'
      options[:fq] << "influences_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'influence'
      options[:fq] << "themes_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'theme'
    end
    
    options[:fq] << "popular_facets_for_solr_t:#{@popular_category}" if !@popular_category.blank?
    options[:fq] << "popular_subfacets_for_solr_t:#{@popular_subcategory}" if !@popular_subcategory.blank?
    
    
    #-- available as facet --
    #FIXME: It is *not* clear how to associate works and resources, as all of
    #superwork, work, expression and manifestations have described by resource relationships
    if !@available_as.blank?
      options[:fq] << "available_as_top_level_facet_for_solr_t: #{@available_as}"
    end
    
    options[:fq] << "available_as_scores_sheets_for_solr_t:#{@score_type}" if !@score_type.blank?
    options[:fq] << "available_as_samples_for_solr_t:#{@sample_type}" if !@sample_type.blank?
    options[:fq] << "available_as_recordings_for_solr_t:#{@recording_format}" if !@recording_format.blank?
  options[:fq] << "available_as_resource_types_facet_for_solr_t:#{@resource_type}" if !@resource_type.blank?
    options[:fq] << "available_as_sounzmedia_video_for_solr_t:#{@video_type}" if !@video_type.blank?    
    options[:fq] << "available_as_sounzmedia_audio_for_solr_t:#{@audio_type}" if !@audio_type.blank?        

    # Duration facet data
    if !@duration.blank?
      options[:fq] << "intended_duration_for_solr_i:" + FinderHelper.duration_category_to_solr_query(@duration)
    else
      options[:facet_queries] << 'intended_duration_for_solr_i:[1 TO 299]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[300 TO 599]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[600 TO 899]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[900 TO 1199]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[1200 TO 1799]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[1800 TO *]'
    end
    
    
    #Check available for
    if !@available_for.blank?
      case @available_for
        when 'hire'
          options[:fq] << 'can_be_hired_for_solr_t:yes'
        when 'purchase'
          options[:fq] << 'can_be_bought_for_solr_t:yes'
        when 'loan'
          options[:fq] << 'can_be_loaned_for_solr_t:yes'
         
      end
    end

    # Category/subcategory
    if @subcategory > 0
      #refine_by.push("all_categorizations_for_solr_t:work_subcategory_id=" + @subcategory.to_s);
      options[:fq] << 'subcategory_ids_for_solr_t:' + @subcategory.to_s
      
      
    elsif @category > 0
      
      # FIXME: only need id field, so should only return that
      WorkSubcategory.find(:all, :conditions => {:work_category_id => @category}).each do |ws|
        options[:facet_queries] << 'subcategory_ids_for_solr_t: ' + ws.work_subcategory_id.to_s
      end
      options[:fq] << 'category_ids_for_solr_t:' + @category.to_s
    else
      
    end

    # WR#52205
    if @special_subcategory > 0 && @category > 0
    if @category == WorkCategory::TAONGA_PUORO.work_category_id
      options[:fq] << 'taonga_puoro_special_subcategory_ids_for_solr_t:' + @special_subcategory.to_s
    elsif @category == WorkCategory::MUSIC_FOR_STAGE.work_category_id
      options[:fq] << 'music_for_stage_special_subcategory_ids_for_solr_t:' + @special_subcategory.to_s
    end
    end
  
    # Suitable for, and youth - note they are different fields
    # They really should be separate facets...
    if @suitable_for > 0
      if @suitable_for != 4
        options[:fq] << 'difficulty_for_solr_t:' + @suitable_for.to_s
      else
        options[:fq] << 'suitable_for_youth_for_solr_t:"1"'
      end
    end
  
  models_to_search = [Work,Resource]
  
    # Quicklink search parameters and models
  if @quicklink_search
    models_to_search = [Manifestation, Resource]
    
    if @search_details.quicklink == 'download'
      options[:q] << 'AND (downloadable_for_solr_t:yes)'
    else
      options[:q] << 'AND (quicklink_format_for_solr_t:(' + @search_details.quicklink + '))'
    end
        
    # common requirements
    options[:q] << 'AND (can_be_bought_for_solr_t:yes OR can_be_loaned_for_solr_t:yes OR can_be_hired_for_solr_t:yes)'
  end

  if ! @sort_by.blank?
    if @sort_by == 'title'
      options[:sort]= 'title_as_string_for_solr_s asc'
    elsif @sort_by == 'author'
        options[:sort]= 'authors_cvs_as_string_for_solr_s asc'
    end
    end
  
    if @query.length < 3 then
          
    lucene_query = FinderHelper.build_advanced_query(models_to_search, [], '')
      
      #Use the commonly named string field for resource and work
      options[:sort]= 'title_as_string_for_solr_s asc' 
      logger.debug "PRE SOLR_QUERY, options are"
      logger.debug options.to_yaml
 
      logger.debug "LUCENE3:#{lucene_query}"
      lucene_query = append_status_filter_if_required(@login, lucene_query)
      @results, @paginator = solr_query(lucene_query, options)
      # Remove the results if nothing has been searched for, ie no facet query
      if options[:fq].empty? && options[:q].empty?
        @results[:docs] = [] #this hides the results when no query happens, phew took a while to find!
      end
    else
    
      if @quicklink_search
        fields = [
        {:name => 'title_for_solr_t',          :boost => 4},
        {:name => 'author_note_for_solr_t',    :boost => 2.5},
        {:name => 'general_note_for_solr_t',   :boost => 1},
        {:name => 'series_title_for_solr_t',   :boost => 1},
        {:name => 'publisher_note_for_solr_t', :boost => 1}
                 ]
      else
      fields = [
          {:name => 'work_title_for_solr_t', :boost => 4},
          {:name => 'composers_csv_for_solr_t', :boost => 2.5},
          {:name => 'work_description_for_solr_t'},
          {:name => 'programme_note_for_solr_t', :boost => 1},
          {:name => 'manifestation_titles_for_solr_t', :boost => 1},
          {:name => 'manifestation_general_note_for_solr_t', :boost => 1},
          {:name => 'expression_general_note_for_solr_t', :boost => 1},
          {:name => 'contents_note_for_solr_t'},
        
          #These are for resources
          {:name => 'title_for_solr_t', :boost => 4},
          {:name => 'author_note_for_solr_t', :boost => 4},
                 ]
      end
    
      logger.debug "SOLR_QUERY FACET WORK:#{@query.to_yaml}"
      lucene_query = FinderHelper.build_query(models_to_search, @query, fields)
      lucene_query = append_status_filter_if_required(@login, lucene_query)
      lucene_query = FinderHelper.make_query_more_exact(lucene_query) 
      logger.debug "LUCENE: FACET SOLR QUERY:#{lucene_query}"
      logger.debug "LUCENE:FACET OPTIONS:#{options.to_yaml}"
      logger.debug "OPTION FAC QUERY OF CLASS #{options[:facet_queries].class}"
    
     for query in options[:facet_queries]
       logger.debug "facet_queries:#{query} of class #{query.class}"
     end
      
       logger.debug "OPTION FQ QUERY OF CLASS #{options[:fq].class}"
       
       for query in options[:fq]
         logger.debug "FQ:#{query} of class #{query.class}"
       end
      

      
      
      @results, @paginator = solr_query(lucene_query, options)
    end
  end
  
   def find_sounzmedia
    @search_page = 'sounzmedia'
    @query = params[:query]
    
    @query = '' if !@query
    @page = (!params[:page].blank?) ? (params[:page].to_i > 0 ? params[:page].to_i : 1) : 1;
    
    @sort_by = params[:sort_by]
    @sort_by = '' if ! @sort_by
    
    @year_subgroup = params[:year_subgroup]
    @year_group = (@year_subgroup.blank?) ? params[:year_group] : FinderHelper.year_group(@year_subgroup.sub('before-', ''))
    @duration = params[:duration]
    @subcategory = params[:subcategory].to_i
    @category = (@subcategory < 1) ? params[:category].to_i : FinderHelper.category(@subcategory)
    @concept_type = params[:concept_type]
    @concept_id = params[:concept]
    @concept = Concept.find(@concept_id) if !@concept_id.blank?
    @suitable_for = params[:suitable_for].to_i
    @available_for= params[:available_for]
    @available_as = params[:available_as]
    @recording_format = params[:recording_format]
    @sample_type = params[:sample_type]
    @score_type = params[:score_type]
    @resource_type = params[:resource_type]
    @audio_type = params[:audio_type]
    @video_type = params[:video_type]
    @popular_category = params[:popular_category]
    @popular_subcategory = params[:popular_subcategory]
    @special_subcategory = params[:special_subcategory].to_i
    
    @search_details = get_or_create_search_details_from_session('sounzmedia')
    @search_details = reset_search_details_in_session('sounzmedia') 
    @search_details.query = @query if !@query.blank?
    
    @search_details.concept_type = @concept_type if !@concept_type.blank?
    @search_details.category = @category if !@category.blank?
    @search_details.subcategory = @subcategory if !@subcategory.blank?
    @search_details.query = @query if !@query.blank?
    @search_details.year_subgroup = @year_subgroup if !@year_subgroup.blank?
    @search_details.year_group = @year_group if !@year_group.blank?
    @search_details.duration = @duration if !@duration.blank?
    @search_details.concept = @concept_id if !@concept_id.blank?
    @search_details.suitable_for = @suitable_for if !@suitable_for.blank?
    @search_details.available_as = @available_as if !@available_as.blank?
    @search_details.recording_format = @recording_format if !@recording_format.blank?
    @search_details.sample_type = @sample_type if !@sample_type.blank?
    @search_details.score_type = @score_type if !@score_type.blank?
    @search_details.resource_type = @resource_type if !@resource_type.blank?
    @search_details.audio_type = @audio_type if !@audio_type.blank?
    @search_details.video_type = @video_type if !@video_type.blank?
    @search_details.popular_category = @popular_category if !@popular_category.blank?
    @search_details.popular_subcategory = @popular_subcategory if !@popular_subcategory.blank?
    @search_details.available_for = @available_for if !@available_for.blank?
    @search_details.special_subcategory = @special_subcategory if ! @special_subcategory.blank?
    @search_details.sort_by = @sort_by if !@sort_by.blank?
    
    save_search_details_in_session('sounzmedia', @search_details)

    # Base options
    options = {
      :page          => @page,
      :rows          => LISTING_PAGE_SIZE,
      :facet         => true,
      :facet_zeroes  => true,
      :fq            => [],
      :facet_fields  => [ :year_group_for_solr_s, 
                          :year_subgroup_for_solr_s, 
                          :category_ids_for_solr_t,
                          :subcategory_ids_for_solr_t,
                          :has_genres_for_solr_s,
                          :has_influences_for_solr_s,
                          :has_themes_for_solr_s, 
                          :genres_for_solr_t, 
                          :influences_for_solr_t, 
                          :themes_for_solr_t,
                          :available_as_recordings_for_solr_t,
                          :available_as_scores_sheets_for_solr_t,
                          :available_as_samples_for_solr_t,
                          :available_as_resource_types_facet_for_solr_t,
                          :available_as_top_level_facet_for_solr_t,
                          :available_as_sounzmedia_audio_for_solr_t,
                          :available_as_sounzmedia_video_for_solr_t,
                          :suitable_for_youth_for_solr_t,
                          :difficulty_for_solr_t,
                          :popular_facets_for_solr_t,
                          :popular_subfacets_for_solr_t,
                          :can_be_bought_for_solr_t,
                          :can_be_hired_for_solr_t,
                          :can_be_loaned_for_solr_t,
                          :taonga_puoro_special_subcategory_ids_for_solr_t,
                          :music_for_stage_special_subcategory_ids_for_solr_t
                          ],
      :facet_queries => [],
    :q => []
    }
    
    # Year group facet data
    if !@year_subgroup.blank?
      options[:fq] << 'year_subgroup_for_solr_s:' + @year_subgroup
    elsif !@year_group.blank?
      options[:fq] << 'year_group_for_solr_s:' + @year_group
    end
    
    #Concepts
    if !@concept_type.blank?
      options[:fq] << "has_genres_for_solr_s:\"1\"" if @concept_type == 'genre'
      options[:fq] << "has_influences_for_solr_s:\"1\"" if @concept_type == 'influence'
      options[:fq] << "has_themes_for_solr_s:\"1\"" if @concept_type == 'theme'
    end
    
    #restriction if concept chosen
    if !@concept.blank?
      options[:fq] << "genres_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'genre'
      options[:fq] << "influences_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'influence'
      options[:fq] << "themes_for_solr_t:\"#{@concept.concept_id}\"" if @concept_type == 'theme'
    end
    
    options[:fq] << "popular_facets_for_solr_t:#{@popular_category}" if !@popular_category.blank?
    options[:fq] << "popular_subfacets_for_solr_t:#{@popular_subcategory}" if !@popular_subcategory.blank?
    
    
    #available as
    if !@available_as.blank?
      options[:fq] << "available_as_top_level_facet_for_solr_t: #{@available_as}"
    end
    
    options[:fq] << "available_as_scores_sheets_for_solr_t:#{@score_type}" if !@score_type.blank?
    options[:fq] << "available_as_samples_for_solr_t:#{@sample_type}" if !@sample_type.blank?
    options[:fq] << "available_as_recordings_for_solr_t:#{@recording_format}" if !@recording_format.blank?
    options[:fq] << "available_as_resource_types_facet_for_solr_t:#{@resource_type}" if !@resource_type.blank?
    options[:fq] << "available_as_sounzmedia_video_for_solr_t:#{@video_type}" if !@video_type.blank?    
    options[:fq] << "available_as_sounzmedia_audio_for_solr_t:#{@audio_type}" if !@audio_type.blank?        
    

    # Duration facet data
    if !@duration.blank?
      options[:fq] << "intended_duration_for_solr_i:" + FinderHelper.duration_category_to_solr_query(@duration)
    else
      options[:facet_queries] << 'intended_duration_for_solr_i:[1 TO 299]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[300 TO 599]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[600 TO 899]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[900 TO 1199]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[1200 TO 1799]'
      options[:facet_queries] << 'intended_duration_for_solr_i:[1800 TO *]'
    end
    
    
    #available for
    if !@available_for.blank?
      case @available_for
        when 'hire'
          options[:fq] << 'can_be_hired_for_solr_t:yes'
        when 'purchase'
          options[:fq] << 'can_be_bought_for_solr_t:yes'
        when 'loan'
          options[:fq] << 'can_be_loaned_for_solr_t:yes'
         
      end
    end

    # Category/subcategory
    if @subcategory > 0
      #refine_by.push("all_categorizations_for_solr_t:work_subcategory_id=" + @subcategory.to_s);
      options[:fq] << 'subcategory_ids_for_solr_t:' + @subcategory.to_s
    elsif @category > 0
      WorkSubcategory.find(:all, :conditions => {:work_category_id => @category}).each do |ws|
        options[:facet_queries] << 'subcategory_ids_for_solr_t: ' + ws.work_subcategory_id.to_s
      end
      options[:fq] << 'category_ids_for_solr_t:' + @category.to_s
    end

    if @special_subcategory > 0 && @category > 0
      if @category == WorkCategory::TAONGA_PUORO.work_category_id
        options[:fq] << 'taonga_puoro_special_subcategory_ids_for_solr_t:' + @special_subcategory.to_s
      elsif @category == WorkCategory::MUSIC_FOR_STAGE.work_category_id
        options[:fq] << 'music_for_stage_special_subcategory_ids_for_solr_t:' + @special_subcategory.to_s
      end
    end
  
    # Suitable for
    if @suitable_for > 0
      if @suitable_for != 4
        options[:fq] << 'difficulty_for_solr_t:' + @suitable_for.to_s
      else
        options[:fq] << 'suitable_for_youth_for_solr_t:"1"'
      end
    end
    
    models_to_search = [Work]
  
    if !@sort_by.blank?
      if @sort_by == 'title'
        options[:sort]= 'title_as_string_for_solr_s asc'
      elsif @sort_by == 'author'
        options[:sort]= 'authors_cvs_as_string_for_solr_s asc'
      end
    end
 
    fields = [
              {:name => 'title_as_string_for_solr_t', :boost => 4},
              {:name => 'work_description_for_solr_t'},
              {:name => 'programme_note_for_solr_t', :boost => 1},
              {:name => 'manifestation_titles_for_solr_t', :boost => 1},
              {:name => 'manifestation_general_note_for_solr_t', :boost => 1},              
              {:name => 'expression_general_note_for_solr_t', :boost => 1},
              {:name => 'composers_csv_for_solr_t'},
              {:name => 'contents_note_for_solr_t'},
      
              #These are for resources
              {:name => 'title_for_solr_t', :boost => 4},
              {:name => 'author_note_for_solr_t', :boost => 4},
             ]
             
    if @query.length < 3 then
      lucene_query = FinderHelper.build_advanced_query(models_to_search, [], '')
      lucene_query = append_status_filter_if_required(@login, lucene_query)
      lucene_query = append_type_to_query(lucene_query)
      @results, @paginator = solr_query(lucene_query, options)
      # Remove the results if nothing has been searched for, ie no facet query
      if options[:fq].empty? && options[:q].empty?
        @results[:docs] = [] #this hides the results when no query happens
      end
    else
      lucene_query = FinderHelper.build_query(models_to_search, @query, fields)
      lucene_query = append_status_filter_if_required(@login, lucene_query)
      lucene_query = FinderHelper.make_query_more_exact(lucene_query) 
      lucene_query = append_type_to_query(lucene_query)
      @results, @paginator = solr_query(lucene_query, options)
    end
#    logger.debug "wRESULTS: " + @results.to_yaml
   
  end
    
  #Deal with toggling a section of the facets.  To do this
  #- record the fact via an ajax LTR to get to this method.  Maintain in session
  #- in the RJS file call the javasacript to go toggly
  def toggle_facet_block
    
    @facet_id = params[:id]
    @facet_name_id = "name_" + @facet_id
    @search_action = params[:mode]
    search_details = get_or_create_search_details_from_session(@search_action)
    logger.debug "SESH DETAILS:#{search_details == nil}"
    #Fix me, this may not be the case
    if search_details.toggles.blank?
      search_details.toggles = {@facet_id => true}
    else
      search_details.toggles[@facet_id] = !search_details.toggles[@facet_id]
    end
    
    
    
    
    #logger.debug search_details.to_yaml
    
    respond_to do |wants|
      
      wants.html { 
        @redirection_address = request.referer.gsub('http://', '').split('/')
        @redirection_address[0] = ''
        @redirection_address = @redirection_address.join('/')

        logger.debug "REDIR ADDRESS:#{@redirection_address}"
        redirect_to @redirection_address
        } 
      wants.js { render }
    end
    
    #session[:facet_details][:works/people/events][:search_details]
  end
  
  
  
  def reset_searches
     session[:facet_details] = nil
     asdfasdfsdaf
  end
  
  
  
  def reset_work_search
    session[:facet_details]['works'][:search_details] = WorkFacetSearchDetails::new
    redirect_to :action => :shows
  end
  
  def reset_sounzmedia_search
    session[:facet_details]['sounzmedia'][:search_details] = SounzmediaFacetSearchDetails::new
    redirect_to :action => :shows, :id => 'sounzmedia'
  end

  def reset_people_search
    session[:facet_details]['people'][:search_details] = PeopleFacetSearchDetails::new
    redirect_to :action => :shows, :id => 'people'
  end

  def reset_event_search
    session[:facet_details]['events'][:search_details] = EventFacetSearchDetails::new
    redirect_to :action => :shows, :id => 'events'
  end
  
  
  
  private
  
  #Create a search details object, create one if it does not already exist in session
  def get_or_create_search_details_from_session(search_action)
    session[:facet_details] = {} if session[:facet_details].blank?
    session[:facet_details][search_action] = {} if session[:facet_details][search_action].blank?  
    logger.debug "SEARCH ACTION:#{search_action}"
    #do we need to create a search details object
    if session[:facet_details][search_action][:search_details].blank?
      session[:facet_details][search_action][:search_details] = WorkFacetSearchDetails::new if search_action == "works"
      session[:facet_details][search_action][:search_details] = PeopleFacetSearchDetails::new if search_action == 'people'
      session[:facet_details][search_action][:search_details] = EventFacetSearchDetails::new if search_action == 'events'
      session[:facet_details][search_action][:search_details] = SounzmediaFacetSearchDetails::new if search_action == 'sounzmedia'
      
    end
    
  if search_action == "works" && session[:search_details].blank?
    session[:search_details] = WorkFacetSearchDetails::new
    end
    
    logger.debug session[:facet_details].to_yaml
    session[:facet_details][search_action][:search_details] 
  end
  
  
  
  #Reset the search details in session prior to repopulating with details from the search parameters
  #Note however to maintain toggle state
  def reset_search_details_in_session(search_action)
    current_search_details = get_or_create_search_details_from_session(search_action)
    toggles = current_search_details.toggles
    current_search_details = WorkFacetSearchDetails::new if search_action == 'works'
    current_search_details = PeopleFacetSearchDetails::new if search_action == 'people'
    current_search_details = EventFacetSearchDetails::new if search_action == 'events'
    current_search_details = SounzmediaFacetSearchDetails::new if search_action == 'sounzmedia'    
    current_search_details.toggles = toggles
    session[:facet_details][search_action][:search_details]  = current_search_details
    current_search_details
  end
  
  #Save search details
  def save_search_details_in_session(search_action, search_details)
    session[:facet_details][search_action][:search_details]  = search_details
  end
  
  



end
