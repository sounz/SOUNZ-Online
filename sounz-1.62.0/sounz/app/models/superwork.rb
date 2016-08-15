class Superwork < ActiveRecord::Base
  include FrbrHelper
  include FrbrMethodsSuperwork
      
	set_primary_key "superwork_id"
	set_sequence_name "superworks_superwork_id_seq" 
    belongs_to :status
	has_many :superwork_relationships
	has_many :works, :order => :work_title
	has_many :relationships, :through => :superwork_relationships, :select => "superwork_relationships.relationship_type_id, relationships.*"
  
  
  acts_as_solr :fields => [ :superwork_title_for_solr, :superwork_title_alt_for_solr ]
      
  validates_presence_of :superwork_title
  validates_length_of :superwork_title, :in => 2..255
      
  #Updated by relationship
  validates_presence_of :login_updated_by
  validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by


def superwork_title_for_solr
  FinderHelper.strip(superwork_title)
end

def superwork_title_alt_for_solr
  FinderHelper.strip(superwork_title_alt)
end
        
def frbr_type
  "superwork"
end

def frbr_id
superwork_id
end

def frbr_ui_desc
superwork_title
end


def frbr_list_title
  superwork_title
end

def frbr_list_description
  ""
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



#Helper method for showing brief view - composers who have composed works based on this superwork are requierd 
#to be shown
def works_evidenced_composers
  all_composers = []
  works.map{|w| all_composers << w.composers}
  all_composers.flatten!
end



end
