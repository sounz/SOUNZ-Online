class Event < ActiveRecord::Base
    include FrbrHelper
    include FrbrMethodsEvent
    include DateRenderHelper
    include ApplicationHelper
    
    
    set_primary_key "event_id" 
    set_sequence_name "events_event_id_seq" 
    belongs_to :contactinfo
    belongs_to :status
    has_many :event_relationships
    has_many :relationships, :through => :event_relationships, :select => "event_relationships.relationship_type_id, relationships.*",
	         :dependent => :destroy
    #belongs_to :venue
    belongs_to :event_type
    
    belongs_to :status
    
    #Updated by relationship 
    validates_presence_of :login_updated_by
    #validates_associated :login_updated_by

    belongs_to :login_updated_by, 
              :class_name => 'Login',
              :foreign_key => :updated_by
              
    validates_length_of :event_title, :in => 2..100,
    :allow_nil => false,
    :message => "is not between 2 and 100 chars"
    
    validates_presence_of :event_type, :contactinfo
    validates_associated :event_type, :contactinfo
 #   validates_numericality_of :entry_age_limit,
#                              :if => Proc.new {|e| ( e.entry_age_limit != nil) }


    def validate
       errors.add(:event_start, "must be provided if a finish time exists")  if event_start.blank? and !event_finish.blank?
   
       if !event_start.blank? and !event_finish.blank?
         #both are non blank if we get this far 
          if event_finish < event_start
          errors.add(:event_finish, "must be after start date") 
          end
        end
    end
    
    #Self referential join
    #belongs_to :related_event, :class_name => 'Event', :foreign_key => :related_event_id
    #has_many :events_related, :class_name => 'Event', :foreign_key => :related_event_id
    acts_as_tree :foreign_key => :related_event_id, :order => :event_title
    
    has_many :event_attachments, :dependent => :destroy
    has_many :media_items, :through => :event_attachments

    # Solr stuff
    acts_as_solr :fields => [
      :event_title_for_solr,
      :general_note_for_solr,
      :tickets_note_for_solr,
      :event_type_id,
      {:event_start_for_solr => :string},
      {:event_start_with_time_for_solr => :string},
      {:event_finish_for_solr => :string},
      {:event_finish_with_time_for_solr => :string},
	    {:event_finish_adv_search_for_solr => :string},
      :event_dates_for_solr,
      :prize_info_note_for_solr,
      :internal_note_for_solr,
      :status_for_solr,
      :venue_for_solr,
      #These are for facets
      {:cities_for_solr => :string},
      :nz_regions_facet_for_solr, #this is the same as contributors
      :region_for_solr,
      :locality_for_solr,
      {:country_id_for_solr => :string},
      {:facet_sort_field_for_solr => :string},
      
      #These are text, as an event may span several months and we dont want "4,5,6,7" to be a facet token
      :facet_year_group_for_solr,
      :previous_year_sub_group_for_solr, 
	  
	    :related_distinction_types_for_solr
    ]
    
	  # WR#50291 - only relevant to 'Opportunity' event
	  def related_distinction_types_for_solr
	    types = Array.new
	  
	    if is_opportunity?
        distinctions_offered.each do |d|
          if !d.distinction_types.blank?
		        types = types + d.distinction_types.map{|dt| dt.distinction_type_id}
          else
          	# if there is no type assigned to distinction - 'Other' subfacet
          	types.push('other')
          end
        end
		
		    # if there is no related distinction - 'Other' subfacet
	      types.push('other') if distinctions_offered.blank?
      
	    end
	  
	    return types.uniq.join(', ')
    end
    
    def event_dates_for_solr
      start = (event_start.blank? ? event_finish : event_start)
      finish = (event_finish.blank? ? event_start : event_finish)
      dates = get_dates_between(start, finish, format="%Y%m%d")
      return dates.join(", ")
    end

    def status_for_solr
      return status_id
    end
    
    
    def venue_for_solr
      venue_role_frbr_object = get_venue_role
      venue_role = venue_role_frbr_object.objectData if !venue_role_frbr_object.blank?
      le_name = []
      venue_role_title = ''
      venue_role_title = venue_role.role_title if !venue_role.blank?
      le_name = le_name + [FinderHelper.strip(venue_role.role_title)] if !venue_role_title.blank?
      
      org_name= ''
      
      if !venue_role.blank?
        org = venue_role.organisation
        if !org.blank?
          org_name = org.organisation_name
        else
          asdfsadf
        end
      end
      
      le_name = le_name + [FinderHelper.strip(org_name)] if !org_name.blank?
      le_name.join(', ')
    end
    
    
    #This is the previous year grouping, which is single years back to the nearest 5, a group of 5, then the rest,
    # e.g. 2006,2005,2004,2003,2002,2001,2000,1995-1999,before 1999
    def previous_year_sub_group_for_solr
      result_array = []
      #Get the groupings for the current year
      year_groups = FacetHelper.event_facet_previous_years(Time.now.year)
      years = associated_years
      logger.debug "YEARS TO CHECK:#{years.join(',')}"
      for year in years
        logger.debug "CHECKING:#{year}"
        #check the year against the 
        for key in year_groups.keys
          logger.debug "  CHECKING:key #{key}"
          ruby_statement = year_groups[key]
          y = year.to_i
          evaluation = eval(ruby_statement) 
          logger.debug "  EVALUATION: #{y} against #{ruby_statement} = *#{evaluation}*"
          if evaluation == true
            result_array << key
            break
          end
        end
      end
      
      result_array.uniq.sort.join(', ')
    end
    
    #Facets are broken down into these
    # next_year - the next year
    # this_year - current year
    # previous_year - any previous year
    # none - if no start / finish time is provided
    #Note a space separated list is returned as its possible to span multiple years
    def facet_year_group_for_solr
      result = ""
      years = associated_years
      logger.debug "CHECKING: #{years}"
      current_year = Time.now.year
      if years.length > 0
        #logger.debug "YGFS:T1"
        for year_string in years
        #  logger.debug "YGFS:T2"
          year = year_string.to_i
          if year == current_year
        #    logger.debug "YGFS:T3 - current year match"
            result << "current "
          elsif year == (current_year+1)
        #    logger.debug "YGFS:T4 - next year match"
            result << "next "
          elsif year < (current_year)
        #    logger.debug "YGFS:T5 - previous years"
            result << "previous "
          elsif year >> (current_year + 1)
        #    logger.debug "YGFS:T6 - future past next"
            result << "future "
          end
        end
      #no years found
      else 
       # logger.debug "YGFS:T7 - none found"
        result = "none "
      end
      
    #  logger.debug "YGFS: #{years} => #{result}"
      result.strip.split(' ').uniq.sort.join(' ')
    end
    

    
    #Get a comma separated array of associated days, mixed with months
    #The values returned are n*month+day, e.g. 23rd of June would be 623
    def associated_day_of_months
      months = associated_months
      result = []
      
	  start_date = event_start
	  start_date = entry_deadline if is_opportunity?
	  	  
	  if !start_date.blank?
        #if we have no finish date then we only have the day of the event start
        if event_finish.blank?
          result = [100*start_date.month + start_date.day]
        else
          position_date = start_date
          while position_date <= event_finish
            result << 100*position_date.month + position_date.day
            position_date = position_date + 1.day
            break if result.length > 31 #no point iterating through years if we have all the days already
          end
        end
      end
      result.sort
    end
    
    
    
    
    #Work out the associated years for a given event, merging the start and end year.  It returns an array
    #FIXME - will we have events spanning >2 years?
    def associated_years
      years = ""
      
	  start_date = event_start
	  start_date = entry_deadline if is_opportunity?
	  
      years << start_date.year.to_s if !start_date.blank?
      years << ' '
      years << event_finish.year.to_s if !event_finish.blank?
      
      #remove duplicates and trim off spaces
      unique_years = years.strip.split(' ').uniq.sort
      result = unique_years
      if unique_years.length > 1
        result = []
        for y in unique_years[0]..unique_years[1]
          result << y
        end
      end
      result
      #now we have the 2004-2008 case to deal with, we wish to create [2004,2005,...2008]
      
    end
    
    
    #normally an event would happen on a single day but there is no reason why it cannot go over more than one mont
    #or indeed several transcending a year boundary.  Joy....
    def associated_months
      result = [] # expect no months if no dates
      years = associated_years
      
	  start_date = event_start
	  start_date = entry_deadline if is_opportunity?
	  	  
      start_month_year = Time.parse("01/#{start_date}.month/#{start_date}.year") if !start_date.blank?
      finish_month_year = Time.parse("01/#{event_finish}.month/#{event_finish}.year") if !event_finish.blank?
      
      #this is the case when we only have a start month
      if !start_month_year.blank? and finish_month_year.blank?
          result << start_date.month
      #this is the tricky one...
      elsif !start_month_year.blank? and !finish_month_year.blank?
        delta_year = event_finish.year - start_date.year # year
        
        #if the range spans an entire year we have all the months
        if (delta_year) > 1
          result = [1,2,3,4,5,6,7,8,9,10,11,12]
        #this is the case of months being in the same year
        elsif delta_year == 0
          puts start_month_year.month
          puts finish_month_year.month
          for m in start_month_year.month..finish_month_year.month
            result << m
          end
          
        #this is the annoying one, going over new year
        elsif delta_year == 1
          #add months to year end
          for month in start_month_year.month..12
             result << month
          end
          
          #add months from start of year
          for month in 1.. finish_month_year.month
             result << month
          end          
        end
        result
      end
        
      
      
      
      result
    end
    
    #select locality, suburb from contactinfos where contactinfo_id in (select contactinfo_id from events);
    
    #FIXME: how on earth do we get a reliable city from the data provided?
    def cities_for_solr
		  # if there is a default_contactinfo for that role_contactinfo contactinfo
		  # initialize contactinfo based on default_contactinfo fields and then
		  # index the contactinfo field to default
    	default_contactinfo = get_default_contactinfo
		  contactinfo.initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo ) unless default_contactinfo.blank?
		      
      return "#{FinderHelper.strip(contactinfo.locality)} - #{FinderHelper.strip(contactinfo.suburb)} "
    end
    
    #index a region id or a blank
    def nz_regions_facet_for_solr
		# if there is a default_contactinfo for that role_contactinfo contactinfo
		# initialize contactinfo based on default_contactinfo fields and then
		# index the contactinfo field to default
    	default_contactinfo = get_default_contactinfo
		contactinfo.initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo ) unless default_contactinfo.blank?
		      
        region_id = contactinfo.region_id
        region_id = "" if region_id.blank?
        region_id
    end
    
    #index a country id or a blank
    def country_id_for_solr
      result = "none"
      
	  # if there is a default_contactinfo for that role_contactinfo contactinfo
	  # initialize contactinfo based on default_contactinfo fields and then
	  # index the contactinfo field to default
	  default_contactinfo = get_default_contactinfo
			  contactinfo.initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo ) unless default_contactinfo.blank?
	  	  
      country = ContactinfosHelper.get_country_from_country_or_region(contactinfo)
      result = country.country_id.to_s if !country.blank?
      result
    end

    #
    # Returns event region
    #
    def region_for_solr
      # if there is a default_contactinfo for that event contactinfo
      # initialize contactinfo based on default_contactinfo fields and then
      # index the contactinfo field to default
      default_contactinfo = get_default_contactinfo
			contactinfo.initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo ) unless default_contactinfo.blank?

      return contactinfo.region.region_id unless contactinfo.region.blank?
    end

     #
     # Returns what locality this event is in
     #
    def locality_for_solr
      # if there is a default_contactinfo for that event contactinfo
      # initialize contactinfo based on default_contactinfo fields and then
      # index the contactinfo field to default
      default_contactinfo = get_default_contactinfo
			contactinfo.initialize_contactinfo_associated_with_another_contactinfo( default_contactinfo ) unless default_contactinfo.blank?
      return FinderHelper.strip(contactinfo.locality) unless contactinfo.locality.blank?
    end
  
    #Use the event start date or the opportunity deadline - if nothing supplied used 9999 as the year
    def facet_sort_field_for_solr
      date_to_order_by = event_start
      # puts "T1: date_to_order_by = #{date_to_order_by}"
      date_to_order_by = entry_deadline if is_opportunity?
     #  puts "T2: date_to_order_by = #{date_to_order_by}"
      date_to_order_by = Time.parse("12/31/2037") if date_to_order_by.blank?
     # puts "T3: date_to_order_by = #{date_to_order_by}"
      return FinderHelper.date_for_solr_ymd(date_to_order_by)
    end
    
    #FIXME: how does this work with summer time
    def event_start_for_solr
     # return event_start.iso8601[0,19]+'Z'
     start_date = event_start
	 
     start_date = entry_deadline if is_opportunity?
     
	 return FinderHelper.date_for_solr_ymd(start_date)
    end
    
    #FIXME: how does this work with summer time
    #Use the start date if no finish date exists
    # Field for facet search
    def event_finish_for_solr
      #return event_finish.iso8601[0,19]+'Z'
      
      date_of_finish = event_start
	  # NOTE: umbrella events (those with 'children' events) are treated differently
	  # their starting date is indexed in solr as finish date even if they do have a finish date
	  # this is done, so that they are not shown in facets as happening on every day of the
	  # date range, for more details, WR#51702
      date_of_finish = event_finish unless event_finish.blank? || !self.children.blank?
      
	  return FinderHelper.date_for_solr_ymd(date_of_finish)
    end
	
	# Field that will be search in in the Event Advanced Search
	def event_finish_adv_search_for_solr
      #return event_finish.iso8601[0,19]+'Z'
		  
	  date_of_finish = event_start
	  
	  date_of_finish = event_finish unless event_finish.blank?
	  	  
	  date_of_finish = entry_deadline if is_opportunity?
	  		  
	  return FinderHelper.date_for_solr_ymd(date_of_finish)
	end	
    
    def event_start_with_time_for_solr
     # return event_start.iso8601[0,19]+'Z'
	 start_date = event_start
			 
	 start_date = entry_deadline if is_opportunity?     
	 
	 return FinderHelper.date_for_solr_ymdhms(start_date)
    end
    
    #FIXME: how does this work with summer time
    #Use the start date if no finish date exists
    def event_finish_with_time_for_solr
      #return event_finish.iso8601[0,19]+'Z'
      
      date_of_finish = event_start
      date_of_finish = event_finish if !event_finish.blank? #FIXME do we need to treat an umbrella event differently here
      return FinderHelper.date_for_solr_ymdhms(date_of_finish)
    end
    
    def general_note_for_solr
      return FinderHelper.strip(general_note)
    end
    
    
    def tickets_note_for_solr
      return FinderHelper.strip(tickets_note)
    end
    
    
    def prize_info_note_for_solr
      return FinderHelper.strip(prize_info_note)
    end
    
    
    def internal_note_for_solr
      return FinderHelper.strip(internal_note)
    end
    
    
    def event_title_for_solr
      return FinderHelper.strip(event_title)
    end
    
  def set_venue_role(role, login)
     logger.debug("SETTING VENUE ROLE TO: #{role}")
     if role != nil
     RelationshipHelper.delete_frbr_relationship(:event, frbr_id, :is_held_at, :role, role)
     RelationshipHelper.add_frbr_relationship(:event, frbr_id, :is_held_at, :role, role, login)
     else
     RelationshipHelper.delete_all_frbr_relationships(:event, frbr_id, :is_held_at)
     end
     #find the role specified in the first frbr relationship that corresponds to an event-venue relationship
  end
  
  def get_venue_role
    #find the role specified in the first frbr relationship that corresponds to an event-venue relationship
    if (frbr_id != nil)
    relationships=RelationshipHelper.find_frbr_relationships(:event, frbr_id, :is_held_at)
    relationship=relationships.first
    if relationship != nil
    roles=relationship.roles
    role=roles.first
    return FrbrObject.new("role",role)
    end
    else
    return nil
    end
  end
  
        
  def frbr_type
    "event"
  end

  def frbr_id
  event_id
  end

  def frbr_ui_desc
  event_title
  end


  def frbr_listing_description
    result = ""
    result << eBY_date(event_start) unless event_start.blank?
    result << ' to ' if !event_start.blank? && !event_finish.blank?
    result << eBY_date(event_finish) unless event_finish.blank?
	
	return result
  end
  
  
  #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
  #The naming needs to be common to maintain a single partial for list rendering
  def frbr_list_title
    event_title
  end

  def frbr_list_description
    frbr_listing_description
  end

  #TODO: should really subclass frbr_object types from a class that defines this method once.
  def frbr_relationships
        frbr_relationships=Array.new()
        for rel in relationships.uniq
          reltype=RelationshipType.find(rel.relationship_type_id)
        
          #Choose the entity_type that does not match this one.
          #Where both are the same, it does not matter which we pick
          my_entity=EntityType.entityTypeToId(rel.ent_entity_type_id)
          if EntityType.entityTypeToId(rel.ent_entity_type_id) == frbr_type() then 
            my_entity= EntityType.entityTypeToId(rel.entity_type_id)
          end
        
          related_objects=eval('rel.'+my_entity+'s')
        
          for related_object in related_objects
            if rel.entity_type_id == rel.ent_entity_type_id then
              if related_object.id != id then
                frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
              end
            else 
            frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
            end
          end
        end
      frbr_relationships
      end


    def is_anonymous
      result = "No"
      if entry_anonymous != nil and entry_anonymous == true
        result = "Yes"
      end
      result
    end
  
  
    #Is this an opportunity event or not?  Check the event type id to see if it is or not
    def is_opportunity?
      return event_type_id == EventType::OPPORTUNITY.event_type_id
    end
    
    
    #for facetting
    #      ev.happening_expressions + ev.presented_expressions + ev.commissioned_expressions
    #Take all the works commissioned for the event, plus all of the works of the expressions
    # * happening
    # * presented
    # * commissioned
    def associated_works
      result = commissioned_expressions
      assoc_expressions = happening_expressions + presented_expressions + commissioned_expressions
      assoc_expressions.uniq! # dont do more work than we have to
      for exp in assoc_expressions
        works_for_exp = [exp.work] + [exp.parent_work]
        result = result + [exp.work] if !exp.work.blank?
        result = result + [exp.parent_work] if !exp.parent_work.blank?
      end
      
      result
      
      
    end
    
    
    #For rendering the featuring section collate performers directly asocaited with the event and with the happening
    #expressions also
    def all_performers
      result =  performers
      for exp in (happening_expressions+presented_expressions).flatten.uniq
        result = result + exp.performers
      end
      result.flatten.uniq.sort_by{|role|[role.contributor.known_as]}
    end
    
    #This is required to render the New Zealand music section for events
    #Iterate through related expressions and get their works
    def all_works
      result = []
      for exp in (happening_expressions+presented_expressions).flatten.uniq
       # result << exp.work
       logger.debug "CLASS:#{exp.work.class}"
       result = result + [exp.work]
      end
      
      
      result.flatten.uniq.sort_by{|w|[w.work_title.downcase]}

    end
    
    
    #Find all the supporters of an event
    def all_supporters
      
      if event_type.event_type_desc.match('Opportunity')
	    # WR#50294 - DISTINCTIONS rev 300308.doc
	    result = distinctions_offered.map{|d| d.composite_supporters}
      else      
        result = funders+managers+presenters
      end      
	  
	  result.flatten.uniq.sort_by{|role|[role.contributor_names]}
    end
    
    
    def validate
      #FIXME add test to ensure only one level deep
      if !parent.blank?
        grand_parent = parent.parent
        if !grand_parent.blank?
          errors.add(:parent,"An umbrella event cannot exist inside another umbrella event") 
        end
      end
    end
	
	# WR#42492 - event contact info defaults to assigned venue contact info if any
	def default_contactinfo_update
	  venue_role = self.get_venue_role.objectData unless self.get_venue_role.blank?
	  #logger.debug "DEBUG: default_contactinfo_update: venue_role #{venue_role.id}"
	  if !venue_role.blank?
		contactinfo_to_default = nil
		
	  	# contactinfo to default is of 'physical' type, or if that doesn't exist, of the 'postal' contactinfo type
	  	venue_role_physical_contactinfo = venue_role.get_role_contactinfo_by_contactinfo_type('physical').contactinfo
		contactinfo_to_default = venue_role_physical_contactinfo
		if !venue_role_physical_contactinfo.default_contactinfo.blank?
		  contactinfo_to_default = venue_role_physical_contactinfo.initialize_contactinfo_associated_with_another_contactinfo(venue_role_physical_contactinfo.default_contactinfo) 
		end
		
		contactinfo_to_default = venue_role.get_role_contactinfo_by_contactinfo_type('postal').contactinfo if contactinfo_to_default.is_empty?
		
		default_contactinfo = self.contactinfo.default_contactinfo
		
		#logger.debug "DEBUG: default_contactinfo_update: default_contactinfo #{default_contactinfo.id}" unless default_contactinfo.blank?
		#logger.debug "DEBUG: default_contactinfo_update: contactinfo_to_default #{contactinfo_to_default.id}" unless contactinfo_to_default.blank?
		if default_contactinfo.blank? && !contactinfo_to_default.blank?
		  default_contactinfo = DefaultContactinfo.new
		  default_contactinfo.self_create_from_existent_contactinfo(self.contactinfo, contactinfo_to_default)
				   
		# update existent default_contactinfo
		elsif !default_contactinfo.blank? && !contactinfo_to_default.blank?
		  default_contactinfo.self_create_from_existent_contactinfo(self.contactinfo, contactinfo_to_default)
		  
		# delete existent default_contactinfo if there is no contactinfo to default
        elsif !default_contactinfo.blank? && contactinfo_to_default.blank?
          default_contactinfo.destroy
		end		
		
	  end
	  	  
	  # solr indexing
	  self.save
	  
    end

	# Refresh the relationships
	def get_default_contactinfo
	  self.contactinfo    = Contactinfo.find(self.contactinfo_id)
	  default_contactinfo = self.contactinfo.default_contactinfo
	  return default_contactinfo
	end
end
