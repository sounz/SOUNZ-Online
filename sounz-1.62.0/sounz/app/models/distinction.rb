class Distinction < ActiveRecord::Base

    
    include FrbrHelper
    include FrbrMethodsDistinction
    
    
    
    set_primary_key 'distinction_id'
    set_sequence_name 'distinctions_distinction_id_seq'
    
    belongs_to :status
    
    #Updated by relationship 
    validates_presence_of :login_updated_by
    #validates_associated :login_updated_by

    belongs_to :login_updated_by, 
              :class_name => 'Login',
              :foreign_key => :updated_by
    
    belongs_to :contactinfo
    has_many :distinction_instances, :order => 'award_year DESC'
    
	has_many :distinction_relationships, :dependent => :destroy
	has_many :relationships, :through => :distinction_relationships, :select => "distinction_relationships.relationship_type_id, relationships.*"	
    
	has_many :distinction_distinction_types
	has_and_belongs_to_many :distinction_types, :join_table => :distinction_distinction_types
	#Distinctions

#    FrbrHelper.include_relationship :works_awarded, :is_awarded_to, :which_works?
#    FrbrHelper.include_relationship :expressions_awarded, :is_awarded_to, :which_expressions?
#    FrbrHelper.include_relationship :manifestations_awarded, :is_awarded_to, :which_manifestations?
#    FrbrHelper.include_relationship :resources_awarded, :is_awarded_to, :which_resources?
#    FrbrHelper.include_relationship :events_awarded, :is_awarded_to, :which_events?
#    FrbrHelper.include_relationship :venues_awarded, :is_awarded_to, :which_venues?

#    FrbrHelper.include_relationship :concepts, :has_as_its_genre, :which_concepts?
    
#     FrbrHelper.include_relationship :winners, :is_received_by, :which_contributors?
#     FrbrHelper.include_relationship :presenters, :is_presented_by, :which_contributors?
#     FrbrHelper.include_relationship :funders_or_sponsors, :is_awarded_to, :which_contributors?
#     FrbrHelper.include_relationship :administrators, :is_administered_by, :which_contributors?
     
     
     
    def frbr_type
      "distinction"
    end

    def frbr_id
    distinction_id
    end

    def frbr_ui_desc
    award_name
    end
	
	def frbr_list_title
	  award_name
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
    
    # WR#50294 - DISTINCTIONS rev 300308.doc
    def current_opportunities
      current_opportunities = happening_distinctions.select{|o| !o.entry_deadline.blank? && o.entry_deadline > Time.now}
	  return current_opportunities
    end
    
end
