module FrbrMethodsDistinctionInstance

      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_works?
      #
      def works_awarded
          find_related_frbr_objects( :is_awarded_to, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_works?
      #
      def number_of_works_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_expressions?
      #
      def expressions_awarded
          find_related_frbr_objects( :is_awarded_to, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_expressions?
      #
      def number_of_expressions_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_manifestations?
      #
      def manifestations_awarded
          find_related_frbr_objects( :is_awarded_to, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_manifestations?
      #
      def number_of_manifestations_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_resources?
      #
      def resources_awarded
          find_related_frbr_objects( :is_awarded_to, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_resources?
      #
      def number_of_resources_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_events?
      #
      def events_awarded
          find_related_frbr_objects( :is_awarded_to, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_events?
      #
      def number_of_events_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_venues?
      #
      def venues_awarded
          find_related_frbr_objects( :is_awarded_to, :which_venues?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_venues?
      #
      def number_of_venues_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_venues?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_roles?
      #
      def roles_awarded
          find_related_frbr_objects( :is_awarded_to, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_roles?
      #
      def number_of_roles_awarded(login=nil)
          count_by_frbr(login, :is_awarded_to, :how_many_roles?)   
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
      #  is_funded_or_sponsored_by to which_roles?
      #
      #def funders_or_sponsors
      #    find_related_frbr_objects( :is_funded_or_sponsored_by, :which_roles?)   
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_funded_or_sponsored_by to which_roles?
      #
      #def number_of_funders_or_sponsors(login=nil)
      #    count_by_frbr(login, :is_funded_or_sponsored_by, :how_many_roles?)   
      #end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_administered_by to which_roles?
      #
      #def administrators
      #    find_related_frbr_objects( :is_administered_by, :which_roles?)   
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_administered_by to which_roles?
      #
      #def number_of_administrators(login=nil)
      #    count_by_frbr(login, :is_administered_by, :how_many_roles?)   
      #end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      #def concept_genres
      #    find_related_frbr_objects( :has_as_its_genre, :which_concepts?)   
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      #def number_of_concept_genres(login=nil)
      #    count_by_frbr(login, :has_as_its_genre, :how_many_concepts?)   
      #end
      
      
      #def composite_supporters
      #  (funders_or_sponsors + administrators + presenters).sort_by{|c|c.frbr_list_title}
      #end
      
      #def number_of_composite_supporters(login=nil)
      #  number_of_funders_or_sponsors(login) + number_of_administrators(login) + number_of_presenters(login)
      #end
      
      def composite_recipients
          (works_awarded + expressions_awarded + manifestations_awarded +
           resources_awarded  + roles_awarded).sort_by{|c|c.frbr_list_title}
      end
      
      def number_of_composite_recipients(login=nil)
          number_of_works_awarded(login) + number_of_expressions_awarded(login) + number_of_manifestations_awarded(login) + 
          number_of_resources_awarded(login)  + number_of_roles_awarded(login)
          
      end
      
      
end
