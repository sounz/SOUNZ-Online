module AdvancedFinderHelper
  include FinderHelper
  
  #Build query for events
  def self.build_advanced_event_query(search_details, page=1)
    fields = []

    fields << create_search_term('general_note_for_solr_t', search_details, :general_note)
    fields << create_search_term('tickets_note_for_solr_t', search_details, :booking_ticket_note)
    fields << create_search_term('prize_info_note_for_solr_t', search_details, :prize_info_note)
    fields << create_search_term('internal_note_for_solr_t', search_details, :internal_note)

    fields << create_search_term('country_id_for_solr_s', search_details, :country_id)
    fields << create_search_term('region_for_solr_t', search_details, :region_id)
    fields << create_search_term('locality_for_solr_t', search_details, :locality)

    query_string = ""
    query_array = Array.new
    # FIELDS EXCEPTIONS: Title and Venue fields should return more exact matches, e.g. the more terms
    # are entered, the more results filtered, as per WR#66486, note 15:39 10-02-2010
    query_array.push((search_details.title_not == "0" ? "" : "NOT ") + "event_title_for_solr_t:(#{FinderHelper.strip_query(search_details.title)})") unless search_details.title.blank?
    query_array.push((search_details.venue_not == "0" ? "" : "NOT ") + "venue_for_solr_t:(#{FinderHelper.strip_query(search_details.venue)})") unless search_details.venue.blank?

    #now deal with dates
    query_array.push(create_range_search_term('event_start_for_solr_s', search_details, :event_start_from, :event_start_to))
    
    query_string = query_array.join(" AND ")
    
    solr_fields=[]
    not_solr_fields=[]
    RAILS_DEFAULT_LOGGER.debug "DEBUG: query_string #{query_string}"

    #Remove empty values
    fields.map{|f| solr_fields << f[0] if !f[0].blank?}
    fields.map{|f| not_solr_fields << f[1] if !f[1].blank?}

    lucene_query = FinderHelper.build_advanced_query(Event, solr_fields, q_string='', not_solr_fields)

    if !query_string.blank?
      lucene_query << " AND" if !fields.length.blank?
      lucene_query<< " ("
      lucene_query << query_string
      lucene_query << ")"
    end

    lucene_query 
  end
  
  
  
  
  #Build the advanced work *query*
  def self.build_advanced_work_query(search_details, page=1)
    fields = []
	
    fields << create_search_term_if_not_blank('work_title_for_solr_t', search_details.title)
    fields << create_search_term_if_not_blank('work_description_for_solr_t', search_details.description)
    fields << create_search_term_if_not_blank('composers_csv_for_solr_t', search_details.composed_by)
    fields << create_search_term_if_not_blank('instrumentation_for_solr_t', search_details.instrumentation)
    fields << create_search_term_if_not_blank('text_note_for_solr_t', search_details.text_note)
    fields << create_search_term_if_not_blank('internal_note_for_solr_t', search_details.internal_note)
    fields << create_search_term_if_not_blank('commissioned_note_for_solr_t', search_details.commissioned_note)
    fields << create_search_term_if_not_blank('programme_note_for_solr_t', search_details.programme_note)
    fields << create_search_term_if_not_blank('languages_for_solr_t',      search_details.language_id)
    fields << create_search_term_if_not_blank('status_for_solr_t',      search_details.status_id)
    fields << create_search_term_if_not_blank('contents_note_for_solr_t', search_details.contents)

    fields << create_search_term_if_not_blank('year_of_creation_for_solr_t', search_details.composition_year)
    fields << create_search_term_if_not_blank('year_of_revision_for_solr_t', search_details.revision_year)

    #if we have category fields, we need to create a query with the text of the categories, not their ids.
    
    if ! search_details.work_category_id.blank?
   
    fields << create_search_term_if_not_blank('main_category_for_solr_t', ",#{search_details.work_category_id},")
    end
    
    if ! search_details.work_subcategory_id.blank?
    fields << create_search_term_if_not_blank('subcategories_for_solr_t', ",#{search_details.work_subcategory_id}," )
    end
    
    if ! search_details.work_additional_subcategory_id.blank?
    fields << create_search_term_if_not_blank('subcategories_for_solr_t', ",#{search_details.work_additional_subcategory_id},")
    end
    
    #Remove nil fields
    fields.map{|f| fields.delete(f) if f.blank?}
    
    lucene_query = FinderHelper.build_advanced_query(Work,fields)
    
    lucene_query = FinderHelper.make_query_more_exact(lucene_query)

    #now deal with dates ranges
    created_at_search = create_range_search_term('created_at_for_solr_s', search_details, :created_at_from, :created_at_to)
   
    lucene_query << " AND " << created_at_search unless created_at_search.blank?
    
    return lucene_query
	
  end
  
def self.findWorksByConcepts() 
  
end

def self.findWorksByRelationships(relationship_type,relationship_filter,relationship_text)
  workListFromFrbr=[]
  myWorks=Work.find(:all, :include => [:relationships], :conditions => ["work_relationships.relationship_type_id= ?",relationship_type] )
  for work in myWorks
    Work.logger.debug "DEBUG: WORK #{work.work_title}"
  
    myRelationships=Relationship.find(:all, :include => [:work_relationships],:conditions=>["work_relationships.work_id=? and work_relationships.relationship_type_id=?",work.work_id,relationship_type])
    for relationship in myRelationships
      Work.logger.debug "DEBUG: RELATIONSHIP id #{relationship.id} #{relationship.entity_type_id} #{relationship.ent_entity_type_id}"
      #now find out whether ent_entity_id or entity_type_id is our target
      #work is entity_type '2', so we want the one that isn't 2, or possibly they are both 2.
      myTargetTypeId=relationship.ent_entity_type_id
      if (myTargetTypeId==2)
        myTargetTypeId=relationship.entity_type_id
      end
  
      #now find the other end of the relationship
      myClass=EntityType.entityIdToType(myTargetTypeId)
     
      
	  klass = myClass.downcase
	  #klass = 'distinction' if klass.match('distinction_instance') # special case for non-standard distinction_instance
	  
	  Work.logger.debug Inflector.camelize(myClass)+".find(:all,:include =>[:" + klass + "_relationships],:conditions=>[relationship_id="+relationship.id.to_s+"])"
      myTargets=eval(Inflector.camelize(myClass)+".find(:all,:include =>[:" + klass + "_relationships],:conditions=>['" + klass + "_relationships.relationship_id=?',"+relationship.id.to_s+"])")
      
	  #ignore anythign but the first result.
      if !myTargets.blank?
	    myTarget = myTargets.first
        Work.logger.debug "DEBUG: TARGET: #{myTarget.frbr_ui_desc}" unless myTarget.blank?
  
  
        if relationship_filter.to_s=='contains'
  
          if myTarget.frbr_ui_desc =~/#{relationship_text}/i
            Work.logger.debug("ADDING Work:#{work.work_id} to LIST")
            workListFromFrbr.push("Work:#{work.work_id}")

          end
        else
          if myTarget.frbr_ui_desc !~/#{relationship_text}/i
            Work.logger.debug("ADDING Work:#{work.work_id} to LIST")
            workListFromFrbr.push("Work:#{work.work_id}")
          end
        end
      end
    end
  end       
  
  
 return workListFromFrbr 
  
