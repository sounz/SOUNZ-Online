class SavedContactOrganisation < ActiveRecord::Base

  belongs_to :organisation
  belongs_to :saved_contact_list
end
