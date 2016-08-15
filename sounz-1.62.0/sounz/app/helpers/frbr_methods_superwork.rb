module FrbrMethodsSuperwork

      #
      #- Auto generated FRBR relationship 
      #- Returns all FRBR objects for the relationship
      #  is_evidenced_as to which_works?
      #
      def works_evidenced
          find_related_frbr_objects( :is_evidenced_as, :which_works?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_evidenced_as to which_works?
      #
      def number_of_works_evidenced(login=nil)
          count_by_frbr(login, :is_evidenced_as, :how_many_works?)   
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
      #  is_conceived_by to which_roles?
      #
      def conceived_superworks
          find_related_frbr_objects( :is_conceived_by, :which_roles?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_conceived_by to which_roles?
      #
      def number_of_conceived_superworks(login=nil)
          count_by_frbr(login, :is_conceived_by, :how_many_roles?)   
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
      #  provides_source_material_for to which_superworks?
      #
      def superworks_to_whom_source_material_is_provided
          find_related_frbr_objects( :provides_source_material_for, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  provides_source_material_for to which_superworks?
      #
      def number_of_superworks_to_whom_source_material_is_provided(login=nil)
          count_by_frbr(login, :provides_source_material_for, :how_many_superworks?)   
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
      #  is_inspired_by to which_concepts?
      #
      def inspirational_concepts
          find_related_frbr_objects( :is_inspired_by, :which_concepts?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_inspired_by to which_concepts?
      #
      def number_of_inspirational_concepts(login=nil)
          count_by_frbr(login, :is_inspired_by, :how_many_concepts?)   
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
      #  is_an_influence_on to which_superworks?
      #
      def superworks_influenced
          find_related_frbr_objects( :is_an_influence_on, :which_superworks?)   
      end
      
      #
      #- Auto generated FRBR relationship counter
      #- Returns the number of FRBR objects for the relationship
      #  is_an_influence_on to which_superworks?
      #
      def number_of_superworks_influenced(login=nil)
          count_by_frbr(login, :is_an_influence_on, :how_many_superworks?)   
      end
      
      
end