end
  
  
def self.findWorksBySQL(search_details)


    workListFromSQL=[]

    whereClauseEntries=[];

    sqlStatement="select * from works_advanced_search"

    if search_details.has_score.to_s=='yes'
      whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where manifestation_type_category = 1)")
    elsif search_details.has_score.to_s=='no'
      whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where manifestation_type_category = 1)")
    else
      #do nothing
    end

    if search_details.has_recording.to_s=='yes'
      whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where manifestation_type_category = 2)") 
    elsif search_details.has_recording.to_s=='no'
      whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where manifestation_type_category = 2)")
    else
      #do nothing
    end

    if search_details.has_not_applicable.to_s=='yes'
      whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where manifestation_id is not null and manifestation_type_category is null)")
    elsif search_details.has_not_applicable.to_s=='no'
      whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where manifestation_id is not null and manifestation_type_category is null)")
    else
      #do nothing
    end

    #if search_details.has_sample_score.to_s=='yes'
    #  whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where manifestation_type_category = 1 and sample_id is not null)")
    #elsif search_details.has_sample_score.to_s=='no'
    #  whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where manifestation_type_category = 1 and sample_id is not null)")
    #else
    #  #do nothing
    #end

    #if search_details.has_sample_recording.to_s=='yes'
    #  whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where manifestation_type_category = 2 and sample_id is not null)")
    #elsif search_details.has_sample_recording.to_s=='no'
    #  whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where manifestation_type_category = 2 and sample_id is not null)")
    #else
      #do nothing
    #end

    if search_details.programme_note_exists.to_s=='yes'
      whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where programme_note is not null and programme_note not like '')")
    elsif search_details.has_sample_score.to_s=='no'
      whereClauseEntries.push("work_id NOT IN (select work_id from works_advanced_search where programme_note is not null and programme_note not like '')")
    else
      #do nothing
    end

    
    #if !search_details.status_id.blank?
    #  whereClauseEntries.push("work_id IN (select work_id from works_advanced_search where status_id=#{search_details.status_id})")
    #else
    #  #do nothing
    #end


    if whereClauseEntries.length > 0
      sqlStatement+=" WHERE " 
    	for entry in whereClauseEntries
    	 sqlStatement+=entry
    	 if entry!=whereClauseEntries.last
    		  sqlStatement+=" AND "
    	 end
    	end
    end
    sqlStatement+=";"


#RAILS_DEFAULT_LOGGER.debug "SQL STATEMENT #{sqlStatement}"
sql = ActiveRecord::Base
sanitisedSqlStatement=SqlHelper.sanitize(sqlStatement)
results = sql.connection.select_all(sanitisedSqlStatement)
    for result in results
#  Work.logger.info "WORK_ID: #{result['work_id']} EXPRESSION ID: #{result['expression_id']} MANIFESTATION ID: #{result['manifestation_id']} TYPE: #{result['manifestation_type_category']} SAMPLE ID: #{result['sample_id']} "
  workListFromSQL.push("Work:#{result['work_id']}")
    end

    return workListFromSQL
end




  
  


  #This is hte main interface for contributor searching
  #The search parameters are stored in a simple javabean like ruby object - these are used to
  # * create a SOLR query, and execute it to obtain a list of ids
  # csd is a contributor search details object, containing the details of the search
  def self.find_contributors(csd)
    filters=[];
    
    #If we have at least one SOLR search field filled in, search with SOLR
    #If this returns no results we have finished our search
    solr_results_found = false
    
    RAILS_DEFAULT_LOGGER.debug "Search details contain solr query? #{csd.contains_solr_query_data?}"
    
    #create a solr search filter if some results
    if csd.contains_solr_query_data?
      lucene_query = AdvancedFinderHelper.build_advanced_contributor_lucene_query(csd)
      solr_results = FinderHelper.execute_advanced_solr_query(lucene_query)[:docs]
      ids_from_solr = convert_solr_ids_to_database_ids(solr_results)
      RAILS_DEFAULT_LOGGER.debug ids_from_solr
      if ids_from_solr.length > 0
        solr_results_found = true
        #Add the SOLR ids as a filter, as the results have to come from this set
        filters <<  SqlHelper.sanitize(["contributor_id in (?)",ids_from_solr])
      else
        #No solr results were found so return with an empty list of ids, no point filtering an empty list...
        RAILS_DEFAULT_LOGGER.debug "**** NO SOLR RESULTS FOUND, SO RETURNING FROM SEARCH"
        return []
      end
    end
    
    sqlStatement="select distinct contributor_id as id from contributor_advanced_search"
    
    filters << generic_model_filter(:contributor,"year_of_birth=?",csd, :year_of_birth)#different col name sorted by view union
    filters << generic_model_filter(:contributor,"role_type_id=?",csd,:role_type_id)
    filters << generic_model_filter(:contributor,"composer_status=?",csd,:composer_status) 
    filters << generic_model_filter(:contributor,"gender=?",csd,:gender) 
    #filters << generic_model_filter(:contributor,"region_id=?",csd,:region_id)
    filters << generic_model_filter(:contributor,"deceased=?",csd,:deceased) 
    filters << generic_model_filter(:contributor,"apra=?",csd,:apra) 
    filters << generic_model_filter(:contributor,"canz=?",csd,:canz) 
    filters << generic_model_filter(:contributor,"status_id=?",csd,:status_id)
    
    
    
    
    RAILS_DEFAULT_LOGGER.debug "****** FILTERS *****"
    for filter in filters
      RAILS_DEFAULT_LOGGER.debug "PRE...FILTER:#{filter}"
    end
    
    #Remove emtpy entries
    filters.map{|f|filters.delete(f) if f.blank?} 
    
      for filter in filters
        RAILS_DEFAULT_LOGGER.debug "POST...FILTER:#{filter}"
      end
    
    RAILS_DEFAULT_LOGGER.debug "****** /FILTERS *****"
    
    filtered_ids = execute_sql_with_filters(sqlStatement, filters)
    filtered_ids

end



#This is hte main interface for event searching
#The search parameters are stored in a simple javabean like ruby object - these are used to
# * create a SOLR query, and execute it to obtain a list of ids
# sd is an event search details object, containing the details of the search
def self.find_events(sd)
  filters=[];
  
  #If we have at least one SOLR search field filled in, search with SOLR
  #If this returns no results we have finished our search
  solr_results_found = false

  RAILS_DEFAULT_LOGGER.debug "DEBUG: Search details contain solr query? #{sd.contains_solr_query_data?}"
  
  #create a solr search filter if some results
  if sd.contains_solr_query_data? || !(sd.contains_sql_query_data? && sd.contains_solr_query_data?)
    lucene_query = AdvancedFinderHelper.build_advanced_event_query(sd)
    
    options = { :sort => []}
    options[:sort]= 'event_start_with_time_for_solr_s asc, cities_for_solr_s asc'
    
    solr_results = FinderHelper.execute_advanced_solr_query(lucene_query, options)[:docs]
    ids_from_solr = convert_solr_ids_to_database_ids(solr_results)
    RAILS_DEFAULT_LOGGER.debug ids_from_solr
    
    if ids_from_solr.length > 0
      solr_results_found = true
      #Add the SOLR ids as a filter, as the results have to come from this set
      filters <<  SqlHelper.sanitize(["event_id in (?)",ids_from_solr])
    else
      #No solr results were found so return with an empty list of ids, no point filtering an empty list...
      RAILS_DEFAULT_LOGGER.debug "**** NO SOLR RESULTS FOUND, SO RETURNING FROM SEARCH"
      return []
    end
  end
  
  if sd.contains_sql_query_data?
    sqlStatement="select event_id as id from event_advanced_search"
  
    filters << generic_model_filter(:event,"status_id=?",sd, :status_id)
    filters << generic_model_filter(:event,"event_type_id=?",sd, :event_type_id)
  

    RAILS_DEFAULT_LOGGER.debug "****** FILTERS *****"
    for filter in filters
      RAILS_DEFAULT_LOGGER.debug "PRE...FILTER:#{filter}"
    end
  
    #Remove emtpy entries
    filters.map{|f|filters.delete(f) if f.blank?} 
  
    for filter in filters
      RAILS_DEFAULT_LOGGER.debug "POST...FILTER:#{filter}"
    end
  
    RAILS_DEFAULT_LOGGER.debug "****** /FILTERS *****"
  
    filtered_and_ordered_ids = execute_sql_with_filters(sqlStatement, filters, 'event_start ASC, locality ASC')
    
    results = filtered_and_ordered_ids.uniq
  
  else
    
    results = ids_from_solr
  
  end
  
  return results

