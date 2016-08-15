module FacetHelper
  include FinderHelper
  
  
  
  
  SAMPLE_NAMES = {
    'audio' => 'Audio',
    'score' => 'Scores',
    'video' => 'Video',
    'image' => 'Images'
    
  }
  
  #
  # Return a hash mapped from a constant-hash (format: {:solr_field, :facets}) data in the format of
  # key => text, ex. 1 => 'Biography'
  #
  def self.invert_facets(facets)
  	result = {}
	facets.map{|a| result[a.keys[0]] = a[a.keys[0]][:text]}
	return result
  end
    
  # WR#51700 - resource type facets are slightly different from resource_types in the database
  # hence we have to create a facet hash and assign each type manually to keys
  FACET_RESOURCE_TYPES = {
	  :solr_field => :available_as_resource_types_facet_for_solr_t,
	  :facets => [
	  	{1  => {:text => 'Biography',                :conditions => ResourceType.find_by_desc_for_facets('biography')}},
		{2  => {:text => 'History',                  :conditions => ResourceType.find_by_desc_for_facets('history')}},
		{3  => {:text => 'Education Resources',      :conditions => ResourceType.find_by_desc_for_facets('education resource')}},
		{4  => {:text => 'Industry Manuals',         :conditions => ResourceType.find_by_desc_for_facets('industry manual')}},
		{5  => {:text => 'Commentary or Analysis',   :conditions => ResourceType.find_by_desc_for_facets('commentary or analysis')}},
		{6  => {:text => 'Documentaries',            :conditions => ResourceType.find_by_desc_for_facets('documentary')}},
		{7  => {:text => 'Bibliographies',           :conditions => ResourceType.find_by_desc_for_facets('bibliography')}},
		{8  => {:text => 'Repertoire Lists',         :conditions => ResourceType.find_by_desc_for_facets('repertoire list')}},
		{9  => {:text => 'Interviews',               :conditions => ResourceType.find_by_desc_for_facets('interview')}},
		{10 => {:text => 'Programme Notes',          :conditions => ResourceType.find_by_desc_for_facets('programme note')}},
		{11 => {:text => 'Review',                   :conditions => ResourceType.find_by_desc_for_facets('review')}},
		{12 => {:text => 'Sheet Music',              :conditions => ResourceType.find_by_desc_for_facets('sheet music')}},
		{13 => {:text => 'Lyrics and Libretti',      :conditions => ResourceType.find_by_desc_for_facets('lyrics / libretti')}},
		{14 => {:text => 'Other NZ recordings',      :conditions => ResourceType.find_by_desc_for_facets('NZ recordings')}}	  
	  ]
  }  
  
  INVERTED_RESOURCE_TYPE_FACETS = invert_facets(FACET_RESOURCE_TYPES[:facets])
  
  #
  # Return a key of the resource type based on conditions of FACET_RESOURCE_TYPES
  #
  def self.facet_resource_type(resource)
    result = nil
	
	facets_array = FACET_RESOURCE_TYPES[:facets]
	
	#RAILS_DEFAULT_LOGGER.debug "DEBUG: facets_array #{facets_array}"	  
	
	for facet_to_check_for in facets_array
	  key = facet_to_check_for.keys[0]
	  conditions = facet_to_check_for[key][:conditions]	
	  #RAILS_DEFAULT_LOGGER.debug "DEBUG: condition #{condition}"
	  if conditions.include?resource.resource_type
	    #RAILS_DEFAULT_LOGGER.debug "DEBUG: key #{key}"
		result = key
	  end
	end
	
	return result
  end  
 
  # WR#52205
  #def self.special_subcategory_facets_formation(category)
  #	facets = Array.new
  #  key    = 1	
	
  #	# subcategories processing
  #	subcat = WorkSubcategory.find(:all, :conditions => ['work_category_id = (SELECT work_category_id FROM work_categories WHERE work_category_desc ilike (?))', '%' + category + '%'])
	
  #	subcat.each do |s|
  #	  facets.push(
  #	  	{ key => { :text => subcat[0].work_subcategory_desc, :conditions => WorkSubcategory.find_by_desc(subcat[0].work_subcategory_desc)}}
  #	  	)
  #	  key = key + 1
  #	end
	
  #	# special subcategories formation
  #	categories = WorkCategory.work_categories_for_additional_subcategory(category)
	
  #	categories.each do |c|
  #	  facets.push(
  #		{ key => { :text => c.work_category_desc + " with Taonga Puoro", :conditions => WorkCategory.find_by_desc(c.work_category_desc)}}
  #		)
  #	   key = key + 1	  
  #	end
	
  #	return facets
	
  #end
  
  # WR#52205
  TAONGA_PUORO_FACETS = {
    :solr_field => :taonga_puoro_special_subcategory_ids_for_solr_t,
    :facets => [
    	{1   => {:text => 'Taonga Puoro - solo or with keyboard',        :conditions => WorkSubcategory.find_by_desc('Taonga Puoro - solo or with keyboard')}},
		{2   => {:text => 'Taonga Puoro Duo',                            :conditions => WorkSubcategory.find_by_desc('Taonga Puoro Duo')}},
		{3   => {:text => 'Taonga Puoro Trio',                           :conditions => WorkSubcategory.find_by_desc('Taonga Puoro Trio')}},
		{4   => {:text => 'Taonga Puoro Quartet',                        :conditions => WorkSubcategory.find_by_desc('Taonga Puoro Quartet')}},
		{5   => {:text => 'Taonga Puoro Ensemble (5+)',                  :conditions => WorkSubcategory.find_by_desc('Taonga Puoro Ensemble (5+)')}},
		{6   => {:text => 'Orchestra with Taonga Puoro',                 :conditions => WorkCategory.find_by_desc('Orchestra')}},
		{7   => {:text => 'Keyboard with Taonga Puoro',                  :conditions => WorkCategory.find_by_desc('Keyboard')}},
		{8   => {:text => 'Strings (bowed) with Taonga Puoro',           :conditions => WorkCategory.find_by_desc('Strings (bowed)')}},
		{9   => {:text => 'Strings (plectral) with Taonga Puoro',        :conditions => WorkCategory.find_by_desc('Strings (plectral)')}},
		{10  => {:text => 'Woodwind with Taonga Puoro',                  :conditions => WorkCategory.find_by_desc('Woodwind')}},
		{11  => {:text => 'Brass with Taonga Puoro',                     :conditions => WorkCategory.find_by_desc('Brass')}},
		{12  => {:text => 'Percussion with Taonga Puoro',                :conditions => WorkCategory.find_by_desc('Percussion')}},
		{13  => {:text => 'Mixed Chamber Groups with Taonga Puoro',      :conditions => WorkCategory.find_by_desc('Mixed Chamber Groups')}},
		{14  => {:text => 'Sonic Art with Taonga Puoro',                 :conditions => WorkCategory.find_by_desc('Sonic Art')}},
		{15  => {:text => 'Vocal Solo with Taonga Puoro',                :conditions => WorkCategory.find_by_desc('Vocal Solo')}},
		{16  => {:text => 'Vocal Ensemble with Taonga Puoro',            :conditions => WorkCategory.find_by_desc('Vocal Ensemble')}},
		{17  => {:text => 'Choral Music with Taonga Puoro',              :conditions => WorkCategory.find_by_desc('Choral Music')}},
		{18  => {:text => 'Vocal Music for the Stage with Taonga Puoro', :conditions => WorkCategory.find_by_desc('Vocal Music for the Stage')}}		 
               ]
  }
  
  INVERTED_TAONGA_PUORO_FACETS = invert_facets(TAONGA_PUORO_FACETS[:facets])
  
  # WR#52205
  MUSIC_FOR_STAGE_FACETS = {
	  :solr_field => :music_for_stage_special_subcategory_ids_for_solr_t,
	  :facets => [
		  {1   => {:text => 'Opera and Operetta',  :conditions => WorkSubcategory.find_by_desc('Opera and Operetta')}},
		  {2   => {:text => 'Musical',             :conditions => WorkSubcategory.find_by_desc('Musical')}},
		  {3   => {:text => 'Music Theatre',       :conditions => WorkSubcategory.find_by_desc('Music Theatre')}},
		  {4   => {:text => 'Music for Theatre',   :conditions => WorkSubcategory.find_by_desc('Incidental Music for Theatre')}},
		  {5   => {:text => 'Music for Dance',     :conditions => WorkSubcategory.find_by_desc('Music for Dance/Ballet')}},
				 ]
	}
  
  INVERTED_MUSIC_FOR_STAGE_FACETS = invert_facets(MUSIC_FOR_STAGE_FACETS[:facets])
    
  def self.special_subcategories(work, facets_array)
    results = []
	
	facets_array = facets_array
	
	for facet_to_check_for in facets_array
	  key = facet_to_check_for.keys[0]
	  condition = facet_to_check_for[key][:conditions]	
	  #RAILS_DEFAULT_LOGGER.debug "DEBUG: facets condition #{condition}"
	  if condition.class == WorkSubcategory
	  	results << key if work.all_subcategories.include?condition
	    # RAILS_DEFAULT_LOGGER.debug "DEBUG: facets ws key #{key}"
	  
	  elsif condition.class == WorkCategory
	    #RAILS_DEFAULT_LOGGER.debug "DEBUG: facets wc work.main_category #{work.main_category}"
		results << key if condition == work.main_category.work_category
		#RAILS_DEFAULT_LOGGER.debug "DEBUG: facets wc key #{key}"
	  end
	end
	
	return results
  end
 
  
  def event_facet_query(the_login, search_term, facet_options_provided)
 
    options = {
      :page          => 1,
      :rows          => 10,
      :facet         => true,
      :facet_zeroes  => false,
      :fq            => [],
      :facet_fields  => [ 
                          :country_id_for_solr_s,
                          :nz_regions_facet_for_solr_t,
                          :facet_year_group_for_solr_t,
                          :previous_year_sub_group_for_solr_t,
                          :event_type_id_t,
						  :related_distinction_types_for_solr_t
                         ],
      :facet_queries => [],
      :q => []
    }
    
    #default facet options are expressed here - this ensures the key exists
    default_options = {
      :region_key => nil,
      :country_key => nil,
      :year_group_key => nil,
      :month_key => nil,
      :prev_year_subgroup_key => nil,
      :event_type_key => nil,
      :day_key => nil, 
	    :distinction_type_key => nil,
    }

    
    
    
    #techinque from http://wiki.rubyonrails.com/rails/pages/RailsBestPractices
    facet_options = options.merge facet_options_provided
     
      fields = [
        {:name => 'event_title_for_solr_t', :boost => 4},
        {:name => 'general_note_for_solr_t'}
      ]
      
      
    query=''
    
    if search_term == ""
      lucene_query = "type_t:Event"
    else
      lucene_query = FinderHelper.build_query(Event, search_term, fields)
    end

    #Do we have a virginal query?  Check for no search text, no restrictions in fq, no facet keys chosen
    st_blank = search_term.blank?
    fq_len_is_zero = (options[:fq].length == 0)
    option_keys_blank = check_if_star_key_all_blank(facet_options)
    quicklink_search = (facet_options[:q].length > 0)
    virgin_query = ((st_blank) && (fq_len_is_zero) && option_keys_blank && !quicklink_search) #and option_keys_blank
   
    
    # gq = generate_contributor_born_facet_query(facet_options[:born_key])
  #   last_name_opts = generate_contributor_last_name_facet_query(facet_options[:region_key])
     nz_region_opts = generate_facet_query(REGION_DETAILS,facet_options[:region_key])
     country_opts = generate_facet_query(ALL_COUNTRY_FACET_DETAILS,facet_options[:country_key])
     year_group_opts = generate_facet_query(YEAR_GROUP_DETAILS, facet_options[:year_group_key])
     
     
     day_k = facet_options[:day_key]
     month_k = facet_options[:month_key]
     year_k = nil
     key = facet_options[:year_group_key]
     if key == 'current'
       year_k = Time.now.year.to_s
     elsif key == 'next'
       year_k = (Time.now + 1.year).year.to_s
     end
     
     RAILS_DEFAULT_LOGGER.debug "DAYK:#{day_k}"
     RAILS_DEFAULT_LOGGER.debug "MONTHL:#{month_k}"
     RAILS_DEFAULT_LOGGER.debug "YEAR K:#{year_k}"
     
     time_opts = generate_time_facet_query(day_k,month_k,year_k)
     
     RAILS_DEFAULT_LOGGER.debug time_opts.to_yaml
     
     
     
     #day_opts = generate_facet_query(ALL_DAYS_OF_MONTHS, facet_options[:day_key], append_comma = true)
    # RAILS_DEFAULT_LOGGER.debug "DAY OPTS:#{day_opts}"
