require 'erb'

class FrbrCodeGenerator
  
  # Generate code for a single FRBR relationship
  def self.generate_code_for_relationship(known_as, relationship_type_symbol,entity_type2_plural )
    how_many = entity_type2_plural.to_s.gsub('which', 'how_many').to_sym
    template = ERB.new <<-EOF
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  <%=relationship_type_symbol%> to <%=entity_type2_plural%>
      #
      def <%=known_as%>
          find_related_frbr_objects( :<%=relationship_type_symbol%>, :<%=entity_type2_plural%>)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  <%=relationship_type_symbol%> to <%=entity_type2_plural%>
      #
      def number_of_<%=known_as%>(login = nil)
          count_by_frbr( login, :<%=relationship_type_symbol%>, :<%=how_many%>)   
      end
      
      
    EOF
    
    return template.result(binding)
    
=begin
      puts "ADDING REL: #{self.class.to_s}_#{id}.#{known_as} with #{relationship_type_symbol} to #{entity_type2_plural}"
      define_method(known_as) do
              find_related_frbr_objects( relationship_type_symbol, entity_type2_plural)
      end
      
      how_many = entity_type2_plural.to_s.gsub('which', 'how_many').to_sym
      
      puts "ADDING CTR: number_of_#{known_as} with #{relationship_type_symbol} to #{entity_type2_plural}"
      define_method("number_of_"+known_as.to_s) do
          count_by_frbr(relationship_type_symbol, how_many)
      end
=end
  end


  
  #----------------------------------------------------------------------------------------
  #- From teh valid relationships table create all the methods as expressed in that table -
  #- A call to this would look like include_all_valid_relationships(:work)
  #----------------------------------------------------------------------------------------
  def self.generate_code_for_valid_relationships(entity_type_symbol)
    klass_name = "frbr_methods_" + entity_type_symbol.to_s
    entity_type = EntityType.find_by_symbol(entity_type_symbol)
    valid_eers = ValidEntityEntityRelationship.find(:all, :conditions => ["entity_type_from_id  = ?",entity_type.id])
     
    puts "The entity type *#{entity_type.entity_type}* has the following valid possible relationships"
    result = "module "
    result << klass_name.camelize
    result << "\n\n"
    
     for veer in valid_eers
       d = RelationshipType.find(veer.relationship_type_id).relationship_type_desc
        d.downcase!
         d.gsub!(' ','_')
         d.gsub!('(', '')
         d.gsub!(')', '')
         d.strip!
        
         relationship_type_sym = d.to_sym
       entity_type_to = "which_"+EntityType.find(veer.entity_type_to_id).entity_type+"s?"
       entity_type_to_sym = entity_type_to.to_sym
       puts "***** Adding relationship "+entity_type.entity_type+' ' +relationship_type_sym.to_s+" "+entity_type_to.to_s
       meths = generate_code_for_relationship veer.ruby_method_name.to_sym, relationship_type_sym, entity_type_to_sym
       result << meths
     end
     
     
     result << 'end'
     output_file_name = "/tmp/#{klass_name}.rb"
     file = File.new(output_file_name, "w")
     file.puts result
     file.close
     
     puts output_file_name
     
     
  end
  
  #- Generate code for all FRBR classes
  def self.generate_all_frbr_classes
    FrbrCodeGenerator.generate_code_for_valid_relationships(:concept)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:role)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:expression)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:manifestation)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:event)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:distinction_instance)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:resource)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:superwork)
    FrbrCodeGenerator.generate_code_for_valid_relationships(:work)
   
  end

  
  
end