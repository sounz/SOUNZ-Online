module FrbrMethodsExpression

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
      #  is_realisation_of to which_works?
      #
      def works_realised_through
          find_related_frbr_objects( :is_realisation_of, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_realisation_of to which_works?
      #
      def number_of_works_realised_through(login=nil)
          count_by_frbr(login, :is_realisation_of, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_part_of to which_works?
      #
      def parent_work
          find_related_frbr_objects( :is_part_of, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_part_of to which_works?
      #
      def number_of_parent_work(login=nil)
          count_by_frbr(login, :is_part_of, :how_many_works?)   
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
      #  is_exhibited_by to which_roles?
      #
      def exhibitors
          find_related_frbr_objects( :is_exhibited_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_exhibited_by to which_roles?
      #
      def number_of_exhibitors(login=nil)
          count_by_frbr(login, :is_exhibited_by, :how_many_roles?)   
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
      #  is_broadcasted_by to which_roles?
      #
      def broadcasters
          find_related_frbr_objects( :is_broadcast_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_broadcasted_by to which_roles?
      #
      def number_of_broadcasters(login=nil)
          count_by_frbr(login, :is_broadcast_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_notated_by to which_roles?
      #
      def notators
          find_related_frbr_objects( :is_notated_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_notated_by to which_roles?
      #
      def number_of_notators(login=nil)
          count_by_frbr(login, :is_notated_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_compiled_by to which_roles?
      #
      def compilers
          find_related_frbr_objects( :is_compiled_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_compiled_by to which_roles?
      #
      def number_of_compilers(login=nil)
          count_by_frbr(login, :is_compiled_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_embodied_in to which_manifestations?
      #
      def emboided_manifestations
          find_related_frbr_objects( :is_embodied_in, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_embodied_in to which_manifestations?
      #
      def number_of_emboided_manifestations(login=nil)
          count_by_frbr(login, :is_embodied_in, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  presented_at to which_events?
      #
      def events_expressed_at
          find_related_frbr_objects( :presented_at, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  presented_at to which_events?
      #
      def number_of_events_expressed_at(login=nil)
          count_by_frbr(login, :presented_at, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  happens_at to which_events?
      #
      def events_happening_at
          find_related_frbr_objects( :happens_at, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  happens_at to which_events?
      #
      def number_of_events_happening_at(login=nil)
          count_by_frbr(login, :happens_at, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_commissioned_for to which_events?
      #
      def events_commissioned_at
          find_related_frbr_objects( :is_commissioned_for, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_commissioned_for to which_events?
      #
      def number_of_events_commissioned_at(login=nil)
          count_by_frbr(login, :is_commissioned_for, :how_many_events?)   
      end
      
      
end