end
    
    
 


  protected
  
=begin  
  #Create a restriction condition clause for adding to the filters
   #Example call - filters << generic_model_filter(:contributor,"canz=?",csd,:canz) 
   def self.generic_model_filter(:contributor,condition, search_details, method_sym)
     method = method_sym.to_s
     value = search_details.send(method)

     #now check for not
     not_method = method+"_not"
     not_value = nil

     not_clause =""
     if search_details.respond_to?(not_method)
       not_value = search_details.send(not_method)
     end

     if not_value == "1"
       not_clause = "NOT"
     end

     RAILS_DEFAULT_LOGGER.debug "#{method} --> #{value}"
     RAILS_DEFAULT_LOGGER.debug "NOT VAL:#{not_value}"

     result=""

     #we dont append a filter if no not and no value to check
     if !(value.blank? and not_clause.blank?) #good old de morgan laws
       result = SqlHelper.sanitize(["contributor_id #{not_clause} IN (select contributor_id from contributor_advanced_search where "+
                 condition+")", value])
       RAILS_DEFAULT_LOGGER.debug "Added:#{result}"
     end

     result
   end
=end

   
   #Create a restriction condition clause for adding to the filters
    #Example call - filters << generic_model_filter(:contributor,,"canz=?",csd,:canz)
    #Note this deals with the NOT case, but relies on the following
    # the id of the model is <model_name>_id
    # the view <model_name>_advanced_search exists in the db
    def self.generic_model_filter(klass_sym,condition, search_details, method_sym)
      method = method_sym.to_s
      value = search_details.send(method)

      #now check for not
      not_method = method+"_not"
      not_value = nil

      not_clause =""
      if search_details.respond_to?(not_method)
        not_value = search_details.send(not_method)
      end

      if not_value == "1"
        not_clause = "NOT"
      end

      RAILS_DEFAULT_LOGGER.debug "#{method} --> #{value}"
      RAILS_DEFAULT_LOGGER.debug "NOT VAL:#{not_value}"

      result=""
      model_class = klass_sym.to_s
      #we dont append a filter if no not and no value to check
      if !value.blank? #good old de morgan laws
        result = SqlHelper.sanitize(["#{model_class}_id #{not_clause} IN (select #{model_class}_id from #{model_class}_advanced_search where "+
                  condition+")", value])
        RAILS_DEFAULT_LOGGER.debug "Added:#{result}"
      end

      result
    end
  
  
=begin
SELECT manifestation_id as mid, '0'::integer as rid, manifestation_title AS title FROM manifestations WHERE manifestation_id IN (1269,3867)
UNION
SELECT '0'::integer as mid, resource_id AS rid, resource_title AS title FROM resources WHERE resource_id IN (331,332)
ORDER BY title;


SELECT 'M'::text as type, manifestation_id as id, manifestation_title AS title FROM manifestations WHERE manifestation_id IN (1269,3867)
UNION
SELECT 'R'::text as type, resource_id AS id, resource_title AS title FROM resources WHERE resource_id IN (331,332)
ORDER BY title;

