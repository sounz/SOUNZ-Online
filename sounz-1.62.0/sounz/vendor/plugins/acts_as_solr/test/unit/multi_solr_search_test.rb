require File.join(File.dirname(__FILE__), '../test_helper')

class ActsAsSolrTest < Test::Unit::TestCase
  
  fixtures :books, :movies

  # Testing the multi_solr_search with the returning results being objects
  def test_multi_solr_search_return_objects
    records = Book.multi_solr_search "Napoleon OR Tom", :models => [Movie], :results_format => :objects
    assert_equal 2, records.size
    assert_equal Movie, records.first.class
    assert_equal Book,  records.last.class
  end

  # Testing the multi_solr_search with the returning results being ids
  def test_multi_solr_search_return_ids
    records = Book.multi_solr_search "Napoleon OR Tom", :models => [Movie], :results_format => :ids
    assert_equal 2, records.size
    assert records.include?({"id" => "Movie:1"})
    assert records.include?({ "id" => "Book:1"})
  end
  
end
