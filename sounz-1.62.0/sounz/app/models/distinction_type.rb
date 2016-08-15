class DistinctionType < ActiveRecord::Base
  set_primary_key :distinction_type_id
  
  has_many :distinction_distinction_types
  has_many :distinctions, :through => :distinction_distinction_types
  
  acts_as_dropdown :text => "distinction_type_name"
  
end