=end
  
  #This is hte main interface for resource and manifestation searching
  #The search parameters are stored in a simple javabean like ruby object - these are used to
  # * create a SOLR query, and execute it to obtain a list of ids
  # sd is a  search details object, containing the details of the search
  def self.find_manifestations_and_resources(sd)
    RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTER:======"
    
    RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTER: search details ="+ sd.to_yaml
    
    #these are the resource and manifestation ids from SOLR - there is no point in using relevant SQL filters
    #if these are blank after SOLR
    resource_solr_ids = []
    manifestation_solr_ids = []
    
    filtered_results = [] # this will stay empty if no solr results
    
    RAILS_DEFAULT_LOGGER.debug "DEBUG: Search details contain solr query? #{sd.contains_solr_query_data?}"
    
    #create a solr search filter if some results
    if sd.contains_solr_query_data? || !(sd.contains_solr_query_data? && sd.contains_sql_query_data?)
      RAILS_DEFAULT_LOGGER.debug "DEBUG:*** SEARCHING FOR MANS AND RES USING SOLR"
      
      #create query and execute it
      lucene_query = AdvancedFinderHelper.build_advanced_man_res_lucene_query(sd)
      RAILS_DEFAULT_LOGGER.debug "DEBUG: QUERY:#{lucene_query}"
      lucene_query = FinderHelper.make_query_more_exact(lucene_query)

      # deal with dates ranges
      created_at_search = create_range_search_term('created_at_for_solr_s', sd, :created_at_from, :created_at_to)
      lucene_query << " AND " << created_at_search unless created_at_search.blank?
    
      options = {:q => []}
	  
      if !sd.downloadable.blank?
	if sd.downloadable == 'true'
	  options[:q] << 'downloadable_for_solr_t:yes'
	elsif sd.downloadable == 'no'
	  options[:q] << 'downloadable_for_solr_t:no'
	end
      end
	  
      solr_results = FinderHelper.execute_advanced_solr_query(lucene_query, options)[:docs]
      
      #could probably do this as a map but ho hum
      for res in solr_results
        parts = res.split(':')
        klass = parts[0]
        id = parts[1]
        if klass == 'Manifestation'
          manifestation_solr_ids << id
        elsif klass == 'Resource'
          resource_solr_ids << id
        end
      end
     
      #now store the resource and manifestation ids in separate arrays - we still need the main solr_results
      #array for ordering purposes
      filtered_results = solr_results
    end
    
    #perform sql filtering on resources if so required
     filtered_resource_ids = resource_solr_ids
     filtered_manifestation_ids = manifestation_solr_ids
     filters=[]
     
	 if sd.contains_sql_query_data?
	 
	   # do resource sql search only if there are no just manifestation search params
	   if (sd.entity_to_search == 'resource' || sd.entity_to_search == 'both') && (sd.manifestation_type_format_id.blank? && sd.manifestation_type_id.blank?)
	     sqlStatement = "select distinct resource_id as id from resource_advanced_search ras"
         if resource_solr_ids.length > 0
           filters <<  SqlHelper.sanitize(["resource_id in (?)",resource_solr_ids])
         end
       
	     filters << generic_model_filter(:resource,"format_id=?",sd,  :resource_type_format_id)
         filters << generic_model_filter(:resource,"resource_type_id=?",sd,  :resource_type_id)
         filters << generic_model_filter(:resource,"clonable=?",sd,  :cloneable) #good old spelling
         filters << generic_model_filter(:resource,"available_for_loan=?",sd,  :available_for_loan)
         filters << generic_model_filter(:resource,"available_for_hire=?",sd,  :available_for_hire)
         filters << generic_model_filter(:resource,"available_for_sale=?",sd,  :available_for_sale)
     
		 if sd.item_exists == "true"
           filters << "((select count(*) from items i where i.resource_id=ras.resource_id)>0)"
		 elsif sd.item_exists == "no"
		   filters << "(ras.resource_id NOT IN (SELECT DISTINCT resource_id FROM resource_advanced_search WHERE resource_id IN (SELECT DISTINCT resource_id FROM items)))"
		 end
     
         filters.map{|f|filters.delete(f) if f.blank?}
	     RAILS_DEFAULT_LOGGER.debug "DEBUG adv: resource_solr_ids:#{resource_solr_ids.length}"
         RAILS_DEFAULT_LOGGER.debug "DEBUG adv: RES FILTER LEN:#{filters}"
		 RAILS_DEFAULT_LOGGER.debug "DEBUG adv: RES FILTER LEN:#{filters.length}"   
         filtered_resource_ids = execute_sql_with_filters(sqlStatement, filters) unless filters.blank?
	   else
	     filtered_resource_ids = []	 
	   end
	 
       filters = [] #reset
	   
       #perform sql filtering on manifestations if so required
	   # do manifestation sql search only if there are no just resource search params
	   if (sd.entity_to_search == 'manifestation' || sd.entity_to_search == 'both') && (sd.resource_type_format_id.blank? && sd.resource_type_id.blank?)
	     sqlStatement="select distinct manifestation_id as id from manifestation_advanced_search mas"
         if manifestation_solr_ids.length > 0
           filters <<  SqlHelper.sanitize(["manifestation_id in (?)",manifestation_solr_ids])
         end
      
	     filters << generic_model_filter(:manifestation,"format_id=?",sd,  :manifestation_type_format_id)
         filters << generic_model_filter(:manifestation,"manifestation_type_id=?",sd,  :manifestation_type_id)
         filters << generic_model_filter(:manifestation,"clonable=?",sd,  :cloneable) #good old spelling
         filters << generic_model_filter(:manifestation,"available_for_loan=?",sd,  :available_for_loan)
         filters << generic_model_filter(:manifestation,"available_for_hire=?",sd,  :available_for_hire)
         filters << generic_model_filter(:manifestation,"available_for_sale=?",sd,  :available_for_sale)
         
		 if sd.item_exists == "true"
           filters << "((select count(*) from items i where i.manifestation_id=mas.manifestation_id)>0)"
		 elsif sd.item_exists == "no"
		   filters << "(mas.manifestation_id NOT IN (SELECT DISTINCT manifestation_id FROM manifestation_advanced_search WHERE manifestation_id IN (SELECT DISTINCT manifestation_id FROM items)))"
		 end
  
  # ((select count(*) from items i where i.manifestation_id=mas.manifestation_id)>0);
         filters.map{|f|filters.delete(f) if f.blank?} 
         RAILS_DEFAULT_LOGGER.debug "DEBUG: MAN FILTER LEN:#{filters.length}"
      
      
         filtered_manifestation_ids = execute_sql_with_filters(sqlStatement, filters) unless filters.blank?
         RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERED MANS:#{filtered_manifestation_ids}"
		 RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERED SIZE:#{filtered_manifestation_ids.length}"
         RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERS: #{filters}"
      
	   else
	     filtered_manifestation_ids = []
	   end 
      
	   RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERED_RES_SIZE:#{filtered_resource_ids.length}"
       RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERED_MAN_SIZE:#{filtered_manifestation_ids.length}"
       RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTERED_RESULTS_SIZE:#{filtered_results.length}"
	 end
      #Create the final results, maintaining solr order.  Revisit if inefficiency issues
      final_results = []
      
      #if we did a SOLR search we keep the ranking order
      if sd.contains_solr_query_data?
        for fr in filtered_results
          splits = fr.split(':')
          fr_klass = splits[0]
          fr_id = splits[1]
          if fr_klass == "Manifestation"
            final_results << fr if filtered_manifestation_ids.include?(fr_id)
          elsif fr_klass == "Resource"
            final_results << fr if filtered_resource_ids.include?(fr_id)
          else
            RAILS_DEFAULT_LOGGER.debug "DEBUG: FOUND INVALID FR KLASS #{fr_klass}"
            raise ArgumentError, "Found non resource of manfiestation from search whilst filtering"
          end
        end
        
      #otehrwise just glump resources and manifestatons together
      else
        #create result array in form Class:instance_id
        filtered_manifestation_ids.map{|m_id| final_results << "Manifestation:#{m_id}"}
		filtered_resource_ids.map{|r_id| final_results << "Resource:#{r_id}"}
      end
     

      final_results
  end
  
  def self.find_expressions(sd)
	filters=[];
		
	#If we have at least one SOLR search field filled in, search with SOLR
	#If this returns no results we have finished our search
	solr_results_found = false
		
		
	lucene_query = AdvancedFinderHelper.build_advanced_expression_query(sd)
		  
	options = { :sort => []}
	
	if sd.title.blank?
	  options[:sort] = 'title_as_string_for_solr_s asc'
	  
	  options[:sort] = 'expression_start_for_solr_s asc' if !sd.expression_start_from.blank?
	  
	  options[:sort] = 'expression_start_for_solr_s desc' if sd.expression_start_from.blank? && !sd.expression_start_to.blank?
	  
	  options[:sort] = 'expression_finish_for_solr_s asc' if !sd.expression_finish_from.blank?
			
	  options[:sort] = 'expression_finish_for_solr_s desc' if sd.expression_finish_from.blank? && !sd.expression_finish_to.blank?	  
	  
	end
		  
	solr_results = FinderHelper.execute_advanced_solr_query(lucene_query, options)[:docs]
		
	#RAILS_DEFAULT_LOGGER.debug ids_from_solr
		  
	results = solr_results
	
	return results
  	
  end
  
  #Build query for events
  def self.build_advanced_expression_query(search_details, page=1)
	  fields = []
	  fields << create_search_term('title_for_solr_t',           search_details, :title)
	  fields << create_search_term('mode_for_solr_t',            search_details, :mode_id)
	  fields << create_search_term('edition_for_solr_t',         search_details, :edition)
	  fields << create_search_term('premiere_status_for_solr_t', search_details, :premiere)
	  fields << create_search_term('restriction_for_solr_t',     search_details, :restriction)
	  fields << create_search_term('general_note_for_solr_t',    search_details, :general_note)
	  fields << create_search_term('internal_note_for_solr_t',   search_details, :internal_note)
	  fields << create_search_term('status_for_solr_t',          search_details, :status_id)
	  
	  solr_fields = []
	  not_solr_fields = []
		  
	  #Remove empty values
	  fields.map{|f| solr_fields << f[0] if !f[0].blank?}
	  fields.map{|f| not_solr_fields << f[1] if !f[1].blank?}
	  
	  fields = []
	  
	  # partial expression special processing
	  partial_expression = nil
	  if search_details.partial_expression == "true"
	    partial_expression = 1
	  elsif search_details.partial_expression == "no"
		partial_expression = 0
	  end
	  
	  fields << create_search_term_if_not_blank('partial_expression_for_solr_t', partial_expression.to_s)
	  
	  # has_manifestation special processing
	  has_manifestation = nil
	  if search_details.has_manifestation == "true"
		has_manifestation = 1
	  elsif search_details.has_manifestation == "no"
		has_manifestation = 0
	  end
		   
	  fields << create_search_term_if_not_blank('has_manifestation_for_solr_t', has_manifestation.to_s)	  
	    
	  	  
      fields.map{|f| solr_fields << f if !f.blank?}
	  
	  lucene_query = FinderHelper.build_advanced_query(Expression, solr_fields,  query_string='',not_fields = not_solr_fields)
	  
	  #now deal with dates - firstly convert to format 20071106
	  query_array = Array.new
	  query_array.push(create_range_search_term('expression_start_for_solr_s', search_details, :expression_start_from, :expression_start_to))
	  query_array.push(create_range_search_term('expression_finish_for_solr_s', search_details, :expression_finish_from, :expression_finish_to))
	  
	  #Remove emtpy entries
          query_array.map{|q| query_array.delete(q) if q.nil?} 

	  lucene_query << " AND " << query_array.join(" AND ") unless query_array.blank?

	  # players_count
	  if !search_details.players_count.blank?
	  
		if !search_details.players_count_param.blank?
		
		  case search_details.players_count_param
			when 'equal':
			  lucene_query << ' AND (players_count_for_solr_t:(' + search_details.players_count + '))'
			  
			when 'greater':
			  players_count = search_details.players_count.to_i + 1
			  lucene_query << ' AND (players_count_for_solr_t:[' + players_count.to_s + ' TO *])'

			when 'less':
			  players_count = search_details.players_count.to_i - 1
			  lucene_query << ' AND (players_count_for_solr_t:[0 TO ' + players_count.to_s + '])'

		  end
		  
		else
		  lucene_query << ' AND (players_count_for_solr_t:(' + search_details.players_count + '))'
		end
		
	  end
	  
	  # relationships
	  if !search_details.relationship_text.blank?
		relationship = search_details.relationship_text
		if !search_details.relationship_type.blank?
	  	  relationship_type_desc = RelationshipType.find(:first, :conditions => ['relationship_type_id =?', search_details.relationship_type]).relationship_type_desc
	  	  relationship = '"' + relationship_type_desc.downcase + '" ' + relationship
		end
		
		operator = "AND "
		
		if search_details.relationship_not == "1"
		  lucene_query << ' AND (relationship_type_ids_for_solr_t:(' + search_details.relationship_type + '))'
		  operator = "AND NOT"
		end
		
		lucene_query << ' ' + operator + ' (relationships_for_solr_t:(' + relationship + '))'
	  end	    
		 
		
	  # return the value
	  lucene_query 
	end  
  
  # -----------------------------------------
  # - Advanced search for works & resources -
  # -----------------------------------------
  def self.find_works_and_resources(search_details)
    sd = search_details
    RAILS_DEFAULT_LOGGER.debug "FILTER:======"
    
    RAILS_DEFAULT_LOGGER.debug "FILTER: search details ="+ sd.to_yaml
    
    # these are the resource and manifestation ids from SOLR - there is no point in using relevant SQL filters
    # if these are blank after SOLR
    resource_solr_ids = []
    work_solr_ids = []
    
    filtered_results = [] # this will stay empty if no solr results
    
    RAILS_DEFAULT_LOGGER.debug "Search details contain solr query? #{sd.contains_solr_query_data?}"
    
    # create a solr search filter if some results
    if sd.contains_solr_query_data?
      RAILS_DEFAULT_LOGGER.debug "*** SEARCHING FOR WORK AND RESOURCE USING SOLR"
      
      # create query and execute it
      solr_results = AdvancedFinderHelper.execute_advanced_work_resource_lucene_query(sd)
            
      #could probably do this as a map but ho hum
      for res in solr_results
        #RAILS_DEFAULT_LOGGER.debug "RES:#{res}"
        parts = res.split(':')
        klass = parts[0]
        id = parts[1]
        if klass == 'Work'
          work_solr_ids << id
        elsif klass == 'Resource'
          resource_solr_ids << id
        end
      end
      
           
      #now store the resource and manifestation ids in separate arrays - we still need the main solr_results
      #array for ordering purposes
      #RAILS_DEFAULT_LOGGER.debug "SOLR RESULTS:#{solr_results}"
      filtered_results = solr_results
     end
    
     # perform sql filtering on resources only
     # if sd do not contain unique for work model fields
     # this check prevents adding of resources gotten from
     # sql for common fields, when no solr searches are done
     filtered_resource_ids = resource_solr_ids
     filtered_work_ids = work_solr_ids
     RAILS_DEFAULT_LOGGER.debug "sd.contains_sql_query_fields?:#{sd.contains_sql_query_fields?}"
     # perform sql filtering only if there are sql query fields
     if sd.contains_sql_query_fields?
     filtered_resource_ids = []
     RAILS_DEFAULT_LOGGER.debug "sd.contains_uniq_for_work_filters?:#{sd.contains_uniq_for_work_filters?}"