#     asdfsdfds
     
     
     
     previous_year_groups = generate_facet_query(FacetHelper.create_event_facet_previous_years_array, 
                                                         facet_options[:prev_year_subgroup_key])
     event_type_opts = generate_facet_query(ALL_EVENT_TYPES_FACET,
                                            facet_options[:event_type_key])
	 distinction_type_opts = generate_facet_query(OPPORTUNITY_DISTINCTION_TYPES_FACET, facet_options[:distinction_type_key])	 
    

     
     gq =concatentate_facet_hashes([nz_region_opts,
                                    country_opts,
                                    time_opts,
                                    previous_year_groups,
                                    event_type_opts,
                                    year_group_opts,
									distinction_type_opts
                                     ])
     
    
    #RAILS_DEFAULT_LOGGER.debug "****MREGED:#{gq.class}, #{gq.to_yaml}"


     facet_query = gq[:facet_queries]
     #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES ARE #{facet_query}"
     #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES CLASS ARE #{facet_query.class}"
     #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES LENGTH ARE #{facet_query.length}"
     facet_options[:facet_queries] = facet_query
     facet_options[:fq] = gq[:fq]
     

    
     
     #If no search term, alphabetise results
     #if search_term.blank?
       
     facet_options[:sort]= 'event_start_for_solr_s desc'
       
     #end

     #RAILS_DEFAULT_LOGGER.debug "facet queries of class #{ options[:facet_queries].length}, #{ options[:facet_queries][0].class}"


     #RAILS_DEFAULT_LOGGER.debug "LUC QUERY:"+lucene_query
     #  @results, @paginator  = solr_query(lucene_query, facet_queries)

     #RAILS_DEFAULT_LOGGER.debug "GQ:#{gq.to_yaml}"
     
     
     
    # #RAILS_DEFAULT_LOGGER.debug "FACET QUERIES:#{facet_queries.to_yaml}"
     #RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS:#{facet_options.to_yaml}"
    #

     lucene_query = append_status_filter_if_required(the_login, lucene_query)
    lucene_query = FinderHelper.make_query_more_exact(lucene_query) 
      logger.debug "LUCENE QUERY:#{lucene_query}"

      @results, @paginator  = solr_query(lucene_query, facet_options)
      RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS SELECTED:" + facet_options[:fq].to_yaml
      RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS PROVIDED:" + facet_options_provided.to_yaml
      RAILS_DEFAULT_LOGGER.debug "RESULTS:#{@results.to_yaml}"


      if virgin_query
          @results[:docs] = []
       end
      [@results, @paginator]
    
  end
  
  
  
  #Create the faceted query required for people
  # facet_options can contain the following parameters.  Note that if they are nil all of the facets for
  # that particular type shall be included
  # If both the text/facets chosen queries are empty return only the root facets (ie set docs returned to nil)
  
  def people_facet_query(the_login, search_term, facet_options_provided)
    options = {
      :page          => 1,
      :rows          => 10,
      :facet         => true,
      :facet_zeroes  => false,
      :fq            => [],
      :facet_fields  => [:role_type_id_for_solr_t, 
                         :fully_represented_for_solr_s,
                         :inside_nz_for_solr_s,
                         :outside_nz_for_solr_s,
                         :countries_facet_for_solr_s,
                         :nz_regions_facet_for_solr_t,
                         :role_type_group_for_solr_s,
                         :year_of_creation_range_for_solr_s,
                         :last_name_range_for_solr_s,
                         :role_type_id_for_solr_t,
						 :awards_received_for_solr_t
                         ],
      :facet_queries => []
    }
    
    #default facet options are expressed here - this ensures the key exists.  In effect nil means ALL
    default_options = {
      :born_key => nil,
      :last_name_key => nil,
      :person_organisation_key => nil,
      :fully_represented_key => nil,
      :inside_nz_key => nil,
      :outside_nz_key => nil,
      :country_facet_key => nil,
      :region_facet_key => nil,
      :role_group_key => nil,
      :role_type_key => nil, # an individual role, e.g. funder,
      :status => nil,
	  :distinction_type_key => nil
    }
    
    
    
    #techinque from http://wiki.rubyonrails.com/rails/pages/RailsBestPractices
    facet_options = options.merge facet_options_provided
    
    #log
    #RAILS_DEFAULT_LOGGER.debug facet_options.to_yaml
 
    
    fields = [
      {:name => 'known_as_for_solr_t', :boost => 4},
      {:name => 'description_for_solr_t', :boost => 2.5},
      {:name => 'profile_for_solr_t', :boost => 0.6},
      {:name => 'pull_quote_for_solr_t'}
      ]
      
    query=''
   # lucene_query = FinderHelper.build_query(RoleContactinfo, query, fields)
   #Note OR is needed here as we are searching for the same text in several fields
    #OLD BROKEN lucene_query = FinderHelper.build_advanced_query(Contributor, fields,search_term,query_param_boolean='OR')
    
    if search_term == ""
      lucene_query = "type_t:Contributor"
    else
      lucene_query = FinderHelper.build_query(Contributor, search_term, fields)
    end
    
    lucene_query = FinderHelper.make_query_more_exact(lucene_query)
     
    #As per WR50270, filter to only include those contributors with known_as
    #You can check those affected by doing this in a Ruby console
    #Contributor.find_all_by_known_as(nil).map{|c|c.description}
    lucene_query << " has_known_as_for_solr_t:1"
    
    #Do we have a virginal query?  Check for no search text, no restrictions in fq, no facet keys chosen
    st_blank = search_term.blank?
    fq_len_is_zero = (options[:fq].length == 0)
    option_keys_blank = check_if_star_key_all_blank(facet_options)  
    virgin_query = ((st_blank) && (fq_len_is_zero) && option_keys_blank) #and option_keys_blank
    

   # gq = generate_contributor_born_facet_query(facet_options[:born_key])
    last_name_opts = generate_contributor_last_name_facet_query(facet_options[:last_name_key])
    creation_year_opts = generate_contributor_born_facet_query(facet_options[:born_key])
    person_org_opts = generate_contributor_person_org_query(facet_options[:person_organisation_key])
    fully_rep_opts = generate_facet_query(FULL_REPRESENTED_DETAILS,facet_options[:fully_represented_key])
    inside_nz_opts = generate_facet_query(INSIDE_NZ_DETAILS,facet_options[:inside_nz_key])
    outside_nz_opts = generate_facet_query(OUTSIDE_NZ_DETAILS,facet_options[:outside_nz_key])
    country_opts = generate_facet_query(COUNTRY_DETAILS,facet_options[:country_facet_key])
    nz_region_opts = generate_facet_query(REGION_DETAILS,facet_options[:region_facet_key])
    role_group_opts = generate_facet_query(ROLE_TYPE_GROUP_DETAILS, facet_options[:role_group_key])
    role_opts = generate_facet_query(ALL_ROLE_TYPES_FACET, facet_options[:role_type_key])
    status_opts = generate_facet_query(FULL_REPRESENTED_DETAILS, facet_options[:status])
    distinction_type_opts = generate_facet_query(ALL_DISTINCTION_TYPES_FACET, facet_options[:distinction_type_key])
    
    gq =concatentate_facet_hashes([last_name_opts,
                                    creation_year_opts,
                                    person_org_opts,
                                    fully_rep_opts,
                                    inside_nz_opts,
                                    outside_nz_opts,
                                    country_opts,
                                    nz_region_opts,
                                    role_group_opts,
                                    role_opts,
                                    status_opts,
									distinction_type_opts
                                    ])
    #RAILS_DEFAULT_LOGGER.debug "****MREGED:#{gq.class}, #{gq.to_yaml}"
    
    facet_query = gq[:facet_queries]
    #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES ARE #{facet_query}"
    #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES CLASS ARE #{facet_query.class}"
    #RAILS_DEFAULT_LOGGER.debug "FACET QUERY VALUES LENGTH ARE #{facet_query.length}"
    facet_options[:facet_queries] = facet_query
    facet_options[:fq] = gq[:fq]
    
    facet_options[:sort]= 'facet_sort_field_for_solr_s asc' if search_term.blank?
    
    #RAILS_DEFAULT_LOGGER.debug "facet queries of class #{ options[:facet_queries].length}, #{ options[:facet_queries][0].class}"

    
    #RAILS_DEFAULT_LOGGER.debug "LUC QUERY:"+lucene_query
    #  @results, @paginator  = solr_query(lucene_query, facet_queries)
 
    #RAILS_DEFAULT_LOGGER.debug "GQ:#{gq.to_yaml}"
   # #RAILS_DEFAULT_LOGGER.debug "FACET QUERIES:#{facet_queries.to_yaml}"
    #RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS:#{facet_options.to_yaml}"
   #

   lucene_query = append_status_filter_if_required(the_login, lucene_query)
   logger.debug "LUCENE QUERY:#{lucene_query}"
   
    
     @results, @paginator  = solr_query(lucene_query, facet_options)
     #RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS SELECTED:" + facet_options[:fq].to_yaml
     #RAILS_DEFAULT_LOGGER.debug "FACET OPTIONS PROVIDED:" + facet_options_provided.to_yaml
     
     @lq = lucene_query
     
     if virgin_query
         @results[:docs] = []
         
      end
     [@results, @paginator]
  end
  
  
  
  #create a hash of the {:solr_field => :field_name, :facets => N*{:text => 'Text', :lucene_query='*'}}
  def self.create_all_countries_facet
    facets = {}
    for country in Country.find(:all, :order => :country_name)
      
      facets[country.country_id.to_s] = {:text => country.country_name, :lucene_query => country.country_id.to_s}
    end
    
    return {
      :solr_field => :country_id_for_solr_s,
      :facets => facets
    }
  end


  #create a hash of the {:solr_field => :field_name, :facets => N*{:text => 'Text', :lucene_query='*'}}
  def self.create_role_types_facet_hash
    facets = {}
    for role_type in RoleType.find(:all)
      facets[role_type.role_type_id.to_s] = {:text => role_type.role_type_desc, :lucene_query => role_type.role_type_id.to_s}
    end
    
    return {
      :solr_field => :role_type_id_for_solr_t,
      :facets => facets
    }
  end

  def self.create_distinction_types_facet_hash(solr_field)
    facets = {}
    for distinction_type in DistinctionType.find(:all)
      facets[distinction_type.distinction_type_id.to_s] = {:text => distinction_type.distinction_type_name, :lucene_query => distinction_type.distinction_type_id.to_s}
    end
    
    # special case for 'Opportunity' Event subfacet
	if solr_field.match('related_distinction_types_for_solr_t')
	  facets['other'] = {:text => 'Other', :lucene_query => 'other'}
    end
	
	return {
      :solr_field => solr_field,
      :facets => facets
    }
  end  
  
  #create a hash of the {:solr_field => :field_name, :facets => N*{:text => 'Text', :lucene_query='*'}}
  def self.create_event_types_facet_hash
    facets = {}
    for event_type in EventType.find(:all)
      facets[event_type.event_type_id.to_s] = {:text => event_type.event_type_desc, :lucene_query => event_type.event_type_id.to_s}
    end

    return {
      :solr_field => :event_type_id_t,
      :facets => facets
    }
  end
  
  
  #create a hash of the {:solr_field => :field_name, :facets => N*{:text => 'Text', :lucene_query='*'}}
  def self.create_days_of_months_facet_hash
    a_leap_year = Time.parse('1/1/2004') #Remember Feb 29!
    facets = {}
    
    for i in 0..365
        dm_key = a_leap_year.month*100+a_leap_year.day
        facets[dm_key.to_s] = {:text => a_leap_year.day.ordinalize, :lucene_query => dm_key.to_s}
        a_leap_year = a_leap_year + 1.day
    end
    
    return {
      :solr_field => :days_for_solr_t,
      :facets => facets
    }
  end
  
  
  def self.day_month_keys
    a_leap_year = Time.parse('1/1/2004') #Remember Feb 29!
    result = []
    
    for i in 0..365
      result << (dm_key = a_leap_year.month*100+a_leap_year.day).to_s
      a_leap_year = a_leap_year + 1.day
    end
    result
  end


