#
# This module mostly contains helper methods for the faceted search interface
#
module FinderHelper

  include ActionController::Pagination

  def self.strip(string)
     # Remove junk from the string

     string = string.to_s.downcase.gsub(/[:;,.?!()+-\/\*"]/, ' ').strip

     # strip control characters that are not legal in xml to avoid Solr 1.3
     # crashing
     string = string.gsub(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/, ' ').strip

     return string
  end

  def self.strip_query(q_string)
	   # Remove junk from the query string

	   q_string = q_string.to_s.downcase.gsub(/[:;,.?!()+-\/\*]/, ' ').strip

	   return q_string
  end

  #Do the advanced search.  This requires explicit setting of queries for each field, and overrides the
  #OR parameter to be AND - so that all the terms are a filter ie the more you type the less you find
  #Note the use of nbcxvbnxcvbdsbf as a search term, that ought not to appear in documents, but is required
  #so as not to return a query of *:* used for faceting
  def self.build_advanced_query(models,fields, query_string='',not_fields=[])
    return build_query(models, query_string = query_string, fields, query_param_boolean='AND',
              not_fields = not_fields, defined_models_only = true)
  end

  #
  # Given some models to search, a query string to search for and fields to
  # search through, returns a search string for solr that can be used with the
  # solr_query method
  #
  # Parameters:
  #
  #  * models - Required. Either a model or an array of models that will be
  #    searched (e.g. Work, [Person, Organisation])
  #  * query_string - Optional. A string defining what to search for. If not
  #    specified, every item in the specified models will be included in the
  #    results, however their ordering of course will be strange. You can pass any
  #    old string, for example one got from a search form. This method will remove
  #    unnecessary tokens and make all words have a wildcard after them.
  #  * fields - Optional. An array of fields to search. Each entry in the array
  #    is a hash, in the form:
  #
  #       {:name => 'field name', :boost => [number]}
  #
  #    :name is required, and is a valid field name. :boost is optional, and is
  #    a double precision number greater than zero that says how important the field
  #    should be in the searching. 1.0 is normal, numbers higher than 1 give the
  #    field more weight. To make a field less important, use a number less than 1.
  #
  #    If you don't specify fields, all fields are searched with equal priority.
  #
  #  * not_fields - Optional. An array of fields with the values to exclude from search.
  #    Each entry in the array is a hash, in the form:
  #
  #       {:name => 'field name', :boost => [number]}
  #   (see 'fields' description for details)
  #
  #  * defined_models_only - flag defaulted to false. If it is set to true, the defined models
  #    in 'models' parameter are only searched and not all models (with the query set to '*:*' if
  #    'query_string' parameter is nil. It is used for advanced contact searches
  #

  def self.build_query(models, query_string='', fields=[], query_param_boolean='OR', not_fields=[], defined_models_only=false)
    if !models
      raise ArgumentError, "Must specify a model"
    end

    if models.is_a?(Array)
      models.each do |m|
        raise ArgumentError, "Model expected but " + m.class.to_s + " found" if m.superclass != ActiveRecord::Base
      end
      models.uniq!
    elsif models.superclass != ActiveRecord::Base
      raise ArgumentError, "First argument is not a model"
    end

    raise ArgumentError, "Second argument must be a string" if !query_string.is_a?(String)

    raise ArgumentError, "Third argument must be an array" if !fields.is_a?(Array)

    raise ArgumentError, "Query param boolean must be either AND or OR" if !["OR","AND"].include?(query_param_boolean)

    fields.each do |f|
      raise ArgumentError, "Hash expected but got " + f.class.to_s if !f.is_a?(Hash)
    end

    # NOTE: we wish that solr supported configuration lowerCaseExpandTerms, but
    # it does not. This means that wildcard searches (as these are) are case
    # sensitive, and we don't want that. So we make the search lower case here,
    # it's the best that can be done for the moment
    query_string.downcase!
    # Remove junk from the query string
    query_string = strip_query(query_string)#query_string.to_s.gsub(/[^a-zA-Z0-9=, ]/, ' ')
    # Split into bits, add a * on the end of each part
    #FIXME - this is for the case where you pass a search term of the form "penguin dance fun"
    #it gets mapped to "penguin* OR dance* or fun*"
    query_string = '(' << query_string.split.map! {|p| p << '*' }.join(" #{query_param_boolean} ") << ')'

    # Build the model search string
    result = ''
    if models.is_a?(Array)
      models.map! {|m| 'type_t:' << m.to_s}
      result << '(' << models.join(' OR ') << ')'
    else
      result << 'type_t:' << models.to_s
    end

     #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:query string = #{query_string}"
     #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:defined_models_only = #{defined_models_only}"
    # Now the actual query string
    if query_string != '()' || defined_models_only
      #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ1"
      if fields.empty?
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ2"
        result << ' AND ' << query_string unless query_string == '()'
      else
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ3"
        # fields processing
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:fields=#{fields}"
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:query_string=#{query_string}"

        search_fields = process_search_fields(fields, query_string)
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:search_fields=#{search_fields}"
        result << ' AND (' << search_fields.join(" #{query_param_boolean} ") << ')' unless search_fields.blank?
      end
      #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ4"
      if !not_fields.empty?
        #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ5"
        # not_fields processing
        not_search_fields = process_search_fields(not_fields) unless not_fields.blank?
        result << ' AND NOT (' << not_search_fields.join(" #{query_param_boolean} ") << ')' unless not_search_fields.blank?
      end
    else
      #RAILS_DEFAULT_LOGGER.debug "FINDER_HELPER:TQ6"
      # Search for everything in all models
      # unless defined_models_only is set to true
      # (false by default)
      result = '*:*' if !defined_models_only
    end

    result
  end

  #
  # Return an array of prepared for search fields or query string
  #
  def self.process_search_fields(fields, query_string='')
    #RAILS_DEFAULT_LOGGER.debug "TRACE:PSF0"
    search_fields = []
    fields.each do |f|
      search_field = ''

      #the query for the field is either the specific string in the hash or the default main query string
      q_string = query_string
      field_query_string = f[:query_string]
   
      if !field_query_string.blank?
        q_string = process_search_field(field_query_string)
      end

      #append the query string, or *:* if its blank (ie all)
      #RAILS_DEFAULT_LOGGER.debug "DEBUG: FINDER_HELPER:q_string is #{q_string}"
      query_string_to_append=q_string
      query_string_to_append="(*:*)" if q_string=='()'

      search_field << f[:name] << ':' << query_string_to_append
      search_field << '^' + f[:boost].to_s if f[:boost]
      search_fields.push(search_field)
    end

    return search_fields

  end
  
  #
  # Prepare search string
  #
  def self.process_search_field(q_string)
    
      unless q_string.blank?
        # Remove junk from the query string
        q_string = strip_query(q_string.downcase)

        # numbers case
	if q_string.match(/[0-9]/)
            q_string = "(#{q_string.split.join(' OR ')})"
	    
	# phrase search case
	elsif q_string.match(/\A".*"\Z/)
	    q_string = "(#{q_string})"

	else
	    # Split into bits
            q_string = '(' << q_string.split.map! {|p| p }.join(' OR ') << ')'
        end
	
      end

      return q_string

  end

=begin
fields = [{:name => 'work_title_t', :query_string => 'penguin'},{:name => 'work_description_t', :query_string => 'radio'}]
FinderHelper.build_query(Work, "penguin", fields, query_param_boolean='AND')
=end


  #This method was the original non class method, and has to be this in order that the pagination
  #object is available for the simple searches.  Note with advanced search this is not possible due to the
  #extra post filtering of the SOLR results
  #  RESULT PARSING:
  #  A hash is returned with the following keys:
  #   * :total - the total number of results returned by the query, as an integer
  #   * :docs - an array of actual results objects (or ids) returned by the query in order
  #   * :facets - a hash of results dealing with facets - this will only appear if a facetted query comes in.
  #           This in turn contains the following...
  #         * facet_queries (note - *string*, not symbol) - the facet queries made and hte number of associated results.  This is also a hash.
  #         * facet_fields (note - *string*, not symbol)  - fields that are marked as being faceted, e.g. role_type_id
  #           This is a hash and contains keys that are *strings*, each being a SOLR field name

  # So for example one could get the facet results as follows for a field:
  # result[:facets]['facet_fields']['role_type_id_for_solr_t']
  def solr_query(query, opts={}, ids_only=false)

    options = {:rows => LISTING_PAGE_SIZE}.merge(opts)
    if options.has_key?(:page) and options[:page].is_a?(Integer)
      options[:start] = (options[:page] - 1) * options[:rows]
    elsif options.has_key?(:start)
      options[:page] = options[:start] / options[:rows] + 1
    end




    #GBA - FIXME should we not be using the merged options instead of passed in opts?
    solr_results = FinderHelper.execute_solr_query(query, opts, ids_only)




    if solr_results.length != 0
      [solr_results, Paginator.new(self, solr_results[:total], options[:rows], options[:page])]
    else
      [solr_results, nil]
    end
  end

  #Do the same as solr query but only return ids
  def self.execute_advanced_solr_query(query, opts={})

    opts[:rows] = 65536 #return a lot of hits, these will be SQL filtered
    execute_solr_query(query, opts, ids_only=true)
  end

  #
  # Runs a query as a static method
  # FIXME: Document this
  # Under default use this will return objects.  However for the advanced search its desirable to only have ids
  # To provide these only pass ids_only = false into finder helper
  # Return a hash containing :total => N documents, :docs => ruby objects or ids in the form Contributor:1020,
  # these are the actual solr results
  # GBA: 2007-09-26
  #  The Lucene query and facetting are handled in 2 separate ways.  The query string is formed using the
  # build_query or build_advanced_query methods - this string can be used alone without facetting.
  # If facetting is required you need to pass in the following:
  #   * a key called :facet (symbol) set to the value of true.  No facetting will be done without this
  #   * a key called :facet_zeroes (symbol) set to true or false, a flag as to whether to show zero facets or not
  #   * a key called :facet_fields (symbol) - an array of fields (as symbols) to generate facets for.  Note that this
  #    does no grouping so if you pass in for example (year) you will get a facet for each and every year.  Its
  #    possible for groupings to be indexed by a SOLR query, e.g. year_group_for_solr in class Work
  #   * a key called :facet_queries (symbol).  This contains an array of Lucene queries, as strings, that form groupings - for
  #    example with queries like ["year_of_creation_for_solr_t:[2000 TO 2009]",
  #    "year_of_creation_for_solr_t:[1900 TO 1950]"] - naturally this fails to parse if you use TO in small letters
  #   * the oddly named key [:fq] contains a list of currently selected items.  e.g. if the user clicked on the 2000
  # to 2009 facet, then a string of the form "year_of_creation_for_solr_t:[2000 TO 2009]" is appended to the array.  Other
  # examples are (from work debug) FQ:year_group_for_solr_s:before-1970 of class String, FQ:intended_duration_for_solr_i:[900 TO 1199] of class String

  # :fq            => [],

  # :facet_queries => []
  #
  #  RESULT PARSING:
  #  A hash is returned with the following keys:
  #   * :total - the total number of results returned by the query, as an integer
  #   * :docs - an array of actual results objects (or ids) returned by the query in order
  #   * :facets - a hash of results dealing with facets - this will only appear if a facetted query comes in.
  #           This in turn contains the following...
  #         * facet_queries (note - *string*, not symbol) - the facet queries made and hte number of associated results.  This is also a hash.
  #         * facet_fields (note - *string*, not symbol)  - fields that are marked as being faceted, e.g. role_type_id
  #           This is a hash and contains keys that are *strings*, each being a SOLR field name

  # So for example one could get the facet results as follows for a field:
  # result[:facets]['facet_fields']['role_type_id_for_solr_t']
  #
  def self.execute_solr_query(query, opts={}, ids_only = false)
    options = {:rows => LISTING_PAGE_SIZE}.merge(opts)
    if options.has_key?(:page) and options[:page].is_a?(Integer)
      options[:start] = (options[:page] - 1) * options[:rows]
    elsif options.has_key?(:start)
      options[:page] = options[:start] / options[:rows] + 1
    end

    begin
      query_options = []

      #RAILS_DEFAULT_LOGGER.debug "FINDER HELEPR: About to add facetting bits"
      # If faceting
      if options.has_key?(:facet) and options[:facet] == true
        #RAILS_DEFAULT_LOGGER.debug "FINDER HELEPR:fq of size #{options[:fq].length}"
        #RAILS_DEFAULT_LOGGER.debug "FINDER HELEPR:facet_fields of size #{options[:facet_fields].length}"
        #RAILS_DEFAULT_LOGGER.debug "FINDER HELEPR:facet_queries of size #{options[:facet_queries].length}"

        # Do stuff (defaults)
        options[:fq].each {|k| query_options << {:key => 'fq', :value => k} } if options.has_key?(:fq) and options[:fq].is_a?(Array)
        options.delete(:fq)

        options[:facet_fields].each {|k| query_options << {:key => 'facet.field', :value => k} } if options.has_key?(:facet_fields) and options[:facet_fields].is_a?(Array)
        options.delete(:facet_fields)

        options[:facet_queries].each {|k|
          query_options << {:key => 'facet.query', :value => k}
          #RAILS_DEFAULT_LOGGER.debug "Added facet query #{k}"
        } if options.has_key?(:facet_queries) and options[:facet_queries].is_a?(Array)
        options.delete(:facet_queries)
      end

      options[:q].each {|k| query << ' ' << k} if options.has_key?(:q)
      options.delete(:q)

      # Build the query string
      query_options = query_options.map! {|qo| qo[:key] << '=' << ERB::Util::url_encode(qo[:value]) }.join('&')
      base_options = ''
      options.each_pair{|k,v| base_options << "&#{k}=#{v}" if k != :page } if !options.nil? && options.respond_to?(:each_pair)
      base_options << '&' if base_options.length > 0 and query_options.length > 0

      # Send the request and get the return data
      query_to_post="q=#{ERB::Util::url_encode(query)}&wt=ruby&fl=id&json.nl=map#{base_options}#{query_options}"

      sort = options[:sort]


      if !sort.blank?
        query_to_post << "&#{ERB::Util::url_encode('sort='+sort)}"
      end

      puts "POSTING QUERY:#{query_to_post}"
      response = ActsAsSolr::Post.execute(query_to_post)
      puts "=========="
     # puts response
      puts "=========="
      data = response ? eval(response) : nil

      results = {
        :docs => [],
        :total => 0
      }

      if data
        results[:total] = data['response']['numFound'].to_i

       # puts "TRACE1"
      #  puts data['response']['docs'].to_yaml

        #if we are not having only ids, load the actual objects using active record, then convert them to
        #FRBR objects for display purposes
        if !ids_only
          data['response']['docs'].each{|doc| k = doc.fetch('id').split(':'); results[:docs] << k[0].constantize.find(k[1])}

       #   puts "TRACE2"
      #    puts results

          # Wrap objects in FrbrObject objects. Maybe one day this will disappear
          results[:docs].map! do |doc|
            doc = FrbrObject.new(doc.class.name.downcase, doc)
          end

        #copy the ids over to result docs
        else
          data['response']['docs'].each{|doc| results[:docs] << doc.fetch('id')}

        end

        if data.has_key?('facet_counts')
          results[:facets] = data['facet_counts']
        end
    end

    results

    rescue Exception => e
      RAILS_DEFAULT_LOGGER.error "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      raise "There was a problem executing your search: #{$!}"
    end
  end

  #
  # Year group faceting
  #

  # Given a year, return what top level year group it should be in
  def self.year_group(year)

    case year.to_i
    when 1..1969 then 'before-1970'
    when 1970..1979 then '1970-1979'
    when 1980..1989 then '1980-1989'
    when 1990..1999 then '1990-1999'
    when 2000..2009 then '2000-2009'
    when 2010..2030 then 'since-2010'
    else nil
    end
  end

  # Given a year, return what bottom level subgroup it should be in
  def self.year_subgroup(year)
    case year.to_i
    when 1..1949 then 'before-1950'
    when 1950..1954 then '1950-1954'
    when 1955..1959 then '1955-1959'
    when 1960..1964 then '1960-1964'
    when 1965..1969 then '1965-1969'
    when 1970..2030 then year.to_s
    else nil
    end
  end

  # Build a hash of <b>year group</b> (top level) data, including the counts for each
  # item from the results
  def self.year_groups(results)
    year_groups = [
      {:category => 'before-1970', :name => 'Before 1970', :count => 0},
      {:category => '1970-1979',   :name => '1970 to 1979', :count => 0},
      {:category => '1980-1989',   :name => '1980 to 1989', :count => 0},
      {:category => '1990-1999',   :name => '1990 to 1999', :count => 0},
      {:category => '2000-2009',   :name => '2000 to 2009', :count => 0},
      {:category => 'since-2010',  :name => '2010 onwards', :count => 0}
    ]
    if results.has_key?(:facets)
      year_groups.map! do |v|
        v[:count] = results[:facets]["facet_fields"]["year_group_for_solr_s"][v[:category]]
        v
      end
    end
    year_groups
  end

  # Builds a hash of year subgroup (bottom level) data, including the counts
  # for each item from the results
  def self.year_group_facet_data(year_group, results)
    case year_group
    when 'before-1970'
      facet_data = [
        {:category => 'before-1950', :name => 'Before 1950', :count => 0},
        {:category => '1950-1954', :name => '1950-1954', :count => 0},
        {:category => '1955-1959', :name => '1955-1959', :count => 0},
        {:category => '1960-1964', :name => '1960-1964', :count => 0},
        {:category => '1965-1969', :name => '1965-1969', :count => 0},
      ]
    when 'since-2010'
      facet_data = [
        {:category => 'since-2010', :name => '2010 onwards', :count => 0},
      ]

      # Add a facet for each year from 2010 to now. Might need changing in a
      # few years ^_^
      for year in 2010..Date.today.year
        facet_data.push({
          :category => year.to_s,
          :name     => year.to_s,
          :count    => 0,
        })
      end
    else
      # A facet group like '1970-1979' should be split into years
      parts = year_group.split(/-/)
      facet_data = []
      for i in parts[0].to_i..parts[1].to_i
        facet_data.push({:category => i.to_s, :name => i.to_s, :count => 0})
      end
    end

    # Add the result counts if they're available
    if results.has_key?(:facets)
      facet_data.map! do |v|
        v[:count] = results[:facets]["facet_fields"]["year_subgroup_for_solr_s"][v[:category]]
        v
      end
    end

    facet_data
  end


  #
  # Duration facet
  #

  def self.duration_groups(results)
    duration_groups = [
      {:category => '0-5', :name => 'Less than 5 minutes', :count => 0},
      {:category => '5-10', :name => '5-10 minutes', :count => 0},
      {:category => '10-15', :name => '10-15 minutes', :count => 0},
      {:category => '15-20', :name => '15-20 minutes', :count => 0},
      {:category => '20-30', :name => '20-30 minutes', :count => 0},
      {:category => '30-', :name => 'Longer than 30 minutes', :count => 0},
    ]
    if results.has_key?(:facets)
      duration_groups.map! do |v|
        v[:count] = results[:facets]["facet_queries"]['intended_duration_for_solr_i:' +
          duration_category_to_solr_query(v[:category])]
        v
      end
    end
    duration_groups
  end

  def self.duration_category_to_solr_query(category)
    case category
    when '0-5' then '[1 TO 299]'
    when '5-10' then '[300 TO 599]'
    when '10-15' then '[600 TO 899]'
    when '15-20' then '[900 TO 1199]'
    when '20-30' then '[1200 TO 1799]'
    when '30-' then '[1800 TO *]'
    else ''
    end
  end

  def self.category(subcategory)
    WorkSubcategory.find(subcategory).work_category_id.to_i
  end

  def self.category_groups(results)
    categories = []
    #This simply ignores all of the work subcategories that have their parent as the additional parent
    WorkCategory.find(:all, :conditions => 'additional IS NOT TRUE', :order => 'display_order').each do |wc|
	  name = wc.work_category_desc
	  name = 'Music for Stage' if name =~/Vocal Music for the Stage/

	  categories.push({
        :category => wc.work_category_id,
        :name     => name,
        :count    => 0
      });
    end

   # RAILS_DEFAULT_LOGGER.debug results[:facets].to_yaml

    if results.has_key?(:facets)
      categories.map! do |v|
        v[:count] = results[:facets]["facet_fields"]["category_ids_for_solr_t"][v[:category].to_s]
        v
      end
    end

    categories
  end



  def self.category_facet_data(category, results)
    subcategories = []
    WorkSubcategory.find(:all,  :order => 'display_order',
    :conditions => {:work_category_id => category}).each do |ws|
      subcategories.push({
        :category => ws.work_subcategory_id,
        :name     => ws.work_subcategory_desc,
        :count    => 0
      })
    end


   # RAILS_DEFAULT_LOGGER.debug subcategories.to_yaml
   # RAILS_DEFAULT_LOGGER.debug "RESULTS BIT:"
   # RAILS_DEFAULT_LOGGER.debug results[:facets]["facet_queries"].keys.join(', ')
  #  RAILS_DEFAULT_LOGGER.debug results[:facets]["facet_queries"].keys.map{|k|k.class.to_s}.join(', ')
  #  RAILS_DEFAULT_LOGGER.debug results[:facets]["facet_queries"]["subcategory_ids_for_solr_t"].to_yaml

    if results.has_key?(:facets)
      subcategories.map! do |v|
    #  RAILS_DEFAULT_LOGGER.debug "CHECKING |#{v[:category]}|"

    #  RAILS_DEFAULT_LOGGER.debug "\t*#{results[:facets]['facet_queries']['subcategory_ids_for_solr_t: ' + v[:category].to_s]}"
        v[:count] = results[:facets]["facet_queries"]["subcategory_ids_for_solr_t: " + v[:category].to_s]
        v
      end
    end

    subcategories
  end


  def self.special_subcategory_facets(results, facets_hash)
		result = []
		solr_query = facets_hash[:solr_field].to_s
		RAILS_DEFAULT_LOGGER.debug "DEBUG special: solr_query #{solr_query}"
		facet_fields = results[:facets]["facet_fields"][solr_query]
		RAILS_DEFAULT_LOGGER.debug "DEBUG special: facet_fields #{facet_fields.keys}"
		for facet in facets_hash[:facets]
		  key = facet.keys[0]
		  amount = facet_fields[key.to_s]
		  if amount != nil
			result << {
			  :category => key,
			  :name => facet[key][:text],
			  :count => amount
			}
		  end
		end
		result
	end

  #
  # Suitable For facet
  #

  def self.suitable_for_data(results)
    suitable_for = [
      {:category => '1', :name => 'Beginner',     :count => 0},
      {:category => '2', :name => 'Intermediate', :count => 0},
      {:category => '3', :name => 'Advanced',     :count => 0},

      #Note - youth is a separate facet SOLR wise (different table) so its a bit of a hack
      #to lump it here.  Ho hum
      {:category => '4', :name => 'Youth',     :count => 0}
    ]

    if results.has_key?(:facets)
      for data_row in suitable_for
        category = data_row[:category]

        #Deal with non youth case
        if category != '4'
          data_row[:count] = results[:facets]["facet_fields"]["difficulty_for_solr_t"][data_row[:category]]

        #add youth
        else
          data_row[:count] = results[:facets]["facet_fields"]["suitable_for_youth_for_solr_t"]["1"]

        end
      end
=begin
      suitable_for.map! do |v|
        v[:count] = results[:facets]["facet_fields"]["difficulty_for_solr_t"][v[:category]]
        v
      end
=end

    end

    #Now add the youth option
    #RAILS_DEFAULT_LOGGER.debug suitable_for.to_yaml

    suitable_for


  end


  # Given a concept type of genre, theme or influence obtain the array of hashes representing
  # the facet of that concept type
  def self.concept_data(concept_type,results)
   # #RAILS_DEFAULT_LOGGER.debug "RESULTS IN CONCEPT DATA"

    result = []
    facet_fields = results[:facets]["facet_fields"]

    #genres
    if concept_type == 'genre'
      concepts = Concept.find(:all, :conditions => ["parent_concept_id is null and concept_type_id = ?",
          ConceptType::GENRE.concept_type_id
        ], :order => 'concept_name')
      for concept in concepts
        count = facet_fields["genres_for_solr_t"][concept.concept_id.to_s]
        count = 0 if count.blank?
        result << {
          :category => concept.concept_id.to_s,
          :name => concept.concept_name,
          :count => count
        }
      end

    #influences
    elsif concept_type == 'influence'
      concepts = Concept.find(:all, :conditions => ["parent_concept_id is null and concept_type_id = ?", ConceptType::INFLUENCE.concept_type_id
        ], :order => 'concept_name')
      for concept in concepts
        count = facet_fields["influences_for_solr_t"][concept.concept_id.to_s]
       # #RAILS_DEFAULT_LOGGER.debug "LOOKING FOR KEY #{concept.concept_id} in #{facet_fields['influences_for_solr_t'].keys.join(',')}"
        count = 0 if count.blank?

        result << {
          :category => concept.concept_id.to_s,
          :name => concept.concept_name,
          :count => count
        }
      end



    #themes
    elsif concept_type == 'theme'
      concepts = Concept.find(:all, :conditions => ["parent_concept_id is null and concept_type_id = ?",
        ConceptType::THEME.concept_type_id
        ], :order => 'concept_name')
      for concept in concepts
        count = facet_fields["themes_for_solr_t"][concept.concept_id.to_s]
     #   #RAILS_DEFAULT_LOGGER.debug "LOOKING FOR KEY #{concept.concept_id} in #{facet_fields['influences_for_solr_t'].keys.join(',')}"
        count = 0 if count.blank?

        result << {
          :category => concept.concept_id.to_s,
          :name => concept.concept_name,
          :count => count
        }
      end
    end
 #   #RAILS_DEFAULT_LOGGER.debug result.to_yaml
    ##RAILS_DEFAULT_LOGGER.debug "/RESULTS IN CONCEPT DATA"
    result
  end



  #Convert the facet results for recordings into a form suitable for teh GUI
  def self.recording_formats(results)
    result = []
    facet_fields = results[:facets]["facet_fields"]["available_as_recordings_for_solr_t"]
    for format_id in facet_fields.keys
      format = Format.find(format_id)
      result << {
        :category => format_id.to_s,
        :name => format.format_desc,
        :count => facet_fields[format_id]
      }
    end
     result
  end


  def self.sample_types(results)
    result = []
    facet_fields = results[:facets]["facet_fields"]["available_as_samples_for_solr_t"]
    for key in facet_fields.keys
      result << {
        :category => key,
        :name => "#{FacetHelper::SAMPLE_NAMES[key]}",
        :count => facet_fields[key]
      }
    end
     result
  end

  def self.score_types(results)
    result = []
    facet_fields = results[:facets]["facet_fields"]["available_as_scores_sheets_for_solr_t"]
    for key in facet_fields.keys
      mt = ManifestationType.find(key)
      result << {
        :category => key,
        :name => mt.manifestation_type_desc,
        :count => facet_fields[key]
      }
    end
     result
  end

  def self.resource_type_facets(results)
	  result = []
	  facet_fields = results[:facets]["facet_fields"]["available_as_resource_types_facet_for_solr_t"]
	  RAILS_DEFAULT_LOGGER.debug "DEBUG: facet_fields #{facet_fields.keys}"
	  for facet in FacetHelper::FACET_RESOURCE_TYPES[:facets]
	    key = facet.keys[0]
		amount = facet_fields[key.to_s]
		if amount != nil
		  result << {
			:category => key,
			:name => facet[key][:text],
			:count => amount
		  }
		end
	  end
	  result
  end


  #Convert a date into a string of the form YYYYMMDD - this is the case where you dont care about minutes.
  #Return nil if nil passed
  #time is a Time object
  def self.date_for_solr_ymd(time)
    result = nil
    if !time.blank?
      raise ArgumentError, "The time parameter must be of class Time - the provided param was #{time.class}" if time.class != Time
      #convert to form 20070920 so that string comparisions can happen
      result = time.strftime("%Y%m%d")
    end
    result
  end

  #Convert a date into a string of the form YYYYMMDD - this is the case where you do care about minutes
  #Return nil if nil passed in
  #time is a Time object
  def self.date_for_solr_ymdhms(time)
    result = nil
    if !time.blank?
      raise ArgumentError, "The time parameter must be of class Time" if time.class != Time
      #convert to form 20070920 so that string comparisions can happen
      result = time.strftime("%Y%m%d%H%M")
    end
    result
  end


  #Filter by status if the user is public or a member
  def append_status_filter_if_required(the_login, current_lucene_query)
    result = current_lucene_query
    if !ControllerRestrictionHelper.has_permission_to_search_non_public_tap?(the_login)
      result << " AND status_for_solr_t: #{Status::PUBLISHED.status_id}"
    end
    result
  end


  def self.make_query_more_exact(lucene_query)
    lucene_query.gsub!('* OR', ' AND ')
    lucene_query.gsub!('*', ' ')
    lucene_query
  end


  def self.trailing_commas(array)
    result = ""
    if !array.blank?
      result = array.join(', ')
      result<<','
    end
    result
  end

  def self.find_all_solr_ids(klass)
     # Send the request and get the return data
     query = "type_t: #{klass.to_s}"
      query_to_post="q=#{ERB::Util::url_encode(query)}&wt=ruby&fl=pk_i&rows=10000000"


      response = ActsAsSolr::Post.execute(query_to_post)
      puts response
      data = response ? eval(response) : nil



      if data
        results[:total] = data['response']['numFound'].to_i

      end

      puts results.to_yaml
  end
end
