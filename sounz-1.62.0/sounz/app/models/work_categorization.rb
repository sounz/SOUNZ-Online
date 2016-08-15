class WorkCategorization < ActiveRecord::Base
  set_primary_key "work_categorization_id"
  set_sequence_name "work_categorizations_work_categorization_id_seq"

  belongs_to :work_subcategory 
  belongs_to :work

  acts_as_solr [:work_id, :work_subcategory_id]
end
