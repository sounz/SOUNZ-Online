module SearchContactsHelper
  
  #--------------------------------------------------------------------------
  #- Search for people by freetext.  Search for organisations by freetext.
  #  Return a list of people who work at the organisations that match       -
  #  If either of the query terms are empty or blank no results are returned
  #--------------------------------------------------------------------------
  def find_people_who_work_for_organisation_by_solr(person_query, organisation_query, keyword_query='')
    logger.debug "Searching for contacts"
    logger.debug "Person query:#{person_query}"
    logger.debug "Organisation query: #{organisation_query}"
    if person_query.blank? or organisation_query.blank?
      contacts = []
    else
      # Note: duplicated in controllers/search_controller.rb
      person_keyword_query = organisation_keyword_query = ""
      if !keyword_query.blank?
        person_keyword_query = " "
        organisation_keyword_query = " OR internal_note:#{keyword_query.downcase} OR organisation_abbrev:#{keyword_query.downcase}"
      end

      @found_organisation_ids =  Organisation.find_id_by_solr("contributor_name:#{organisation_query}" + organisation_keyword_query, :rows => 100)
      @found_people_ids = Person.find_id_by_solr("contributor_name:#{person_query}" + person_keyword_query, :rows => 100)
      
      #Now we have an in list from the text search, filter them from the roles
      
      some_organisations = @found_organisation_ids.length > 0
      some_people = @found_people_ids.length > 0
      
      #We only wish results for people who work at a company - if either list is empty then return empty list
      if some_people and some_organisations
        roles = Role.find(:all, :conditions =>["person_id in (?) and organisation_id in (?)",@found_people_ids, @found_organisation_ids])
      else
        roles = []
      end
      contacts = roles.collect {|role| role.organisation}
      contacts = contacts +  roles.collect {|role| role.person}
    end
    return contacts
    
  end
  
end
