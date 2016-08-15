class ResourceRelationship < ActiveRecord::Base
  set_primary_key "resource_relationship_id"
  set_sequence_name "resource_relationships_resource_relationship_id_seq"
  belongs_to :resource
  belongs_to :relationship
  belongs_to :relationship_type
end
