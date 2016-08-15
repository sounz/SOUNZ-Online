module FrbrMethodsDistinction

      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_works?
      #
      def works_awarded
          distinction_instances.map{|di|di.works_awarded}.flatten.uniq
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_works?
      #
      def number_of_works_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_works_awarded(login)}.sum
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_expressions?
      #
      def expressions_awarded
          distinction_instances.map{|di|di.expressions_awarded}.flatten.uniq  
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_expressions?
      #
      def number_of_expressions_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_expressions_awarded(login)}.sum
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_manifestations?
      #
      def manifestations_awarded
          distinction_instances.map{|di|di.manifestations_awarded}.flatten.uniq
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_manifestations?
      #
      def number_of_manifestations_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_manifestations_awarded(login)}.sum   
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_resources?
      #
      def resources_awarded
          distinction_instances.map{|di|di.resources_awarded}.flatten.uniq
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_resources?
      #
      def number_of_resources_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_resources_awarded(login)}.sum  
      end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_events?
      #
      def events_awarded
          distinction_instances.map{|di|di.events_awarded}.flatten.uniq   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_events?
      #
      def number_of_events_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_events_awarded(login)}.sum
      end
      
      
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_awarded_to to which_roles?
      #
      def roles_awarded
          distinction_instances.map{|di|di.roles_awarded}.flatten.uniq
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_awarded_to to which_roles?
      #
      def number_of_roles_awarded(login=nil)
          distinction_instances.map{|di|di.number_of_roles_awarded(login)}.sum
      end
      
      
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
	  def funders_or_sponsors
		find_related_frbr_objects( :is_funded_or_sponsored_by, :which_roles?)   
	  end
			
	  #
	  #- Auto generated FRBR relationship counter
	  #- Returns the number of FRBR objects for the relationship
	  #  is_funded_or_sponsored_by to which_roles?
	  #
	  def number_of_funders_or_sponsors(login=nil)
		count_by_frbr(login, :is_funded_or_sponsored_by, :how_many_roles?)   
	  end
			
			
	  #
	  #- Auto generated FRBR relationship 
	  #- Returns all FRBR objects for the relationship
	  #  is_administered_by to which_roles?
	  #
	  def managers
		find_related_frbr_objects( :is_managed_by, :which_roles?)   
	  end
			
	  #
	  #- Auto generated FRBR relationship counter
	  #- Returns the number of FRBR objects for the relationship
	  #  is_administered_by to which_roles?
	  #
	  def number_of_managers(login=nil)
		count_by_frbr(login, :is_managed_by, :how_many_roles?)   
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
      #  is_presented_by to which_roles?
      #
      #def presenters
      #    distinction_instances.map{|di|di.presenters}.flatten.uniq  
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_presented_by to which_roles?
      #
      #def number_of_presenters(login=nil)
      #    distinction_instances.map{|di|di.number_of_presenters(login)}.sum
      #end
      
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      #def funders_or_sponsors
      #    distinction_instances.map{|di|di.funders_or_sponsors}.flatten.uniq  
      #end
      
 
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_published_by to which_roles?
      #
      #def number_of_funders_or_sponsors(login=nil)
      #    distinction_instances.map{|di|di.number_funders_or_sponsors(login)}.sum
      #end
      
      
      #def administrators
      #  distinction_instances.map{|di|di.administrators}.flatten.uniq  
      #end
      
      #def number_of_funders_or_sponsors(login=nil)
      #    distinction_instances.map{|di|di.number_of_administrators(login)}.sum
      #end
      
      
      
   
      
      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      #def concept_genres
      #    distinction_instances.map{|di|di.concept_genres}.flatten.uniq
      #end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  has_as_its_genre to which_concepts?
      #
      #def number_of_concept_genres(login=nil)
      #    distinction_instances.map{|di|di.number_of_concept_genres(login)}.sum 
      #end
      
	  def happening_distinctions
		find_related_frbr_objects( :is_presented_by, :which_events?)
	  end
			
	  def number_of_happening_distinctions(login=nil)
		count_by_frbr(login, :is_presented_by, :how_many_events?)
	  end	  
  
      def composite_recipients
            (works_awarded + expressions_awarded + manifestations_awarded + resources_awarded  + roles_awarded).sort_by{|c|c.frbr_list_title}
      end

      def number_of_composite_recipients(login=nil)
            number_of_works_awarded(login) + number_of_expressions_awarded(login) + number_of_manifestations_awarded(login) + number_of_resources_awarded(login)  + number_of_roles_awarded(login)
      end
      
      
      def composite_supporters
        (funders_or_sponsors + managers + presenters).sort_by{|c|c.frbr_list_title}
      end
      
      def number_of_composite_supporters(login=nil)
        number_of_funders_or_sponsors(login) + number_of_managers(login) + number_of_presenters(login)
      end	     
      
end
