class RelationshipType < ActiveRecord::Base
set_primary_key "relationship_type_id"
set_sequence_name "relationship_types_relationship_type_id_seq"

@@rships = nil #FIXME investigate behaviour upon new class generation, is this reset to nil?


def self.find_by_symbol(relationship_name_as_sym)
 REL_TYPES_CACHED[relationship_name_as_sym]
end


#- Find a relationship type by its symbol, e.g. 
#- RelationshipType.find_by_symbol(:is_composed_by)
def self.find_by_symbol2(name)
  if @@rships == nil
    @@rships = {}
    rts = RelationshipType.find(:all, :order => :relationship_type_desc)
    for rt in rts
        d = rt.relationship_type_desc
        d.downcase!
        d.gsub!(' ','_')
        d.gsub!('(', '')
        d.gsub!(')', '')
        d.strip!
        puts d
        @@rships[d.to_sym] = rt
    end
   
  end
  
  
   return @@rships[name]
end

end
