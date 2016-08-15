class DistinctionRelationship < ActiveRecord::Base
  set_primary_key "distinction_relationship_id"
  set_sequence_name "distinction_relationships_distinction_relationship_id_seq"
  belongs_to :distinction, :foreign_key => 'distinction_id'
  
  belongs_to :relationship
  belongs_to :relationship_type
end
