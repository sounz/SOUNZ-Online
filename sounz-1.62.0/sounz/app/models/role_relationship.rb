class RoleRelationship < ActiveRecord::Base

set_primary_key "role_relationship_id"
set_sequence_name "role_relationships_role_relationship_id_seq"
belongs_to :role
belongs_to :relationship
belongs_to :relationship_type

end
