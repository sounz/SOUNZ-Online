class ExpressionLanguage < ActiveRecord::Base
  set_primary_key "expression_language_id"
  
  # model relationships
  belongs_to :language
  belongs_to :expression
  
  # model validation
  validates_presence_of :expression_id,
                        :language_id,
            :message => "cannot be empty"
end
