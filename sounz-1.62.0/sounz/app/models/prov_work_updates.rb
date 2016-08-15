class ProvWorkUpdates < ActiveRecord::Base
  set_primary_key :prov_work_update_id
  
  belongs_to :status
end
