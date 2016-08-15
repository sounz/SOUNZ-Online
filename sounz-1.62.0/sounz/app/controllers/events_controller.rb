class EventsController < ApplicationController
  
  include AttachmentHelper
  include StatusesHelper
  include FrbrLinksHelper
  include FrbrMruHelper
  include ModelAsStringHelper
  include FinderHelper
  include ApplicationHelper
  
  EVENT_TYPE = EntityType.find_by_symbol(:event)
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def news
    @events = Event.paginate(:page => params[:page], :per_page => 10, :order => 'event_start desc')
  end
  
  def homepage_news
    @events = Event.find(:all, :order => "event_start desc", :limit => 5)
    render :partial => 'homepage_news', :collection => @events 
  end

  def list
    @events = Event.paginate(:page => params[:page], :per_page => 50, :order => 'event_title')
  end

  def show
    @event = Event.find(params[:id])
    @eventTypes=EventType.find(:all, :order => 'event_type_desc')
    
	if @event.is_opportunity?
	  @page_title= "NZ Music Opportunity - #{@event.event_title}"
	else
      @page_title= "NZ music event - #{@event.event_title}"
	end
	
    @media_items = attachments(@event)
    @assignedVenue=@event.get_venue_role
  end

  def new
    @event = Event.new
    @event_types=EventType.find(:all, :order => 'event_type_desc')
    @contactinfo=Contactinfo.new();
    @event.contactinfo=@contactinfo
    @assignedVenue=nil
    get_statuses(@event)
    set_default_status(@event)
    save_event_instance_in_session
  end

  def create

    @start_time = params[:event][:event_start_time]
    @finish_time = params[:event][:event_finish_time]

    #Parse dates to tweak params to keep rails happy
    parse_dates(params)

    @event = Event.new(params[:event])
    @contactinfo = Contactinfo.create(params[:contactinfo]);
    @event.contactinfo = @contactinfo
    #logger.debug "EVENT CREATE: @login #{@login} login_id #{@login.login_id}"
    @event.updated_by = @login.login_id
    @contactinfo.updated_by = @login.login_id

    if (!@start_time.blank? && @start_time != "00:00") || (!@finish_time.blank? && @finish_time != "00:00")
      @event.supress_times = false
    end

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to :action => 'show', :id => @event.event_id
    else
      get_statuses(@event)
      @event_types=EventType.find(:all, :order => 'event_type_desc')
      render :action => 'new'
    end
  end


  def parse_dates(params)
    @start_date_ok = false
    begin
      convert_datetime_to_db_format_in_params(params, 'event','event_start')
      @start_date_ok = true
    rescue TimeParseException
      @event.errors.add("Start time")
    end
    
    @finish_date_ok = false
    begin
      convert_datetime_to_db_format_in_params(params, 'event','event_finish')
      @finish_date_ok = true
    rescue TimeParseException
      @event.errors.add("Finish time")
    end
    
    @entry_deadline_date_ok = false
    begin
      convert_datetime_to_db_format_in_params(params, 'event','entry_deadline')
      @entry_deadline_date_ok = true
    rescue TimeParseException
      @event.errors.add("Entry deadline time")
    end
    
  end

  def findContactinfos
    if params[:query].length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
      @matchingPeople=Person.find(:all,:conditions => ["first_names like ? or last_name ilike ?", '%'+params[:query]+'%','%'+params[:query]+'%'] )
      @matchingOrganisations=Organisation.find(:all,:conditions => ["organisation_name ilike ?", '%'+params[:query]+'%'] )
      @matchingObjects=@matchingPeople+@matchingOrganisations
      render :partial => 'result', :collection => @matchingObjects      
      
    end
  
  end
  
  
  
  
=begin
todo list

rebuild DB, rerun tests
fix upload form for multiple on same page