#event_type_id_t:
  
  
  
  ALL_COUNTRY_FACET_DETAILS = FacetHelper.create_all_countries_facet
  
  ALL_ROLE_TYPES_FACET = FacetHelper.create_role_types_facet_hash
  
  ALL_DISTINCTION_TYPES_FACET = FacetHelper.create_distinction_types_facet_hash('awards_received_for_solr_t')
  
  OPPORTUNITY_DISTINCTION_TYPES_FACET = FacetHelper.create_distinction_types_facet_hash('related_distinction_types_for_solr_t')
  
  ALL_EVENT_TYPES_FACET = FacetHelper.create_event_types_facet_hash
  
  ALL_DAYS_OF_MONTHS = FacetHelper.create_days_of_months_facet_hash
  
  DAY_MONTH_KEYS = FacetHelper.day_month_keys
  
  private
  


  
  

  

  #The keys are
  #  - :text is the English text that appears on the site
  #  - :
  BORN_FACET_DETAILS = {
    :solr_field => :year_of_creation_range_for_solr_s,
    :facets => {
      '0-1899' => {:text => 'Before 1900',:lucene_query => "0-1899" },
      '1900-1949' => {:text => '1900 to 1949',:lucene_query => "1900-1949" },
      '1950-1959' => {:text => '1950 to 1959',:lucene_query => "1950-1959" },
      '1960-1969' => {:text => '1960 to 1969',:lucene_query => "1960-1969" },
      '1970-1979' => {:text => '1970 to 1979',:lucene_query => "1970-1979" },
      '1980-1989' => {:text => '1980 to 1989',:lucene_query => "1980-1989" },
      '1990-1999' => {:text => '1990 to 1999',:lucene_query => "1990-1999" },
      '2000-2009' => {:text => '2000 to 2009',:lucene_query => "2000-2009" }
    }
  }
  
  
  
  
  
  ROLE_TYPE_GROUP_DETAILS = {
    :solr_field => :role_type_group_for_solr_s,
    :facets => {
      'composer' => {:text => 'Composers', :lucene_query => "composer"},
      'performer' => {:text => 'Performers', :lucene_query => "performer"},
      'commissioner' => {:text => 'Commissioners', :lucene_query => "commissioner"},
      'presenter' => {:text => 'Presenters', :lucene_query => "presenter"},
      'publisher' => {:text => 'Publishers', :lucene_query => "publisher"},
      'writer' => {:text => 'Writers', :lucene_query => "writer"}
    }
  }
  
  
 
  
  PERSON_ORG_ORG_DETAILS = {
    :solr_field => :person_or_organisation_for_solr_s,
    :facets => {
        'People' => {:text => 'People', :lucene_query => 'p'},
        'Organisation' => {:text => 'Organisation', :lucene_query => 'o'}
    }
  }
  

  
  COUNTRY_DETAILS = {
    :solr_field => :countries_facet_for_solr_s,
    :facets => {
        'unitedkingdom' => {:text => 'United Kingdom', :lucene_query => 'unitedkingdom'},
        'canada' => {:text => 'Canada', :lucene_query => 'canada'},
        'australia' => {:text => 'Australia', :lucene_query => 'australia'},
        'unitedstates' => {:text => 'United States', :lucene_query => 'unitedstates'},
        'other' => {:text => 'Other', :lucene_query => 'other'}
      
    }
  }
  
  
  
  MONTH_DETAILS = {
    :solr_field => :months_for_solr_t,
    :facets => {
      '1' => {:text => 'January', :lucene_query => '1'},
      '2' => {:text => 'February', :lucene_query => '2'},
      '3' => {:text => 'March', :lucene_query => '3'},
      '4' => {:text => 'April', :lucene_query => '4'},
      '5' => {:text => 'May', :lucene_query => '5'},
      '6' => {:text => 'June', :lucene_query => '6'},
      '7' => {:text => 'July', :lucene_query => '7'},
      '8' => {:text => 'August', :lucene_query => '8'},
      '9' => {:text => 'September', :lucene_query => '9'},
      '10' => {:text => 'October', :lucene_query => '10'},
      '11' => {:text => 'November', :lucene_query => '11'},
      '12' => {:text => 'December', :lucene_query => '12'},     
    }
  }
  
 
  REGION_DETAILS = {
    :solr_field => :nz_regions_facet_for_solr_t,
    :facets => {
      '2' => {:text => 'Auckland', :lucene_query => '2'},
      '4' => {:text => 'Bay of Plenty', :lucene_query => '4'},
      '14' => {:text => 'Canterbury', :lucene_query => '14'},
      '5' => {:text => 'East Coast', :lucene_query => '5'},
      '9' => {:text => 'Hawkes Bay', :lucene_query => '9'},
      '19' => {:text => 'National', :lucene_query => '19'},
      '12' => {:text => 'Nelson-Marlborough', :lucene_query => '12'},
      '17' => {:text => 'North Island', :lucene_query => '17'},
      '1' => {:text => 'Northland', :lucene_query => '1'},
      '15' => {:text => 'Otago', :lucene_query => '15'},
      '6' => {:text => 'Rotorua-Taupo', :lucene_query => '6'},
      '18' => {:text => 'South Island', :lucene_query => '18'},
      '16' => {:text => 'Southland', :lucene_query => '16'},
      '7' => {:text => 'Taranaki', :lucene_query => '7'},
      '3' => {:text => 'Waikato', :lucene_query => '3'},
      '10' => {:text => 'Wairarapa', :lucene_query => '10'},
      '8' => {:text => 'Wanganui-Manawatu', :lucene_query => '8'},
      '11' => {:text => 'Wellington', :lucene_query => '11'},
      '13' => {:text => 'West Coast', :lucene_query => '13'},
    }
    
  }
  
  FULL_REPRESENTED_DETAILS = {
    :solr_field => :fully_represented_for_solr_s,
    :facets => {
        'fully_represented' => {:text => 'Fully Represented', :lucene_query => 'true'},
        'not_fully_represented' => {:text => 'Other composers', :lucene_query => 'false'}
    }
  }
  
  
  INSIDE_NZ_DETAILS = {
    :solr_field => :inside_nz_for_solr_s,
    :facets => {
        'inside_nz' => {:text => 'Inside New Zealand', :lucene_query => 'true'},
    }
  }
  
  OUTSIDE_NZ_DETAILS = {
    :solr_field => :outside_nz_for_solr_s,
    :facets => {
        'outside_nz' => {:text => 'Inside New Zealand', :lucene_query => 'true'},
    }
  }
  
  NAME_FACET_DETAILS={
    :solr_field => :last_name_range_for_solr_s,
    :facets => {
      'a' => {:text => 'A',:lucene_query => "a*" },
      'b' => {:text => 'B',:lucene_query => "b*" },
      'c' => {:text => 'C',:lucene_query => "c*" },
      'd-e' => {:text => 'D-E',:lucene_query => "[d* TO e*]" },
      'f-g' => {:text => 'F-G',:lucene_query => "[f* TO g*]" },
      'h-j' => {:text => 'H-J',:lucene_query => "[h* TO j*]" },
      'k-l' => {:text => 'K-L',:lucene_query => "[k* TO l*]" },
      'm' => {:text => 'M',:lucene_query => "m*" },
      'n-q' => {:text => 'N-Q',:lucene_query => "[n* TO q*]" },
      'r-s' => {:text => 'R-S',:lucene_query => "[r* TO s*]" },
      't-w' => {:text => 'T-W',:lucene_query => "[t* TO w*]" },
      'x-z' => {:text => 'X-Z',:lucene_query => "[x* TO z*]" },
	  'Other' => {:text => 'Other',:lucene_query => "(Other)" }
    }
  }
  
  
  YEAR_GROUP_DETAILS={
    :solr_field => :facet_year_group_for_solr_t,
    :facets => {
      'previous' => {:text => 'Previous Years',:lucene_query => "previous" },
      'none' => {:text => 'Not Specified',:lucene_query => "none" },
      'current' => {:text => 'This Year',:lucene_query => "current" },
      'next' => {:text => 'Next Year',:lucene_query => "next" },
      'future' => {:text => 'After Next year',:lucene_query => "future" }
     }
  }
  
  DAYS_IN_MONTH = {
    1 => 31,
    2 => 29,
    3 => 31,
    4 => 30, 
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
  }
  
  #Generate query hash for year contributor came to be 
  def generate_contributor_born_facet_query(born_key)
    generate_facet_query(BORN_FACET_DETAILS, born_key)
  end
  
  #Generate query hash for last name facet of a contributor
  def generate_contributor_last_name_facet_query(key)
    generate_facet_query(NAME_FACET_DETAILS, key)
  end
  
  def generate_contributor_person_org_query(key)
    generate_facet_query(PERSON_ORG_ORG_DETAILS,key)
  end
  
  
  #Generate the hashtable required for passing to the solr_query executor.  It contains
  #:facet_queries - queries to facet against
  #:fq - options already chosen (in SOLR form)
  def generate_facet_query(facet_details, facet_chosen_key, append_comma = false )
    #RAILS_DEFAULT_LOGGER.debug "== GENERATING CONTRIBUTOR FACET QUERY =="
    #RAILS_DEFAULT_LOGGER.debug "facet_chosen_key:#{facet_chosen_key}, is blank? #{facet_chosen_key.blank?}"
    result = {
      :fq => [],
      :facet_queries => []
    }
    

    if facet_chosen_key.blank?
      #We are faceting on a field so values will come back automatically from SOLR
      #In the case of custom queries these are provided
        
    #but if its provided and invalid throw an error
    elsif !facet_details[:facets].keys.include?(facet_chosen_key)
      raise ArgumentError, "The facet key chosen, namely #{facet_chosen_key} is not valid, it needs to appear in"+
                              facet_details[:facets].keys.join("*")
      
    #otherwise just add the relevant facet chosen
    else
      #RAILS_DEFAULT_LOGGER.debug "KEY:#{facet_chosen_key}"
      #RAILS_DEFAULT_LOGGER.debug facet_details[:facets]
      #RAILS_DEFAULT_LOGGER.debug facet_details[:facets][facet_chosen_key]
      lq = facet_details[:solr_field].to_s+':'+facet_details[:facets][facet_chosen_key][:lucene_query]
      lq << ',' if append_comma == true
      result[:fq] << lq
    end
      

    
      #RAILS_DEFAULT_LOGGER.debug "#{result.to_yaml}"
      #RAILS_DEFAULT_LOGGER.debug "RESULT IS OF CLASS #{result[:facet_queries].class}"
      #RAILS_DEFAULT_LOGGER.debug "RESULT IS OF FACET QUERY SIZE #{result[:facet_queries].length}"
    #RAILS_DEFAULT_LOGGER.debug "== /GENERATING CONTRIBUTOR FACET QUERY =="

    
    result
  end
  
  
  #Facet query
  #type_t: Event AND (
  #(event_start_for_solr_s:20080310)
  #OR
  #(event_finish_for_solr_s:20080310)
  #OR
  #(
  #event_start_for_solr_s:[00000000 TO 20080310]
  #AND
  #event_finish_for_solr_s:[20080310 TO 99999999]
  #)


  #)

  
  def facet_event_query_for_one_day(day, month, year)
    time_string = "#{month}/#{day}/#{year} 00:00"
    RAILS_DEFAULT_LOGGER.debug time_string
    le_day = FinderHelper.date_for_solr_ymd(Time.parse(time_string))
    
    query =  "(event_start_for_solr_s:#{le_day} "
    query << " OR event_finish_for_solr_s:#{le_day} OR "
    query << " ((event_start_for_solr_s:[00000000 TO #{le_day}]) AND "
    query << " (event_finish_for_solr_s:[#{le_day} TO 99999999]))"
    query << "\n)"
    query
  end
  
  
  
  #This is the case when a month is selected
  def generate_days_in_month_facet_query(month,year)
    days_in_month = DAYS_IN_MONTH[month.to_i]
    
    result = {
      :fq => [],
      :facet_queries => []
    }
    
    
    result[:fq] << [date_query_for_in_month(month,year)] if !month.blank?
    
    
    for day in 1..days_in_month
      query = facet_event_query_for_one_day(day, month, year)
      result[:facet_queries] << query  
    end
    

  
    RAILS_DEFAULT_LOGGER.debug result.to_yaml
    
    result
    
  end
  
  
  
  #This is the case where an individual day has been selected
  def generate_single_day_facet_query(day,month,year)
    result = {
      :fq => [],
      :facet_queries => []
    }
    time_string = "#{month}/#{day}/#{year} 00:00"
    RAILS_DEFAULT_LOGGER.debug time_string
    le_day = FinderHelper.date_for_solr_ymd(Time.parse(time_string))
    
   # result[:fq] << [date_query_for_in_month(month,year)] if !month.blank?
    
    query = facet_event_query_for_one_day(day, month, year)
    
    #Restrict results to this one day
    result[:fq] << query
    
    result
    
    
  end
  
  
  
  
  def generate_months_in_year_facet_query(year)
    result = {
      :fq => [],
      :facet_queries => []
    }
    

    #This is the case where we wish to facet by all the month 
    
      #Add the month facet query
      for moth in 1..12
        result[:facet_queries] << date_query_for_in_month(moth, year)
      end
      
    
    
    logger.debug result.to_yaml
    
    
    result
  end
  
  
  
  def generate_time_facet_query(day,month,year)
    result = {
      :fq => [],
      :facet_queries => []
    }
    
    #One day selected
    if (!day.blank? && !month.blank? && !year.blank?)
      
      result = generate_single_day_facet_query(day,month,year)
    #One month selected
    elsif (!month.blank? && !year.blank?)
      result = generate_days_in_month_facet_query(month,year)
    #Year group selected
  
    elsif (!year.blank?)
      result = generate_months_in_year_facet_query(year)
    end
    
    result
  end
  
  
  def date_query_for_in_month(month,year)
    days = DAYS_IN_MONTH[month.to_i]
    start_day = FinderHelper.date_for_solr_ymd(Time.parse("#{month}/1/#{year} 00:00"))
    
    time_string = "#{month}/#{days}/#{year} 00:00"
    RAILS_DEFAULT_LOGGER.debug time_string
    end_day = FinderHelper.date_for_solr_ymd(Time.parse(time_string))

    query =  "(event_start_for_solr_s:[#{start_day} TO #{end_day}] "
    query << " OR event_finish_for_solr_s:[#{start_day} TO #{end_day}] OR "
    query << " ((event_start_for_solr_s:[00000000 TO #{start_day}]) AND "
    query << "(event_finish_for_solr_s:[#{end_day} TO 99999999]))"
    query << "\n)"
    query
  end
  
  
  #Remove dupes and empty values
  def self.remove_duplicates_and_blank(input_array)
    result = []
    for element in input_array
      result << element if !element.blank?
    end
    result.uniq
  end
  
  
