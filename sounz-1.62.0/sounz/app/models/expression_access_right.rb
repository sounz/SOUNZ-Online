class ExpressionAccessRight < ActiveRecord::Base
  set_primary_key :expression_access_right_id
  
  belongs_to :access_right
  belongs_to :expression
  
  validates_presence_of :access_right_source, :expression, :access_right
  
  validates_inclusion_of :access_right_source, :in => ["publisher", "composer"]
end
