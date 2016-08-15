class CommunicationMethod < ActiveRecord::Base
  set_primary_key :communication_method_id
  
  has_many :communications
  
  has_many :contactinfos
  
  validates_presence_of(:communication_method_desc, :message => "The description cannot be empty")

  acts_as_dropdown :text => 'communication_method_desc'
end
