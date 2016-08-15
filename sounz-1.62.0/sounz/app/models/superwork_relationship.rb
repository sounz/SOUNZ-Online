class SuperworkRelationship < ActiveRecord::Base
set_primary_key "superwork_relationship_id"
set_sequence_name "superwork_relationships_superwork_relationship_id_seq"
belongs_to :superwork
belongs_to :relationship
belongs_to :relationship_type
end
