class EventRelationship < ActiveRecord::Base
set_primary_key "event_relationship_id"
set_sequence_name "event_relationships_event_relationship_id_seq"
belongs_to :event
belongs_to :relationship
belongs_to :relationship_type


def indexable_text

end

end
