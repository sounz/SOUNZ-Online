class EntityType < ActiveRecord::Base

set_sequence_name "entity_types_id_seq"
set_primary_key "entity_type_id"

  #The constant is populated in environment.rb
  def self.find_by_symbol(name)
    if name.to_s == 'distinctioninstance'
      name='distinction_instance'.to_sym
    end
    ENTITY_TYPES_CACHED[name]  
  end


def self.entityIdToType(id)
  entitytype=self.find(id)
  entitytype.entity_type
  end

  def self.entityTypeToId(type)
    entitytype=self.find(:all,:conditions => ["entity_type = ?", type] )
    if entitytype[0].id != nil
     entitytype[0].id
    else
      #FIXME: raise an error!
      0
    end
  end

end