=begin
FULL_REPRESENTED_DETAILS = {
  :solr_field => :fully_represented_for_solr_s,
  :facets => {
      'fully_represented' => {:text => 'Fully Represented', :lucene_query => 'true'},
      'not_fully_represented' => {:text => 'Other composers', :lucene_query => 'false'}
  }
}

=end
  def self.create_event_facet_previous_years_array
    result = { :solr_field => :previous_year_sub_group_for_solr_t}
    facet_result = {}
    previous_years_facets = event_facet_previous_years(Time.now.year)
    for key in previous_years_facets.keys.sort
      facet_result[key.to_s] =  {:text => FacetViewHelper.human_readable_double_year(key.to_s), :lucene_query => key.to_s}
    end
    result[:facets] = facet_result
    result
  end
  
  
  
  @@calculated_facets = {} #global mapping to save recalculation
  
  
  #years are broken down like this
  # - next year
  # - this year
  # - last year
  # at least 1 of the form 2005,2004,2003... until a multiple of 5 is reached
  # These values are mapped to an evalable ruby statement with the year in it, variable y
  #Note the keys are in the form YYYYYYYY, e.g. 20072007 represents 2007, 00001994 is before 1995 etc
  def self.event_facet_previous_years(base_year)
    result = @@calculated_facets[base_year]
    if result.blank?
      result = {}

      last_year = base_year - 1
      #RAILS_DEFAULT_LOGGER.debug "LAST _YEAR:#{last_year}"
        
        
      result[last_year.to_s+last_year.to_s] = "y==#{last_year}" 
    
      n_single_years = (last_year -1) % 5
  
      n_single_years = 5 if n_single_years == 0 
        #RAILS_DEFAULT_LOGGER.debug "N SINGLE YEARS:#{n_single_years}"
      
      
      #start to end is in loop order terms, so 2005 .. 2000 for example
      start_year = last_year
      end_year = last_year - n_single_years - 1
    
        #RAILS_DEFAULT_LOGGER.debug "START YEAR, END YEAR = #{start_year} .. #{end_year}"
      year = start_year
      while year > end_year
        year = year - 1
        #RAILS_DEFAULT_LOGGER.debug "ADDING #{year}"
        result[year.to_s+year.to_s] = "y==#{year.to_s}"
      end
    
      y5_end = end_year - 1
      y5_start = y5_end - 4
      key = "#{y5_start}#{y5_end}"
      result[key] = "y>= #{y5_start} and y <= #{y5_end}"
      
      key = "1000#{y5_start}"
      result[key] = "y < #{y5_start}"
      
      @@calculated_facets[base_year] = result
    end
    
    result
    
  end
  

  private
  #Facet queries for SOLR are in teh form {:fq => [array], :facet_queries => [array]}
  def concatentate_facet_hashes(array_of_facet_queries)
    result = {
      :fq => [],
      :facet_queries => []
    }
    for facet_query_hash in array_of_facet_queries
      result[:fq] = result[:fq] + facet_query_hash[:fq]
      result[:facet_queries] = result[:facet_queries] + facet_query_hash[:facet_queries]
    end
    
    result
  end
  
  
  #In order to check for a virgin query it is necessary to check that user keys of the form
  #*_key are not blank - as its possible to facet by not using options[:fq] but instead use the facet fields
  #If a single non blank key is found we do not have a virgin query
  
  def check_if_star_key_all_blank(the_options)
    #RAILS_DEFAULT_LOGGER.debug "CHECKING STAR KEYS"
    result = true
    for key in the_options.keys
    #  RAILS_DEFAULT_LOGGER.debug "CHECKING KEY:#{key.to_s}"
      if key.to_s.ends_with?("_key")
        if the_options[key] != nil
      #    RAILS_DEFAULT_LOGGER.debug "KEY #{key} is not blank"
          result = false
          break
        end
      end 
    end
   # RAILS_DEFAULT_LOGGER.debug "/CHECKING STAR KEYS"
    result
  end
  
