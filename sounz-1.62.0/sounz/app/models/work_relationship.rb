class WorkRelationship < ActiveRecord::Base
set_primary_key "work_relationship_id"
set_sequence_name "work_relationships_work_relationship_id_seq"
belongs_to :work
belongs_to :relationship
belongs_to :relationship_type
end