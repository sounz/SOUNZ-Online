module ActsAsSolr #:nodoc:
  
  module InstanceMethods

    def solr_id
      "#{self.class.name}:#{self.id}"
    end

    # saves to the Solr index
    def solr_save
      if evaluate_condition(:if, self)
        logger.debug "solr_save: #{self.class.name} : #{self.id}"
        xml = REXML::Element.new('add')
        xml.add_element to_solr_doc
        response = ActsAsSolr::Post.execute(xml.to_s, :update)
        solr_commit
        true
      else
        solr_destroy
      end
    end

    # remove from index
    def solr_destroy
      logger.debug "solr_destroy: #{self.class.name} : #{self.id}"
      ActsAsSolr::Post.execute("<delete><id>#{solr_id}</id></delete>", :update)
      solr_commit
      true
    end

    def solr_commit
      ActsAsSolr::Post.execute('<commit waitFlush="false" waitSearcher="false"/>', :update)
    end

    # convert instance to Solr document
    def to_solr_doc
      #logger.debug "to_doc: creating doc for class: #{self.class.name}, id: #{self.id}"
      doc = REXML::Element.new('doc')

      # Solr id is <classname>:<id> to be unique across all models
      doc.add_element field("id", solr_id)
      doc.add_element field(solr_configuration[:type_field], self.class.name)
      doc.add_element field(solr_configuration[:primary_key_field], self.id.to_s)

      # iterate through the fields and add them to the document,
      configuration[:solr_fields].each do |field|
        field_name = field
        field_type = !configuration[:facets].nil? && configuration[:facets].include?(field.is_a?(String) ? field.to_sym : field) ? "facet" : "t"
        if field.is_a?(Hash)
          field_name = field.keys[0]
          field_type = get_solr_field_type(field.values[0])
        end
        value = self.send("#{field_name}_for_solr")
        
        # add the field to the document, but only if it's not the id field
        # or the type field (from single table inheritance), since these
        # fields have already been added above.
        if (field.to_s != "id") and (field.to_s != "type")
          doc.add_element field("#{field_name}_#{field_type}", value.to_s)
        end
      end
      
      add_includes(doc) unless configuration[:include].nil?
      #logger.debug doc
      return doc
    end
    
    def field(name, value)
      field = REXML::Element.new("field")
      field.add_attribute("name", name)
      field.add_text(value)
      field
    end
    
    private
    def add_includes(xml_doc)
      if configuration[:include].is_a?(Array)
        configuration[:include].each do |association|
          data = ""
          klass = association.to_s.singularize
          case self.class.reflect_on_association(association).macro
          when :has_many, :has_and_belongs_to_many
            records = self.send(association).to_a
            unless records.empty?
              records.each{|r| data << r.attributes.inject([]){|k,v| k << "#{v.first}=#{v.last}"}.join(" ")}
              xml_doc.add_element field("#{klass}_t", data)
            end
          when :has_one, :belongs_to
            record = self.send(association)
            unless record.nil?
              data = record.attributes.inject([]){|k,v| k << "#{v.first}=#{v.last}"}.join(" ")
              xml_doc.add_element field("#{klass}_t", data)
            end
          end
        end
      end
    end

    def condition_block?(condition)
      condition.respond_to?("call") && (condition.arity == 1 || condition.arity == -1)
    end
    
    def evaluate_condition(which_condition, field)
      condition = configuration[which_condition]
      case condition
        when Symbol
          field.send(condition)
        when String
          eval(condition, binding)
        when FalseClass, NilClass
          false
        when TrueClass
          true
        else
          if condition_block?(condition)
            condition.call(field)
          else
            raise(
              ArgumentError,
              "The :#{which_condition} option has to be either a symbol, string (to be eval'ed), proc/method, true/false, or " +
              "class implementing a static validation method"
            )
          end
        end
    end


  end
  
end
