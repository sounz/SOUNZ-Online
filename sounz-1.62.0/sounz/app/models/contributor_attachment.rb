class ContributorAttachment < ActiveRecord::Base
set_primary_key "contributor_attachment_id"
set_sequence_name "contributor_attachments_contributor_attachment_id_seq"

belongs_to :contributor
belongs_to :media_item
belongs_to :attachment_type
end