=end
  
  #DEPRECATED - No longer used
  def assignContactinfo
  contactinfo=Contactinfo.find(params["object_id"])
  render :partial => 'contactinfo', :locals => {:object => contactinfo}
  end

  def edit
    session[:default_contactinfo] = nil
    @event = Event.find(params[:id])
    @eventTypes=EventType.find(:all)
    @contactinfo = @event.contactinfo
    get_statuses(@event)
    @assoc_types=RelationshipType.find(:all)
    @entity_types=EntityType.find(:all)
    @media_items = attachments(@event)
    @assignedVenue = @event.get_venue_role
    @event_types=EventType.find(:all, :order => 'event_type_desc')
    @default_contactinfo = @contactinfo.default_contactinfo
    @contactinfo.initialize_contactinfo_associated_with_another_contactinfo( @default_contactinfo ) unless @default_contactinfo.blank?
    #@assignedVenue = FrbrObject.new("venue",@event.venue) if !@event.venue.blank?
    save_event_instance_in_session

  end

  def update
    session[:default_contactinfo] = nil 
    #The expression is saved in the session prior to editing.  Its tweaked by the AJAX date widget,
    #so needs to be reloaded from session
    @event = load_event_instance_from_session

    @event_from_id = Event.find(params[:id])
    #The event is saved in the session prior to editing.  Its tweaked by the AJAX date widget,
    #so needs to be reloaded from session
    @event = load_event_instance_from_session #this is the one in session

    if @event_from_id.event_id != @event.event_id
      raise "Unable to save event due to changing event in session issue (WR42723), form submission id is "+
      " #{params[:id]}, event id in session is #{@event.event_id}"
    end

    @event.updated_by= @login.login_id
    get_statuses(@event)

    if (!params[:event][:event_start_time].blank? && params[:event][:event_start_time] != "00:00") || 
      (!params[:event][:event_finish_time].blank? && params[:event][:event_finish_time] != "00:00")
      params[:event][:supress_times] = false 
    end

    #Parse dates to tweak params to keep rails happy
    parse_dates(params)

    if @event.update_attributes(params[:event])
      #if params[:venue] != nil
      #@event.set_venue_role(params[:venue][:role_id], @login.login_id)
      #else
      #@event.set_venue_role(nil, @login.login_id)
      #end

      @event.contactinfo.updated_by= @login.login_id

      if !params[:default_contactinfo].blank?
        @default_contactinfo = DefaultContactinfo.find(params[:default_contactinfo][:default_contactinfo_id])
        @default_contactinfo.self_update(params[:default_contactinfo])
      end

      if @event.contactinfo.update_attributes(params[:contactinfo])

        # blank fields based on default_contactinfo if the latter exists
        @event.contactinfo.override_contactinfo_with_null_values(@default_contactinfo) unless @default_contactinfo.blank?

        #this is a duplication, but hopefully it improves indexing when contactinfo changes
        Event.index_objects([ @event ])

        flash[:notice] = 'Event was successfully updated.'
        redirect_to :action => 'show', :id => @event

      else
      flash[:notice] = 'Contactinfo updating was a problem!'
      redirect_to :action => 'show', :id => @event
      end
    else
      @eventTypes=EventType.find(:all)
      #@contactinfos=Contactinfo.find(:all)
      @contactinfo=@event.contactinfo
      @contactinfo.updated_by=@login.login_id
      @contactinfo.update_attributes(params[:contactinfo])
      @assoc_types=RelationshipType.find(:all)
      @entity_types=EntityType.find(:all)
      @media_items = attachments(@event)
      @assignedVenue=@event.get_venue_role
      @event_types=EventType.find(:all, :order => 'event_type_desc')
      #@assignedVenue = FrbrObject.new("venue",@event.venue) if !@event.venue.blank?
      render :action => 'edit'
    end
    
 
  end

  def destroy
  	event = Event.find(params[:id])
    contactinfo = event.contactinfo
	# destroy contactinfo belonging to that event
	contactinfo.destroy if event.destroy
    redirect_to :action => 'list'
  end
  
  
  def findVenues
  	@event = Event.find(params[:object])
    @results=Array.new
    if params[:query].length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
      #FIXME: Replace with a proper solr search passing venue as a parameter
      
