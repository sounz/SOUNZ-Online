module FacetViewHelper
  
  # Convert the results from a people search hash into a form that the facet block helper can use
  # The paramater results is the full hashtable returned from SOLR - it will contain facet results as well as
  # the normal inline page results
  def self.people_facet_block_hash(results)
    where_facet = {
      :name => 'Year Group'
    }
    
  end
  
  
  #  Convert a row, denoted by a key, from a query hash such as this one
  #<pre>
  # BORN_FACET_DETAILS = {
  #  :solr_field => :year_of_creation_range_for_solr_s,
  #  :facets => {
  #    '0-1899' => {:text => 'Before 1900',:lucene_query => "0-1899" },
  #    '1900-1949' => {:text => '1900 to 1949',:lucene_query => "1900-1949" },
  #    '1950-1959' => {:text => '1950 to 1959',:lucene_query => "1950-1959" },
  #    '1960-1969' => {:text => '1960 to 1969',:lucene_query => "1960-1969" },
  #    '1970-1979' => {:text => '1970 to 1979',:lucene_query => "1970-1979" },
  #    '1980-1989' => {:text => '1980 to 1989',:lucene_query => "1980-1989" },
  #    '1990-1999' => {:text => '1990 to 1999',:lucene_query => "1990-1999" },
  #    '2000-2009' => {:text => '2000 to 2009',:lucene_query => "2000-2009" }
  #  }
  #}
  #</pre>
	# to this format: 
	#{:category => 'publisher', :name => 'Publishers', :count => role_groups["publisher"]},
  def self.convert_query_hash_to_view_hash(query_hash, key, facets_result_hash)

      #RAILS_DEFAULT_LOGGER.debug "QUERY HASH OF CLASS #{query_hash.class}"
          facets_hash = query_hash[:facets]
    
  
 
    #RAILS_DEFAULT_LOGGER.debug "==== CONVERT QUERY TO VIEW HASH ===="
    #RAILS_DEFAULT_LOGGER.debug "FACETS HASH:#{facets_hash.to_yaml}"
    #RAILS_DEFAULT_LOGGER.debug "FACETS HASH CLASS:#{facets_hash.class}"
    #RAILS_DEFAULT_LOGGER.debug "FACETS HASH KEYS:#{facets_hash.keys.to_yaml}"
    #RAILS_DEFAULT_LOGGER.debug "KEY:#{key}"
     
        debug_string = ""
        
    for fkey in facets_hash.keys
      #RAILS_DEFAULT_LOGGER.debug "HASH KEY:*#{fkey}* of class #{fkey.class}"
      debug_string << "*#{fkey}* of class #{fkey.class},"
    end
    
    RAILS_DEFAULT_LOGGER.debug "RETRIEVAL KEY:*#{key}* of class #{key.class}"
    
    #facet results are grouped under this key, but it needs to be converted from a sym
    solr_field = query_hash[:solr_field].to_s 
    

    text = "BROKEN KEY #{key}"
    if !facets_hash[key].blank?
      #RAILS_DEFAULT_LOGGER.debug "CHECKING FACETS HASH[#{key} which is non blank for [:text]"
      #RAILS_DEFAULT_LOGGER.debug "FACETS_HASH[#{key}] = "
      #RAILS_DEFAULT_LOGGER.debug facets_hash[key].to_yaml
      
      new_text = facets_hash[key][:text]
       if !new_text.blank?
         text = new_text
      else
        text = "BROKEN KEY AT 2 *#{key}* of class #{key.class} | SOURCE: #{debug_string}"
      end
      #RAILS_DEFAULT_LOGGER.debug "TEXT FOUND:#{text}"

    end
    
    #RAILS_DEFAULT_LOGGER.debug "RESULTS HASH:#{facets_result_hash.to_yaml}"
    #RAILS_DEFAULT_LOGGER.debug "SOLR FIELD HASH BIT: GRAB HASH facets_result_hash[#{solr_field}].to_yaml"
    #RAILS_DEFAULT_LOGGER.debug "SOLR FIELD HASH BIT:#{facets_result_hash[solr_field.to_s].to_yaml}"
    #RAILS_DEFAULT_LOGGER.debug "SOLR FIELD:#{solr_field} of class #{solr_field.class}"
    for fkey in facets_result_hash.keys
      #RAILS_DEFAULT_LOGGER.debug "HASH KEY:*#{fkey}* of class #{fkey.class}"
    end
    
    #RAILS_DEFAULT_LOGGER.debug "key is #{key}"
    #RAILS_DEFAULT_LOGGER.debug "text is #{text}"
    #RAILS_DEFAULT_LOGGER.debug "solr_field is #{solr_field}"
    #RAILS_DEFAULT_LOGGER.debug "facets_result_hash is #{facets_result_hash}"
    
    {:category => key, :name => text, :count => facets_result_hash[solr_field.to_s][key]}
  end
  
  #From an array of keys we wish to return an array of hashes of the form
  # {:category => 'publisher', :name => 'Publishers', :count => 20 },
  def self.convert_query_hash_to_view_array(query_hash, ordered_keys, facets_result_hash)
    result = []  
    
     for key in ordered_keys
           #RAILS_DEFAULT_LOGGER.debug "CHECKING KEY #{key} of class #{key.class}"
      result << convert_query_hash_to_view_hash(query_hash, key, facets_result_hash)
    end
    
    
    #RAILS_DEFAULT_LOGGER.debug "KEYS"
    for key in ordered_keys
      #RAILS_DEFAULT_LOGGER.debug "Trying to match *#{key}* of class #{key.class}"
    end
    
    for key in query_hash[:facets].keys
         #RAILS_DEFAULT_LOGGER.debug "Trying to match to this: *#{key}* of class #{key.class}"
    end

    
    result
  end
  
