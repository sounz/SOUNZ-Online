class Nomen  < ActiveRecord::Base
  set_primary_key :nomen_id
  
  # this is to show the relationship with person
  has_many :people
  
  #For adding new nomenations in the HTML interface
  acts_as_dropdown
end
