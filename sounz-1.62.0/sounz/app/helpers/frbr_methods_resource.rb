module FrbrMethodsResource

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
      #  describes to which_works?
      #
      def works_described
          find_related_frbr_objects( :describes, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  describes to which_works?
      #
      def number_of_works_described(login=nil)
          count_by_frbr(login, :describes, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  describes to which_superworks?
      #
      def superworks_described
          find_related_frbr_objects( :describes, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  describes to which_superworks?
      #
      def number_of_superworks_described(login=nil)
          count_by_frbr(login, :describes, :how_many_superworks?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  describes to which_expressions?
      #
      def expressions_described
          find_related_frbr_objects( :describes, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  describes to which_expressions?
      #
      def number_of_expressions_described(login=nil)
          count_by_frbr(login, :describes, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  describes to which_manifestations?
      #
      def manifestations_described
          find_related_frbr_objects( :describes, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  describes to which_manifestations?
      #
      def number_of_manifestations_described(login=nil)
          count_by_frbr(login, :describes, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  documents to which_manifestations?
      #
      def manifestations_documented
          find_related_frbr_objects( :documents, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  documents to which_manifestations?
      #
      def number_of_manifestations_documented(login=nil)
          count_by_frbr(login, :documents, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  describes to which_roles?
      #
      def roles_described
          find_related_frbr_objects( :describes, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  describes to which_roles?
      #
      def number_of_roles_described(login=nil)
          count_by_frbr(login, :describes, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      def writers
          find_related_frbr_objects( :is_written_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      def number_of_writers(login=nil)
          count_by_frbr(login, :is_written_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_recorded_by to which_roles?
      #
      def recorders
          find_related_frbr_objects( :is_recorded_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_recorded_by to which_roles?
      #
      def number_of_recorders(login=nil)
          count_by_frbr(login, :is_recorded_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      def publishers
          find_related_frbr_objects( :is_published_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      def number_of_publishers(login=nil)
          count_by_frbr(login, :is_published_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_licensed_by to which_roles?
      #
      def licensers
          find_related_frbr_objects( :is_licensed_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_licensed_by to which_roles?
      #
      def number_of_licensers(login=nil)
          count_by_frbr(login, :is_licensed_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_released_by to which_roles?
      #
      def releasers
          find_related_frbr_objects( :is_released_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_released_by to which_roles?
      #
      def number_of_releasers(login=nil)
          count_by_frbr(login, :is_released_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_sold_by to which_roles?
      #
      def sellers
          find_related_frbr_objects( :is_sold_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_sold_by to which_roles?
      #
      def number_of_sellers(login=nil)
          count_by_frbr(login, :is_sold_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_launched_by to which_events?
      #
      def events_launched_at
          find_related_frbr_objects( :is_launched_by, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_launched_by to which_events?
      #
      def number_of_events_launched_at(login=nil)
          count_by_frbr(login, :is_launched_by, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_related_to to which_resources?
      #
      def related_resources
          find_related_frbr_objects( :is_related_to, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_related_to to which_resources?
      #
      def number_of_related_resources(login=nil)
          count_by_frbr(login, :is_related_to, :how_many_resources?)   
      end
      
      
      #-- additional onces that were missing
      def dedicatees
         find_related_frbr_objects( :is_dedicated_to, :which_roles?) 
      end
      
      def number_of_dedicatees(login=nil)
         count_by_frbr(login, :is_dedicated_to, :which_roles?) 
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
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  describes to which_resources?
      #
      def resources_described
      	find_related_frbr_objects( :describes, :which_resources?)   
      end
	  
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_described_by to which_resources?
      #
      def descriptive_resources
          find_related_frbr_objects( :is_described_by, :which_resources?)   
      end

      def composite_authors
        return (writers + recorders + releasers + publishers).sort_by{ |r| r.contributor.known_as }
      end
end
