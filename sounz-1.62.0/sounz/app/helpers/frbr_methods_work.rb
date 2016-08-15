module FrbrMethodsWork

      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  receives to which_distinction_instances?
      #
      def distinctions
          find_related_frbr_objects( :receives, :which_distinction_instances?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  receives to which_distinction_instances?
      #
      def number_of_distinctions(login=nil)
          count_by_frbr(login, :receives, :how_many_distinction_instances?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_influenced_by to which_concepts?
      #
      def concept_influences
          find_related_frbr_objects( :is_influenced_by, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_influenced_by to which_concepts?
      #
      def number_of_concept_influences(login=nil)
          count_by_frbr(login, :is_influenced_by, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_as_its_theme to which_concepts?
      #
      def concept_themes
          find_related_frbr_objects( :has_as_its_theme, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_as_its_theme to which_concepts?
      #
      def number_of_concept_themes(login=nil)
          count_by_frbr(login, :has_as_its_theme, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      def concept_genres
          find_related_frbr_objects( :has_as_its_genre, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      def number_of_concept_genres(login=nil)
          count_by_frbr(login, :has_as_its_genre, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_evidence_of to which_superworks?
      #
      def superwork_evidences
          find_related_frbr_objects( :is_evidence_of, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_evidence_of to which_superworks?
      #
      def number_of_superwork_evidences(login=nil)
          count_by_frbr(login, :is_evidence_of, :how_many_superworks?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  draws_source_material_from to which_superworks?
      #
      def superworks_from_whom_source_material_is_drawn
          find_related_frbr_objects( :draws_source_material_from, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  draws_source_material_from to which_superworks?
      #
      def number_of_superworks_from_whom_source_material_is_drawn(login=nil)
          count_by_frbr(login, :draws_source_material_from, :how_many_superworks?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_influenced_by to which_superworks?
      #
      def superwork_influences
          find_related_frbr_objects( :is_influenced_by, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_influenced_by to which_superworks?
      #
      def number_of_superwork_influences(login=nil)
          count_by_frbr(login, :is_influenced_by, :how_many_superworks?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  draws_source_material_from to which_works?
      #
      def works_from_whom_source_material_is_drawn
          find_related_frbr_objects( :draws_source_material_from, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  draws_source_material_from to which_works?
      #
      def number_of_works_from_whom_source_material_is_drawn(login=nil)
          count_by_frbr(login, :draws_source_material_from, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  provides_source_material_for to which_works?
      #
      def works_to_whom_source_material_is_provided
          find_related_frbr_objects( :provides_source_material_for, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  provides_source_material_for to which_works?
      #
      def number_of_works_to_whom_source_material_is_provided(login=nil)
          count_by_frbr(login, :provides_source_material_for, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_influenced_by to which_works?
      #
      def work_influences
          find_related_frbr_objects( :is_influenced_by, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_influenced_by to which_works?
      #
      def number_of_work_influences(login=nil)
          count_by_frbr(login, :is_influenced_by, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_an_influence_on to which_works?
      #
      def influences_these_works
          find_related_frbr_objects( :is_an_influence_on, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_an_influence_on to which_works?
      #
      def number_of_influences_these_works(login=nil)
          count_by_frbr(login, :is_an_influence_on, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_realised_through to which_expressions?
      #
      def realisations
          find_related_frbr_objects( :is_realised_through, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_realised_through to which_expressions?
      #
      def number_of_realisations(login=nil)
          count_by_frbr(login, :is_realised_through, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  contains to which_expressions?
      #
      def expression_parts
          find_related_frbr_objects( :contains, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  contains to which_expressions?
      #
      def number_of_expression_parts(login=nil)
          count_by_frbr(login, :contains, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_described_by to which_resources?
      #
      def descriptive_resources
          find_related_frbr_objects( :is_described_by, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_described_by to which_resources?
      #
      def number_of_descriptive_resources(login=nil)
          count_by_frbr(login, :is_described_by, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_commissioned_for to which_events?
      #
      def event_commissions
          find_related_frbr_objects( :is_commissioned_for, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_commissioned_for to which_events?
      #
      def number_of_event_commissions(login=nil)
          count_by_frbr(login, :is_commissioned_for, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_composed_by to which_roles?
      #
      def composers
          find_related_frbr_objects( :is_composed_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_composed_by to which_roles?
      #
      def number_of_composers(login=nil)
          count_by_frbr(login, :is_composed_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_improvised_by to which_roles?
      #
      def improvisors
          find_related_frbr_objects( :is_improvised_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_improvised_by to which_roles?
      #
      def number_of_improvisors(login=nil)
          count_by_frbr(login, :is_improvised_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  written_text_by to which_roles?
      #
      def writers
          find_related_frbr_objects( :is_written_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  written_text_by to which_roles?
      #
      def number_of_writers(login=nil)
          count_by_frbr(login, :is_written_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_arranged_by to which_roles?
      #
      def arrangers
          find_related_frbr_objects( :is_arranged_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_arranged_by to which_roles?
      #
      def number_of_arrangers(login=nil)
          count_by_frbr(login, :is_arranged_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_created_by to which_roles?
      #
      def creaters
          find_related_frbr_objects( :is_created_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_created_by to which_roles?
      #
      def number_of_creaters(login=nil)
          count_by_frbr(login, :is_created_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_commissioned_by to which_roles?
      #
      def commissioners
          find_related_frbr_objects( :is_commissioned_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_commissioned_by to which_roles?
      #
      def number_of_commissioners(login=nil)
          count_by_frbr(login, :is_commissioned_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_selected_by to which_roles?
      #
      def selectors
          find_related_frbr_objects( :is_selected_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_selected_by to which_roles?
      #
      def number_of_selectors(login=nil)
          count_by_frbr(login, :is_selected_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_funded_by to which_roles?
      #
      def funder
          find_related_frbr_objects( :is_funded_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_funded_by to which_roles?
      #
      def number_of_funder(login=nil)
          count_by_frbr(login, :is_funded_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_dedicated_to to which_roles?
      #
      def roles_dedicated
          find_related_frbr_objects( :is_dedicated_to, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_dedicated_to to which_roles?
      #
      def number_of_roles_dedicated(login=nil)
          count_by_frbr(login, :is_dedicated_to, :how_many_roles?)   
      end

      def composite_authors
        return composers.sort_by{ |r| r.contributor.known_as }
      end

end
