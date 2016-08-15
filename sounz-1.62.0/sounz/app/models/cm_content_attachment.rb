class CmContentAttachment < ActiveRecord::Base
  set_primary_key :cm_content_attachment_id
  belongs_to :cm_content
  belongs_to :media_item
  belongs_to :attachment_type
end
