class ProvEvents < ActiveRecord::Base
  set_primary_key :prov_event_id
  
  belongs_to :status
end
