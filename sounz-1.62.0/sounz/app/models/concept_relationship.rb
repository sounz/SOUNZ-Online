class ConceptRelationship < ActiveRecord::Base
set_primary_key "concept_relationship_id"
set_sequence_name "concept_relationships_concept_relationship_id_seq"
belongs_to :concept
belongs_to :relationship
belongs_to :relationship_type
end
