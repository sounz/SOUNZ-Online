require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/helpers/facet_helper'

class FacetHelperTest < Test::Unit::TestCase

  include FacetHelper
  
  
  #This is the case where no search term chosen
  def test_event_facets_with_no_search_term
      search_options = {
   #   :region_key => 14.to_s
   #   :country_key => 158.to_s,
   #   :region_key => 15.to_s,
   #   :year_group_key => 'previous',
   #   :month_key => '4'
       :event_type_key => "9"
    }
    
    result, paginator = event_facet_query(
     "", search_options
    )
    
   # facet_results = result[:facets]['facet_fields']['role_type_id_for_solr_t']
    #RAILS_DEFAULT_LOGGER.debug result[:facets].to_yaml
    puts result.to_yaml
  end
  
  
  
  #This is the case where no search term chosen
  def test_people_facets_with_no_search_term
      search_options = {
     # :region_key        => '10'
     :role_type_key => '9'
    }
    
    result, paginator = people_facet_query(
     "", search_options
    )
    
   # facet_results = result[:facets]['facet_fields']['role_type_id_for_solr_t']
    #RAILS_DEFAULT_LOGGER.debug result[:facets].to_yaml
    puts result.to_yaml
  end
  
  
  #Perform a search of people facets, with "chr*"
    def test_people_facets_with_search_term
        search_options = {
       # :selected_role_type_id        => '10'
      }

      result, paginator = people_facet_query(
       "cresswell", search_options
      )

      facet_results = result[:facets]['facet_fields']['role_type_id_for_solr_t']

      x = result[:facets]['facet_queries']
      RAILS_DEFAULT_LOGGER.debug "YAML:#{ x.to_yaml}"
      RAILS_DEFAULT_LOGGER.debug "KEYS:#{x.keys}"
       RAILS_DEFAULT_LOGGER.debug "CLASS:#{x.class}"
       
    end
    
  
   def test_people_facets_with_facet_chosen
        search_options = {
       # :born_key       => '1990-1999',
       :region_facet_key => '9'
      }

      result, paginator = people_facet_query(
       "", search_options
      )

      facet_results = result[:facets]['facet_fields']['role_type_id_for_solr_t']


      RAILS_DEFAULT_LOGGER.debug result[:facets].to_yaml
      RAILS_DEFAULT_LOGGER.debug result[:facets].class
 

    end
  
  
  
  #Test a bad born key causes things to barf
  def test_people_facets_bad_born_key
      search_options = {
      :born_key => "asdoifusadiofu"
      }
        assert_raise(ArgumentError) {
            result = people_facet_query(
               "", search_options
              )
        }
  end
  
  
  def test_people_facets_born_facets
    search_options = {
    :born_key => "1950-1959"
    }
    
    result = people_facet_query(
       "", search_options
      )
      
    puts result.to_yaml
  end
  
end