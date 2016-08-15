require File.dirname(__FILE__) + '/common_methods'

module ActsAsSolr #:nodoc:

  module ClassMethods
    include CommonMethods
    
    #this is the number of documents that will be indexed in batches for rebuild_solr_index
    BATCH_REINDEX_SIZE=100
    
    # Finds instances of a model. Terms are ANDed by default, can be overwritten 
    # by using OR between terms
    # 
    # Here's a sample (untested) code for your controller:
    # 
    #  def search
    #    results = Book.find_by_solr params[:query]
    #  end
    # 
    # You can also search for specific fields by searching for 'field:value'
    # 
    # ====options:
    # start:: - The first document to be retrieved (offset)
    # rows::  - The number of rows per page
    # field_types:: Use this option if you had set a field type on your acts_as_solr call:
    # 
    #                 class Electronic < ActiveRecord::Base
    #                   acts_as_solr :fields => [{:price => :range_float}]
    #                   def current_time
    #                     Time.now
    #                   end
    #                 end
    # 
    #               Then on your search you would do:
    # 
    #                 Electronic.find_by_solr "ipod AND price:[* TO 59.99]", 
    #                                         :field_types => [{:price => :range_float}]
    # 
    # 
    def find_by_solr(query, options={})
      data = process_query(query, options)

      if data
        docs = data['response']['docs']
        return [] if docs.size == 0
        ids = docs.collect {|doc| doc["#{solr_configuration[:primary_key_field]}"]}
        conditions = [ "#{self.table_name}.#{primary_key} in (?)", ids ]
        result = self.find(:all, :conditions => conditions)
        reorder(result, ids)
      end            
    end
    
    # Finds instances of a model and returns a hash with the documents and the
    # faceted search results:
    # 
    #  def search
    #    records = Electronic.find_with_facet "memory", :facets => {:fields =>[:category]}
    #  end
    # 
    # ====options:
    # Accepts the same options as find_by_solr plus:
    # facets:: This option argument accepts two other arguments:
    #          fields:: The fields to be included in the faceted search (Solr's facet.field)
    #          query:: The queries to be included in the faceted search (Solr's facet.query)
    # 
    # Example:
    # 
    #   Electronic.find_with_facet "memory", :facets => {:query => ["price:[* TO 200]",
    #                                                               "price:[200 TO 500]",
    #                                                               "price:[500 TO *]"],
    #                                                    :fields => [:category, :manufacturer]}
    def find_with_facet(query, options={})
      data = process_query(query, options)
      if data
        docs = data['response']['docs']
        return { :docs => [], :facets => { 'facet_fields' => []}} if docs.size == 0
        ids = docs.collect {|doc| doc["#{solr_configuration[:primary_key_field]}"]}
        conditions = [ "#{self.table_name}.#{primary_key} in (?)", ids ]
        result = self.find(:all, :conditions => conditions)
        {:docs => reorder(result, ids), :facets => data['facet_counts'], :total => data['response']['numFound'].to_i}
      end            
    end
    
    # Finds instances of a model and returns an array with the ids:
    #  Book.find_id_by_solr "rails" => [1,4,7]
    # The options accepted are the same as find_by_solr
    # 
    def find_id_by_solr(query, options={})
      
      data = process_query(query, options)

      if data
        docs = data['response']['docs']
        ids = docs.collect {|doc| doc["#{solr_configuration[:primary_key_field]}"]}
        return docs.size == 0 ? [] : ids
      end            
    end
    
    # This method can be used to execute a search across multiple models:
    #   Book.multi_solr_search "Napoleon OR Tom", :models => [Movie]
    # 
    # ====options:
    # Accepts the same options as find_by_solr plus:
    # models:: The additional models you'd like to include in the search
    # results_format:: Specify the format of the results found
    #                  :objects :: Will return an array with the results being objects (default). Example:
    #                               Book.multi_solr_search "Napoleon OR Tom", :models => [Movie], :results_format => :objects
    #                  :ids :: Will return an array with the ids of each entry found. Example:
    #                           Book.multi_solr_search "Napoleon OR Tom", :models => [Movie], :results_format => :ids
    #                           => [{"id" => "Movie:1"},{"id" => Book:1}]
    #                          Where the value of each array is as Model:instance_id
    # 
    def multi_solr_search(query, options = {})
      models = "AND (#{solr_configuration[:type_field]}:#{self.name}"
      options[:models].each{|m| models << " OR type_t:"+m.to_s} if options[:models].is_a?(Array)
      options.update(:results_format => :objects) unless options[:results_format]
      data = process_query(query, options, models<< ")")
      result = []
      if data
        docs = data['response']['docs']
        return [] if docs.size == 0
        if options[:results_format] == :objects
          docs.each{|doc| k = doc.fetch('id').split(':'); result << k[0].constantize.find_by_id(k[1])}
          result
        elsif options[:results_format] == :ids
          docs
        end
      end
    end
    
    # returns the total number of documents found in the query specified:
    #  Book.count_by_solr 'rails' => 3
    # 
    def count_by_solr(query)        
      data = process_query(query)
      data ? data['response']['numFound'] : 0
    end
            
    # It's used to rebuild the Solr index for a specific model. 
    #  Book.rebuild_solr_index
    #def rebuild_solr_index
    #  self.find(:all).each {|content| content.solr_save}
    #  solr_optimize
    #  logger.debug self.count>0 ? "Index for #{self.name} has been rebuilt" : "Nothing to index for #{self.name}"
    #end
    
    
    #Testing out how the methods are attached
    def index_objects(list_of_objects)
      puts "ioasudfoisuf"
      puts list_of_objects
      
      xml = REXML::Element.new('add')
      for object_to_index in list_of_objects
          xml.add_element object_to_index.to_solr_doc
      end

       # Add the new stuff
      xml = xml.to_s
      logger.debug "Adding: XML document length = " + xml.length.to_s
      response = ActsAsSolr::Post.execute(xml, :update)
      logger.debug response
    
      solr_commit
      
    end
    

    # New version of rebuild_solr_index, designed to post many documents at once
    # Simple version at the moment: build all at once
    # FIXME: allow configurable amounts to be sent at a time. Send the patch upstream.
    def rebuild_solr_index(commit_after_initial_delete = false)

      start_time = Time.now
      
      # Delete everything
      logger.debug 'Deleting every ' + self.to_s
      query_string = '<delete><query>type_t:' + self.to_s + '</query></delete>'
      response = ActsAsSolr::Post.execute(query_string, :update)
      logger.debug response
      
      #By default do not commit the initial delete as this blocks searching
      if commit_after_initial_delete
        solr_commit
      end
         
      #Find the number of documents to be indexed
      n_objects = self.count

      iterations = n_objects/BATCH_REINDEX_SIZE
      for i in 0..iterations
        logger.debug "**********"
        logger.debug "INDEXING ITERATION #{i}, INDEXED #{i*BATCH_REINDEX_SIZE}"
        xml = REXML::Element.new('add')
        self.find(:all, :offset => (i*BATCH_REINDEX_SIZE), :limit => BATCH_REINDEX_SIZE).each do |content|
          xml.add_element content.to_solr_doc
          
          #Uncomment this to see what text is being indexed
          #logger.debug "Indexing text:#{content.to_solr_doc}"
        end

        # Add the new stuff
        xml = xml.to_s
        logger.debug "Adding: XML document length = " + xml.length.to_s
        response = ActsAsSolr::Post.execute(xml, :update)
        logger.debug response
      end
      solr_commit
      solr_optimize
      true
      
    end_time = Time.now
    
    elapsed_time = end_time-start_time
    logger.debug "INDEXING TIME:#{elapsed_time}"
    end

    # optimize solr index
    def solr_optimize
      ActsAsSolr::Post.execute('<optimize waitFlush="false" waitSearcher="false"/>', :update)
    end
    
    def solr_commit
      ActsAsSolr::Post.execute('<commit/>', :update)
    end
    
    
    
    
    private
    def process_query(query=nil, options={}, models=nil)
      valid_options = [:start, :rows, :facets, :models, :results_format, :field_types, :sort_by, :operator]
      query_options = {}
      search_options = []
      return if query.nil?
      raise "Invalid parameters: #{(options.keys - valid_options).join(',')}" unless (options.keys - valid_options).empty?
      begin
        query_options[:start] = options[:start] if options[:start]
        query_options[:rows] = options[:rows] if options[:rows]
        query_options['q.op'] = options[:operator] if options[:operator]
        
        # first steps on the facet parameter processing
        if options[:facets]
          query_options[:facet] = true
          query_options["facet.zeros"] = false
          query_options["facet.zeros"] = options[:facets][:zeros] if options[:facets][:zeros]
          query_options["facet.sort"] = true
          search_options << options[:facets][:refine_by].collect{|k| "fq=#{ERB::Util::url_encode(k)}"}.join("&") if options[:facets][:refine_by]
          search_options << options[:facets][:fields].collect{|k| "facet.field=#{k}_facet"}.join("&") if options[:facets][:fields]
          search_options << options[:facets][:query].collect{|k| "facet.query=#{k.sub!(/ *: */,"_facet:")}"}.join("&") if options[:facets][:query]
          search_options << options[:facets][:rawquery].collect{|k| "facet.query=#{ERB::Util::url_encode(k)}"}.join("&") if options[:facets][:rawquery]
        end
        
        if models.nil?
          models = "AND #{solr_configuration[:type_field]}:#{self.name}"
          field_list = solr_configuration[:primary_key_field]
        else
          field_list = "id"
        end
        
        query_options.each_pair{|k,v| search_options << "#{k}=#{v}"} if !query_options.nil? && query_options.respond_to?(:each_pair)
        search_options = search_options.join("&")
        query = "(#{query.gsub(/ *: */,"_t:")}) #{models}"  
        # Patch: gets around not allowing *:* search
        query = query.gsub(/\*_t:\*/, '*:*')
        
        if options[:field_types] && options[:field_types].is_a?(Hash)
          options[:field_types].each{|k,v| 
            field = "#{k.to_s}_#{get_solr_field_type(v.to_sym)}:"
            query = query.gsub(/#{k.to_s}_t:/,field)
            search_options = search_options.gsub(/#{k.to_s}_t:/,field)
          }
        end 
               
        query_for_posting = "q=#{ERB::Util::url_encode(query)}&wt=ruby&json.nl=map&fl=#{field_list}&#{search_options}"
        
        logger.debug "QUERY FOR POSTING:#{query_for_posting}"
        response = ActsAsSolr::Post.execute(query_for_posting)
        response ? eval(response) : nil
      rescue
        raise "There was a problem executing your search: #{$!}"
      end
    end
    
    
    
    def reorder(things, ids)
      ordered_things = []
      ids.each do |id|
        ordered_things << things.find {|thing| thing.id.to_i == id.to_i}
      end
      ordered_things
    end
    
  end
  
end
