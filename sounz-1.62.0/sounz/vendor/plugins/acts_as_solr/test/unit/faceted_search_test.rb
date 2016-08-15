require File.join(File.dirname(__FILE__), '../test_helper')

class FacetedSearchTest < Test::Unit::TestCase
  
  fixtures :electronics
  
  # The tests below are for faceted search, but make sure you setup
  # the fields on your model you'd like to index as a facet field:
  # 
  # class Electronic < ActiveRecord::Base
  #   acts_as_solr :facets => [:category, :manufacturer]  
  # end
  # 
  # A basic faceted search using just one facet field
  def test_faceted_search_basic
    records = Electronic.find_with_facet "memory", :facets => {:fields =>[:category]}
    assert_equal 4, records[:docs].size
    assert_match /Apple 60 GB Memory iPod/, records[:docs].first.name
    assert_equal({"category_facet" => {"Electronics" => 1, 
                                       "Memory" => 2, 
                                       "Hard Drive" => 1}}, 
                 records[:facets]['facet_fields'])
  end

  def test_faceted_search_no_matches
    records = Electronic.find_with_facet "not found", :facets => { :fields => [:category]}
    assert_equal [], records[:docs]
    assert_equal [], records[:facets]['facet_fields']
  end
  
  # A basic faceted search using multiple facet fields
  def test_faceted_search_multiple_fields
    records = Electronic.find_with_facet "memory", :facets => {:fields =>[:category, :manufacturer]}
    assert_equal 4, records[:docs].size
    assert_equal({"category_facet" => {"Electronics" => 1, 
                                       "Memory" => 2, 
                                       "Hard Drive" => 1},
                  "manufacturer_facet" => {
                                           "Samsung Electronics Co. Ltd." => 1, 
                                           "Corsair Microsystems Inc." => 1, 
                                           "A-DATA Technology Inc." => 1,
                                           "Apple Computer Inc." => 1}}, records[:facets]['facet_fields'])
  end
  
  # A basic faceted search using facet queries to get counts. 
  # Here are the facets search query meaning:
  # "price:[* TO 200]" - Price up to 200
  # "price:[200 TO 500]" - Price from 200 to 500
  # "price:[500 TO *]" - Price higher than 500
  def test_facet_search_with_query
    records = Electronic.find_with_facet "memory", :facets => {:query => ["price:[* TO 200.00]",
                                                                          "price:[200.00 TO 500.00]",
                                                                          "price:[500.00 TO *]"]},
                                                   :field_types => {:price => :range_float}
    assert_equal 4, records[:docs].size
    assert_equal({"facet_queries" => {"price_rf:[* TO 200.00]"=>2,
                                      "price_rf:[500.00 TO *]"=>1,
                                      "price_rf:[200.00 TO 500.00]"=>1}, 
                  "facet_fields" => {}}, records[:facets])
  end
  
  def test_facet_search_with_query_and_field
    records = Electronic.find_with_facet "memory", :facets => {:query => ["price:[* TO 200.00]",
                                                                          "price:[200.00 TO 500.00]",
                                                                          "price:[500.00 TO *]"],
                                                               :fields => [:category, :manufacturer]},
                                                   :field_types => {:price => :range_float}
    
    q = records[:facets]["facet_queries"]
    assert_equal 2, q["price_rf:[* TO 200.00]"]
    assert_equal 1, q["price_rf:[500.00 TO *]"]
    assert_equal 1, q["price_rf:[200.00 TO 500.00]"]

    f = records[:facets]["facet_fields"]
    assert_equal 1, f["category_facet"]["Electronics"]
    assert_equal 2, f["category_facet"]["Memory"]
    assert_equal 1, f["category_facet"]["Hard Drive"]
    assert_equal 1, f["manufacturer_facet"]["Samsung Electronics Co. Ltd."]
    assert_equal 1, f["manufacturer_facet"]["Corsair Microsystems Inc."]
    assert_equal 1, f["manufacturer_facet"]["A-DATA Technology Inc."]
    assert_equal 1, f["manufacturer_facet"]["Apple Computer Inc."]
  end
  
  
end
