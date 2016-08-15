class ManifestationAttachment < ActiveRecord::Base
  set_primary_key :manifestation_attachment_id
  belongs_to :manifestation
  belongs_to :media_item
  belongs_to :attachment_type
  
  validates_presence_of :media_item
end