#These have been found by hand, slowly and painfully.

#Note concepts can be both parents and children, so they may appear twice.  All we have to go on
#is a text phrase in a spreadsheet uch as "NZ Birds"
TH_IN=[ConceptType::THEME, ConceptType::INFLUENCE]
GE_IN=[ConceptType::GENRE, ConceptType::INFLUENCE]



#To add to the fun we have work subcategories in the mix
FOR_EDUCATION_1 = WorkSubcategory.find(131)
#FOR_EDUCATION_2 = WorkSubcategory.find(168) # WR#59124 - deprecated


SOUND_DESIGN_1 = Concept.find(522)
SOUND_DESIGN_2 = Concept.find(723)

#TV_1 = WorkSubcategory.find(169)  # WR#59124 - deprecated
TV_2 = WorkSubcategory.find(180)

#DB1 = WorkSubcategory.find(165)  # WR#59124 - deprecated
DB2 = WorkSubcategory.find(179)

THEATRE=Concept.find(843)

MULTIMEDIA_EL = WorkSubcategory.find(136)
ELECTRO_EL = WorkSubcategory.find(137)





SACRED = WorkSubcategoriesHelper.find_by_name('Sacred')


NZ_TEXT = WorkSubcategoriesHelper.find_by_name('New Zealand Text')


