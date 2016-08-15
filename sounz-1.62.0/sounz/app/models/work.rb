require 'frbr_helper'
require 'uri'
require 'erb'

class Work < ActiveRecord::Base
    include WorksHelper
    include FrbrHelper
    include FrbrMethodsWork

    
    set_primary_key "work_id" 
    set_sequence_name "works_work_id_seq" 
    belongs_to :status
    has_many :work_categorizations,:dependent => :destroy
    has_many :work_subcategories, :through => :work_categorizations
    has_many :work_relationships
    has_many :relationships, :through => :work_relationships, :select => "work_relationships.relationship_type_id, relationships.*"


    #Relationship to a superwork
    belongs_to :superwork
        
    has_many :work_attachments
    has_many :media_items, :through => :work_attachments
    
    has_many :expressions, :order => :expression_title
    
    has_many :work_access_rights
    
    
    
  #  validates_inclusion_of :no_duration, :in => [true, false]
    
    
    #Updated by relationship 
    validates_presence_of :login_updated_by
    validates_associated :login_updated_by
    
    

    belongs_to :login_updated_by, 
              :class_name => 'Login',
              :foreign_key => :updated_by
     
    # New version of main category
    belongs_to :main_category,
              :class_name => 'WorkSubcategory',
              :foreign_key => :work_subcategory_id

    
    @@performance_mode = nil
    validates_presence_of :status, :work_title, :main_category
    validates_associated :status, :main_category
    
    #Checks for the years
    validates_numericality_of :year_of_revision, :only_integer => true,
    :allow_nil => true,
    :if => ModelHelper.only_check_if_not_empty( :year_of_revision)
    
    validates_numericality_of :year_of_creation, :only_integer => true,
    :allow_nil => true,
    :if => ModelHelper.only_check_if_not_empty( :year_of_creation)
    
    
    #- Checks for duration -
 #   validates_numericality_of :intended_duration, :only_integer => true, 
#      :if => Proc.new {|work| work.no_duration == false }
      
    validates_format_of :intended_duration, 
                      :if => Proc.new {|model| ( model.intended_duration != nil) },
                      :with => DURATION_REGEX,
                      :message=> "must be of the format |number|:|00 to 59|:|00 to 59|"
    
    

    # Solr searching. All fields to be indexed must be listed here in :fields.
    # If faceting over the value, it should be declared as type :string.
    acts_as_solr :fields => [
        :frbr_ui_desc_for_solr, 
        :work_title_for_solr, 
        {:title_as_string_for_solr => :string},
        :work_description_for_solr,
         {:year_group_for_solr => :string},
         {:year_subgroup_for_solr => :string},
         {:intended_duration_for_solr => :integer},
         {:categories_for_solr => :string},
        :can_be_bought_for_solr,
        :can_be_loaned_for_solr,
        :can_be_hired_for_solr,
        :downloadable_for_solr,
        :main_category_for_solr,
        :subcategories_for_solr,
        :difficulty_for_solr, 
        :composers_csv_for_solr,
        :creators_csv_for_solr,
        :arrangers_csv_for_solr,
        :writers_csv_for_solr,
        :instrumentation_for_solr,
        :contents_note_for_solr,
        :text_note_for_solr,
        :internal_note_for_solr,
        :commissioned_note_for_solr,
        :genres_for_solr,
        :influences_for_solr,
        :themes_for_solr,
        :programme_note_for_solr, #This is the text of the first resource currently,
        :year_of_creation_for_solr,
        :year_of_revision_for_solr,
        :languages_for_solr,
        {:has_genres_for_solr => :string},
        {:has_influences_for_solr => :string},
        {:has_themes_for_solr => :string},
        :available_as_recordings_for_solr,
        :available_as_scores_sheets_for_solr,
        :available_as_samples_for_solr,
        :available_as_sounzmedia_audio_for_solr,
        :available_as_sounzmedia_video_for_solr,        
        :available_as_top_level_facet_for_solr,
        :suitable_for_youth_for_solr,
        :popular_facets_for_solr,
        :popular_subfacets_for_solr, 
        :status_for_solr,
        :has_programme_note_for_solr,
        :has_descriptive_resources_for_solr,
        :has_sounzmedia_for_solr,
        :descriptive_resource_type_ids_for_solr,
        #:all_categorizations_for_solr,
        :subcategory_ids_for_solr,
        :category_ids_for_solr,
        :manifestation_titles_for_solr,
        :manifestation_general_note_for_solr,
        :expression_general_note_for_solr,
	:taonga_puoro_special_subcategory_ids_for_solr,
	:music_for_stage_special_subcategory_ids_for_solr,
	{:authors_cvs_as_string_for_solr => :string},
        {:created_at_for_solr => :string}
      ],
      :if => Proc.new { |work| work.should_be_indexed? }
    

    def created_at_for_solr
      return FinderHelper.date_for_solr_ymd(created_at)
    end

    # work_categorization_id=23666   work_id=16821   work_subcategory_id=18  work_categorization_id=23667
    # work_id=16821   work_subcategory_id=135
    
    def all_categorizations_for_solr
      result = ""
      
      for wsc in all_categories
        result << "work_id=#{work_id} "
        result << "work_subcategory_id=#{wsc.work_subcategory_id}  " unless wsc.work_subcategory_id.blank?
        result << "work_category_id=#{wsc.work_category_id}  " unless wsc.work_category_id.blank?
      end
      
      result
      
    end
    
    
    def all_subcategories
      subcats = [main_category]
      work_categorizations.map{|wc| subcats << wc.work_subcategory if wc.work_subcategory.additional == true}
      subcats
    end
    
    def all_categories
      all_subcategories.map{|wsc| wsc.work_category}.uniq
    end

    
