class Concept < ActiveRecord::Base

  include FrbrHelper
  include FrbrMethodsConcept
  
set_primary_key "concept_id"
set_sequence_name "concepts_concept_id_seq"

belongs_to :concept_type

#This will allow subconcepts
acts_as_tree :foreign_key => :parent_concept_id


acts_as_solr :fields => [
  :frbr_ui_desc, :concept_type_description
]

acts_as_dropdown

#Updated by relationship 
validates_presence_of :login_updated_by
validates_associated :login_updated_by

belongs_to :login_updated_by, 
          :class_name => 'Login',
          :foreign_key => :updated_by
          

validates_presence_of :concept_name
validates_length_of :concept_name, :in => 2..100,
          :allow_nil => false,
          :message => "is not between 2 and 100 chars"

#belongs_to :status

    has_many :concept_relationships
    has_many :relationships, :through => :concept_relationships, :select => "concept_relationships.relationship_type_id, relationships.*"

    def frbr_type
      "concept"
    end

    def frbr_id
      concept_id
    end


    # This allows one to show things like Landscape / Jazz
    def frbr_ui_desc
      result = ""
      if ! parent.blank?
        result << parent.concept_name
        result << ' | '
      end
      result << concept_name
      result << '  ('
      result << concept_type.concept_type_desc
      result << ')'
    end
    
    #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
    #The naming needs to be common to maintain a single partial for list rendering
    def frbr_list_title
      frbr_ui_desc
    end

    def frbr_list_description
      ""
    end
    
    
    
    
    #Used by solr, it will be either 1,2,or 3
    def concept_type_description_id
      concept_type.concept_type_id
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
    
    
    def validate
      #FIXME add test to ensure only one level deep
      if !parent.blank?
        grand_parent = parent.parent
        if !grand_parent.blank?
          errors.add(:parent,"Concepts cannot be sub sub concepts") 
        end
      end
    end
    
    # -----------------------------------------------
    # - Return concepts with parent_concept_id NULL -
    # - based on requested concept type             -
    # -----------------------------------------------
    def self.get_main_categories(concept_type_desc)
      concepts = ''
      if !concept_type_desc.blank?
        concept_type_id = ConceptType.find(:first, :select => 'concept_type_id', :conditions => ['LOWER(concept_type_desc) =?', concept_type_desc.downcase])
        
        concepts = Concept.find(:all, :conditions => ['concept_type_id =? and parent_concept_id IS null', concept_type_id], :order => 'concept_name')
      end
      return concepts

    end


end
