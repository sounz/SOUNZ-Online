require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/helpers/finder_helper'

class FinderHelperTest < Test::Unit::TestCase

  include FinderHelper
  
  def test_model_parameter_sane
    assert_raise ArgumentError do
      FinderHelper.build_query(SearchController)
    end

    assert_raise ArgumentError do
      FinderHelper.build_query([Work, SearchController])
    end
  end

  def test_search_parameter_sane
    assert_raise ArgumentError do
      FinderHelper.build_query(Work, 0)
    end
  end

  def test_field_parameter_sane
    assert_raise ArgumentError do
      FinderHelper.build_query(Work, '', 1)
    end

    assert_raise ArgumentError do
      FinderHelper.build_query(Work, '', 'string')
    end

    assert_raise ArgumentError do
      FinderHelper.build_query(Work, '', [{:name => 'value'}, 1])
    end
  end
  
  
  def test_simple_and_advanced_match
    desired_result = "type_t:Work AND (work_title_for_solr_t:(harry* OR potter*))"
    assert_equal desired_result, 
      FinderHelper.build_query(Work,  'Harry Potter', [:name => 'work_title_for_solr_t'])
    assert_equal desired_result, FinderHelper.build_advanced_query(Work, 
          [:name => 'work_title_for_solr_t', :query_string =>  'Harry Potter'])
  end
  
  

  def test_blank_non_advanced_query
    assert_equal "FIXME: What should this do?", 
      FinderHelper.build_query(Work,  '', [{:name => 'work_title_for_solr_t'}]
      )
  end
  
  
  def test_blank_advanced_query
    
    assert_equal "type_t:Work AND (work_title_for_solr_t:(*:*) AND instrumentation_for_solr_t:(flute*))", 
      FinderHelper.build_advanced_query(Work,  [{:name => 'work_title_for_solr_t'}, 
              {:name => 'instrumentation_for_solr_t', :query_string => 'flute'}],''
      )
    
    desired_result = "type_t:Work AND (work_title_for_solr_t:(*:*))"
      assert_equal desired_result, 
        FinderHelper.build_advanced_query(Work, [:name => 'work_title_for_solr_t'], '')

    assert_equal desired_result, FinderHelper.build_advanced_query(Work, 
          [:name => 'work_title_for_solr_t', :query_string =>  ''])
  end




  def test_search_string_built_ok
    assert_equal 'type_t:Work AND (dollyfish*)', FinderHelper.build_query(Work, 'dollyfish')
    
    #query across common fields
    assert_equal 'type_t:Work AND (work_title_for_solr_t:(harry* OR potter*))', 
      FinderHelper.build_query(Work,  'Harry Potter', [:name => 'work_title_for_solr_t'])
    assert_equal '(type_t:Work OR type_t:Person) AND (potter*)', FinderHelper.build_query([Work, Person], 'potter**')
    assert_equal '(type_t:Work OR type_t:Person) AND (work_title_for_solr_t:(hello* OR world*)^2.0 OR work_description_for_solr_t:(hello* OR world*)^1.2)',
        FinderHelper.build_query([Work, Person], 
        'hello world!@^$@%#', [{:name => 'work_title_for_solr_t', :boost => 2.0}, 
          {:name => 'work_description_for_solr_t', :boost => 1.2}])
  end

  def test_empty_search
    assert_equal '*:*', FinderHelper.build_query([])
  end
  
  #Test switching between AND/OR for simple queries
  def test_query_type
    assert_raise ArgumentError do
      FinderHelper.build_query(Work, 'sheeps',[{:name => 'value'}], query_param_boolean='BORKEN')
    end

    assert_equal "type_t:Work AND (value:(sheep* OR stack*))", FinderHelper.build_query(Work, 'sheep stack',[{:name => 'value'}])    
    assert_equal "type_t:Work AND (value:(sheep* AND stack*))", FinderHelper.build_query(Work, 'sheep stack',[{:name => 'value'}], query_param_boolean='AND')
    assert_equal "type_t:Work AND (value:(sheep* OR stack*))", FinderHelper.build_query(Work, 'sheep stack',[{:name => 'value'}], query_param_boolean='OR')
  end
  
  
  def test_blank_main_query
     assert_equal "*:*", FinderHelper.build_query(Work, '',[{:name => 'value'}])    
  end
  
  
  def test_terms_for_fields
    fields = [{:name => 'work_title_for_solr_t', :query_string => 'penguin'},
            {:name => 'work_description_for_solr_t', :query_string => 'dance little penguin'}
            ]
    assert_equal "type_t:Work AND (work_title_for_solr_t:(penguin*) AND work_description_for_solr_t:(dance* OR little* OR penguin*))",
                                  FinderHelper.build_query(Work, "penguin", fields, query_param_boolean='AND')
    
    assert_equal "type_t:Work AND (work_title_for_solr_t:(penguin*) OR work_description_for_solr_t:(dance* OR little* OR penguin*))",
                  FinderHelper.build_query(Work, "penguin dance", fields, query_param_boolean='OR')
  end
  
  
  
  def test_strip
    assert_equal "abcd", FinderHelper.strip("abcd")
    assert_equal "abcd1234", FinderHelper.strip("abcd1234")
    assert_equal "abcd                         M  M     ", FinderHelper.strip("abcd !**(^(*&^^*&^&*(^&*^*&><M<>M<>)))")
    assert_equal "     abcd     ", FinderHelper.strip("     abcd:    ")
    assert_equal "a b c d", FinderHelper.strip("a b c d")
  end
  
  def test_query_gen
    assert_equal "type_t:Work",FinderHelper.build_advanced_query(Work,[])
  end
  
  
