class ResourceAttachment < ActiveRecord::Base
  set_primary_key :resource_attachment_id
  belongs_to :resource
  belongs_to :media_item
  belongs_to :attachment_type
end
