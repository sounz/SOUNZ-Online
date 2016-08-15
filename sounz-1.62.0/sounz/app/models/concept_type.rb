class ConceptType < ActiveRecord::Base
set_primary_key "concept_type_id"
set_sequence_name "concept_types_concept_type_id_seq"

GENRE = ConceptType.find(:first, :conditions => ['concept_type_desc = ?','Genre'])
INFLUENCE = ConceptType.find(:first, :conditions => ['concept_type_desc = ?','Influence'])
THEME = ConceptType.find(:first, :conditions => ['concept_type_desc = ?','Theme'])

has_many :concepts
end