# For Taonga Pouro
# WR#52688 - Taonga Puoro results are to include works with additional subcategory of 'includes taonga puoro' 
# and also concept of Taonga puoro (genre)
TAONGA = WorkSubcategoriesHelper.find_by_name('Taonga Puoro').concat(ConceptsHelper.find_by_text_and_type('Taonga Puoro', [ConceptType::GENRE]))

# WR#52688 - Maori Music and Culture: Te Reo (language) facet - drawn from language = Maori (on expressions) 
TE_REO = Language.find(:all, :select => 'language_id', 
	:conditions => ['language_name ilike (?)', '%maori%'])

# Music in Education
FOR_ED_USE = WorkSubcategoriesHelper.find_by_name('For educational use')
# WR#52688 - Music with resources - Works which are linked by 'is described by' FRBR relationship to a 
# resource where where resouce type = education resource
MUSIC_WITH_RESOURCES = ResourceType.find(:all, :select => 'resource_type_id', 
	:conditions => ['resource_type_desc ilike (?)', '%education resource%'] )

DANCE_BALLET_WSC = WorkSubcategoriesHelper.find_by_name('Music for Dance/Ballet')
INCIDENTAL_FOR_THEATRE_WSC = (
WorkSubcategoriesHelper.find_by_name('Incidental music for theatre')+
WorkSubcategoriesHelper.find_by_name('Theatrical Elements')
).flatten

