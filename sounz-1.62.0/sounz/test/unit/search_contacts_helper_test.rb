require File.dirname(__FILE__) + '/../test_helper'



class SearchContactsHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  include SearchContactsHelper
  
  
  
  # Check that people who work for an organisation can be found by search each of them using free text
  # Note that roles fixtures are random, so we need to get round this by getting a list of people who work for
  # an organisation and then search for each one.  Hey you gotta be thorough!
  def test_people_and_organisations_found
    organisation = Organisation.find(10)
    people = organisation.people
    for person in people
      puts "Searching for \'#{person.full_name}\' working for \'#{organisation.organisation_name}\'"
      contacts = find_people_who_work_for_organisation_by_solr(person.full_name,organisation.organisation_name)
      for contact in contacts
        puts contact.class
        #Check if the person and organisation match correctly
        if contact.class.to_s == "Person"
          assert contact == person
        elsif contact.class.to_s == "Organisation"
          assert contact == organisation
        end
        puts contact.to_string
      end
    end
    puts ""
  end
  
  # If no organsations or people are found then things get tricky as select * from roles where organisation_id in ('') does not work too well...
  def test_people_with_no_organisations_found
    #Choose a name of an org that almost certainly wont be found
    p = Person.find(100)
    contacts = find_people_who_work_for_organisation_by_solr(p.full_name, "oiasdufoisadufoisdaufouosdaif")
    assert contacts.length == 0
  end
  
  
  # If no organsations or people are found then things get tricky as select * from roles where organisation_id in ('') does not work too well...
  def test_organisations_with_no_people_found
    #Choose a name of an person that almost certainly wont be found
    o = Organisation.find(33)
    contacts = find_people_who_work_for_organisation_by_solr( "oiasdufoisadufoisdaufouosdaif", o.organisation_name)
    assert contacts.length == 0
  end
  
  
  def test_blank_organisation
    p = Person.find(100)
    contacts = find_people_who_work_for_organisation_by_solr( p.full_name,"")
    assert contacts.length == 0
  end
  
  
  def test_nil_organisation
    p = Person.find(100)
    contacts = find_people_who_work_for_organisation_by_solr( p.full_name,nil)
    assert contacts.length == 0
  end
  
  
  def test_blank_person
    o = Organisation.find(30)
    contacts = find_people_who_work_for_organisation_by_solr( "",o)
    assert contacts.length == 0
  end
  
  
  def test_nil_person
    o = Organisation.find(30)
    contacts = find_people_who_work_for_organisation_by_solr( nil, o)
    assert contacts.length == 0
  end
  
  
  #Try and get SOLR to fall over
  def test_long_query_strings
    for number_words in [1,2,5,10,20,50,100]
    for number_chars in [10,20,50,100,200,500,1000,10000,100000]
      puts "Words, chars = #{number_words}, #{number_chars}"
      person_query = ""
      for i in 1..number_words
      person_query = person_query + get_string_of_length(number_chars)
      end
      org_query = get_string_of_length(number_chars)
    #  puts "Person_query:#{person_query}"
    #  puts "Organisation_query: #{org_query}"
      contacts = find_people_who_work_for_organisation_by_solr(person_query, org_query)
      assert contacts.length == 0
      puts ""
    end
    end
  end
  
end