=begin
:facet_queries: 
- intended_duration_for_solr_i:[0 TO 299]
- intended_duration_for_solr_i:[300 TO 599]
- intended_duration_for_solr_i:[600 TO 899]
- intended_duration_for_solr_i:[900 TO 1199]
- intended_duration_for_solr_i:[1200 TO 1799]
- intended_duration_for_solr_i:[1800 TO *]
:facet_fields: 
- :year_group_for_solr_s
- :year_subgroup_for_solr_s
- :categories_for_solr_s
- :difficulty_t
:rows: 10
:page: 1
:facet_zeroes: true
:facet: true
=end
  def test_facet_search
    options = {
      :page          => 1,
      :rows          => 10,
      :facet         => true,
      :facet_zeroes  => true,
      :fq            => [],
      :facet_fields  => [:year_group_for_solr_s, :year_subgroup_for_solr_s, :categories_for_solr_s, :difficulty_t],
      :facet_queries => []
    }
    options[:facet_queries]=""
    options[:facet_queries] << 'intended_duration_for_solr_i:[0 TO 299]'
    options[:facet_queries] << 'intended_duration_for_solr_i:[300 TO 599]'
    options[:facet_queries] << 'intended_duration_for_solr_i:[600 TO 899]'
    options[:facet_queries] << 'intended_duration_for_solr_i:[900 TO 1199]'
    options[:facet_queries] << 'intended_duration_for_solr_i:[1200 TO 1799]'
    options[:facet_queries] << 'intended_duration_for_solr_i:[1800 TO *]'
  end
  

  def test_not_fields
    fields = [{:name => 'work_title_for_solr_t', :query_string => 'penguin'},
    {:name => 'work_description_for_solr_t', :query_string => 'dance little penguin'}
    ]
    
    not_fields = [{:name => 'not_work_title_for_solr_t', :query_string => 'penguin'},
    {:name => 'not_work_description_for_solr_t', :query_string => 'dance little penguin'}
    ]
    query =  FinderHelper.build_query(Work, "", [], query_param_boolean='AND', not_fields = not_fields,defined_models_only=true)
    puts "========"
    puts query
    
    assert_equal "type_t:Work AND NOT (not_work_title_for_solr_t:(penguin*) AND not_work_description_for_solr_t:(dance* OR little* OR penguin*))",query
    
    query =  FinderHelper.build_query(Work, "", fields, query_param_boolean='OR', not_fields = not_fields,defined_models_only=true)
    puts "========"
    puts query
    assert_equal "type_t:Work AND (work_title_for_solr_t:(penguin*) OR work_description_for_solr_t:(dance* OR little* OR penguin*)) AND NOT (not_work_title_for_solr_t:(penguin*) OR not_work_description_for_solr_t:(dance* OR little* OR penguin*))",query
    
    query =  FinderHelper.build_query([Work,Resource], "", fields, query_param_boolean='OR', not_fields = not_fields)
    puts "========"
    puts query
  end
  
  
  def test_solr_date
    t = Time.parse("04 Jan 2007")
    assert_equal "20070104", FinderHelper.date_for_solr_ymd(t)
    
    t = t + 11.hours
    t = t + 47.minutes
    
    assert_equal "200701041147", FinderHelper.date_for_solr_ymdhms(t)
  end
  
  
  def test_numeric_queries
   
    assert_equal "ghfghfg", FinderHelper.build_query(Work, '47', [:name => 'title_t']) 
    #assert_equal "ghfghfg", FinderHelper.build_query(Work, '47') 
       
     FinderHelper.build_query(Work,  'Harry Potter', [:name => 'work_title_for_solr_t'])
  end
  
  
  
  
  
  

end
