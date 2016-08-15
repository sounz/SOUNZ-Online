class ProvContactUpdates < ActiveRecord::Base
  set_primary_key :prov_contact_update_id
  
  belongs_to :status
end
