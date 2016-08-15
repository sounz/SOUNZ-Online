class EventAttachment < ActiveRecord::Base
  set_primary_key :event_attachment_id
  belongs_to :event
  belongs_to :media_item
  belongs_to :attachment_type
end
