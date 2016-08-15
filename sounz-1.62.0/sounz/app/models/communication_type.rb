class CommunicationType < ActiveRecord::Base
  set_primary_key :communication_type_id
  
  has_many :communications
  
  validates_presence_of(:communication_type_desc, :message => "The description cannot be empty")

  acts_as_dropdown
end
