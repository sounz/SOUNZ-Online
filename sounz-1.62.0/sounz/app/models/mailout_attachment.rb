class MailoutAttachment < ActiveRecord::Base
  set_primary_key "mailout_attachment_id"
  
  # model relationships
  belongs_to :campaign_mailout
  belongs_to :media_item
  belongs_to :attachment_type
  
  # model validation
  validates_presence_of :attachment_type_id,
                        :campaign_mailout_id,
                        :media_item_id,
            :message => "cannot be empty"
end
