class DistinctionInstance < ActiveRecord::Base
  
  include FrbrHelper
  include FrbrMethodsDistinctionInstance

  set_primary_key "distinction_instance_id"
  set_sequence_name "distinction_instances_distinction_instance_id_seq"

  belongs_to :status
  
  has_many :distinction_instance_relationships, :dependent => :destroy
  has_many :relationships, :through => :distinction_instance_relationships, :select => "distinction_instance_relationships.relationship_type_id, relationships.*"
    
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
   
  belongs_to :distinction
  belongs_to :contributor
  belongs_to :event

  acts_as_solr :fields => [
	  :instance_info_for_solr,
	  :award_name_for_solr  
  ]
    
  def award_name_for_solr
    return FinderHelper.strip(distinction.award_name)
  end
  
  def instance_info_for_solr
    return FinderHelper.strip(instance_info)
  end
  
    def frbr_type
      "distinction_instance"
    end

    def frbr_id
    distinction_instance_id
    end

    def frbr_ui_desc
    distinction.award_name+" (#{award_year})"
    end


    #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
    #The naming needs to be common to maintain a single partial for list rendering
    def frbr_list_title
      distinction.award_name
    end

    def frbr_list_description
      award_year
    end
    
    
    def frbr_relationships
      frbr_relationships=Array.new()
      for rel in relationships.uniq
        reltype=RelationshipType.find(rel.relationship_type_id)
        
        #Choose the entity_type that does not match this one.
        #Where both are the same, it does not matter which we pick
        my_entity=EntityType.entityTypeToId(rel.ent_entity_type_id)
        if EntityType.entityTypeToId(rel.ent_entity_type_id) == frbr_type() then 
          my_entity= EntityType.entityTypeToId(rel.entity_type_id)
        end
        
        related_objects=eval('rel.'+my_entity+'s')
        
        for related_object in related_objects
          if rel.entity_type_id == rel.ent_entity_type_id then
            if related_object.id != id then
              frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
            end
          else 
          frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
          end
        end
      end
    frbr_relationships
    end
  

end
