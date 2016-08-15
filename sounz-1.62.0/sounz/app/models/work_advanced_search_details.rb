#This is used to store the details of an advanced work search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class WorkAdvancedSearchDetails
  
  attr_reader :title, :composed_by, :composition_year, :revision_year, :description, :instrumentation,
              :contents, :text_note, :language_id, :created_at, :programme_note_exists, :programme_note,
              :status_id, :work_category_id, :work_subcategory_id, :work_additional_subcategory_id, :has_score, :has_recording,
              :has_not_applicable, :has_sample_score, :has_sample_recording, :concept_name, :concept_text, :concept_filter,
              :relationship1_type, :relationship1_filter, :relationship1_text, :relationship2_type, :relationship2_filter,
			  :relationship2_text, :internal_note, :commissioned_note, :created_at_from, :created_at_to
            
  attr_writer :title, :composed_by, :composition_year, :revision_year, :description, :instrumentation,
              :contents, :text_note, :language_id, :created_at, :programme_note_exists, :programme_note,
              :status_id, :work_category_id, :work_subcategory_id, :work_additional_subcategory_id, :has_score, :has_recording,
              :has_not_applicable, :has_sample_score, :has_sample_recording, :concept_name, :concept_text, :concept_filter,
              :relationship1_type, :relationship1_filter, :relationship1_text, :relationship2_type, :relationship2_filter, 
			  :relationship2_text, :internal_note, :commissioned_note, :created_at_from, :created_at_to


  def contains_solr_query_data?
    !(title.blank? and
      description.blank? and
      composed_by.blank? and
      instrumentation.blank? and
      text_note.blank? and
      contents.blank? and
      programme_note.blank? and
      language_id.blank? and
      status_id.blank? and
      composition_year.blank? and
      revision_year.blank? and
      work_category_id.blank? and
      work_subcategory_id.blank? and
      work_additional_subcategory_id.blank? and
      internal_note.blank? and
      created_at_from.blank? and
      created_at_to.blank?
     )
   end
  
end