require "#{File.dirname(File.expand_path(__FILE__))}/../test_helper"

class ActsAsSolrTest < Test::Unit::TestCase
  
  fixtures :books, :movies
  
  # Inserting new data into Solr and making sure it's getting indexed
  def test_insert_new_data
    assert_equal 2, Book.count_by_solr('ruby OR splinter OR bob')
    b = Book.create(:name => "Fuze in action", :author => "Bob Bobber", :category_id => 1)
    Book.solr_commit
    assert b.valid?
    assert_equal 3, Book.count_by_solr('ruby OR splinter OR bob')
  end

  # Testing basic solr search:
  #  Model.find_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_by_solr_ruby
    ['ruby', 'dummy', 'name:ruby', 'name:dummy', 'name:ruby AND author:peter', 
      'author:peter AND ruby', 'peter dummy'].each do |term|
      records = Book.find_by_solr term
      assert_equal 1, records.size
      assert_equal "Peter McPeterson", records.first.author
      assert_equal "Ruby for Dummies", records.first.name
      assert_equal ({"id" => 2, 
                      "category_id" => 2, 
                      "name" => "Ruby for Dummies", 
                      "author" => "Peter McPeterson"}), records.first.attributes
    end
  end
  
  # Testing basic solr search:
  #   Model.find_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_by_solr_splinter
    ['splinter', 'name:splinter', 'name:splinter AND author:clancy', 
      'author:clancy AND splinter', 'cell tom'].each do |term|
      records = Book.find_by_solr term
      assert_equal 1, records.size
      assert_equal "Splinter Cell", records.first.name
      assert_equal "Tom Clancy", records.first.author
      assert_equal ({"id" => 1, "category_id" => 1, "name" => "Splinter Cell", 
                     "author" => "Tom Clancy"}), records.first.attributes
    end
  end
  
  # Testing basic solr search:
  #   Model.find_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_by_solr_ruby_or_splinter
    ['ruby OR splinter', 'ruby OR author:tom', 'name:cell OR author:peter', 'dummy OR cell'].each do |term|
      records = Book.find_by_solr term
      assert_equal 2, records.size
    end
  end
  
  # Testing search in indexed field methods:
  # 
  # class Movie < ActiveRecord::Base
  #   acts_as_solr :fields => [:name, :description, :current_time]
  # 
  #   def current_time
  #     Time.now.to_s
  #   end
  # 
  # end
  # 
  # The method current_time above gets indexed as being part of the
  # Movie model and it's available for search as well
  def test_find_with_dynamic_fields
    date = Time.now.strftime('%b %d %Y')
    ["dynamite AND #{date}", "description:goofy AND #{date}", "goofy napoleon #{date}", 
      "goofiness #{date}"].each do |term|
      records = Movie.find_by_solr term 
      assert_equal 1, records.size
      assert_equal ({"id" => 1, "name" => "Napoleon Dynamite", 
                     "description" => "Cool movie about a goofy guy"}), records.first.attributes
    end
  end
  
  # Testing basic solr search that returns just the ids instead of the objects:
  #   Model.find_id_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_id_by_solr_ruby
    ['ruby', 'dummy', 'name:ruby', 'name:dummy', 'name:ruby AND author:peter', 
      'author:peter AND ruby'].each do |term|
      records = Book.find_id_by_solr term
      assert_equal 1, records.size
      assert_equal [2], records
    end
  end
  
  # Testing basic solr search that returns just the ids instead of the objects:
  #   Model.find_id_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_by_solr_splinter
    ['splinter', 'name:splinter', 'name:splinter AND author:clancy', 
      'author:clancy AND splinter'].each do |term|
      records = Book.find_id_by_solr term
      assert_equal 1, records.size
      assert_equal [1], records
    end
  end
  
  # Testing basic solr search that returns just the ids instead of the objects:
  #   Model.find_id_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_find_id_by_solr_ruby_or_splinter
    ['ruby OR splinter', 'ruby OR author:tom', 'name:cell OR author:peter', 
      'dummy OR cell'].each do |term|
      records = Book.find_id_by_solr term
      assert_equal 2, records.size
      assert_equal [1,2], records
    end
  end
  
  # Testing basic solr search that returns the total number of records found:
  #   Model.find_count_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_count_by_solr
    ['ruby', 'dummy', 'name:ruby', 'name:dummy', 'name:ruby AND author:peter', 
      'author:peter AND ruby'].each do |term|
      assert_equal 1, Book.count_by_solr(term), "there should only be 1 result for search: #{term}"
    end
  end
  
  # Testing basic solr search that returns the total number of records found:
  #   Model.find_count_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_count_by_solr_splinter
    ['splinter', 'name:splinter', 'name:splinter AND author:clancy', 
      'author:clancy AND splinter', 'author:clancy cell'].each do |term|
      assert_equal 1, Book.count_by_solr(term)
    end
  end
  
  # Testing basic solr search that returns the total number of records found:
  #   Model.find_count_by_solr 'term'
  # Note that you're able to mix free-search with fields and boolean operators
  def test_count_by_solr_ruby_or_splinter
    ['ruby OR splinter', 'ruby OR author:tom', 'name:cell OR author:peter', 'dummy OR cell'].each do |term|
      assert_equal 2, Book.count_by_solr(term)
    end
  end
    
  # Testing basic solr search with additional options:
  # Model.find_count_by_solr 'term', :rows => 10, :start => 0
  def test_find_with_options
    [0,1,2].each do |count|
      records = Book.find_by_solr 'ruby OR splinter', :rows => count
      assert_equal count, records.size
    end
  end
  
  # Testing self.rebuild_solr_index
  # - It makes sure the index is rebuilt after a data has been lost
  def test_rebuild_solr_index
    assert_equal 1, Book.count_by_solr('splinter')
    
    Book.find(:first).solr_destroy
    Book.solr_commit
    assert_equal 0, Book.count_by_solr('splinter')
    
    Book.rebuild_solr_index
    Book.solr_commit
    assert_equal 1, Book.count_by_solr('splinter')
  end
  
  # Testing instance methods:
  # - solr_save
  # - solr_destroy
  def test_solr_save_and_solr_destroy
    assert_equal 1, Book.count_by_solr('splinter')
  
    Book.find(:first).solr_destroy
    Book.solr_commit
    assert_equal 0, Book.count_by_solr('splinter')
    
    Book.find(:first).solr_save
    Book.solr_commit
    assert_equal 1, Book.count_by_solr('splinter')
  end
  
  def test_find_in_order
    records = Book.find_by_solr 'ruby^5 OR splinter'
    # we boosted ruby so ruby should come first

    assert_equal 2, records.size
    assert_equal 'Ruby for Dummies', records[0].name
    assert_equal 'Splinter Cell', records[1].name    
  end
    
end
