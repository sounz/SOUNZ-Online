class PersonContactinfo < ActiveRecord::Base
  set_primary_key :person_contactinfo_id
  
  # this is to show the relationship with person and contact info
  belongs_to :person
  belongs_to :contactinfo

  CONTACTINFO_TYPES_ARRAY = ['home', 'work', 'delivery', 'billing']
  
  # MODEL VALIDATIONS
  # check that 'not null' fields are not nil
  validates_presence_of :person, 
                        :contactinfo,
                        :contactinfo_type,
             :message => "cannot be empty"
  
  # test booleans exist and are non nil
  validates_inclusion_of :preferred, :in => [true, false]
  
  
  
  def self.get_contactinfo_types_array
    return CONTACTINFO_TYPES_ARRAY
  end

end
