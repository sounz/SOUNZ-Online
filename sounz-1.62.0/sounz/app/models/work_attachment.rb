class WorkAttachment < ActiveRecord::Base
    set_primary_key :work_attachment_id
    belongs_to :work
    belongs_to :media_item
    belongs_to :attachment_type
end
