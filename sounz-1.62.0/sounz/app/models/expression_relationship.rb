class ExpressionRelationship < ActiveRecord::Base
set_primary_key "expression_relationship_id"
set_sequence_name "expression_relationships_expression_relationship_id_seq"
belongs_to :expression
belongs_to :relationship
belongs_to :relationship_type
end
