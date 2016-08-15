class Language < ActiveRecord::Base
  set_primary_key "language_id"
  
  # model relationships
  has_many :expression_languages
  has_and_belongs_to_many :expressions, :join_table => :expression_languages
  
  # model validation
  validates_presence_of :language_name,
                        :display_order,
            :message => "cannot be empty"
  
  # Test booleans exist and are non nil
  validates_inclusion_of :is_default, :in => [true, false]
  
  acts_as_dropdown :text => 'language_name', :order => 'display_order'
            
end
