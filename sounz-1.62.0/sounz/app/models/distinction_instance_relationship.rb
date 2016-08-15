class DistinctionInstanceRelationship < ActiveRecord::Base
  set_primary_key "distinction_instance_relationship_id"
  set_sequence_name "distinction_instance_relationships_distinction_instance_relationship_id_seq"
  belongs_to :distinction_instance, :foreign_key => 'distinction_instance_id'
  
  belongs_to :relationship
  belongs_to :relationship_type
end