=begin
MONTH_DETAILS = {
   :solr_field => :months_for_solr_t,
   :facets => {
     '1' => {:text => 'January', :l
=end
  
  def self.convert_month_facet_searches_to_view_array(facets_result_hash)
    result = []
    for facet_query in facets_result_hash[:facets]['facet_queries']
       fq = facet_query[0].strip
       RAILS_DEFAULT_LOGGER.debug fq.to_yaml
       if fq.starts_with?("(event_start_for_solr_s:")
         month = fq[29,2] #Remove the event_start_for_solr part from the facet query
         month = month.to_i.to_s
         
         amount = facet_query[1]
         result << {
          :category => month.to_s,
          :name => FacetHelper::MONTH_DETAILS[:facets][month][:text], 
          :count => amount
          }
       end
    end
    
    result2 = result.sort_by{|r| r[:category].to_i  }
    result = result2
    
    result
  end
  
  
  
  def self.convert_available_for_facet_to_view_array(results)
    v = [
      {:category => 'purchase', :name => 'Purchase', :count => 0},
	  {:category => 'hire',   :name => 'Hire', :count => 0},
      {:category => 'loan',   :name => 'Loan', :count => 0}
    ]
    if results.has_key?(:facets)
      
      
    
        v[0][:count] = results[:facets]["facet_fields"]["can_be_bought_for_solr_t"]["yes"]     
		v[1][:count] = results[:facets]["facet_fields"]["can_be_hired_for_solr_t"]["yes"]
        v[2][:count] = results[:facets]["facet_fields"]["can_be_loaned_for_solr_t"]["yes"]

    end
    v
  end
  
  

  
  
  
  def self.convert_day_facet_searches_to_view_array(facets_result_hash, month)
    result = []
    for facet_query in facets_result_hash[:facets]['facet_queries']
       fq = facet_query[0].strip
       RAILS_DEFAULT_LOGGER.debug fq.to_yaml
       if fq.starts_with?("(event_start_for_solr_s:")
         day = fq[30,2] #Remove the event_start_for_solr part from the facet query
         day = day.to_i.to_s
         
         amount = facet_query[1]
         result << {
          :category => day.to_s,
          :name => day.to_i.ordinalize, 
          :count => amount
          }
       end
    end
    
    result2 = result.sort_by{|r| r[:category].to_i  }
    result = result2
    
    result
  end
  
  #Convert the role types to the correct format
  def self.convert_role_types_to_view_array(facets_result_hash)
    result = []
    solr_field_name = 'role_type_id_for_solr_t'
    count_hash = facets_result_hash[solr_field_name]
 
    for role_type in RoleType.find(:all, :order => 'role_type_desc')
      key = role_type.role_type_id.to_s

      facet_count = count_hash[key]
        if facet_count != nil #NOTE - not all role types are currently in system for contributors
        result << {
          :category => key,
          :name => role_type.role_type_desc.gsub(' (c)', ''), 
          :count => facet_count
          }
      end
    end
    result
  end
  
=begin
 :nz => {
    :text => "New Zealand",
    :subfacets => [
      {1 => {:text => "Birds", :conditions => [BIRDS_1, BIRDS_2]}},
      {2 => {:text => "Landscape", :conditions => [LANDSCAPE_1, LANDSCAPE_2]}},
      {3 => {:text => "Culture", :conditions => [CULTURE_1, CULTURE_2]}},
      {4 => {:text => "History", :conditions => [HISTORY_1, HISTORY_2]}},
      {5 => {:text => "Flora and Fauna", :conditions => [FLORA_1, FLORA_2]}}
    ]
  },
=end


  def self.popular_subcategory_name(subcat_id)
    FacetHelper::INVERTED_SUBFACETS[subcat_id.to_i]
  end

  def self.popular_category_name(key)
    FacetHelper::POPULAR_FACETS[key.to_sym][:text]
  end

  def self.popular_subfacets(popular_category, facets_result_hash)
    count_hash = facets_result_hash['popular_subfacets_for_solr_t']
    pop_cat_sym = popular_category.to_sym
    result = []
    if !FacetHelper::POPULAR_FACETS[pop_cat_sym].blank?
      for subfacet in FacetHelper::POPULAR_FACETS[pop_cat_sym][:subfacets]
        subkey = subfacet.keys[0]
        amount = count_hash[subkey.to_s] #string, grrr
        if amount != nil
          result << {
            :category => subkey,
            :name => subfacet[subkey][:text],
            :count => amount
          }
        end
      end
    else
      raise ArgumentError, "Popular category #{popular_category} is invalid"
    end
    result
  end
  
  def self.popular_facets(facets_result_hash)
    RAILS_DEFAULT_LOGGER.debug facets_result_hash
    
    result = []
    count_hash = facets_result_hash
    
    for key in ['nz','maori', 'education', 'incidental', 'special', 'sonic']
      key_sym = key.to_sym
      facet_count = facets_result_hash[key]
      if count_hash.has_key?(key)
        result << {
          :category => key_sym,
          :name => FacetHelper::POPULAR_FACETS[key_sym][:text],
          :count => facet_count
        }
      end
    end
    
    RAILS_DEFAULT_LOGGER.debug result.to_yaml
    
    
    result
  end
  
  #Convert the role types to the correct format
  def self.event_types_to_view_array(facets_result_hash)
    result = []
    solr_field_name = 'event_type_id_t'
    count_hash = facets_result_hash[solr_field_name]
 
    for event_type in EventType.find(:all, :order => 'event_type_desc')
      key = event_type.event_type_id.to_s

      facet_count = count_hash[key]
        if facet_count != nil #NOTE - not all role types are currently in system for contributors
        result << {
          :category => key,
          :name => event_type.event_type_desc, 
          :count => facet_count
          }
      end
    end
    result
  end
  
  
  
  #Convert a string of the form XXXXYYYY into one of the following:
  #20002000 - 2000
  #20002001 - 2000 to 2001
  #10001994 - before 1994
  def self.human_readable_double_year(years_string)
    raise ArgumenError, "You must provide a numeric string of 8 letters" if years_string.length !=8
    year1 = years_string.first(4)
    year2 = years_string.last(4)  
    result = "ERROR : UNDEFINED"
    result = year1.to_s if year1==year2
    #Note 1000 is the zero year
    result = "#{year1}-#{year2}" if year1 != year2 and year1 !="1000" 
    result = "Before #{year2}" if year1 != year2 and year1 == "1000"
    result
  end
  
  
  #Put NZ at teh top of the list, and order the rest alpha
  #Note a list of ids, as strings, are passed in to this method
  def self.order_country_keys(country_keys)
      sql = <<-EOF
        select country_id from countries where country_id in (?) order by country_name

     EOF
     country_keys.delete("none") #Some event have no country, remove them
     sql = SqlHelper.sanitize([sql,country_keys])
     ordered_keys = ActiveRecord::Base.connection.execute(sql)
     ordered_keys = ordered_keys.map{|result| result['country_id']}
     nz_id = Country::NEW_ZEALAND.country_id.to_s
     if ordered_keys.include?(nz_id)
       ordered_keys.delete(nz_id)
       ordered_keys = [nz_id] + ordered_keys
     end
  
     ordered_keys
  end
  
  
  
  #Prelaunch day fix - revist post launch
  #FIXME - use date ranges
  def self.fix_date_array(array_to_fix, month)
    result = []
    month = "0"+month if month.length == 1
    for hash in array_to_fix
      day_key = hash[:category]
      day_key = "0"+day_key if day_key.length == 3
      result << hash if day_key.starts_with?(month)
    end

   
    
    result
  end
  
  #Convert the distinction types to the correct format
  def self.distinction_types_to_view_array(facets_result_hash, solr_field_name)
    result = []
	
    count_hash = facets_result_hash[solr_field_name]
    
	#RAILS_DEFAULT_LOGGER.debug "DEBUG: count_hash #{count_hash}"
	
	#RAILS_DEFAULT_LOGGER.debug "DEBUG: facets_result_hash #{facets_result_hash}"
    for distinction_type in DistinctionType.find(:all, :order => 'distinction_type_id')
      key = distinction_type.distinction_type_id.to_s

      facet_count = count_hash[key]
        if facet_count != nil
        result << {
          :category => key,
          :name => distinction_type.distinction_type_name, 
          :count => facet_count
          }
      end
    end
	
	# special case for 'Opportunity' Event subfacet
	facet_count = count_hash['other']
	if facet_count != nil
	  result << {
		      :category => 'other',
			  :name => 'Other', 
			  :count => facet_count
			    }
	end	
	
    result
  end  
  
  

end