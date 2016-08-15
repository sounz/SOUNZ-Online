module FindCommunicatonsHelper
  
  # -------------------------------------------------------------
  # - This is the method called by the find communications form -
  # -------------------------------------------------------------
  def find_communications(person_query, organisation_query, freetext_query, communication_types, modified_since)
    #We want all the organisations and people who match
    #FIXME: Spec says this but its different behaviour from find contacts but with identical interface...
    
    
    
    logger.debug "Person query is #{person_query}"
    logger.debug "Organisation query is #{organisation_query}"
    logger.debug "Freetext query is #{freetext_query}"
    
    @search_query = ""
    #@found_organisation_ids and @found_organisation_ids will be nil if no search text
    if organisation_query.length >= 3
      @search_query = @search_query+" OR associated_organisation_name: #{organisation_query}"
    end
    
    if person_query.length >= 3
      @search_query = @search_query+" OR associated_person_name: #{person_query}"
    end
    
    if freetext_query.length >= 3
      @search_query = @search_query+" AND (communication_note: #{freetext_query} OR communication_subject: #{freetext_query})"
    end
    
    #Remove any prefix AND or ORs
    @search_query.strip!
    
    #This is the case where we have search terms
    if @search_query.length >=3
      prefix = @search_query[0,3]
      logger.debug "************************* Prefix is #{prefix}"
      if prefix ==  "OR " or prefix == "AND"
        @search_query = @search_query[3..@search_query.length]
      end
      
      logger.debug "** LUCENE QUERY is #{@search_query}"
      @communication_ids = Communication.find_id_by_solr @search_query
      
      logger.debug "Number of results returned is "+@communication_ids.length.to_s
      
      #this is the case of no solr results
    else
      @communication_ids = nil
    end
    
    
    #we now have to apply relevant conditions
    
    restriction_sql = ""
    restriction_params = []
    
    first = true
    
    if @communication_ids != nil and @communication_ids.length > 0
      restriction_sql = "communication_id in (#{@communication_ids.join(',')})"
      logger.debug "Added a restriction for communications found by SOLR"
      first = false
    end
    
    #Check for communication types
    #FIXME: The empty case appears to be [""] - this does not seem correct.
    logger.debug "Commuication types  len is #{communication_types.length}"
    
    has_comms = true


    for ct  in communication_types
      puts "**** COMM TYPE: #{ct}"
    end
    
    logger.debug "++++ DOING COMM TYPES ++++"
    if has_comms
      logger.debug "Communication types are #{communication_types.join(',')}"
      logger.debug "Communication types are of length #{communication_types.length} "
      if communication_types.length > 0
        
          list_of_type_ids = communication_types.join(',')
        logger.debug "******COMMS TYPES ARE #{communication_types.length}"
        logger.debug "Type ids are *#{list_of_type_ids}*"
        logger.debug "id list of length #{list_of_type_ids.length}"
        
        if list_of_type_ids.length > 0
        restriction_params = restriction_params + [communication_types]
        restriction_sql = restriction_sql +" and " unless first == true
        first = false
        logger.debug "Added a restriction for communication types"
        restriction_sql = restriction_sql + "communication_type_id in (?)"
         end
      else
        logger.debug "DID NOT ADD RESTRICTION FOR COMMUNICATION TYPES DUE TO ZERO LENGTH" 
      end
      
    end
    
    logger.debug "++++ DONE COMM TYPES ++++"
    
    
    #Check for modified at
    if !modified_since.blank?
      last_modified_time = Time.parse(modified_since)
      restriction_sql = restriction_sql +" and " unless first == true
        first = false
         restriction_sql = restriction_sql + "updated_at > ?"
        restriction_params = restriction_params + [last_modified_time]
        logger.debug "Added a restriction for modified since"
    end
    
    restrictions = [restriction_sql]+restriction_params
    logger.debug "restrictions size is #{restrictions}"
    logger.debug "First is #{first}"
    logger.debug "++++++++++++++++++++++++++ About to do query"
    #We only wish to do this when we have restrictions
    
    if !first #ie we have a restriction
      @communications = Communication.find(:all, :conditions => restrictions, :limit => 10)
    else
      #This is the case where SOLR produced no results from the text search
     @communications = []
     NOSEARCHQUERYWHATTODOOOOOOOO
    end
    
    logger.debug "++++++ DONE QUERY++++++"
    
    
    
    
    return @communications
  end
end
