module ActsAsSolr #:nodoc:
  
  module CommonMethods
    
    # Converts field types into Solr types
    def get_solr_field_type(field_type)
      case field_type
        when :float:          return "f"
        when :integer:        return "i"
        when :boolean:        return "b"
        when :string:         return "s"
        when :date:           return "d"
        when :range_float:    return "rf"
        when :range_integer:  return "ri"
      else
        raise "Unknow field type: #{field_type}"
      end
    end
    
  end
  
end