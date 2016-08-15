class ProvFeedbacks < ActiveRecord::Base
  set_primary_key :prov_feedback_id
  
  belongs_to :status
end
