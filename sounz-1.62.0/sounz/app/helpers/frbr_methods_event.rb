module FrbrMethodsEvent

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
      
	  #- Auto generated FRBR relationship 
	  #- Returns all FRBR objects for the relationship
	  #  receives to which_distinction_instances?
	  #
	  def distinctions_offered
		find_related_frbr_objects( :presents, :which_distinctions?)   
	  end
			
	  #
	  #- Auto generated FRBR relationship counter
	  #- Returns the number of FRBR objects for the relationship
	  #  receives to which_distinction_instances?
	  #
	  def number_of_distinctions_offered(login=nil)
		count_by_frbr(login, :presents, :how_many_distinctions?)   
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
      #  has_commissioned to which_works?
      #
      def commissioned_works
          find_related_frbr_objects( :has_commissioned, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_commissioned to which_works?
      #
      def number_of_commissioned_works(login=nil)
          count_by_frbr(login, :has_commissioned, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_presented_by to which_roles?
      #
      def presenters
          find_related_frbr_objects( :is_presented_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_presented_by to which_roles?
      #
      def number_of_presenters(login=nil)
          count_by_frbr(login, :is_presented_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_performed_by to which_roles?
      #
      def performers
          find_related_frbr_objects( :is_performed_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_performed_by to which_roles?
      #
      def number_of_performers(login=nil)
          count_by_frbr(login, :is_performed_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_funded_by to which_roles?
      #
      def funders
          find_related_frbr_objects( :is_funded_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_funded_by to which_roles?
      #
      def number_of_funders(login=nil)
          count_by_frbr(login, :is_funded_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_broadcasted_by to which_roles?
      #
      def broadcasters
          find_related_frbr_objects( :is_broadcasted_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_broadcasted_by to which_roles?
      #
      def number_of_broadcasters(login=nil)
          count_by_frbr(login, :is_broadcasted_by, :how_many_roles?)   
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
      #  is_managed_by to which_roles?
      #
      def managers
          find_related_frbr_objects( :is_managed_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_managed_by to which_roles?
      #
      def number_of_managers(login=nil)
          count_by_frbr(login, :is_managed_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_presented to which_expressions?
      #
      def presented_expressions
          find_related_frbr_objects( :has_presented, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_presented to which_expressions?
      #
      def number_of_presented_expressions(login=nil)
          count_by_frbr(login, :has_presented, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_happening to which_expressions?
      #
      def happening_expressions
          find_related_frbr_objects( :has_happening, :which_expressions?)   
      end
      

      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_happening to which_expressions?
      #
      def number_of_happening_expressions(login=nil)
          count_by_frbr(login, :has_happening, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_commissioned to which_expressions?
      #
      def commissioned_expressions
          find_related_frbr_objects( :has_commissioned, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_commissioned to which_expressions?
      #
      def number_of_commissioned_expressions(login=nil)
          count_by_frbr(login, :has_commissioned, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  launches to which_manifestations?
      #
      def manifestations_launched
          find_related_frbr_objects( :launches, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  launches to which_manifestations?
      #
      def number_of_manifestations_launched(login=nil)
          count_by_frbr(login, :launches, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  launches to which_resources?
      #
      def resources_launched
          find_related_frbr_objects( :launches, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  launches to which_resources?
      #
      def number_of_resources_launched(login=nil)
          count_by_frbr(login, :launches, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_presented_by to which_venues?
      #
      def venues_presented_at
          find_related_frbr_objects( :is_presented_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_presented_by to which_venues?
      #
      def number_of_venues_presented_at(login=nil)
          count_by_frbr(login, :is_presented_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_held_by to which_venues?
      #
      def venues_held_at
          find_related_frbr_objects( :is_held_at, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_held_by to which_venues?
      #
      def number_of_venues_held_at(login=nil)
          count_by_frbr(login, :is_held_at, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_related_to to which_events?
      #
      def related_events
          find_related_frbr_objects( :is_related_to, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_related_to to which_events?
      #
      def number_of_related_events(login=nil)
          count_by_frbr(login, :is_related_to, :how_many_events?)   
      end
      
      
end
