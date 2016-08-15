class DistinctionDistinctionType < ActiveRecord::Base
  set_primary_key :distinction_distinction_type_id
  
  # relationships
  belongs_to :distinction
  belongs_to :distinction_type
  
  # MODEL VALIDATIONS
  # check that 'not null' fields are not nil
  validates_presence_of :distinction_id,
                        :distinction_type_id,
             :message => "cannot be empty"
end
