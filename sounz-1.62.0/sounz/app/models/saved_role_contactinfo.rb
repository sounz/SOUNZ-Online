class SavedRoleContactinfo < ActiveRecord::Base
  set_primary_key :saved_role_contactinfo_id
  
  # relationships
  belongs_to :role_contactinfos
  belongs_to :saved_contact_list
  
  # MODEL VALIDATIONS
  # check that 'not null' fields are not nil
  validates_presence_of :saved_role_contactinfo_id, 
                        :role_contactinfo_id,
                        :saved_contact_list_id,
             :message => "cannot be empty"
end
