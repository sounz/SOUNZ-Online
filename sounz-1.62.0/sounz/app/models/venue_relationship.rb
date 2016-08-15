class VenueRelationship < ActiveRecord::Base
set_primary_key "venue_relationship_id"
set_sequence_name "venue_relationships_venue_relationship_id_seq"
belongs_to :venue
belongs_to :relationship
belongs_to :relationship_type
end
