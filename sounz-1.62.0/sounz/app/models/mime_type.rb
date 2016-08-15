class MimeType < ActiveRecord::Base
set_primary_key "mime_type_id"
set_sequence_name "mime_types_mime_type_id_seq"
has_many :media_items
end