#-- deal with the popular facets --

   #This is one of NZ, Maori culture and music, incidentfal film and music as a text key
   #See FacetHelper::POPULAR_FACETS for exact values
   def popular_facets_for_solr
   	 #logger.debug "DEBUG: WORK popular_facets_for_solr"
     FacetHelper.popular_facets(self).join(', ')
   end
   
   
   #These are the subfacets and are indexed as a unique number.  This maps to text inside
   #FacetHelper::POPULAR_FACETS - cant use text due to SOLR issues
   def popular_subfacets_for_solr
   	 #logger.debug "DEBUG: WORK popular_subfacets_for_solr"
     FacetHelper.popular_subfacets(self).join(', ')
   end

#-- oh boy, the available as facets are FRBR hoppy

    #This is the facet for available as / recordings
    #We get the related manifestations, find those that are recordings, and grab the manifestation types
    #Just to add to the fun,the download option is added iff the manifestations in question have an item
    #Returned is a comma separated list of unique manifestation type ids
    def available_as_recordings_for_solr
      #logger.debug "DEBUG: WORK available_as_recordings_for_solr"
      recordings = ManifestationsHelper.recordings_only(related_manifestations)
      result = []
      recordings.map{|r| result << r.format.format_id}
      result.uniq.sort.join(', ')
    end
    
    def available_as_sounzmedia_audio_for_solr
      sounzmedia_audio_manifestations = ManifestationsHelper.sounzmedia_audio_only(related_manifestations)
      sounzmedia_audio_resources = ResourcesHelper.sounzmedia_audio_only(related_resources)
      result = []
      sounzmedia_audio_manifestations.map{|r| result << r.format.format_id.to_s}
      sounzmedia_audio_resources.map{|r| result << r.format.format_id.to_s}
      result.uniq.sort.join(', ')
    end

    def available_as_sounzmedia_video_for_solr
      sounzmedia_video_manifestations = ManifestationsHelper.sounzmedia_video_only(related_manifestations)
      sounzmedia_video_resources = ResourcesHelper.sounzmedia_video_only(related_resources)
      result = []
      sounzmedia_video_manifestations.map{|r| result << r.format.format_id.to_s}
      sounzmedia_video_resources.map{|r| result << r.format.format_id.to_s}
      result.uniq.sort.join(', ')
    end

    #For score sheets we first ascertain whether it is a score type, and then join
    #the manifestation types
    def available_as_scores_sheets_for_solr
      #logger.debug "DEBUG: WORK available_as_scores_sheets_for_solr"
      scores = ManifestationsHelper.scores_only(related_manifestations)
      result = []
      scores.map{|s| result << s.manifestation_type.manifestation_type_id}
      result.uniq.sort.join(', ')
    end
    
    #m.samples[0].sample_attachments[0].sample
    
    #Mapping of sample formats - need to ask Paul best way to do this
    #Returns a comma separated list of text such as 'audio, video'
    def available_as_samples_for_solr
      #logger.debug "DEBUG: WORK available_as_samples_for_solr"
      result = []
      
        #Note this filters using expression id
        for s in all_manifestation_samples
          result << "audio" if s.contains_audio?
          result << "video" if s.contains_video?
          result << "scores" if s.contains_document?
          result << "image" if s.contains_image?
        end

      
      result.uniq.sort.join(', ')
      
    end
    
    
    #The top level facet of available as is a drill down of
    # samples
    # recording
    # scores / sheet
    # resources
    # Return a comma separate list containing any or all of uniquely "samples, scores, resources, recording"
    def available_as_top_level_facet_for_solr
      #logger.debug "DEBUG: WORK available_as_top_level_facet_for_solr"
      result = []
      rel_man = related_manifestations #Cache these to avoid 2nd db lookup
      result << "scores" if !ManifestationsHelper.scores_only(rel_man).blank?
      result << "recordings" if !ManifestationsHelper.recordings_only(rel_man).blank?
      result << "audio" if !ManifestationsHelper.sounzmedia_audio_only(rel_man).blank?
      result << "video" if !ManifestationsHelper.sounzmedia_video_only(rel_man).blank?
      some_samples = false
	    for exp in expressions
		    #logger.debug("EXPRESSION #{exp.expression_id} #{exp.expression_title}")
		    for manif in exp.manifestations
		      #logger.debug("MANIFESTATION #{manif.manifestation_title}")
		      for sample in manif.samples
			      #logger.debug("SAMPLE #{sample.expression_id}")
			      if sample.expression_id == exp.expression_id || sample.expression_id.blank?
              some_samples = true
            end
          end
	      end
	    end      
      result << "samples" if some_samples
            
      result.uniq.sort.join(', ')
      #FIXME - resources are to do
    end
    
    
    
    #Concept facets
      def genres_for_solr
      	#logger.debug "DEBUG: WORK genres_for_solr"
        concepts_as_parent(concept_genres)
      end
      
      def influences_for_solr
      	#logger.debug "DEBUG: WORK influences_for_solr"
        concepts_as_parent(concept_influences)
      end
      
      def themes_for_solr
      	#logger.debug "DEBUG: WORK themes_for_solr"
        concepts_as_parent(concept_themes)
      end

    #From a given list of concepts only include the parents, and uniqueify them
    def concepts_as_parent(all_concepts)
    	#logger.debug "DEBUG: WORK concepts_as_parent"
        result = []
      for c in all_concepts
        #Add the most parental id, ie not sub concepts
        if c.parent
          result << c.parent.concept_id
        else
          result << c.concept_id
        end
      end
      result.uniq.sort.join(', ')
    end
    
    
    #0 == does not have a theme, 1 = does have a theme
    #Note SOLR indexes a true if the method fails, hence the use of 0 and 1
    def has_genres_for_solr
      #logger.debug "DEBUG: WORK has_genres_for_solr"
      result = "0"
      result = "1" if concept_genres.length > 0
      result
    end
    
    #0 == does not have a theme, 1 = does have a theme
    #Note SOLR indexes a true if the method fails, hence the use of 0 and 1
    def has_influences_for_solr
      #logger.debug "DEBUG: WORK has_influences_for_solr"
      result = "0"
      result = "1" if concept_influences.length > 0
      result
    end
    
    #0 == does not have a theme, 1 = does have a theme
    #Note SOLR indexes a true if the method fails, hence the use of 0 and 1
    def has_themes_for_solr
      #logger.debug "DEBUG: WORK has_themes_for_solr"
      result = "0"
      result = "1" if concept_themes.length > 0
      result
    end
    
    
    def manifestation_titles_for_solr
      #logger.debug "DEBUG: WORK manifestation_titles_for_solr"
      result = related_manifestations.map{|m| FinderHelper.strip(m.manifestation_title)}.join(", ")
    end
    
    def manifestation_general_note_for_solr
      result = related_manifestations.map{|m| FinderHelper.strip(m.general_note)}.join(", ")
      result = "" if result == ','
      result
    end
    
    # Used by solr for faceting
    def year_of_creation_for_solr
      #logger.debug "DEBUG: WORK year_of_creation_for_solr"
      result = year_of_creation
      result = -1 if year_of_creation.blank?
      return result
    end

   def year_of_revision_for_solr
   	  #logger.debug "DEBUG: WORK year_of_revision_for_solr"
      return year_of_revision
    end

    def year_group_for_solr
      #logger.debug "DEBUG: WORK year_group_for_solr"
      return FinderHelper.year_group(year_of_creation)
    end

    def year_subgroup_for_solr
      #logger.debug "DEBUG: WORK year_subgroup_for_solr"
      return FinderHelper.year_subgroup(year_of_creation)
    end
    
    def work_title_for_solr
      #logger.debug "DEBUG: WORK work_title_for_solr"
      #logger.debug "DEBUG: indexing work id: #{self.work_id}"
      return FinderHelper.strip(work_title)
    end
    
    def title_as_string_for_solr
      #logger.debug "DEBUG: WORK title_as_string_for_solr"
      return FinderHelper.strip(work_title.downcase)
    end
    

    def work_description_for_solr
      #logger.debug "DEBUG: WORK work_description_for_solr"
      return FinderHelper.strip(work_description)
    end
    
    def difficulty_for_solr
      #logger.debug "DEBUG: WORK difficulty_for_solr"
      return FinderHelper.strip(difficulty)    
    end
    
    def contents_note_for_solr
      #logger.debug "DEBUG: WORK contents_note_for_solr"
      return FinderHelper.strip(contents_note)
    end
    
    #index a zero for false, and a 1 for true, getting round the true indexed if the method barfs
    #acts as solr bug
    def suitable_for_youth_for_solr
      #logger.debug "DEBUG: WORK suitable_for_youth_for_solr"
      result = "0"
      result = "1" if  work_subcategories.include?(WorkSubcategory::SUITABLE_FOR_YOUTH) == true
      result
    end
    
    def text_note_for_solr
      #logger.debug "DEBUG: WORK text_note_for_solr"
      return FinderHelper.strip(text_note)
    end
	
    def internal_note_for_solr
      #logger.debug "DEBUG: WORK internal_note_for_solr"
      return FinderHelper.strip(internal_note)
    end
    
    def commissioned_note_for_solr
      return FinderHelper.strip(commissioned_note)
    end 
    
    def programme_note_for_solr
      #logger.debug "DEBUG: WORK programme_note_for_solr"
      return FinderHelper.strip(programme_note)
    end
    
    
    def cache_key(category_key)
      return category_key+'_work_'+id.to_s+updated_at.to_f.to_s
    end
    
    
    
    
    def frbr_ui_desc_for_solr
      #logger.debug "DEBUG: WORK #{work_id}"
      return FinderHelper.strip(frbr_ui_desc)
    end
    
    def intended_duration_for_solr
      #logger.debug "DEBUG: WORK intended_duration_for_solr"
      duration=-1
      if intended_duration != nil
        duration=intended_duration_as_seconds 
      end
      
      #puts "INTENDED DURATION FOR SOLR:#{duration.to_i}"
      return duration.to_i
    end

    #def categories
    #  work_subcategories.collect {|sc| sc.work_category_id}
    #end
    
    def subcategories_for_solr
    #logger.debug "DEBUG: WORK subcategories_for_solr"
    result = ''
      work_subcategories.collect {|sc| sc.id}.each do |id|
        result += " ,#{id.to_s}, "
      end
      result += " ,#{main_category.id.to_s}, "
      return result.last(-1)
    
    end
    
    def categories_for_solr
      #logger.debug "DEBUG: WORK categories_for_solr"
      result = ''
      all_categories.collect {|sc| sc.work_category_id}.each do |id|
        result += ' work_category_id=' + id.to_s
      end
      return result.last(-1)
    end
    
    #GBA 20/11/2007 - attempt to fix facetting with main cat issue
    def subcategory_ids_for_solr
      #logger.debug "DEBUG: WORK subcategory_ids_for_solr"
      all_subcategories.map{|wsc|wsc.work_subcategory_id}.uniq.join(", ")
    end
    
	# Music facets
    def category_ids_for_solr
      #logger.debug "DEBUG: WORK category_ids_for_solr"
      category_ids = all_subcategories.map{|wsc|wsc.work_category.work_category_id}
      
	  # WR#52205 - special cases for works with additional subcategories
	  # of "Includes Taonga Puoro" and "Music for Dance/Ballet"/"Incidental Music for Theatre"
	  if all_subcategories.map{|s| s.work_subcategory_desc}.include?"Includes Taonga Puoro"
        category_ids << WorkCategory::TAONGA_PUORO.work_category_id
      end
	  
	  if all_subcategories.map{|s| s.work_subcategory_desc}.include?"Music for Dance/Ballet" || "Incidental Music for Theatre"
	    category_ids << WorkCategory::MUSIC_FOR_STAGE.work_category_id
      end
	  
	  return category_ids.uniq.join(", ")
    end
	
	# WR#52205 - as it is a combination of subcategories and additional subcategories
	# we have to compile a FacetHelper::TAONGA_PUORO_FACETS hash to accomodate the
	# processing of two different cases
	def taonga_puoro_special_subcategory_ids_for_solr
	  #logger.debug "DEBUG: WORK taonga_puoro_special_subcategory_ids_for_solr"
	  subcategory_ids = ''
	  
	  if (all_subcategories.map{|s| s.work_subcategory_desc}.include?"Includes Taonga Puoro") || (all_subcategories.map{|s| s.work_category_id}.include?(WorkCategory::TAONGA_PUORO.work_category_id))
	      
		  subcategory_ids = FacetHelper.special_subcategories(self, FacetHelper::TAONGA_PUORO_FACETS[:facets]).join(', ')
	  
	  end
	  
	  return subcategory_ids
	end
	
	# WR#52205 - as it is a combination of subcategories and additional subcategories
	# we have to compile a FacetHelper::TAONGA_PUORO_FACETS hash to accomodate the
	# processing of two different cases
	def music_for_stage_special_subcategory_ids_for_solr
	  #logger.debug "DEBUG: WORK music_for_stage_special_subcategory_ids_for_solr"
	  subcategory_ids = ''
	  
	  if (all_subcategories.map{|s| s.work_subcategory_desc}.include?"Music for Dance/Ballet") || (all_subcategories.map{|s| s.work_subcategory_desc}.include?"Incidental Music for Theatre") || (all_subcategories.map{|s| s.work_category_id}.include?(WorkCategory::MUSIC_FOR_STAGE.work_category_id))
		subcategory_ids = FacetHelper.special_subcategories(self, FacetHelper::MUSIC_FOR_STAGE_FACETS[:facets]).join(', ')
	  end
	  
	  return subcategory_ids	  
	end	
    
    def main_category_for_solr
      #logger.debug "DEBUG: WORK main_category_for_solr"
      return " ,#{main_category.work_category_id.to_s}, "
    end
    
    def composers_csv_for_solr
      #logger.debug "DEBUG: WORK composers_csv_for_solr"
      return composers.map{|c| FinderHelper.strip(c.frbr_ui_desc)}.join(',')
    end
    
    def creators_csv_for_solr
      #logger.debug "DEBUG: WORK creators_csv_for_solr"
      return creaters.map{|c| FinderHelper.strip(c.frbr_ui_desc)}.join(',')
    end

    def arrangers_csv_for_solr
      #logger.debug "DEBUG: WORK arrangers_csv_for_solr"
      return arrangers.map{|c| FinderHelper.strip(c.frbr_ui_desc)}.join(',')
    end
    
    def writers_csv_for_solr
      #logger.debug "DEBUG: WORK writers_csv_for_solr"
      return writers.map{|c| FinderHelper.strip(c.frbr_ui_desc)}.join(',')
    end
    
	def authors_cvs_as_string_for_solr
	  #logger.debug "DEBUG: WORK authors_cvs_as_string_for_solr"
	  return composers.map{|c| FinderHelper.strip(c.contributor.internal_contributor_name.downcase)}.join(', ')
	end
	
    def instrumentation_for_solr
      #logger.debug "DEBUG: WORK instrumentation_for_solr"      
      return FinderHelper.strip(instrumentation)
    end
    
    
    #-- Buy, borrow, hire facets --
    def can_be_bought_for_solr
      #logger.debug "DEBUG: WORK can_be_bought_for_solr"
      result = "no"
      sql_template = sql_for_availability('available_for_sale')
      sql = sql_template.result(binding)
      
      n_available = ActiveRecord::Base.connection.execute(sql)[0]['count'].to_i
      result = "yes" if n_available > 0
      result
    end
    
    #-- Buy, borrow, hire facets --
    def can_be_loaned_for_solr
      #logger.debug "DEBUG: WORK can_be_loaned_for_solr"
      result = "no"
      sql_template = sql_for_availability('available_for_loan')
      sql = sql_template.result(binding)
      
      n_available = ActiveRecord::Base.connection.execute(sql)[0]['count'].to_i
      result = "yes" if n_available > 0
      result
    end
    
    #-- Buy, borrow, hire facets --
    def can_be_hired_for_solr
      #logger.debug "DEBUG: WORK can_be_hired_for_solr"
      result = "no"
      sql_template = sql_for_availability('available_for_hire')
      sql = sql_template.result(binding)
      
      n_available = ActiveRecord::Base.connection.execute(sql)[0]['count'].to_i
      result = "yes" if n_available > 0
      result
    end

    def downloadable_for_solr
      #logger.debug "DEBUG: WORK downloadable_for_solr"
      result = "no"
      sql_template = sql_for_availability('downloadable')
      sql = sql_template.result(binding)
      
      n_available = ActiveRecord::Base.connection.execute(sql)[0]['count'].to_i
      result = "yes" if n_available > 0
      result
    end

    #Note a nil char here means unknown - see Schema
    def self.difficulty_statuses
      {
        :Advanced => 3,
        :Beginner => 1,
        :Intermediate => 2,
        :Unknown => 0
      }
    end
    
    def difficulty_as_string
      result = Work.difficulty_statuses.invert[difficulty]
      if result == nil
        result = :unknown
      end
      
      return result.to_s.capitalize
      
    end
    
    def languages_for_solr
      #logger.debug "DEBUG: WORK languages_for_solr"
      #return expressions.collect{ |e| e.expression_languages.collect {|el| el.language_id}}.join(',')
      result = expressions.map{|e| e.languages}.flatten.uniq.map{|l| l.language_id }.join(', ') << ','
      result.strip!
      result = "" if result == ','
      result
    end
    
    def expression_general_note_for_solr
      result = expressions.map{|e| FinderHelper.strip(e.general_note)}.join(", ")
      result = "" if result == ','
      result
    end
    
    def status_for_solr
      #logger.debug "DEBUG: WORK status_for_solr"
      return status_id
    end
    
    def has_programme_note_for_solr
      #logger.debug "DEBUG: WORK has_programme_note_for_solr"
      programme_note.blank? ? 0 : 1
    end
    
    # 'is_described_by' relationship with resources for solr 
    def has_descriptive_resources_for_solr
      #logger.debug "DEBUG: WORK has_descriptive_resources_for_solr"
      descriptive_resources.blank? ? 0 : 1
    end
    
    def has_sounzmedia_for_solr
      return has_sounzmedia?
    end
    
    def descriptive_resource_type_ids_for_solr
      #logger.debug "DEBUG: WORK descriptive_resource_type_ids_for_solr"
      descriptive_resources.collect{ |r| r.resource_type_id}.join(',')
    end
    
    
    #Work now has programme_note 'natively'
    
    #helper method for programme note - its the text of the first resource
    #def programme_note
    #  x = descriptive_resources # Store this to avoid having to reevaluate it
    #  note = nil
    #  if x.length ==1
    #  	note = x[0].text_note
    #  end
    #  note
    #end
    
    
    
    def frbr_type
      "work"
    end

    def frbr_id
    work_id
    end

    def frbr_ui_desc
      work_title
    end
    
    #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
    #The naming needs to be common to maintain a single partial for list rendering
    def frbr_list_title
      work_title
    end

    def frbr_list_description
      work_description
    end

    def frbr_updateImplicitRelationships(login_id)
      #We need to pass in the login id as it is not accessible from the model scope
      #FIXME: relationship type should ideally not be hardcoded.
      implicitRelationship=RelationshipType.find_by_symbol(:is_evidence_of) #child of
      #check to see if our associated superwork is already up to date
      updated=0
      for relationship in relationships
          #check this relationship is our implictly mapped relationship
          #e.g. 'is parent of'
          #logger.info 'checking relationship: '+relationship.id.to_s+" "+relationship.relationship_type_id.to_s
          if relationship.relationship_type_id.to_i== implicitRelationship.id
          #logger.info 'found relationship!'
          #we have our parent superwork. lets check it is the correct number
            for superwork_rel in relationship.superwork_relationships
              if superwork_rel.superwork_id != superwork_id
              #found our existing relationship, but linked to a different superwork. lets update it.
              superwork_rel.superwork_id=superwork_id
              superwork_rel.save()
              end
            end  
          updated=1
          end
        end
        
        if updated == 0
          #we need to create a new implicit relationship from scratch.
          relationship = Relationship.new()
          relationship.updated_by=login_id
          relationship.entity_type_id=EntityType.entityTypeToId('work')
          relationship.ent_entity_type_id=EntityType.entityTypeToId('superwork')
    
          if relationship.save
            invreltype=RelationshipType.find(implicitRelationship.id).inverse
            relationship.make_inter_relationship(relationship.id,EntityType.entityTypeToId("work"),work_id,implicitRelationship.id)
            relationship.make_inter_relationship(relationship.id,EntityType.entityTypeToId("superwork"),superwork.id,invreltype)
          end
    
        end
    end
    
    
    def frbr_relationships
      frbr_relationships=Array.new()
      for rel in relationships.uniq
        reltype=RelationshipType.find(rel.relationship_type_id)
        
        #Choose the entity_type that does not match this one.
        #Where both are the same, it does not matter which we pick
        logger.info("WHA?:" + rel.ent_entity_type_id.to_s)
        my_entity=EntityType.entityIdToType(rel.ent_entity_type_id)
        if EntityType.entityIdToType(rel.ent_entity_type_id) == frbr_type() then 
          my_entity= EntityType.entityIdToType(rel.entity_type_id)
        end
        
        related_objects=eval('rel.'+my_entity+'s')
        
        for related_object in related_objects
          if rel.entity_type_id == rel.ent_entity_type_id then
            if related_object.id != id then
              frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
            end
          else 
          frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
          end
        end
      end
    frbr_relationships
    end
    
    
    def has_additional_frbr_relationships
      found_additional_relationships=false
      
      for rel in relationships.uniq
        reltype=RelationshipType.find(rel.relationship_type_id)
        #if not superwork or composed by
        logger.info("LOG: "+reltype.relationship_type_desc)
        if reltype.relationship_type_desc != 'Is composed by' and reltype.relationship_type_desc != 'Is child of'  
        logger.info("LOG: found additional")
        found_additional_relationships=true
        end
      end
      
      return found_additional_relationships
    end
    
    
    #This is used in the pages for all the various lists e.g. compositions, performances etc
    def frbr_listing_description
      return work_description
    end
    
    
    def has_duration?
      return !intended_duration.blank?
    end


    def duration_human_readable
      result = ""
      if  !intended_duration.blank?
        result = TimeHelper.convert_duration_to_hours_and_minutes(intended_duration)
        result << " (can vary)" if duration_varies
      end
      result
    end
    
    def intended_duration_as_minutes
    #take a postgres duration text string and return the value in minutes (seconds are rounded)    
    minutes=0
    if ! intended_duration.blank?
      #logger.info("INTENDED DURATION: "+intended_duration.to_s)
      elements=intended_duration.split(':')
      if  elements != nil
        minutes=(elements[0].to_i*60)+elements[1].to_i
        if elements[2].to_i > 30
          minutes+=1
        end
      end
    end
    #logger.info("MINUTES: "+minutes.to_s)
    return minutes
  end
  
  def intended_duration_as_seconds
    #take a postgres duration text string and return the value in seconds    
    seconds=0
    if ! intended_duration.blank?
      #logger.info("INTENDED DURATION: "+intended_duration.to_s)
      elements=intended_duration.split(':')
      if  elements != nil
        seconds=(elements[0].to_i*60*60)+elements[1].to_i*60+elements[2].to_i
        
      end
    end
    #logger.info("SECONDS: "+seconds.to_s)
    return seconds
  end
  


  def minutes_to_duration(minutes)
  #take an integer value in minutes and return a hh:mm:00 string
  #Not implemented yet
  return "00:00:00"
  end
    
    #Find all the expressions which are of mode performance for this work, and have happened or are
    #currently happening
    def past_performance_realisations
      if @@performance_mode == nil
        @@performance_mode = Mode.find(:first, :conditions => ["mode_desc=?", "performance"])
      end
      return Expression.find(:all, 
      :order => ["premiere desc, expression_start, expression_finish"],
      :conditions => ["work_id = ? and mode_id = ? and expression_start < ? ",id,@@performance_mode.id, Time.now ])
    end
    
    
    #Find all the expressions which are of mode performance for this work
    def future_performance_realisations
      if @@performance_mode == nil
        @@performance_mode = Mode.find(:first, :conditions => ["mode_desc=?", "performance"])
      end
      
      return Expression.find(:all,
      	:order => ["premiere desc, expression_start, expression_finish"],
        :conditions => ["work_id = ? and mode_id = ? and expression_start > ? ",id,@@performance_mode.id, Time.now])
    
    end
    
    
    #Use FRBR to get the related manifestations for this work.  This is how it works...
    #  * Find all the expressions of this work
    #  * Expressions have manifestations - get them and append them into one big array
    # Note that the relationships are in FRBR as well as postgres - use postgres
    def related_manifestations
      result = []
      for exp in expressions
        result = result + exp.manifestations
      end
      result.uniq!
      result
    end
    
   def related_resources 
      result = []
      resource_relation_type = RelationshipType.find(:first, :conditions => ["relationship_type_desc = 'Describes'"])
      for exp in expressions
        for exp_rel in exp.expression_relationships
          if exp_rel.relationship_type_id == resource_relation_type.inverse
              resource_rels = ResourceRelationship.find(:all, :conditions => ["relationship_id =" +  exp_rel.relationship_id.to_s])  
              for resource_rel in resource_rels
                result = result + Resource.find(:all, :conditions => ["resource_id=" + resource_rel.resource_id.to_s])
              end
            end
          end
       end
      result.uniq!
      result 
    end
    
    def has_sounzmedia?
      for m in related_manifestations
        if m.is_a_sounzmedia?
          return true
        end
      end
      
      for r in related_resources
        if r.is_a_sounzmedia?
          return true
        end
      end
      
      return false
    end

    def all_score_samples
      result = []
      for exp in expressions
      #logger.debug("EXPRESSION #{exp.expression_id} #{exp.expression_title}")
        for manif in exp.manifestations
        if manif.manifestation_type.manifestation_type_desc.to_s != 'Not-applicable'
        #logger.debug("MANIFESTATION #{manif.manifestation_title}")
          for sample in manif.samples
            #logger.debug("SAMPLE #{sample.expression_id}")
            if sample.expression_id == exp.expression_id || sample.expression_id.blank?
              result << sample
          end
         end
         end
        end 
        end 
      result.flatten.uniq
    end
    
    def all_recording_samples
      #logger.debug("IN RECORDING SAMPLES")
      result = []
      for exp in expressions
      #logger.debug("EXPRESSION #{exp.expression_id} #{exp.expression_title}")
        for manif in exp.manifestations
        #logger.debug("MANIFESTATION #{manif.manifestation_title} #{manif.manifestation_type.manifestation_type_desc.to_s}")
        if manif.manifestation_type.manifestation_type_desc.to_s == 'Not-applicable'
        
          for sample in manif.samples
            #logger.debug("RECORDING SAMPLE #{sample.id} EXP ID:#{sample.expression_id}")
            if sample.expression_id == exp.expression_id || sample.expression_id.blank?
              result << sample
            end
          end
         end
         end
        end 
      #logger.debug("RESULT:"+result.flatten.uniq.to_s )
      result.flatten.uniq
    end
    
    #Collate all the samples together
    def all_manifestation_samples
      result = []
      for exp in expressions
      #logger.debug("EXPRESSION #{exp.expression_id} #{exp.expression_title}")
        for manif in exp.manifestations
        #logger.debug("MANIFESTATION #{manif.manifestation_title}")
          for sample in manif.samples
            #logger.debug("SAMPLE #{sample.id} #{sample.expression_id}")
            if sample.expression_id == exp.expression_id || sample.expression_id.blank?
              result << sample
            end
          end
         end
        end 
      result.flatten.uniq
    end
    
    
    #helper method to get the year and revision
    def year_description
      result = ""
      
      #Do we have a publication year
      if !year_of_creation.blank?
        result << year_of_creation.to_s
      end
      
      #Do we have a revision year?
      if !year_of_revision.blank?
        result << ', ' if !(result.length == 0)
        result << 'r. '
        result << year_of_revision.to_s
      end
      
      #if !result.blank?
      #  result = '('+result+')'
      #end
      
      result
    end
    
    
    # Extra validation for the work is carried out here
    # * Check that year of revision is >= year of creation
    # * Check revision cant exist without creation
    # * Check years are in the range 1900..now
    # Check that a main subcategory exists (ie additional flag is not true) - 
    # like Highlander there can be only one
    def validate
      
      #logger.debug "** WORK VALIDATION ** no_duration = #{no_duration}, check = #{([true,false].include?(no_duration))}"
      #This did not work using the standard thing, not sure why
      errors.add(:no_duration, "must be boolean") if !([true,false].include?(no_duration))
      
      current_year = Time.now.year
      
      #Check the 1900 case
      errors.add(:year_of_creation, "should be least 1840") if !year_of_creation.blank? and year_of_creation < 1840
      errors.add(:year_of_revision, "should be least 1840") if !year_of_revision.blank? and year_of_revision< 1840
      
      #Check more than now case
      errors.add(:year_of_creation, "should not be in the future") if !year_of_creation.blank? and year_of_creation > (current_year+2)
      errors.add(:year_of_revision, "should not be in the future") if !year_of_revision.blank? and year_of_revision > (current_year+3)
    
      if !year_of_revision.blank? and year_of_creation.blank?
        errors.add(:year_of_revision, "cannot exist without year of creation")
      end
      
      #Check for revision before creation
      if !year_of_revision.blank? and !year_of_creation.blank?
        errors.add(:year_of_revision, "should be after year of creation") if year_of_revision < year_of_creation
      end
      
      test=iswc_code=~/^T-\d{9}-\d/
      if  test.blank? and !iswc_code.blank?
      #logger.info("iswc_code:"+iswc_code)
      errors.add(:iwsc_code, "ISWC should be in the form T-XXXXXXXXX-X")
      end
      #Check for non -ve intended duration
   #   errors.add(:intended_duration, "should be specified") if !no_duration and intended_duration.blank?
  #    errors.add(:intended_duration, "should be a postive number") if !no_duration and !intended_duration.blank? and intended_duration < 0
        


            
      
    end
    
    #This *seems* the cleanest way of doing this, we shall see!
    #Delete all the existing FRBR relationships for work is composed by, and set them to these
    #FIXME - could this become a magic new FRBR method??
    
    #Note: the method composers= makes for nicer code but it is not possible to return a true for success,
    #it returns the array of contributors.  As such reverted to Java like syntax
    def set_composers(new_composers)
      RelationshipHelper.delete_all_frbr_relationships(:work, id, :is_composed_by)
      for comp in new_composers
        RelationshipHelper.add_frbr_relationship(:work, id, :is_composed_by, :role, comp.role_id, self.updated_by)
        #puts "COMPOSER:#{comp.contributor.role.contributor_names}"
      end
      
      #logger.debug "WORK NOW HAS THIS MANY COMPOSERS:#{composers.length}"
      return true #FIXME, transaction
    end
    
    #It became a sounz requirement that a work must have at least one composer
    def save_with_composers(new_composers)
      #logger.debug "==== SAVE WITH COMPOSERS ===="
      #FIXME - transaction!
      result = save # we need an id....
      #logger.debug "Saved with composers, saved work is #{result}"
      if result == true
        #logger.debug "Setting composers"
        result = self.set_composers(new_composers)
        #logger.debug "Composers now #{composers.length}"
      else
        puts "**** DID NOT SAVE WORK ****"
      end
      
      #logger.debug "==== /SAVE WITH COMPOSERS, #{result} ===="
      
      result
    end
    
    #It became a sounz requirement that a work must have at least one composer
    def update_attributes_with_composers(new_values_hash,new_composers, login)
      #FIXME - transaction!
      result = update_attributes(new_values_hash)
      
      #logger.debug "UPDATING WORK WITH #{new_values_hash.to_yaml}"
      
      
      
      if result == true
        #logger.debug "****"
        #logger.debug "Setting composers"
        result = (self.set_composers(new_composers))
        #logger.debug "Composers now #{composers}"
      end
      
      result
    end
    
    
    #---- helper methods for categories ----
    
    #Retrieve the main category, of which there is only one
    def main_category_not
       WorkSubcategory.find(:first, :conditions =>["work_subcategory_id "+
          " in (select work_subcategory_id from work_categorizations where work_id = ? and "+
          "(additional = false or additional is null))",work_id])
      
    end
    
    
    #find the additional subcategories
    def additional_categories_not
      WorkSubcategory.find(:all, :conditions =>["work_subcategory_id "+
        " in (select work_subcategory_id from work_categorizations where work_id = ? and additional = true)",work_id])
    end
    
    
    
    #Get a list of related works via the superwork, but dont include this work
    def related_works
      result_all = superwork.works
      result = []
      result_all.map{|r| result << r if r != self}
      result.flatten.uniq.sort_by{|w|[w.work_title.downcase]}
    end
    
    
      
      def all_associated_concepts
        result = concept_influences + concept_genres + concept_themes
        result.flatten.uniq.sort_by{|c| c.frbr_ui_desc}
      end
      
    
    
    #-- get teh number of scores and recordings in an as efficient a manner as possible --  
    def number_of_scores(status='ALL')
      number_of_things(1, status)
    end
    
    def number_of_recordings(status='ALL')
      number_of_things(2, status)
    end
    
    def number_of_sounzmedia(status='ALL')
      number_of_things(3, status) + ResourcesHelper.sounzmedia_only(related_resources).size
    end    
    
    
    def number_of_things(manifestation_type_category_id, status)
      sql =  <<-EOF
      select count(manifestation_id) from manifestations m where manifestation_id in (
      select distinct manifestation_id from expression_manifestations where expression_id in 
      (select expression_id from expressions where work_id = WORK)
      )
      and manifestation_type_id in 
      (select manifestation_type_id from manifestation_types where manifestation_type_category = CAT)
      STATUS
      ;


      EOF
      
      sql.gsub!('WORK', work_id.to_s)
      sql.gsub!('CAT', manifestation_type_category_id.to_s)
      if status.to_s.match('ALL')
        sql.gsub!('STATUS', '')
      else
        sql.gsub!('STATUS', "AND status_id=#{status.status_id}")
      end
      sanit_sql = SqlHelper.sanitize(sql)
      logger.debug "NUMBER OF THINGS: sql #{sql}"
      logger.debug "NUMBER OF THINGS: sanit_sql #{sanit_sql}"
      n_of_type = ActiveRecord::Base.connection.select_one(sanit_sql)
      n_of_type['count'].to_i
    end
    
    
    #Create sql template for the available field passed in, such as available_for_sale
    def sql_for_availability(available_field)
       sql_template = ERB.new <<-EOF
          select count(*) from manifestations where manifestation_id in (
          	select manifestation_id from expression_manifestations where expression_id in (
          		select expression_id from expressions where work_id = #{work_id}
          	)
          )
          and #{available_field}=true
          ;
          
       EOF
       sql_template
      
    end
    
    # Determine whether this work should be indexed by Solr
    def should_be_indexed?
      !programme_note.blank? || !related_manifestations.empty? || !related_resources.empty?
    end 

    
end
