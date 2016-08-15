class VenueAttachment < ActiveRecord::Base
  set_primary_key :venue_attachment_id
  
  belongs_to :media_item
  belongs_to :venue
end