=begin
the_query = FinderHelper.build_query(Superwork, params[:query])
@matchingSuperworks = solr_query(the_query)[0][:docs].map{|f|f.objectData}
=end
      fields = [
        {:name => 'contributor_known_as_for_solr_t', :boost => 4},
        {:name => 'contributor_description_for_solr_t', :boost => 2.5}
      ]
      lucene_query = FinderHelper.build_query(Role, params[:query], fields)
      logger.debug "LUCENE QUERY: T1: #{lucene_query}"
      lucene_query << " AND role_type_id_for_solr_t:#{RoleType::VENUE.role_type_id}"
      lucene_query.gsub!("type_t:Role AND", "")
      logger.debug "LUCENE QUERY: T2: #{lucene_query}"
      
      
     # @matchingRoles=Role.find_by_solr(lucene_query)
      @matchingRoles = solr_query(lucene_query)[0][:docs].map{|f|f.objectData}
       
      logger.debug "LUCENE RESULTS:#{@matchingRoles}"
      for role in @matchingRoles
         @results.push((FrbrObject.new("role",role))) if role != nil
      end
    render :partial => 'result', :collection => @results, :locals => {:event => @event}
    end
  
  end
  
  def assignVenue
  	#logger.debug "DEBUG: assign_venue ###################"
  	@event = Event.find(params[:event])
	
	@prev_assignedVenue = @event.get_venue_role
	@event.set_venue_role(nil, @login.login_id) unless @prev_assignedVenue.blank?
    
	@assignedVenue=FrbrObject.new("role",Role.find(params["object_id"]))
	@event.set_venue_role(@assignedVenue.objectData.role_id, @login.login_id)
	
	@event.updated_by = @login.login_id
	@event.save
		
	@event.default_contactinfo_update
	@event.contactinfo.updated_by = @login.login_id
	@event.contactinfo.save
  end
  
  def removeVenue
  	@event = Event.find(params[:event])
    @assignedVenue=nil

	# delete default contactinfo
	@event.contactinfo.default_contactinfo.destroy if @event.set_venue_role(@assignedVenue, @login.login_id) && ! @event.contactinfo.default_contactinfo.blank?
	
	@event.updated_by = @login.login_id
	@event.contactinfo.updated_by = @login.login_id
	@event.contactinfo.save
	@event.save
	
  end
  
  #def assignVenueFromPopup
  #  assignVenue
  #   render :partial => 'venue', :locals => {:object => @assignedVenue}
  #end

 #def addVenue
 #  @role = Role.new
 #  get_statuses(@event)
 #  render :partial => 'new_venue_popup'
 #end
 
 #def addVenueFromPopup    
 #   @venue = Venue.new(params[:venue])
 #   @venue.save()
 #   render :partial => 'window_closer', :locals => {:venue_id => @venue.id}
 # end
  
  

 # Alter the expression held in session, and tweak the main form accordingly
 def event_type_chosen
   load_event_instance_from_session
   event_type = EventType.find(params[:type])
   @event.event_type = event_type
   save_event_instance_in_session
 end
 
 
 #When the start time is changed, make the end time the start time for parent work duration 
  #(if parent work set).  Do not execute however if the end date is turned off
  def set_end_time_from_start_time
    @event = load_event_instance_from_session
    @execute_update = false
    if !@event.event_finish.blank?
      @execute_update = true      
      @start_date = params[:start_date]
      @start_hms = params[:start_hms]

      start_time = Time.parse(@start_date << ' ' << @start_hms)

      #Use a dummy event for rendering purposes
      @dummy_event = Event.new
      @dummy_event.event_finish = start_time
    end

    #if the time has changed tweak the minutes supression flag
    logger.debug "Prior to supress, start hms is #{@start_hms}"
    if @start_hms != "00:00"
      logger.debug "Setting supress times to false"
      @event.supress_times  = false
      save_event_instance_in_session
    end
  end


  #- needed to keep the ajax happy -
  def disable_dates
    @event = load_event_instance_from_session
    @event.event_start = nil
    @event.event_finish = nil
    save_event_instance_in_session
  end


  #- needed to keep the ajax happy -
  def enable_dates
    @event = load_event_instance_from_session
    @event.event_start = Time.now
    @event.event_finish = Time.now
    save_event_instance_in_session
  end

  # Hide the widget for end date
  def set_no_finish_time
    @event = load_event_instance_from_session
    @event.event_finish = nil
    save_event_instance_in_session
  end

  # Show the widget for end date
  def set_has_finish_time
    @event = load_event_instance_from_session
    @event.event_finish = Time.now
    save_event_instance_in_session
  end

  #When date minutes are zeroed, set the  supress_times  flag
  def disable_date_minutes
    @event = load_event_instance_from_session
    logger.debug "Setting supress times when disabling date minutes"
    @event.supress_times  = true
    save_event_instance_in_session
  end
  
  
  
  #Note this is the FRBR related items
  def related
    @event = Event.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@event, "frbr_"+mode)
    
    logger.debug @related_frbr_objects
    @sub_partial_path = "shared/frbr/objects/full/event/frbr_list_wrapper"
  end
  

  
  
  
  
  
  #-------------------------------------------------------
  #- Bulk add events to this one for the purposes of umbrellaing
  #-------------------------------------------------------
  
  #show the form
  def add_recent_events
    @event = Event.find(params[:id])
    @mru_frbr_objects= find_mru_entity_types(EVENT_TYPE, @login, amount = 10, 
                                              already_chosen_ids = [@event.event_id])    
  end
  
  
  #Add sub events, turning this one into an umbrella event
  def add_multiple_events
    @event = Event.find(params[:event][:id])

    new_event_ids=params[:new_related_frbr][:ids]
    event_array = []

    bad_id = false # Set this to true if 
    for id in new_event_ids
    ev = convert_id_to_model(id)
    if ev.class != Event
        bad_id = true
        flash[:message]= 'Objects that are not of type event cannot be added here'
      break
      else
        event_array << ev
      end
    end
    
    
    if !bad_id
      if EventsHelper.add_events_to_create_umbrella(@event,event_array)
        #good
         redirect_to :action => :show, :id => @event.event_id
      else
        flash[:message] = "An error occurred whilst trying to add these events"
        render :action => :add_recent_events, :id =>@event.event_id
      end
      
    #This is the case where ids where submitted that are not expressions (ie someone is le hacking)
    else
      #bad
      flash[:message] = "You can only add events"
      render :action => :add_events, :id => @event.event_id
    end
  
  end
  
  

  #---- deal with the related events widget ----
  def detach_sub_event
    show_params(params)
    source_id = params[:source_id]
    source_event = convert_id_to_model(source_id)
    event_to_detach = convert_id_to_model(params[:id])
    @dom_id = "attached_"+generate_id(event_to_detach)
    logger.debug "DOM ID:#{@dom_id}"
    event_to_detach.parent = nil
    @successful_destroy = false
    if event_to_detach.save
      @successful_destroy = true
    else
      logger.debug event_to_detach.errors.to_yaml
      asdsdfdsfsdfsdfsdf
    end
  end
  
  #instigated from the find as you type in the sub events form
  def find_sub_events
    show_params(params)
    fields = [
      {:name => 'event_title_for_solr_t', :boost => 4}
    ]
    lucene_query = FinderHelper.build_query(Event, params[:search_text],fields)
   # @events = Event.find_by_solr(params[:search_text])
    @events = solr_query(lucene_query)[0][:docs].map{|f|f.objectData}
    @source_id = params[:frbr_object_id]
    render :layout => false
  end
  
