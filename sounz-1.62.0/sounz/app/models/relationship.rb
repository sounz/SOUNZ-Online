class Relationship < ActiveRecord::Base
    set_sequence_name "relationships_relationship_id_seq"
    set_primary_key "relationship_id" 
    

    
    belongs_to :relationship_type
    
  has_many :superwork_relationships, :dependent => :destroy
  has_many :work_relationships, :dependent => :destroy
	#has_many :contributor_relationships
  has_many :role_relationships, :dependent => :destroy
	has_many :expression_relationships, :dependent => :destroy
	has_many :manifestation_relationships, :dependent => :destroy
	has_many :event_relationships, :dependent => :destroy
	has_many :concept_relationships, :dependent => :destroy
	has_many :distinction_relationships, :dependent => :destroy
	has_many :distinction_instance_relationships, :dependent => :destroy
	has_many :resource_relationships, :dependent => :destroy
	
    has_many :superworks, :through => :superwork_relationships, :select => "superwork_relationships.relationship_type_id, superworks.*"
	  has_many :works, :through => :work_relationships, :select => "work_relationships.relationship_type_id, works.*"
	#has_many :contributors, :through => :contributor_relationships, :select => "contributor_relationships.relationship_type_id, contributors.*"
    has_many :roles, :through => :role_relationships, :select => "role_relationships.relationship_type_id, roles.*"
    has_many :expressions, :through => :expression_relationships, :select => "expression_relationships.relationship_type_id, expressions.*"
    has_many :manifestations, :through => :manifestation_relationships, :select => "manifestation_relationships.relationship_type_id, manifestations.*"   
    has_many :events, :through => :event_relationships, :select => "event_relationships.relationship_type_id, events.*"
    has_many :concepts, :through => :concept_relationships, :select => "concept_relationships.relationship_type_id, concepts.*"
    has_many :distinction_instances, :through => :distinction_instance_relationships, :select => "distinction_instance_relationships.relationship_type_id, distinction_instances.*"
	has_many :distinctions, :through => :distinction_relationships, :select => "distinction_relationships.relationship_type_id, distinctions.*"
    has_many :resources, :through => :resource_relationships, :select => "resource_relationships.relationship_type_id, resources.*"
    

    def destroy_inter_relationships(rel_id,rel_entity_type_id)
        sql = ActiveRecord::Base.connection()
        sql.execute("DELETE from "+EntityType.entityIdToType(rel_entity_type_id)+"_relationships WHERE relationship_id = "+  rel_id.to_s)
    end


    # Save an interrelationship - returns true if saved, false if not
    def make_inter_relationship(rel_id,rel_entity_type_id,object_id,rel_type_id)
        entity_type=EntityType.entityIdToType(rel_entity_type_id)
        type=Inflector.camelize(entity_type)
        logger.debug("TYPE: #{type}")
        #special case
        #if type.to_s=='DistinctionInstance'
        #  @inter_rel=DistinctionRelationship.new()
        #else
          @inter_rel=eval(type+'Relationship.new()')
        #end
        
        @inter_rel.relationship_id=rel_id
        eval('@inter_rel.'+entity_type+'_id=object_id')
        @inter_rel.relationship_type_id=rel_type_id
        return @inter_rel.save()
    end
    
    
    #Some relationships are superseded by the database.  As such dont allow these are not allowed to be edited in
    #the relationships widget.
    def is_editable?
      #We need to find the relationship type first
      logger.debug("TYPE IS EDITABLE?: #{EntityType.find(entity_type_id).entity_type}")
      entity_type_from_name = EntityType.find(entity_type_id).entity_type
      #special case
      #if (entity_type_from_name.to_s=='distinction_instance')
      #  rels_table_name = 'distinction_relationship'
      #else
        rels_table_name = entity_type_from_name +'_relationship'
      #end
      
     puts "RELTABNAME:#{rels_table_name}"
      rails_klass = Inflector.camelize(rels_table_name).constantize
      puts "RAILS CLASS IS #{rails_klass}"
      klass_relation_instance = rails_klass.find(:first, :conditions => ["relationship_id = ?", relationship_id]).relationship_type
      puts "class_rel is #{klass_relation_instance.relationship_type_desc}"
      puts "Searching for veer:  [entity_type_from_id=#{entity_type_id} and entity_type_to_id = #{ent_entity_type_id} "+
          " and relationship_type_id = #{klass_relation_instance.relationship_type_id}"

      relationship_type_id = klass_relation_instance.relationship_type_id
      puts "relationship type id:#{relationship_type_id}"
      puts "ent from id:#{entity_type_id}"
      puts "ent to id:#{ent_entity_type_id}"
      veer = ValidEntityEntityRelationship.find(:first,
          :conditions => ["relationship_type_id = ? and entity_type_from_id=? and entity_type_to_id =?",
            relationship_type_id, entity_type_id, ent_entity_type_id,]
      )
      if veer != nil
        return veer.user_maintainable
      else
        return false
      end
    end











    
end
