class ExpressionManifestation < ActiveRecord::Base
  
  set_primary_key 'expression_manifestation_id'
  
  belongs_to :expression
  belongs_to :manifestation
end