=begin

  lucene_query = FinderHelper.build_query(Role, params[:query])
  logger.debug "LUCENE QUERY: T1: #{lucene_query}"
  lucene_query << " AND role_type_id_t:#{RoleType::VENUE.role_type_id}"
  lucene_query.gsub!("type_t:Role AND", "")
  logger.debug "LUCENE QUERY: T2: #{lucene_query}"
  
  
 # @matchingRoles=Role.find_by_solr(lucene_query)
   @matchingRoles = solr_query(lucene_query)[0][:docs].map{|f|f.objectData}

=end
  
  
=begin
action: add_sub_event
id: event_368
controller: events
source_id: event_133
=end
  def add_sub_event
    show_params(params)
    @source_id = params[:source_id]
    @new_sub_event = convert_id_to_model(params[:id])
    @parent_event = convert_id_to_model(@source_id)
    @new_sub_event.parent = @parent_event
    @succesful_addition = true
    
    @parent_dom_id = "related_events_list_#{@source_id}"
    
    new_sub_id = generate_id(@new_sub_event)
    @new_child_dom_id = "attached_#{new_sub_id}"
    @dom_id =  "found_#{new_sub_id}"
    if !@new_sub_event.save
      @successful_attach = false
    end
    render :layout => false
  end
  
  # ---- Session storage of events ----

  #In order for the ajax to repopulate correctly the dates when a mode is changed, the event being edited
  #needs to be stored in the session
  def save_event_instance_in_session
    session[:event_being_edited] = @event
  end

  #Load the instance variable @event with whats saved
  def load_event_instance_from_session
    @event = session[:event_being_edited]
  end
  
  # - WR#50282 - Create a copy of an event with its associations/relationships
  def copy
    event_to_clone = Event.find(params[:id])
			  
	@event = event_to_clone.clone
	
	@event.event_title = "Copy of '#{event_to_clone.event_title}'"
	
	@event.status = Status::PENDING # default to 'pending'
	
	# delete created_at assigned from event_to_clone created_at value
	# as we need created_at be actual time of creating the copy
	@event.created_at = nil	
		
	# updated by
	@event.updated_by = get_user.login_id
	
	# contact info - we create a new one by copying details of event_to_clone
	contactinfo = Contactinfo.new
	contactinfo = event_to_clone.contactinfo.clone
	contactinfo.created_at = nil
	contactinfo.updated_by = get_user.login_id

	@event.contactinfo = contactinfo
		
	if @event.save
	  
	  # copying relationships
	  success = true
	  
	  # default_contactinfo
	  if !event_to_clone.contactinfo.default_contactinfo.blank?
		  default_contactinfo = DefaultContactinfo.new
		  default_contactinfo = event_to_clone.contactinfo.default_contactinfo.clone
		  default_contactinfo.contactinfo = @event.contactinfo
		  
		  success = false if !default_contactinfo.save
	  end
	  	  
	  # attachments
	  event_to_clone.event_attachments.each do |ea|
	    event_attachment          = EventAttachment.new
		event_attachment          = ea.clone
		event_attachment.event_id = @event.id
		
		success = false if !event_attachment.save
	  end
	  
	  # other relationships
	  event_to_clone.event_relationships.each do |event_relationship|
	  	success = false if !RelationshipHelper.copy_frbr_relationships(@event, event_relationship, @login)
	  end
	  
	  notice = 'Event clone was successfully created.'
	  notice += ' But some of the relationships or attachments failed to be copied.' if !success
	  
	  flash[:notice] = notice
	  
	  redirect_to :action => 'edit', :id => @event
	else
	  flash[:error] = 'Event cloning has failed.'
	  redirect_to :action => 'edit', :id => event_to_clone.id
	end			
  end
  
  #------------------------------------------------
  #- Set default_contactinfo field based on param -
  #------------------------------------------------
  def set_default_contactinfo_change
  	@contactinfo = Contactinfo.find(params[:contactinfo])
	if ! @contactinfo.blank?
		@default_contactinfo = @contactinfo.default_contactinfo
		session[:default_contactinfo] = @default_contactinfo unless !session[:default_contactinfo].blank?
		@default_contactinfo = session[:default_contactinfo] unless session[:default_contactinfo].blank?		
		
		@default_contactinfo = @default_contactinfo.set_values(params)
        @contactinfo.initialize_contactinfo_associated_with_another_contactinfo( @default_contactinfo ) unless @default_contactinfo.blank?
    else
   	    render :action => :edit
    end
  end 
end
