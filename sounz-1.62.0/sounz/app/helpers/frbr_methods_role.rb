module FrbrMethodsRole

      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  identifies_with to which_concepts?
      #
      def concepts_identifies_with
          find_related_frbr_objects( :identifies_with, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  identifies_with to which_concepts?
      #
      def number_of_concepts_identifies_with(login=nil)
          count_by_frbr(login, :identifies_with, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  publishes to which_resources?
      #
      def published_resources
          find_related_frbr_objects( :publishes, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  publishes to which_resources?
      #
      def number_of_published_resources(login=nil)
          count_by_frbr(login, :publishes, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  presents to which_expressions?
      #
      def presentations
          find_related_frbr_objects( :presents, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  presents to which_expressions?
      #
      def number_of_presentations(login=nil)
          count_by_frbr(login, :presents, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_influenced_by to which_concepts?
      #
      def influential_concepts
          find_related_frbr_objects( :is_influenced_by, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_influenced_by to which_concepts?
      #
      def number_of_influential_concepts(login=nil)
          count_by_frbr(login, :is_influenced_by, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  licenses to which_resources?
      #
      def licensed_resources
          find_related_frbr_objects( :licenses, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  licenses to which_resources?
      #
      def number_of_licensed_resources(login=nil)
          count_by_frbr(login, :licenses, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_the_dedicatee_of to which_resources?
      #
      def resources_dedicated
          find_related_frbr_objects( :is_the_dedicatee_of, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_the_dedicatee_of to which_resources?
      #
      def number_of_resources_dedicated(login=nil)
          count_by_frbr(login, :is_the_dedicatee_of, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  writes_according_to to which_concepts?
      #
      def writes_according_to
          find_related_frbr_objects( :writes_according_to, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  writes_according_to to which_concepts?
      #
      def number_of_writes_according_to(login=nil)
          count_by_frbr(login, :writes_according_to, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  releases to which_resources?
      #
      def released_resources
          find_related_frbr_objects( :releases, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  releases to which_resources?
      #
      def number_of_released_resources(login=nil)
          count_by_frbr(login, :releases, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  performs_according_to to which_concepts?
      #
      def performs_according_to
          find_related_frbr_objects( :performs_according_to, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  performs_according_to to which_concepts?
      #
      def number_of_performs_according_to(login=nil)
          count_by_frbr(login, :performs_according_to, :how_many_concepts?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  improvises to which_expressions?
      #
      def improvised_expressions
          find_related_frbr_objects( :improvises, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  improvises to which_expressions?
      #
      def number_of_improvised_expressions(login=nil)
          count_by_frbr(login, :improvises, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  broadcasts to which_expressions?
      #
      def broadcasted_expressions
          find_related_frbr_objects( :broadcasts, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  broadcasts to which_expressions?
      #
      def number_of_broadcasted_expressions(login=nil)
          count_by_frbr(login, :broadcasts, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  sells to which_resources?
      #
      def sold_resources
          find_related_frbr_objects( :sells, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  sells to which_resources?
      #
      def number_of_sold_resources(login=nil)
          count_by_frbr(login, :sells, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  notates to which_expressions?
      #
      def notations
          find_related_frbr_objects( :notates, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  notates to which_expressions?
      #
      def number_of_notations(login=nil)
          count_by_frbr(login, :notates, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  conceives to which_superworks?
      #
      def conceptions
          find_related_frbr_objects( :conceives, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  conceives to which_superworks?
      #
      def number_of_conceptions(login=nil)
          count_by_frbr(login, :conceives, :how_many_superworks?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  presents to which_events?
      #
      def presented_events
          find_related_frbr_objects( :presents, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  presents to which_events?
      #
      def number_of_presented_events(login=nil)
          count_by_frbr(login, :presents, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  compiles to which_expressions?
      #
      def compilations
          find_related_frbr_objects( :compiles, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  compiles to which_expressions?
      #
      def number_of_compilations(login=nil)
          count_by_frbr(login, :compiles, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  composes to which_works?
      #
      def compositions
          find_related_frbr_objects( :composes, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  composes to which_works?
      #
      def number_of_compositions(login=nil)
          count_by_frbr(login, :composes, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  presents to which_distinction_instances?
      #
      def presented_distinctions
          find_related_frbr_objects( :presents, :which_distinction_instances?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  presents to which_distinction_instances?
      #
      def number_of_presented_distinctions(login=nil)
          count_by_frbr(login, :presents, :how_many_distinction_instances?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  performs to which_events?
      #
      def performed_events
          find_related_frbr_objects( :performs, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  performs to which_events?
      #
      def number_of_performed_events(login=nil)
          count_by_frbr(login, :performs, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  records to which_manifestations?
      #
      def recordings
          find_related_frbr_objects( :records, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  records to which_manifestations?
      #
      def number_of_recordings(login=nil)
          count_by_frbr(login, :records, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  funds_or_sponsors to which_distinctions?
      #
      def funded_or_sponsored_distinctions
          find_related_frbr_objects( :funds_or_sponsors, :which_distinctions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  funds_or_sponsors to which_distinctions?
      #
      def number_of_funded_or_sponsored_distinctions(login=nil)
          count_by_frbr(login, :funds_or_sponsors, :how_many_distinctions?)   
      end

      
      
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
      #  funds to which_events?
      #
      def funded_events
          find_related_frbr_objects( :funds, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  funds to which_events?
      #
      def number_of_funded_events(login=nil)
          count_by_frbr(login, :funds, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  works_with to which_roles?
      #
      def roles_working_with
          find_related_frbr_objects( :works_with, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  works_with to which_roles?
      #
      def number_of_roles_working_with(login=nil)
          count_by_frbr(login, :works_with, :how_many_roles?)   
      end
      
  
      def roles_worked_by_with
        find_related_frbr_objects( :is_worked_with_by, :which_roles?)   
      end
      
      def number_of_roles_worked_by_with(login=nil)
        count_by_frbr(login, :is_worked_with_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  broadcasts to which_events?
      #
      def broadcasted_events
          find_related_frbr_objects( :broadcasts, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  broadcasts to which_events?
      #
      def number_of_broadcasted_events(login=nil)
          count_by_frbr(login, :broadcasts, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  improvises to which_works?
      #
      def improvised_works
          find_related_frbr_objects( :improvises, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  improvises to which_works?
      #
      def number_of_improvised_works(login=nil)
          count_by_frbr(login, :improvises, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_worked_with_by to which_roles?
      #
      def roles_worked_with_by
          find_related_frbr_objects( :is_worked_with_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_worked_with_by to which_roles?
      #
      def number_of_roles_worked_with_by(login=nil)
          count_by_frbr(login, :is_worked_with_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  administers to which_distinction_instances?
      #
      #def administered_distinctions
      #    find_related_frbr_objects( :administers, :which_distinction_instances?)   
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  administers to which_distinction_instances?
      #
      #def number_of_administered_distinctions(login=nil)
      #    count_by_frbr(login, :administers, :how_many_distinction_instances?)   
      #end

      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  commissions to which_roles?
      #
      def roles_commissioned
          find_related_frbr_objects( :commissions, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  commissions to which_roles?
      #
      def number_of_roles_commissioned(login=nil)
          count_by_frbr(login, :commissions, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  writes to which_works?
      #
      def writings
          find_related_frbr_objects( :writes, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  writes to which_works?
      #
      def number_of_writings(login=nil)
          count_by_frbr(login, :writes, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  funds to which_roles?
      #
      def roles_funded
          find_related_frbr_objects( :funds, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  funds to which_roles?
      #
      def number_of_roles_funded(login=nil)
          count_by_frbr(login, :funds, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  publishes to which_manifestations?
      #
      def published_manifestations
          find_related_frbr_objects( :publishes, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  publishes to which_manifestations?
      #
      def number_of_published_manifestations(login=nil)
          count_by_frbr(login, :publishes, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  arranges to which_works?
      #
      def arrangements
          find_related_frbr_objects( :arranges, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  arranges to which_works?
      #
      def number_of_arrangements(login=nil)
          count_by_frbr(login, :arranges, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  licenses to which_manifestations?
      #
      def licensed_manifestations
          find_related_frbr_objects( :licenses, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  licenses to which_manifestations?
      #
      def number_of_licensed_manifestations(login=nil)
          count_by_frbr(login, :licenses, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  records to which_events?
      #
      def recorded_events
          find_related_frbr_objects( :records, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  records to which_events?
      #
      def number_of_recorded_events(login=nil)
          count_by_frbr(login, :records, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  creates to which_works?
      #
      def creations
          find_related_frbr_objects( :creates, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  creates to which_works?
      #
      def number_of_creations(login=nil)
          count_by_frbr(login, :creates, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  releases to which_manifestations?
      #
      def released_manifestations
          find_related_frbr_objects( :releases, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  releases to which_manifestations?
      #
      def number_of_released_manifestations(login=nil)
          count_by_frbr(login, :releases, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  sells to which_events?
      #
      def sold_events
          find_related_frbr_objects( :sells, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  sells to which_events?
      #
      def number_of_sold_events(login=nil)
          count_by_frbr(login, :sells, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  commissions to which_works?
      #
      def commissioned_works
          find_related_frbr_objects( :commissions, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  commissions to which_works?
      #
      def number_of_commissioned_works(login=nil)
          count_by_frbr(login, :commissions, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  sells to which_manifestations?
      #
      def sold_manifestations
          find_related_frbr_objects( :sells, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  sells to which_manifestations?
      #
      def number_of_sold_manifestations(login=nil)
          count_by_frbr(login, :sells, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  manages to which_events?
      #
      def managed_events
          find_related_frbr_objects( :manages, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  manages to which_events?
      #
      def number_of_managed_events(login=nil)
          count_by_frbr(login, :manages, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_described_by to which_resources?
      #
      def descriptive_resource
          find_related_frbr_objects( :is_described_by, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_described_by to which_resources?
      #
      def number_of_descriptive_resource(login=nil)
          count_by_frbr(login, :is_described_by, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  selects to which_works?
      #
      def selected_works
          find_related_frbr_objects( :selects, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  selects to which_works?
      #
      def number_of_selected_works(login=nil)
          count_by_frbr(login, :selects, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  funds to which_works?
      #
      def funded_works
          find_related_frbr_objects( :funds, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  funds to which_works?
      #
      def number_of_funded_works(login=nil)
          count_by_frbr(login, :funds, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_the_dedicatee_of to which_works?
      #
      def works_dedicated
          find_related_frbr_objects( :is_the_dedicatee_of, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_the_dedicatee_of to which_works?
      #
      def number_of_works_dedicated(login=nil)
          count_by_frbr(login, :is_the_dedicatee_of, :how_many_works?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  writes to which_resources?
      #
      def written_resources
          find_related_frbr_objects( :writes, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  writes to which_resources?
      #
      def number_of_written_resources(login=nil)
          count_by_frbr(login, :writes, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  performs to which_expressions?
      #
      def performances
          find_related_frbr_objects( :performs, :which_expressions?).map{|e|e.work}.uniq   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  performs to which_expressions?
      #
      def number_of_performances(login=nil)
        #FIXME - make this more efficient as its a special case
      	PrivilegesHelper.permitted_objects(login, performances).length 
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_the_dedicatee_of to which_manifestations?
      #
      def manifestations_dedicated
          find_related_frbr_objects( :is_the_dedicatee_of, :which_manifestations?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_the_dedicatee_of to which_manifestations?
      #
      def number_of_manifestations_dedicated(login=nil)
          count_by_frbr(login, :is_the_dedicatee_of, :how_many_manifestations?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  records to which_resources?
      #
      def recorded_resources
          find_related_frbr_objects( :records, :which_resources?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  records to which_resources?
      #
      def number_of_recorded_resources(login=nil)
          count_by_frbr(login, :records, :how_many_resources?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  exhibits to which_expressions?
      #
      def exhibitions
          find_related_frbr_objects( :exhibits, :which_expressions?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  exhibits to which_expressions?
      #
      def number_of_exhibitions(login=nil)
          count_by_frbr(login, :exhibits, :how_many_expressions?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  presents to which_events?
      #
      def presented_events
          find_related_frbr_objects( :presents, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  presents to which_events?
      #
      def number_of_presented_events(login=nil)
          count_by_frbr(login, :presents, :how_many_events?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  holds to which_events?
      #
      def held_events
          find_related_frbr_objects( :holds, :which_events?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  holds to which_events?
      #
      def number_of_held_events(login=nil)
          count_by_frbr(login, :holds, :how_many_events?)   
      end
      
      
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
      #  is_owned_by to which_roles?
      #
      def owners
          find_related_frbr_objects( :is_owned_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_owned_by to which_roles?
      #
      def number_of_owners(login=nil)
          count_by_frbr(login, :is_owned_by, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  hosts_performers to which_roles?
      #
      def performers
          find_related_frbr_objects( :hosts_performers, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  hosts_performers to which_roles?
      #
      def number_of_performers(login=nil)
          count_by_frbr(login, :hosts_performers, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_related_to to which_roles?
      #
      def related_resources
          find_related_frbr_objects( :is_related_to, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_related_to to which_roles?
      #
      def number_of_related_resources(login=nil)
          count_by_frbr(login, :is_related_to, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_commonalities_with to which_roles?
      #
      def venues_things_in_common_with
          find_related_frbr_objects( :has_commonalities_with, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_commonalities_with to which_roles?
      #
      def number_of_venues_things_in_common_with(login=nil)
          count_by_frbr(login, :has_commonalities_with, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  things_in_common_with to which_roles?
      #
      def venues_has_commonalities_with
          find_related_frbr_objects( :things_in_common_with, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  things_in_common_with to which_roles?
      #
      def number_of_venues_has_commonalities_with(login=nil)
          count_by_frbr(login, :things_in_common_with, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  manages to which_roles?
      #
      def managed_venues
          find_related_frbr_objects( :manages, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  manages to which_roles?
      #
      def number_of_managed_venues(login=nil)
          count_by_frbr(login, :manages, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  owns to which_roles?
      #
      def owned_venues
          find_related_frbr_objects( :owns, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  owns to which_roles?
      #
      def number_of_owned_venues(login=nil)
          count_by_frbr(login, :owns, :how_many_roles?)   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  performs_at to which_roles?
      #
      def performed_venues
          find_related_frbr_objects( :performs_at, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  performs_at to which_roles?
      #
      def number_of_performed_venues(login=nil)
          count_by_frbr(login, :performs_at, :how_many_roles?)   
      end
      
      
      #-- Composite methods as inferred by Scilla --
      def composite_influences
        concepts_identifies_with + influential_concepts + writes_according_to
      end
      
      def number_of_composite_influences(login=nil)
        number_of_concepts_identifies_with(login) + number_of_influential_concepts(login) + number_of_writes_according_to(login)
      end
      
      #-- composite for published --
      def composite_publications
        published_resources + licensed_resources + released_resources + sold_resources+writings+
          published_manifestations + licensed_manifestations + sold_manifestations + written_resources
      end
      
      def number_of_composite_publications(login=nil)
        number_of_published_resources(login) + number_of_licensed_resources(login) + number_of_released_resources(login) + 
        number_of_sold_resources(login) + number_of_writings(login) +
        number_of_published_manifestations(login) + number_of_licensed_manifestations(login) + 
        number_of_sold_manifestations(login) + number_of_written_resources(login)
      end
      
      
      def composite_performances
      	(improvised_expressions.map{|e|e.work}  + performances + improvised_works).uniq
      end

      def number_of_composite_performances(login=nil)
      	improvised_expressions.map{|e| PrivilegesHelper.permitted_objects(login, [e.work])}.uniq.length + number_of_improvised_works(login) + number_of_performances(login)
      end

      def number_of_composite_media_on_demand(login=nil)
        composite_media_on_demand.length
      end
      
      def composite_media_on_demand
         result = []
         expressions = find_related_frbr_objects( :performs, :which_expressions?)
         #has one of these expressions a manifestation as media on demand?
         for exp in expressions
             for rel in exp.relationships
                if rel.relationship_type_id == "38"
                    #get manifestation and check is sounzmedia
                    exp_man = ExpressionManifestation.find(:all, :conditions => ['expression_id =?', exp.expression_id])
                    for em in exp_man
                        manifestation = Manifestation.find(em.manifestation_id)
                        if(manifestation.is_a_sounzmedia?)
                            if(!result.include?(manifestation))
                                result.push(manifestation)
                            end
                            
                        end
                    end
                end
             end
         end
         
         result 
      end

      def composite_broadcasts
      	broadcasted_expressions + broadcasted_events
      end

      def number_of_composite_broadcasts(login=nil)
      	number_of_broadcasted_expressions(login) + number_of_broadcasted_events(login)
      end


      def composite_recordings
      	recordings + recorded_events + released_manifestations + recorded_resources
      end

      def number_of_composite_recordings(login=nil)
      	number_of_recordings(login) + number_of_recorded_events(login) + number_of_released_manifestations(login) + number_of_recorded_resources(login)
      end


      def composite_works
      	compositions + creations
      end

      def number_of_composite_works(login=nil)
      	number_of_compositions(login) + number_of_creations(login)
      end


      def composite_collaborations
      	roles_working_with + roles_worked_by_with
      end

      def number_of_composite_collaborations(login=nil)
      	number_of_roles_working_with(login) + number_of_roles_worked_by_with(login)
      end


      def composite_commissions
      	roles_commissioned + commissioned_works + funded_works
      end

      def number_of_composite_commissions(login=nil)
      	number_of_roles_commissioned(login) + number_of_commissioned_works(login) + number_of_funded_works(login)
      end


      def composite_related_resources
      	descriptive_resource + related_resources
      end

      def number_of_composite_related_resources(login=nil)
      	number_of_descriptive_resource(login) + number_of_related_resources(login)
      end

      def composite_events
      	exhibitions + presented_events + held_events + performed_events
      end

      def number_of_composite_events(login=nil)
      	number_of_exhibitions(login) + number_of_presented_events(login) + number_of_held_events(login)  + number_of_performed_events(login)
      end

      # WR#55627
      # relationships: 'composes', 'creates', 'publishes', 'releases', 'records', 'writes', 'receives'
      def composite_distinctions

         composite_works_distinctions = composite_works.collect{ |w| w.distinctions}.flatten

         published_resources_distinctions = published_resources.collect{ |r| r.distinctions}.flatten
         published_manifestations_distinctions = published_manifestations.collect{ |m| m.distinctions}.flatten

         released_resources_distinctions = released_resources.collect{ |r| r.distinctions}.flatten
         released_manifestations_distinctions = released_manifestations.collect{ |m| m.distinctions}.flatten

         recorded_resources_distinctions = recorded_resources.collect{ |r| r.distinctions}.flatten

         written_resources_distinctions = written_resources.collect{ |r| r.distinctions}.flatten

         return (distinctions + composite_works_distinctions + published_resources_distinctions + published_manifestations_distinctions +
                 released_resources_distinctions + released_manifestations_distinctions + recorded_resources_distinctions + written_resources_distinctions).sort_by{ |di| [di.award_year]}
      end

      # WR#55627
      # relationships: 'composes', 'creates', 'publishes', 'releases', 'records', 'writes', 'receives'
      def number_of_composite_distinctions(login=nil)
         count = 0

         objects = composite_works + published_resources + published_manifestations + released_resources + released_manifestations + recorded_resources + written_resources

         objects.each do |o|
           count = count + o.number_of_distinctions(login)
         end

         return (number_of_distinctions(login) + count)

      end
end