FILM_TV_WSC = WorkSubcategoriesHelper.find_by_name('Music for Film')
SOUND_DESIGN = ConceptsHelper.find_by_text_and_type("Sound Design", [ConceptType::GENRE])


  
BIRDS_NZ = ConceptsHelper.find_by_text_and_type("Birds - NZ", TH_IN)
LANDSCAPE_NZ = ConceptsHelper.find_by_text_and_type("Birds - NZ", TH_IN)
CULTURE_NZ = (
  ConceptsHelper.find_by_text_and_type('People - NZ', TH_IN)+
  ConceptsHelper.find_by_text_and_type('Art and Literature - NZ', TH_IN)+
  ConceptsHelper.find_by_text_and_type('Urban - NZ', TH_IN)
).flatten


=begin
ask scilla 

 concept_id | concept_type_id |      concept_name       
------------+-----------------+-------------------------
        494 |               1 | Kaupapa (protest) music
        527 |               2 | Kaupapa - protest
        660 |               2 | Kaupapa - protest
        695 |               2 | Kaupapa (protest) music
        728 |               3 | Kaupapa - protest
        852 |               3 | Kaupapa - protest
        
=end
HISTORY_NZ =  (
  ConceptsHelper.find_by_text_and_type('History - NZ', TH_IN)+
  ConceptsHelper.find_by_text_and_type('Kaupapa', TH_IN)
).flatten

FLORA_FAUNA_NZ = ConceptsHelper.find_by_text_and_type('Flora and Fauna - NZ', TH_IN)
SEA_AND_WATER_NZ = ConceptsHelper.find_by_text_and_type('Sea and Water - NZ', TH_IN)
ANTARCTICA = ConceptsHelper.find_by_text_and_type('Antarctica', TH_IN)

MOTEATEA_KARANGA = (
  ConceptsHelper.find_by_text_and_type('Moteatea', GE_IN) + 
  ConceptsHelper.find_by_text_and_type('Karanga', GE_IN) 
  ).flatten
  
IWI = ConceptsHelper.find_by_text_and_type('Iwi - people', TH_IN)
PURAKAU = ConceptsHelper.find_by_text_and_type('Purakau - legends', TH_IN)
WAIATA = ConceptsHelper.find_by_text_and_type('Waiata', TH_IN)
HAKA = ConceptsHelper.find_by_text_and_type('Haka', TH_IN)
KAUPAPA = ConceptsHelper.find_by_text_and_type('Kaupapa', TH_IN)
  
WEDDING = ConceptsHelper.find_by_text_and_type('Wedding', TH_IN)
EASTER = ConceptsHelper.find_by_text_and_type('Easter', TH_IN)
CHRISTMAS = ConceptsHelper.find_by_text_and_type('Christmas', TH_IN)
ANNIVERSARY = ConceptsHelper.find_by_text_and_type('Anniversary', TH_IN)
HISTORICAL_EVENT = ConceptsHelper.find_by_text_and_type('Historical Event', TH_IN)
CELEBRATION = ConceptsHelper.find_by_text_and_type('Celebration', TH_IN)


INTERMEDIA = [Concept.find(521)] #specific in this case
JAZZ = [Concept.find(44), Concept.find(57)]
ELECTRO_ACOUSTIC_ELS = (
  WorkSubcategoriesHelper.find_by_name('Electroacoustic Elements')+
  WorkSubcategoriesHelper.find_by_name('Includes Live Electronics')+
  WorkSubcategoriesHelper.find_by_name('Electroacoustic Elements')
)

