require File.dirname(__FILE__) + '/../test_helper'

class ContributorTest < Test::Unit::TestCase
  
  
  def setup
    @contributor = Contributor.find(1288)
  end
  
  
  def test_type
    for contributor in Contributor.find(:all)
      puts contributor.description+"(#{contributor.contributor_id}):"+contributor.what_kind_of_contributor?.to_s
      puts
    end
  end
  
  
  def test_frbr_and_inverse
    #Mr de Pledge
    c = Contributor.find(1288)
    
    #This is the array of object, we wish to avoid getting them
    performances = c.performances
    n1 = performances.length
    
    #This is one way for FRBR
    n2 = c.number_of_performances
    
    assert_same(n1,n2)
    
    assert_same(c.commissioned_works.length, c.number_of_commissioned_works)
    
  end
  
  
  def test_known_as_contributor_person_both_blank
     p = @contributor.person
     
    c = @contributor
    c.known_as = nil
    p.known_as = nil
    assert_equal  p.full_name, c.description
  end
  
  
  def test_known_as_contributor_person_contributor_blank
    p = @contributor.person
    p.known_as = "Test"
    @contributor.known_as = nil
    p.save
    @contributor.save
    puts "********"
    assert_equal  p.known_as, @contributor.description
  end
  
  
  def test_known_as_contributor_person_not_blank
    p = @contributor.person
    c = @contributor
    c.known_as = "Test"
        
    assert_equal  c.known_as, c.description
  end
  
  def test_description_person_both_blank
    p = @contributor.person
    c = @contributor
    c.known_as = nil
    p.known_as = nil
        
    assert_equal  "Stephen De Pledge", c.description
    
  end
  
  
  def test_known_as_contributor_organisation

    c = @contributor
    c.person = nil
    c.organisation = nil
    c.organisation = Organisation.find(:first)
    c.known_as = nil
    c.save
    assert_equal  c.organisation.organisation_name, c.description
    
    
    c.known_as = "Test"
    assert_equal c.known_as, c.description

    puts "TEST BOTH NILS........"
    c.known_as = nil
    c.organisation.organisation_name = nil
    assert_equal "ORGANISATION NAME NOT FOUND", c.description
  end
  
  
  def test_person_description
      contributor = Contributor.find(1001)
      assert_equal "Eve De Castro-Robinson", contributor.description    
  end
  

  def test_person_urls
    contributor = Contributor.find(1228)
    assert_equal ["www.chriswatsoncomposer.com"], contributor.get_website_urls
  end
  
  
  #this guy has no contact info countries or regions
  def test_inside_outside_nz
    c = Contributor.find(1273)
    #just to make sure...
    for ci in c.role.contactinfos
      ci.country = nil
      ci.region = nil
    end
    assert c.save

         
    assert_equal "", c.countries_facet_for_solr
    assert_equal "", c.nz_regions_facet_for_solr
    assert_equal false, c.inside_nz_for_solr
    assert_equal false, c.outside_nz_for_solr
    
    c.role.contactinfos[0].country = Country::NEW_ZEALAND
     assert_equal "", c.countries_facet_for_solr
     assert_equal "", c.nz_regions_facet_for_solr
     assert_equal true, c.inside_nz_for_solr
     assert_equal false, c.outside_nz_for_solr
     c.role.contactinfos[0].country = nil
 
    nz_region = Region.find(1)
    assert_equal Country::NEW_ZEALAND, nz_region.country
     c.role.contactinfos[0].region = nz_region
     puts Region.find(1)
      assert_equal "", c.countries_facet_for_solr
      assert_equal nz_region.region_id.to_s, c.nz_regions_facet_for_solr
      assert_equal true, c.inside_nz_for_solr
      assert_equal false, c.outside_nz_for_solr
      c.role.contactinfos[0].region = nil
 
      c.role.contactinfos[0].country = Country::AUSTRALIA
       assert_equal "australia", c.countries_facet_for_solr
       assert_equal "", c.nz_regions_facet_for_solr
       assert_equal false, c.inside_nz_for_solr
       assert_equal true, c.outside_nz_for_solr
       c.role.contactinfos[0].country = nil
 
 
     #FIXME TODO test with a non nz region and blank country
 
    
  end
  
  
  def test_organisation_urls
    flunk "todo"
  end
  
  
  def test_associated_countries
    contributor = Contributor.find(1068)
    for ci in contributor.role.contactinfos
      puts "CONTACT_INFO:#{ci.contactinfo_id} COUNTRY:#{ci.country_id} REGION:#{ci.region_id}"
    end
       puts "COUNTRIES:"+contributor.associated_countries.map{|ci| ci.country_id}.to_s
  end
  
  
  def test_last_name
    c = Contributor.find(1105) #Bill Barclay
    assert 'b', c.last_name_range_for_solr
    
  end
  
  def test_last_name_range_for_solr
    c = Contributor.find(:first)
    c.known_as = "Gary Wilby"
    assert_equal "t-w", c.last_name_range_for_solr
  end
  
  def test_facet_ordering
    c = Contributor.find(:first)
    c.known_as = "Gary Wilby"
    assert_equal "Wilby, Gary", c.facet_sort_field_for_solr
  end
  
  
end
