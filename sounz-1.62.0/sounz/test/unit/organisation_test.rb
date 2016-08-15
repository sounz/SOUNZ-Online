require File.dirname(__FILE__) + '/../test_helper'

class OrganisationTest < Test::Unit::TestCase
  
  
  def setup
    @organisation = Organisation.find(:first)
  end

  def test_people
    
    org=Organisation.find(74)
    spods = org.people
    puts "===="
    #For each organisation we get its people and check that they exist in the organisatiion.people method
    for spod in spods
      puts spod.person_id.to_s+":"+spod.full_name
      orgs = spod.organisations
      assert orgs.include?(org)
    end
    
    #Now check all the organisations and do a total count
    ctr = 0
    for spod in Person.find(:all)
      if spod.organisations.include?(org)
        ctr = ctr + 1
      end
    end
    
    #There should be the same number
    assert ctr == spods.length
    puts "===="
  end
  
  
  def test_new
    org = Organisation.new
    assert !org.save
  end
  
  
  def test_length_of_organisation_name
      test_long_value_boundaries_of_model_field(@organisation, :organisation_name, 2, 100)
  end
  
  
  def test_updated_by_necessary
    assert @organisation.save
    @organisation.login_updated_by = nil
    assert !@organisation.save
  end
  
  def test_status_necessary
    assert @organisation.save
    @organisation.status = nil
    assert !@organisation.save
  end
  
  

  
  
  
  def test_both_roles_with_organisation
    updated_by_id = Login.find(:first)
    
    @org_with_role = Organisation.find(:first)
    assert @org_with_role.roles.length == 0 #Check no roles
    
    research_role_type = RoleType.find(18)
    contributor_role_type =  RoleType::CONTRIBUTOR
    
    
    #Now create a researcher role and a contributor role
    @researcher_role = Role.create(:role_type_id => research_role_type.role_type_id,  :role_title => 'Test title')
    @contributor_role = Role.create(:role_type_id => contributor_role_type.role_type_id, :role_title => 'Dancing Queen')
        
    assert @org_with_role.create_self(@researcher_role, @contributor_role)
    
    assert_equal @org_with_role, @researcher_role.organisation
    assert_equal @org_with_role, @contributor_role.organisation
    
    #This appears to be necessary
    @org_with_role.reload
    
    assert @org_with_role.is_contributor?
    assert_equal 2,@org_with_role.roles.length
    
    #Lets add some addresses, one with a country and one with a region
    @research_ci = Contactinfo.new
    @research_ci.region = Region.find(1)
    @research_ci.login_updated_by = updated_by_id
    @research_ci.website_urls = "http://www.test1.com\nhttp://www.test2.com"
     
    puts "LOGIN UPDATED BY is "+updated_by_id.to_s
    assert @research_ci.save
    
    @rrci = RoleContactinfo.new
    @rrci.role = @researcher_role
    @rrci.contactinfo = @research_ci
    @rrci.contactinfo_type = 'physical'
    assert @rrci.save
    
    @contributor_ci = Contactinfo.new
    @contributor_ci.country = Country.find(1)
    @contributor_ci.login_updated_by = updated_by_id
    @contributor_ci.website_urls = "http://www.test3.com\nhttp://www.test4.com"
    assert @contributor_ci.save
    
    @crci = RoleContactinfo.new
    @crci.role = @contributor_role
    @crci.contactinfo = @contributor_ci
    @crci.contactinfo_type = 'billing'
    assert @crci.save
    
    assert_equal  @crci.contactinfo_id, @contributor_role.contactinfos[0].contactinfo_id
    assert_equal  @rrci.contactinfo_id, @researcher_role.contactinfos[0].contactinfo_id
    
    
    puts "ORG CONTRIB ID"
    puts @organisation.contributor_id
    puts "DONE"
    
    
  end
  
  
  #FIXME: This test does not pass, why!
  def test_legacy_codes_unique
    orgs = Organisations.find(:all, :limit => 2)
    org1 = orgs[0]
    org2 = orgs[1]
    
    new_leg_code = "AAAA"
    assert org1.legacy4d_identity_code != org2.legacy4d_identity_code
    org1.legacy4d_identity_code = new_leg_code
    org2.legacy4d_identity_code = new_leg_code
    assert !org1.save
    assert !org2.save
    
  end
  
  def test_legacy_code_optional
    @organisation.legacy4d_identity_code = nil
    assert @organisation.save
  end
  
  def test_name_mandatory
    @organisation.organisation_name = nil
    assert !@organisation.save
  end
  
end
