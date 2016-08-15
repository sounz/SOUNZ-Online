require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/helpers/finder_helper'

class AdvancedFinderHelperTest < Test::Unit::TestCase

  include FinderHelper
  
  #taken from http://www.robbyonrails.com/articles/2006/01/25/rails-logger-and-those-pesky-tests
  def logger
    RAILS_DEFAULT_LOGGER
  end
  
  def test_valid_work_search
    search_details = WorkAdvancedSearchDetails.new
   # search_details.composed_by = "Alf"
    search_details.title = "Th"
   # search_details.description = "fluffy bunnies"
    query = AdvancedFinderHelper.build_advanced_work_query(search_details)
    puts "Query:  #{query}"
    result = solr_query(query)
    
    matching_frbr_objects = result[0][:docs].map{|f|f.objectData}
    for result in matching_frbr_objects
      puts result.frbr_ui_desc
    end    
  end
  
  
  def test_contributor_search_query_generation
    search_details = ContributorAdvancedSearchDetails.new
    search_details.known_as="Dav"
    search_details.pull_quote = "pull quote text"
    search_details.profile = "profile text"
    search_details.internal_note = "internal note"
    query = AdvancedFinderHelper.build_advanced_contributor_lucene_query(search_details)
    assert_equal "type_t:Contributor AND (known_as:(dav*) AND profile:(profile* OR text*) AND profile_alt:(profile* OR text*) AND pull_quote:(pull* OR quote* OR text*) AND internal_note:(internal* OR note*))", 
    query
  end
  
  
  #Check the ids only function works
  def test_contributor_search_ids_only
    search_details = ContributorAdvancedSearchDetails.new
    search_details.known_as="chris"
    query = AdvancedFinderHelper.build_advanced_contributor_lucene_query(search_details)
    result1 = solr_query(query, {:rows => 3})[0][:docs]
    result2 = advanced_solr_query(query, {:rows => 3})[0][:docs]
    
    puts result1.to_yaml
    puts result2.to_yaml
    assert_equal result1.length, result2.length
    
    
    ids = []
    result2.map{|m| ids << m.split(':')[1]}
    puts ids

  end
  
  
  #test the contributor search function
  def test_contributor_search_with_letter
    search_details = ContributorAdvancedSearchDetails.new
    search_details.known_as="c"
    
    ids = AdvancedFinderHelper.find_contributors(search_details)
    display_contributors(ids)
  end

=begin
SEARCH DETAILS:--- !ruby/object:ContributorAdvancedSearchDetails 
apra: "no"
canz: "true"
composer_status: ""
deceased: ""
internal_note: ""
known_as: auck
profile: ""
pull_quote: ""
role_type_id: "26"
status_id: ""
work_category_id: ""
work_subcategory_id: ""
year_of_birth: ""
=end

def test_contributor_search
  search_details = ContributorAdvancedSearchDetails.new
  search_details.known_as=""
  search_details.role_type_id=26
  search_details.apra="no"
  search_details.canz="true"
  
  #Add a role type
  search_details.role_type_id = RoleType.find(40)
  search_details.status_id = Status.find_by_symbol(:pending).status_id
  ids = AdvancedFinderHelper.find_contributors(search_details)
  display_contributors(ids)
end




def test_man_res_search
  search_details = ManifestationResourceSearchDetails.new
  search_details.title="guitar"
  search_details.manifestation_type_format_id = 24
  assert_equal true,  search_details.contains_solr_query_data?
  results = AdvancedFinderHelper.find_manifestations_and_resources(search_details)
  obj_results = AdvancedFinderHelper.convert_solr_ids_to_objects(results)
  puts "===="
  obj_results.map{|t| puts t.objectData.format.format_desc+"(#{t.objectData.format_id})"}
end

  def test_man_res_search_without_solr
    search_details = ManifestationResourceSearchDetails.new
    #search_details.title="guitar"
    search_details.manifestation_type_format_id = 24
  
  
    assert_equal false,  search_details.contains_solr_query_data?
    results = AdvancedFinderHelper.find_manifestations_and_resources(search_details)
  
  
    obj_results = AdvancedFinderHelper.convert_solr_ids_to_objects(results)
    obj_results.map{|t| puts t.objectData.format.format_desc+"(#{t.objectData.format_id})"}
    puts results.to_yaml
  
  
    assert results.length != 0 #fixing a no solr results bug
  end


  #Check a few terms to see if the event search query is properly formed
  def test_event_search_query
    search_details = EventAdvancedSearchDetails.new
    search_details.title="concert"
    assert_equal true,  search_details.contains_solr_query_data?
    assert_equal "type_t:Event AND (event_title_for_solr_t:(concert*))", 
              AdvancedFinderHelper.build_advanced_event_query(search_details)
   
    search_details.general_note = 'piano'
    assert_equal "type_t:Event AND (event_title_for_solr_t:(concert*) AND general_note_for_solr_t:(piano*))",
                          AdvancedFinderHelper.build_advanced_event_query(search_details)
                          
    
  end
  
  
  def test_event_search_query_with_dates
    search_details = EventAdvancedSearchDetails.new
    search_details.event_start = "24 Jun 2007"
    assert_equal "type_t:Event AND (event_start_for_solr_s:(20070624))", AdvancedFinderHelper.build_advanced_event_query(search_details)
  
    search_details = EventAdvancedSearchDetails.new
    search_details.event_finish = "24 Jun 2007"
   
    assert_equal "type_t:Event AND (event_finish_for_solr_s:(20070624))", AdvancedFinderHelper.build_advanced_event_query(search_details)
    
     search_details.event_start = "22 Jun 2007"
      search_details.event_finish = "23 Jun 2007"
     assert_equal "asfsadfsadf", AdvancedFinderHelper.build_advanced_event_query(search_details)
  end
  
  def test_event_search_with_status_id
    search_details = EventAdvancedSearchDetails.new
    search_details.status_id = 3
    assert_equal "asdfsasfd", AdvancedFinderHelper.build_advanced_event_query(search_details)
  end
  
  
  
  def test_event_search_with_solr
    search_details = EventAdvancedSearchDetails.new
    search_details.title="concert"
    assert_equal true,  search_details.contains_solr_query_data?

    results = AdvancedFinderHelper.find_events(search_details)


    obj_results = AdvancedFinderHelper.convert_solr_ids_to_objects(results)
    obj_results.map{|t| puts t.objectData.format.format_desc+"(#{t.objectData.format_id})"}
    puts results.to_yaml
  end


  
  
  private
  
  #Show contributors from ids for debug purposes
  def display_contributors(ids)
    conditions = [ "contributors.contributor_id in (?)", ids ]
    puts conditions
    puts "*******"
    result = Contributor.find(:all, :conditions => conditions)
    puts result.map{|c| c.known_as}
  end
  
  
end