class SavedContactPerson < ActiveRecord::Base
  belongs_to :person
  belongs_to :saved_contact_list
end
