class Venue < ActiveRecord::Base
  include FrbrHelper
  include Comparable
  
  include FrbrMethodsVenue
  
  set_primary_key "venue_id" 
  set_sequence_name "venues_venue_id_seq" 
  belongs_to :contactinfo
  belongs_to :status
  has_many :venue_relationships
  has_many :relationships, :through => :venue_relationships, :select => "venue_relationships.relationship_type_id, relationships.*"
  has_many :events
  
  has_many :venue_attachments
  has_many :media_items, :through => :venue_attachments

  acts_as_solr :fields => [:venue_name, :venue_description, :general_note, :internal_note]
  
  
  
  #=== validation ===
  validates_associated :status, :contactinfo
   
   validates_presence_of :status, :contactinfo, :venue_name
   
   validates_length_of :venue_name, :in => 2..100,
   :allow_nil => false,
   :message => "is not between 2 and 100 chars"

  def frbr_type
    "venue"
  end

  def frbr_id
    venue_id
  end

  def frbr_ui_desc
    venue_name
  end

  #TODO: should really subclass frbr_object types from a class that defines this method once.
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