=begin
     if !sd.contains_uniq_for_work_filters?
     
       filtered_resource_ids = resource_solr_ids
       filters=[]
       sqlStatement="SELECT DISTINCT resource_id FROM resource_advanced_search ras"
       if resource_solr_ids.length > 0
         filters <<  SqlHelper.sanitize(["resource_id in (?)",resource_solr_ids])
       end
     
       db_view = 'resource_advanced_search'
       filters << sql_filter_clause_for_checkbox_param(:resource, "downloadable=?",       sd, :available_for_download, db_view)
       filters << sql_filter_clause_for_checkbox_param(:resource, "available_for_hire=?", sd, :available_for_hire,     db_view)
       filters << sql_filter_clause_for_checkbox_param(:resource, "available_for_sale=?", sd, :available_for_sale,     db_view)
     
     
       filters.map{|f|filters.delete(f) if f.blank?}
       RAILS_DEFAULT_LOGGER.debug "RES FILTER LEN:#{filters.length}"   
       filtered_resource_ids = execute_sql_with_filters(sqlStatement, filters)
     
     end
=end
=begin
     filters = [] #reset
     #perform sql filtering on works if so required
     sqlStatement="SELECT DISTINCT work_id FROM work_manifestation_advanced_search wmas"
     if work_solr_ids.length > 0
       filters <<  SqlHelper.sanitize(["work_id IN (?)",work_solr_ids])
     end

     db_view = 'work_manifestation_advanced_search'
     filters << sql_filter_clause_for_checkbox_param(:work, "downloadable=?",       sd, :available_for_download, db_view)
     filters << sql_filter_clause_for_checkbox_param(:work, "available_for_hire=?", sd, :available_for_hire,     db_view)
     filters << sql_filter_clause_for_checkbox_param(:work, "available_for_sale=?", sd, :available_for_sale,     db_view)
                    
     filters.map{|f|filters.delete(f) if f.blank?} 
     RAILS_DEFAULT_LOGGER.debug "WORK FILTER LEN:#{filters.length}"
      
      
     filtered_work_ids = execute_sql_with_filters(sqlStatement, filters)
          
     RAILS_DEFAULT_LOGGER.debug "FILTERED SIZE WORK FIRST FILT: #{filtered_work_ids.length}"
     
     # more filtering now on works_advanced_search view
     # on already filtered data

     if filtered_work_ids.length > 0
