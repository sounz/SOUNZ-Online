class NewsArticleAttachment < ActiveRecord::Base
  set_primary_key "news_article_attachment_id"
  
  # model relationships
  belongs_to :news_article
  belongs_to :media_item
  belongs_to :attachment_type
  
  # model validation
  validates_presence_of :attachment_type_id,
                        :news_article_id,
                        :media_item_id,
            :message => "cannot be empty"
end
