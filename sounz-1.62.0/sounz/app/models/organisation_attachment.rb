class OrganisationAttachment < ActiveRecord::Base
  set_primary_key :organisation_attachment_id
  belongs_to :organisation
  belongs_to :media_item
  belongs_to :attachment_type
end