=end
    if work_solr_ids.length > 0
       filters = []
       sqlStatement="SELECT DISTINCT work_id AS id FROM works_advanced_search wmas"
       #filters <<  SqlHelper.sanitize(["work_id IN (?)",filtered_work_ids])
       filters <<  SqlHelper.sanitize(["work_id IN (?)", work_solr_ids])

       db_view = 'works_advanced_search'
       #FIXME the value for categories are hard-written
       #as in AdvancedFinderHelper.findWorksBySQL(search_details)
       filters << sql_filter_clause_for_checkbox_param(:work, "manifestation_type_category=?", sd, :has_score,     db_view, 1)
       filters << sql_filter_clause_for_checkbox_param(:work, "manifestation_type_category=?", sd, :has_recording, db_view, 2)
                         
       filters.map{|f|filters.delete(f) if f.blank?} 
       RAILS_DEFAULT_LOGGER.debug "WORK FILTER LEN:#{filters.length}"
           
       filtered_work_ids = execute_sql_with_filters(sqlStatement, filters)

       RAILS_DEFAULT_LOGGER.debug "FILTERED SIZE WORK SEC FILT: #{filtered_work_ids.length}"
       
     end
     end
             
     # Create the final results, maintaining solr order.  Revisit if inefficiency issues
     final_results = []
     #if we did a SOLR search we keep the ranking order
     if sd.contains_solr_query_data?
       for fr in filtered_results
         splits = fr.split(':')
         fr_klass = splits[0]
         fr_id = splits[1]
         if fr_klass == "Work"
           final_results << fr if filtered_work_ids.include?(fr_id)
         elsif fr_klass == "Resource"
           final_results << fr if filtered_resource_ids.include?(fr_id)
         else
           RAILS_DEFAULT_LOGGER.debug "FOUND INVALID FR KLASS #{fr_klass}"
           raise ArgumentError, "Found non resource or work from search whilst filtering"
         end
       end
        
      # otherwise just glump resources and works together
      else
        #create result array in form Class:instance_id
        filtered_work_ids.map{|w_id| final_results << "Work:#{w_id}"}
        filtered_resource_ids.map{|r_id| final_results << "Resource:#{r_id}"}
      end
	  
      final_results
  
  end
  
  # --------------------------------------------------------------------------------------------------------
  # - Create a restriction condition clause for adding to the filters 
  # - Example call - 
  # - filters << sql_filter_clause_for_checkbox_param(:work, "downloadable=?", sd, :available_for_download, "work_manifestation_advanced_search")
  # --------------------------------------------------------------------------------------------------------
  def self.sql_filter_clause_for_checkbox_param(klass_sym, condition, search_details, method_sym, db_view, value='t')
      method = method_sym.to_s
      search_method = search_details.send(method)
      
      result=""
      model_class = klass_sym.to_s
      
      # we don't append a filter if no not and no value to check
      if !search_method.blank? && search_method == "1"
        result = SqlHelper.sanitize(["#{model_class}_id IN (select #{model_class}_id FROM #{db_view} WHERE "+
                  condition+")", value])
        RAILS_DEFAULT_LOGGER.debug "Added:#{result}"
      end

      result
  end
  
  def self.convert_solr_ids_to_database_ids(solr_ids)
    ids = []
    solr_ids.map{|m| ids << m.split(':')[1]}
    ids
  end
  
  
  #Create a search term taking account of the NOT case, using introspection.  Returning a 2 part array
  #containing firstly the +ve case then the not case
  def self.create_search_term(fieldname, search_details,method_sym, boost=1)
    result = [nil,nil]
    method = method_sym.to_s
    value = search_details.send(method)
    
    not_flag = nil
    not_method = method+"_not"
    not_value = nil
    if search_details.respond_to?(not_method)
      not_value = search_details.send(not_method)
      if not_value == "1"
        not_flag = true
      end
    end


    
    #check if we need to do something
    if !(value.blank? and not_value.blank?)
      plus_case = create_search_term_if_not_blank(fieldname, value,boost) if !not_flag
      not_case = create_search_term_if_not_blank(fieldname, value,boost) if not_flag
      result = [plus_case, not_case]
    end
    
    result
  end
  
  # Create a solr range query term
  def self.create_range_search_term(fieldname, search_details, method_sym_from, method_sym_to, boost = 1)

    result = nil

    is_params_hash = search_details.is_a?(Hash)
    from = (is_params_hash ? search_details[method_sym_from] : search_details.send(method_sym_from.to_s))
    to = (is_params_hash ? search_details[method_sym_to] : search_details.send(method_sym_to.to_s))
    
    unless from.blank? && to.blank?
      value_from = (from.blank? ? "*" : (Time.parse(from) rescue Time.now).strftime("%Y%m%d"))
      value_to   = (to.blank? ? "*" : (Time.parse(to) rescue Time.now).strftime("%Y%m%d"))
      
      unless value_from == "*" && value_to == "*"
	result = "(#{fieldname}:[#{value_from} TO #{value_to}])"
	result += "^#{boost.to_s}" unless boost == 1
      end
    end
    
    return result
    
  end

  #Check a search term value to see if its not blank, and if that is the case add it to the search parameters.
  #Note this will add nil entries, but these can be removed post processing
  def self.create_search_term_if_not_blank(fieldname, value, boost=1)
    result = nil
    if !value.blank?
      if boost == 1
        result = {:name => fieldname, :query_string => value}
      else
        result = {:name => fieldname, :query_string => value,:boost => boost}
      end
    end
	result
  end
  

  #Build the SOLR query for advanced contributor search.
  def self.build_advanced_contributor_lucene_query(search_details, page=1)
    #do the SOLR searches first, this provides an in list to then apply SQL searches to
    #Actually we need to check if we have no SOLR searches at all, as this means we can apply
    #the SQL searches only
    
    #This one is also complexified by the fact it involves fields from contributor and people
    fields = []
    fields << create_search_term('known_as_for_solr_t', search_details, :known_as)
    fields << create_search_term('profile_for_solr_t', search_details, :profile)
    #FIXME - only for internal use?
    fields << create_search_term('profile_other_for_solr_t', search_details, :profile)
    fields << create_search_term('pull_quote_for_solr_t', search_details, :pull_quote)    
    fields << create_search_term('internal_note_for_solr_t', search_details, :internal_note)

    fields << create_search_term('regions_for_solr_t', search_details, :region_id)
    fields << create_search_term('countries_for_solr_t', search_details, :country_id)
    
    RAILS_DEFAULT_LOGGER.debug "Contributor fields:#{fields}"
    RAILS_DEFAULT_LOGGER.debug "#{fields[0].length}"
  #  RAILS_DEFAULT_LOGGER.debug "Contributor not fields:#{contributor_not_fields}"
    
    contributor_fields=[]
    contributor_not_fields=[]
    
    #Remove empty values
    fields.map{|f| contributor_fields << f[0] if !f[0].blank?}
    fields.map{|f| contributor_not_fields << f[1] if !f[1].blank?}