MUSIC_WITH_ETHNIC_INSTRUMENTS = WorkSubcategoriesHelper.find_by_name('Includes Ethnic Instruments')
VAR_OR_UNSPEC_INST = WorkSubcategoriesHelper.find_by_name('Unspecified or variable instrumentation')
MUSIC_WITH_FOUND_INST = WorkSubcategoriesHelper.find_by_name('Music for found instruments')
MUSIC_WITH_HISTORIC_INST = WorkSubcategoriesHelper.find_by_name('Includes Historic Instruments')
MUSIC_WITH_MULTIMEDIA_ELEMENTS = WorkSubcategoriesHelper.find_by_name('Multimedia Elements')
MUSIC_WITH_IMPROVISESD_ELEMENTS = WorkSubcategoriesHelper.find_by_name('Improvised Elements')
MUSIC_WITH_SPOKEN_WORD = WorkSubcategoriesHelper.find_by_name('Includes Spoken Word')
SYMPHONIES= WorkSubcategoriesHelper.find_by_name('Symphony')
CONCERTOS = WorkSubcategoriesHelper.find_by_name('Concerto')
PIANO_TRIOS = WorkSubcategoriesHelper.find_by_name('Piano trio')
PIANO_QUARTETS = WorkSubcategoriesHelper.find_by_name('Piano quartet')
SONATAS = WorkSubcategoriesHelper.find_by_name('Sonatas')




  #The top level keys are included in the URL, e.g. ?popular_parent=special
  POPULAR_FACETS = {
    :nz => {
      :text => "New Zealand Culture and Music",
      :subfacets => [
        {1 => {:text => "Birds", :conditions => BIRDS_NZ}},
        {2 => {:text => "Landscape", :conditions => LANDSCAPE_NZ}},
        {3 => {:text => "Culture", :conditions => CULTURE_NZ}},
        {4 => {:text => "New Zealand Text", :conditions => NZ_TEXT}},
        {5 => {:text => "History", :conditions => HISTORY_NZ}},
        {6 => {:text => "Flora and Fauna", :conditions => FLORA_FAUNA_NZ}},
        {7 => {:text => "Sea and Water", :conditions => SEA_AND_WATER_NZ}},
        {8 => {:text => "Antarctica", :conditions => ANTARCTICA}}
      ]
    },
    
    :maori => {
      :text => "Maori Culture and Music",
      :subfacets => [
 #       {20 => {:text => "Maori Culture", :conditions => [MC1, MC2]}},
        {9 => {:text => "Taonga Puoro", :conditions => TAONGA}},
        {10 => {:text => "Moteatea (song poetry)", :conditions => MOTEATEA_KARANGA}},
        {11 => {:text => "Iwi - People", :conditions => IWI}},
        {12 => {:text => "Purakau (legends)", :conditions => PURAKAU}},
        {13 => {:text => "Waiata (song)", :conditions => WAIATA}},
        {14 => {:text => "Haka (dance)", :conditions => HAKA}},
        {15 => {:text => "Kaupapa (protest)", :conditions => KAUPAPA}},
		{44 => {:text => "Te Reo (language)", :conditions => TE_REO}}	
      ]
    },
    
    :education => {
      :text => "Music in Education",
      :subfacets => [
    {16 => {:text => "For Educational Use",   :conditions => FOR_ED_USE}},
		{43 => {:text => "Music with resources",  :conditions => MUSIC_WITH_RESOURCES}}
      ]
    },
    


    :incidental => {
      :text => "Incidental / Film Music",
      :subfacets => [
        {17 => {:text => "Dance/Ballet", :conditions => DANCE_BALLET_WSC}},
        
        #Note - do we need some work subcats here also?
        {18 => {:text => "Theatre", :conditions => INCIDENTAL_FOR_THEATRE_WSC}},
        {19 => {:text => "Sound Design", :conditions => SOUND_DESIGN}},
        {20 => {:text => "Film/TV", :conditions =>FILM_TV_WSC}}
        ]
    },
    
    :special => {
      :text => "Occasional Music",
      :subfacets => [
        {21 => {:text => "Sacred", :conditions => SACRED}},
        {22 => {:text => "Wedding", :conditions => WEDDING}},
        {23 => {:text => "Easter", :conditions => EASTER}},
        {24 => {:text => "Christmas", :conditions => CHRISTMAS}},
        {25 => {:text => "Anniversary", :conditions => ANNIVERSARY}},
        {26 => {:text => "Historical Event", :conditions => HISTORICAL_EVENT}},
		{45 => {:text => "Celebration", :conditions => CELEBRATION}}
        ]
    },
    
    :sonic => {
      :text => "Other Useful Filters",
      :subfacets => [
          {28 => {:text => "Music with Ethnic Instruments", :conditions => MUSIC_WITH_ETHNIC_INSTRUMENTS}},
          {29 => {:text => "Variable or Unspecified Instrumentation", :conditions => VAR_OR_UNSPEC_INST}},
          {30 => {:text => "Music with Found Instruments", :conditions => MUSIC_WITH_FOUND_INST}},
          {31 => {:text => "Music with Historic Instruments", :conditions => MUSIC_WITH_HISTORIC_INST}},
          {32 => {:text => "Intermedia", :conditions => INTERMEDIA}},
          {33 => {:text => "Jazz - Music and Influences", :conditions => JAZZ}},
          {34 => {:text => "Music with Electroacoustic Elements", :conditions => ELECTRO_ACOUSTIC_ELS}},
          {35 => {:text => "Music with Multimedia Elements", :conditions => MUSIC_WITH_MULTIMEDIA_ELEMENTS}},
          {36 => {:text => "Music with Improvised Elements", :conditions => MUSIC_WITH_IMPROVISESD_ELEMENTS}},
          {37 => {:text => "Music with Spoken Word", :conditions => MUSIC_WITH_SPOKEN_WORD}},
          {38 => {:text => "Symphonies", :conditions => SYMPHONIES}},
          {39 => {:text => "Concertos", :conditions => CONCERTOS}},
          {40 => {:text => "Piano Trios", :conditions => PIANO_TRIOS}},
          {41 => {:text => "Piano Quartets", :conditions => PIANO_QUARTETS}},
          {42 => {:text => "Sonatas", :conditions => SONATAS}}
        ]
    }

    
    
  }







  def self.invert_subfacets
     result = {}
     p = FacetHelper::POPULAR_FACETS
      p.keys.map{|k| p[k][:subfacets].map{|a| result[a.keys[0]] = a[a.keys[0]][:text]}}
      result
  end
  
  
  #Create a mapping from subfacet id to title, e.g. 19 => 'Works with nz text'
  #This allows for easy display of title in HTML
  INVERTED_SUBFACETS = invert_subfacets



  
  #Figure out the parent of a popular subfacet - this is the popular facet
  #Note this can be an array
  def self.popular_facets(work)
    subfacets = popular_subfacets(work)
    result  =[]
    for parent_key in POPULAR_FACETS.keys
      subfacets_array = POPULAR_FACETS[parent_key][:subfacets]
      for subfacet_to_check in subfacets_array

        subkey = subfacet_to_check.keys[0] #only item per hash
              #  puts "CHECKING #{subkey} against parent #{parent_key}"
        result << parent_key.to_s if subfacets.include?(subkey)
          
      end
    end
    result
  end
  
  
  #For a given work ascertain which subfacets it belongs to, e.g. New Zealand / Culture
  #These are returned as an array of ids, the ids being the keys of the subfacets in POPULAR_FACETS
  def self.popular_subfacets(work)
    #Get the categories and concepts of the work in one hit
    subcats = work.work_subcategories
    
    #These are FRBR related, note taht the spreadsheet sourced from contains fields that
    #cant be found in just themes, hence grabbing the others
    concepts = work.concept_themes + work.concept_influences + work.concept_genres
    	
    result = []
    	
    pkeys = POPULAR_FACETS.keys

    #iterate through the keys looking for matches
    for key in pkeys
      subfacets_array = POPULAR_FACETS[key][:subfacets]
   
      
      for subfacet_to_check_for in subfacets_array
           
          #Each hash has only one key
         # :subfacets => [
         #   {6 => {:text => "For Education", :conditions => [FOR_EDUCATION_1, FOR_EDUCATION_2]}}
         # ]
          subkey = subfacet_to_check_for.keys[0]
          conditions_array = subfacet_to_check_for[subkey][:conditions]
		  #RAILS_DEFAULT_LOGGER.debug "DEBUG: key #{subkey} conditions_array #{conditions_array}"
          for conditional_item in conditions_array
             #puts "\tCHECKING CI:#{conditional_item} of class #{conditional_item.class}"
             #puts "KEY: #{key} => #{conditions_array.length} conditions"
            
            #we now have a list of restrictions, namely concepts, work subcats and special cases
             #Check for a concept match
            if conditional_item.class == Concept
				#puts "\tCONCEPT"
			    result << subkey if concepts.include?(conditional_item)
          
            #Check for a work subcat match  
            elsif conditional_item.class == WorkSubcategory
            	#Check for educational and do FRBR check with resources
              #  puts "\WORK SUB CAT"
              #  puts "Checking for work sub cat #{conditional_item.to_yaml} in #{subcats.to_yaml}"
                result << subkey if subcats.include?(conditional_item) || work.main_category == conditional_item
            
			# WR#52688 - Music with resources - Works which are linked by 'is described by' FRBR relationship to a 
			# resource where where resouce type = education resource
            elsif conditional_item.class == ResourceType
            	result << subkey if work.descriptive_resources.map{|r| r.resource_type}.include?(conditional_item)
            
			# WR#52688 - Maori Music and Culture: Te Reo (language) facet - drawn from language = Maori (on expressions) 
            elsif conditional_item.class == Language
            	result << subkey if work.expressions.map{|e| e.languages}.flatten.uniq.include?(conditional_item)
			
			#ok we must have a special case
            else
            
            end
          end
        end
  
    end
    
    result
    
  end 

  
end