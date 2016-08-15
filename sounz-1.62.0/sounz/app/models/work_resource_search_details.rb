#This is used to store the details of an sonline music advanced search (searching Work and Resource models)
#in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class WorkResourceSearchDetails
  
  attr_reader :title, :composed_written_by, :contents, :composition_revision_year, :duration, :work_category_id, :work_subcategory_id,
              :work_additional_subcategory_id, :difficulty, :language_id, :concept_type, :concept_id,
              :has_score, :has_recording, :has_programme_note, :has_resource, :resource_type_id, :available_for_sale, 
              :available_for_hire, :available_for_download, :status_id, :duration_comparison_param,
              :year_comparison_param, :sort_by,
              
              #instruments
              :includes_piano, :includes_organ, :includes_accordion, :includes_violin, :includes_viola, :includes_cello, 
              :includes_double_bass, :includes_harp, :includes_guitar, :includes_mandolin, :includes_flute, :includes_oboe, 
              :includes_clarinet, :includes_bassoon, :includes_saxophone, :includes_recorder, :includes_trumpet, 
              :includes_horn, :includes_trombone, :includes_tuba, :includes_percussion, :includes_marimba, :includes_vibraphone, 
              :includes_drums, :includes_koauau, :includes_bagpipes,
              
              #voices
              :comprises_soprano, :comprises_mezzo, :comprises_contralto, :comprises_alto, :comprises_tenor, :comprises_baritone,
              :comprises_bass, :comprises_countertenor

  attr_writer :title, :composed_written_by, :contents, :composition_revision_year, :duration, :work_category_id, :work_subcategory_id,
              :work_additional_subcategory_id, :difficulty, :language_id, :concept_type, :concept_id,
              :has_score, :has_recording, :has_programme_note, :has_resource, :resource_type_id, :available_for_sale, 
              :available_for_hire, :available_for_download, :status_id, :duration_comparison_param,
              :year_comparison_param, :sort_by,
              
              :includes_piano, :includes_organ, :includes_accordion, :includes_violin, :includes_viola, :includes_cello, 
              :includes_double_bass, :includes_harp, :includes_guitar, :includes_mandolin, :includes_flute, :includes_oboe, 
              :includes_clarinet, :includes_bassoon, :includes_saxophone, :includes_recorder, :includes_trumpet, 
              :includes_horn, :includes_trombone, :includes_tuba, :includes_percussion, :includes_marimba, :includes_vibraphone, 
              :includes_drums, :includes_koauau, :includes_bagpipes,
              
              #voices
              :comprises_soprano, :comprises_mezzo, :comprises_contralto, :comprises_alto, :comprises_tenor, :comprises_baritone,
              :comprises_bass, :comprises_countertenor
 
  #Do we have the relevant data to make a solr search?
  def contains_solr_query_data?
    !(title.blank? and 
      composed_written_by.blank? and 
      composition_revision_year.blank? and 
      duration.blank? and
      work_category_id.blank? and 
      work_subcategory_id.blank? and 
      work_additional_subcategory_id.blank? and 
      difficulty.blank? and
      language_id.blank? and 
      has_programme_note == "0" and 
      status_id.blank? and
      concept_type.blank? and
      concept_id.blank? and
      has_resource == "0" and
      resource_type_id.blank? and
      !contains_instruments? and
      !contains_voices? and
      available_for_sale == "0" and
      available_for_hire == "0" and
      available_for_download == "0"
      ) 
  end
 
  def contains_instruments?
    !(includes_piano == "0" and
      includes_organ == "0" and
      includes_accordion == "0" and
      includes_violin == "0" and
      includes_viola == "0" and
      includes_cello == "0" and
      includes_double_bass == "0" and
      includes_harp == "0" and
      includes_guitar == "0" and
      includes_mandolin == "0" and
      includes_flute == "0" and
      includes_oboe == "0" and
      includes_clarinet == "0"  and
      includes_bassoon == "0" and
      includes_saxophone == "0" and
      includes_recorder == "0" and
      includes_trumpet == "0" and
      includes_horn == "0" and
      includes_trombone == "0" and
      includes_tuba == "0" and
      includes_percussion == "0" and
      includes_marimba == "0" and
      includes_vibraphone == "0" and
      includes_drums == "0" and
      includes_koauau == "0" and
      includes_bagpipes == "0"
      )
  end
  
  def contains_voices?
    !(comprises_soprano == "0" and
      comprises_mezzo == "0" and
      comprises_contralto == "0" and
      comprises_alto == "0" and
      comprises_tenor == "0" and
      comprises_baritone == "0" and
      comprises_bass == "0" and
      comprises_countertenor == "0"
     )
  end
  
  def contains_sql_query_fields?
    !(has_score == "0" and
      has_recording == "0"
      )
  end
  # ----------------------------------
  # - Return true if search details  -
  # - contain unique for work fields -
  # ---------------------------------- 
  def contains_uniq_for_work_filters?
    !(composition_revision_year.blank? and 
      work_category_id.blank? and 
      work_subcategory_id.blank? and 
      work_additional_subcategory_id.blank? and 
      difficulty.blank? and 
      language_id.blank? and 
      has_programme_note == "0" and 
      has_score == "0" and 
      has_recording == "0"
      )
  end
 
  def self.instruments_for_search
    [ 'piano',
      'organ',
      'accordion',
      'violin',
      'viola',
      'cello',
      'double_bass',
      'harp',
      'guitar',
      'mandolin',
      'flute',
      'oboe',
      'clarinet',
      'bassoon',
      'saxophone',
      'recorder',
      'trumpet',
      'horn',
      'trombone',
      'tuba',
      'percussion',
      'marimba',
      'vibraphone',
      'drums',
      'koauau',
      'bagpipes'
     ]
  end
end