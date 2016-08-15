class PersonAttachment < ActiveRecord::Base
  set_primary_key :person_attachment_id
  belongs_to :person
  belongs_to :media_item
  belongs_to :attachment_type
end
