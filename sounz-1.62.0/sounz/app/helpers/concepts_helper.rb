module ConceptsHelper

  #Used for the other pathways facet.  To avoid hardwirding IDs use a call like this
  # ConceptsHelper.find_by_text_and_type("NZ - Birds", [ConceptType.INFLUENCE, ConceptType.GENRE])
  def self.find_by_text_and_type(text, type_array)
    concept_type_ids = type_array.map{|t|t.concept_type_id}
    Concept.find(:all, :conditions => ["concept_name ilike ? and concept_type_id in (?)",
      '%'+text+'%',
      concept_type_ids
      ])
  end

end