#    contributor_not_fields.map{|f| contributor_not_fields.delete(f) if f.blank?}

    result = FinderHelper.build_advanced_query(Contributor,contributor_fields,
                                                    query_string='',not_fields = contributor_not_fields)
    RAILS_DEFAULT_LOGGER.debug "QUERY:#{result}"
    return result
  end
  
  #Build the SOLR query for advanced contributor search.
  def self.build_advanced_man_res_lucene_query(search_details, page=1)
    #do the SOLR searches first, this provides an in list to then apply SQL searches to
    
    #This one is also complexified by the fact it involves fields from contributor and people
    fields = []
    fields << create_search_term('title_for_solr_t', search_details, :title)
    fields << create_search_term('author_note_for_solr_t', search_details, :author_note)
    fields << create_search_term('series_title_for_solr_t', search_details,  :series_title)
    fields << create_search_term('publication_year_for_solr_t', search_details,  :publication_year)
    fields << create_search_term('isbn_for_solr_t', search_details,  :isbn)
    fields << create_search_term('ismn_for_solr_t', search_details,  :ismn)
    fields << create_search_term('isrc_for_solr_t', search_details,  :isrc)
    fields << create_search_term('imprint_for_solr_t', search_details,  :imprint)
    fields << create_search_term('dedication_note_for_solr_t', search_details,  :dedication_note)
    fields << create_search_term('general_note_for_solr_t', search_details,  :general_note)
    fields << create_search_term('internal_note_for_solr_t', search_details,  :internal_note)
    fields << create_search_term('publisher_note_for_solr_t', search_details,  :publisher_note)
    fields << create_search_term('mw_code_for_solr_t', search_details,  :mw_code)
    fields << create_search_term('code_for_solr_t', search_details,  :code)
    fields << create_search_term('status_for_solr_t', search_details,  :status_id)
    fields << create_search_term('freight_code_for_solr_t', search_details,  :freight_code)
    fields << create_search_term('item_type_ids_for_solr_t', search_details,  :item_type_id)
    
    solr_fields=[]
    not_solr_fields=[]
    
    #Remove empty values
    fields.map{|f| solr_fields << f[0] if !f[0].blank?}
    fields.map{|f| not_solr_fields << f[1] if !f[1].blank?}

    case search_details.entity_to_search
      when 'manifestation'
	entities_to_search = [Manifestation]	    
      when 'resource'
	entities_to_search = [Resource]      
      when 'both'
        entities_to_search = [Manifestation,Resource]
     end
	
    lucene_query = FinderHelper.build_advanced_query(entities_to_search, solr_fields, query_string='',not_fields = not_solr_fields)

    return lucene_query
  end
  
  # ------------------------------------------------------------------
  # - Build and executes the lucene query for work & resource search -
  # ------------------------------------------------------------------
  def self.execute_advanced_work_resource_lucene_query(search_details, page=1)
    #do the SOLR searches first, this provides an in list to then apply SQL searches to
    
    #This one is also complexified by the fact it involves fields from work and resource
    fields = []
    options = {:q => [], :sort => []}
        
    # work only fields
    fields << create_search_term_if_not_blank('difficulty_for_solr_t',                    search_details.difficulty)
    if ! search_details.language_id.blank?
      fields << create_search_term_if_not_blank('languages_for_solr_t',                     ",#{search_details.language_id},")
    end
    fields << create_search_term_if_not_blank('has_programme_note_for_solr_t',            search_details.has_programme_note) unless search_details.has_programme_note == "0"
        
    # work categorisation
    if ! search_details.work_category_id.blank?
    fields << create_search_term_if_not_blank('main_category_for_solr_t', ",#{search_details.work_category_id},")
    end
    
    if ! search_details.work_subcategory_id.blank?
    fields << create_search_term_if_not_blank('subcategories_for_solr_t', ",#{search_details.work_subcategory_id}," )
    end
    
    if ! search_details.work_additional_subcategory_id.blank?
    fields << create_search_term_if_not_blank('subcategories_for_solr_t', ",#{search_details.work_additional_subcategory_id},")
    end
    
    # common fields
    # concepts
    if !search_details.concept_type.blank? && !search_details.concept_id.blank?
      case search_details.concept_type
        when 'genre':
          fields << create_search_term_if_not_blank('genres_for_solr_t',     search_details.concept_id)
        when 'influence':
          fields << create_search_term_if_not_blank('influences_for_solr_t', search_details.concept_id)
        when 'theme':
          fields << create_search_term_if_not_blank('themes_for_solr_t',     search_details.concept_id)
      end
    end

    # status    
    fields << create_search_term_if_not_blank('status_for_solr_t', search_details.status_id)
    
    fields << create_search_term_if_not_blank('contents_note_for_solr_t', search_details.contents)
    
    # Remove empty values
    fields.map{|f| fields.delete(f) if f.blank?}
        
    # special processing fields - the same search fields are applied to several solr fields
    # work and resource checks

    # downloadable, available_for_loan, available_for_hire, available_for_sale
    options[:q] << 'AND (downloadable_for_solr_t:yes)' if search_details.available_for_download == '1'
    options[:q] << 'AND (can_be_bought_for_solr_t:yes)' if search_details.available_for_sale == '1'
    options[:q] << 'AND ((can_be_loaned_for_solr_t:yes) OR (can_be_hired_for_solr_t:yes))' if search_details.available_for_hire == '1'

    if !search_details.title.blank?
      options[:q] << 'AND (work_title_for_solr_t:(' + search_details.title + ')' # Work model
      options[:q] << 'OR title_for_solr_t:(' + search_details.title + '))'       # Resource model
    end
 
    if !search_details.composed_written_by.blank?
      options[:q] << 'AND (composers_csv_for_solr_t:(' + search_details.composed_written_by + ')' # Work model
      options[:q] << 'OR creators_csv_for_solr_t:(' + search_details.composed_written_by + ')'    # Work model
      options[:q] << 'OR arrangers_csv_for_solr_t:(' + search_details.composed_written_by + ')'   # Work model
      options[:q] << 'OR writers_csv_for_solr_t:(' + search_details.composed_written_by + ')'     # Work model
      options[:q] << 'OR author_note_for_solr_t:(' + search_details.composed_written_by + '))'    # Resource model
    end
        
    # work year_of_creation and year_of_revision check and special processing
    if !search_details.composition_revision_year.blank?
    
      if !search_details.year_comparison_param.blank?
      
        case search_details.year_comparison_param
          when 'equal':
            options[:q] << 'AND (year_of_creation_for_solr_t:(' + search_details.composition_revision_year + ')'
            options[:q] << 'OR year_of_revision_for_solr_t:(' + search_details.composition_revision_year + '))'
          when 'greater':
            year = search_details.composition_revision_year.to_i + 1
            options[:q] << 'AND (year_of_creation_for_solr_t:[' + year.to_s + ' TO *]'
            options[:q] << 'OR year_of_revision_for_solr_t:[' + year.to_s + ' TO *])'
          when 'less':
            year = search_details.composition_revision_year.to_i - 1
            options[:q] << 'AND (year_of_creation_for_solr_t:[0 TO ' + year.to_s + ']'
            options[:q] << 'OR year_of_revision_for_solr_t:[0 TO ' + year.to_s + '])'
        end
        
      else
        options[:q] << 'AND (year_of_creation_for_solr_t:(' + search_details.composition_revision_year + ')'
        options[:q] << 'OR year_of_revision_for_solr_t:(' + search_details.composition_revision_year + '))'
      end
      
    end
    
    # 'duration' special processing
    # searches both Work & Resource
    if !search_details.duration.blank?
      duration = search_details.duration.to_i * 60
      
      if !search_details.duration_comparison_param.blank?
        
        case search_details.duration_comparison_param
          when 'equal':
            options[:q] << 'AND (intended_duration_for_solr_i:(' + duration.to_s + ')' # Work model
            options[:q] << 'OR duration_for_solr_i:(' + duration.to_s + '))'           # Resource model
          when 'greater':
            duration = duration + 1
            options[:q] << 'AND (intended_duration_for_solr_i:[' + duration.to_s + ' TO *]' # Work model
            options[:q] << 'OR duration_for_solr_i:[' + duration.to_s + ' TO *])'           # Resource model
          when 'less':
            duration = duration - 1
            options[:q] << 'AND (intended_duration_for_solr_i:[0 TO ' + duration.to_s + ']' # Work model
            options[:q] << 'OR duration_for_solr_i:[0 TO ' + duration.to_s + '])'           # Resource model
        end
        
      else
        options[:q] << 'AND (intended_duration_for_solr_i:(' + duration.to_s + ')' # Work model
        options[:q] << 'OR duration_for_solr_i:(' + duration.to_s + '))'           # Resource model
      end
      
    end
    
    # params from instruments checkboxes
    instruments_s = AdvancedFinderHelper.get_instruments_string(search_details)
    if !instruments_s.blank?
      options[:q] << 'AND (' + instruments_s + ')'
    end
    
    # params from voices checkboxes
    # if a main work category is not requested
    # search only works that have 
    # 'Orchestra', 'Vocal Solo', 'Vocal Ensemble', 'Choral Music', 'Vocal Music'
    # (vocal) main categories
    voices_s = AdvancedFinderHelper.get_voices_string(search_details)
    if !voices_s.blank?
      if search_details.work_category_id.blank?
        voices_categories_ids = WorkCategory.main_categories_for_voices_ids
        voices_categories_ids_s = voices_categories_ids.join(' OR ')
        options[:q] << 'AND (main_category_for_solr_t:(' + voices_categories_ids_s + '))'
      end
      options[:q] << 'AND (' + voices_s + ')'
    end
    
    # related resources
    # applies to Work & Resource
    if search_details.has_resource != "0"
      options[:q] << 'AND (has_descriptive_resources_for_solr_t:(' + search_details.has_resource + ')' # Work model
      options[:q] << 'OR has_related_resources_for_solr_t:(' + search_details.has_resource + '))'      # Resource model
    end
    
    if !search_details.resource_type_id.blank?
      options[:q] << 'AND (descriptive_resource_type_ids_for_solr_t:(' + search_details.resource_type_id + ')' # Work model
      options[:q] << 'OR related_resource_type_ids_for_solr_t:(' + search_details.resource_type_id + '))'      # Resource model
    end
    
	if search_details.title.blank? || search_details.sort_by == 'title'
	  options[:sort] = 'title_as_string_for_solr_s asc'
    end
	
	if search_details.sort_by == 'author'
	  options[:sort] = 'authors_cvs_as_string_for_solr_s asc'
	end
	     
    RAILS_DEFAULT_LOGGER.debug "QUERY:#{fields}"
    
    lucene_query = FinderHelper.build_advanced_query([Work,Resource], fields,
                                                    query_string='')
    RAILS_DEFAULT_LOGGER.debug "QUERY:#{lucene_query}"
    
    solr_results = FinderHelper.execute_advanced_solr_query(lucene_query, options)[:docs]
    
    return solr_results
    
  end
  
  # --------------------------------------------------
  # - Get a search string for instruments and voices -
  # - based on check box params from UI              -
  # --------------------------------------------------
  def self.get_instruments_string(search_details)
    search_terms_a = Array.new
    
    search_details.methods.each do |method|
      
      if method.to_s.match('includes_*')
        instrument = method.to_s.gsub('includes_', ' ')
        instrument = instrument.gsub('=', ' ')
        instrument = instrument.strip
        search_term = instrument.gsub('_', ' ') # special case for double terms
        search_terms_a.push(search_term) if search_details.send('includes_' + instrument) == "1" && !search_terms_a.include?(instrument)
      end
    end   
    
    search_terms_s = ''
    search_terms_a.each do |i|
      search_terms_s = search_terms_s + i.to_s
      search_terms_s = search_terms_s + ' AND ' if i != search_terms_a.last
    end
    
    RAILS_DEFAULT_LOGGER.debug "INSTRUMENTS SEARCH STRING: #{search_terms_s} ###"
    return search_terms_s
  
  end
  
  # -------------------------------------
  # - Get a search string for voices    -
  # - based on check box params from UI -
  # -------------------------------------
  def self.get_voices_string(search_details)
    search_terms_a = Array.new
    
    search_details.methods.each do |method|
      
      if method.to_s.match('comprises_*')
        voice = method.to_s.gsub('comprises_', ' ')
        voice = voice.gsub('=', ' ')
        voice = voice.strip
        search_term = voice.gsub('_', ' ') # special case for double terms
        search_terms_a.push(search_term) if search_details.send('comprises_' + voice) == "1" && !search_terms_a.include?(voice)
      end
    end   
    
    search_terms_s = ''
    search_terms_a.each do |i|
      search_terms_s = search_terms_s + i.to_s
      search_terms_s = search_terms_s + ' AND ' if i != search_terms_a.last
    end
    
    RAILS_DEFAULT_LOGGER.debug "VOICES SEARCH STRING: #{search_terms_s} ###"
    return search_terms_s
  
  end
  
  
  private
  
  
  #Find concepts for a given concept type, and search term.  Either of the terms can be blank but not both
  def find_concept_ids(concept_type, concept_search_term)
    if concept_type.blank? and concept_search_term.blank?
      raise ArgumentError, "Please provide either a concept type or a concept search term"
    end
    concept_ids = []
    
    #This is the concept type case
    if concept_search_term.blank?
      concept_ids = Concept.find(:all, :conditions => ["concept_type_id = ?", concept_type.concept_type_id])
    elsif concent_type.blank?
      
    else
      
    end
  end
  
  
  #Create the full sql statement from its root and a bunch of filters.  The results from postgres
  #are then mapped into an array of ids that can be converted if required into Ruby instances
  def self.execute_sql_with_filters(root_sql, filter_sql_array, order=nil)
    sql_statement = root_sql
    if filter_sql_array.length > 0
      sql_statement << " WHERE " 
    	for entry in filter_sql_array
    	 sql_statement << entry
    	 if entry != filter_sql_array.last
    		  sql_statement << " AND "
    	 end
    	end
    end
    if !order.blank?
      sql_statement << " ORDER BY "
      sql_statement << order
    end
    sql_statement << ";"
    
    RAILS_DEFAULT_LOGGER.debug "DEBUG: #{sql_statement}"
    
    sql_connection = ActiveRecord::Base.connection();
    #sql_connection
    

    RAILS_DEFAULT_LOGGER.debug "DEBUG: FILTER SQL:#{sql_statement}"    
    pg_results = sql_connection.execute(sql_statement)
         
     #Convert the postgres result object into an array of database ids we can actually use
    results = []
    pg_results.map{|pg| results << pg['id']}
    RAILS_DEFAULT_LOGGER.debug results.length
    results
  end
  
  
  #The solr result array contains strings of the following form
  # * class_name:id
  #For example we could have Manifestation:100 or Resource:200
  #This method converts these to FRBR objects so they can be rendered
  def self.convert_solr_ids_to_objects(solr_result_array)
    #@result_frbr_objects.push(myObject)
    results = []
    
    for doc_string in solr_result_array
       k = doc_string.split(':')
       ob = k[0].constantize.find(k[1])
       frbr =FrbrObject.new(k[0].tableize.singularize, ob)
       results << frbr
    end
    
    results
  end
  
  
  

  
end
