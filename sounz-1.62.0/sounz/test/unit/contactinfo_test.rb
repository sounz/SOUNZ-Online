require File.dirname(__FILE__) + '/../test_helper'

class ContactinfoTest < Test::Unit::TestCase
  
  VALID_EMAILS = ['gordon@catalyst.net.nz', 'nigel.mcie@gmail.com', 'wombles@wimbledon.yahoo.com', '']
  INVALID_EMAILS = [' ','300', 'gordon@@catalyst.net.nz', 'nigel@gmail', '@..']
  
  VALID_PHONES = ['021 2334567', '+64 21 231231', '+0064 21 321312', '0800 NIGEL']
  INVALID_PHONES = ['asdfhsadkfasdkfjhkdsahfkdhsafkhadskfhasdhfsdhafs', 'POpapa!!&*^&*^&*']
    
  def setup
    @contactinfo = Contactinfo.find(:first)
    #This ensures validity...
    @contactinfo.country = nil
    @contactinfo.region_id = 1 
  end
  
  def test_search_for_org_and_people
    Contactinfo.find_contacts([1,2,3] , [10,11,12])
  end
  
  def test_get_a_phone_number
      phone="02139487593487589"
      c = Contactinfo.find(:first)
      c.phone = ""
      c.phone_alt=""
      c.phone_fax=""
      c.phone_mobile=phone
      puts "PHONE:"+c.get_a_phone_number
      puts c.to_yaml
  
      assert c.get_a_phone_number == phone

      c.phone_mobile=""
      c.phone_alt=phone
      puts "PHONE:"+c.get_a_phone_number
      puts c.to_yaml
      assert c.get_a_phone_number == phone
  
      c.phone_alt=""
      c.phone=phone
      puts "PHONE:"+c.get_a_phone_number
      puts c.to_yaml
      assert c.get_a_phone_number == phone
  
       puts "PHONE:"+c.get_a_phone_number
       puts c.to_yaml 
      c.phone=""
      c.phone_fax=phone
      assert c.get_a_phone_number == phone+" (fax)"
  
      puts "PHONE:"+c.get_a_phone_number
      puts c.to_yaml
      c.phone_fax = ""
      assert_equal(c.get_a_phone_number, "[No phone number]")
  end
  
  
  def test_urls
    for contactinfo in Contactinfo.find(:all)
      websites = contactinfo.get_list_of_websites
      puts
      puts contactinfo.contactinfo_id
      for website in websites
        puts '\t'+website
      end
    end
  end
 
=begin
phone                 | text                        | 
phone_alt             | text                        | 
phone_fax             | text                        | 
phone_mobile
=end 
  
  def test_phone
    for phone in VALID_PHONES
      @contactinfo.phone = phone
      assert @contactinfo.save
      
      @contactinfo.phone_alt = phone
      assert @contactinfo.save
      
      @contactinfo.phone_fax = phone
      assert @contactinfo.save
      
      @contactinfo.phone_mobile = phone
      assert @contactinfo.save
    end
    
    for phone in INVALID_PHONES
      puts "Testing #{phone}"
      @contactinfo.phone = phone
      assert !@contactinfo.save
      @contactinfo.phone = nil
      
      @contactinfo.phone_alt = phone
      assert !@contactinfo.save
      @contactinfo.phone_alt = nil
      
      @contactinfo.phone_fax = phone
      assert !@contactinfo.save
      @contactinfo.phone_fax = phone
      
      @contactinfo.phone_mobile = phone
      assert !@contactinfo.save
      @contactinfo.phone_mobile = nil
    end
  end
  
  
  def test_email
    for email in VALID_EMAILS
      @contactinfo.email_1 = email
      assert @contactinfo.save
      @contactinfo.email_2 = email
      assert @contactinfo.save
      @contactinfo.email_3 = email
      assert @contactinfo.save
    end
    
    for email in INVALID_EMAILS
      @contactinfo.email_1 = email
      assert !@contactinfo.save
      @contactinfo.email_1 = nil
      @contactinfo.email_2 = email
      assert !@contactinfo.save
      @contactinfo.email_2 = nil
      @contactinfo.email_3 = email
      assert !@contactinfo.save
      @contactinfo.email_3 = nil
    end
  end
  
  #You should not be able to save a totally blank contact info
  def test_blank_contactinfo
    c = Contactinfo::new
    c.updated_by = 1
    assert !c.save
  end
  
  
  def test_country_only
    @contactinfo.country_id = 1
    @contactinfo.region_id = nil
    assert @contactinfo.save
  end
  
  def test_region_only
    @contactinfo.country_id = nil
    @contactinfo.region_id = 1
    assert @contactinfo.save
  end
  
  def test_country_and_region
    @contactinfo.country_id = 1
    @contactinfo.region_id = 2
    saved = @contactinfo.save
    assert saved
  end
  
  #One ought not to be able to add the same region
  def test_region_in_all_countries
    countries = Country.find(:all)
    region = Region.find(2)
    for country in countries
      @contactinfo.country_id = country.country_id
      @contactinfo.region_id = region.region_id
      saved = @contactinfo.save
      assert_equal saved, country.region_id != region.region_id
    end
  end
  
  def test_country_and_region_both_nil
    @contactinfo.country_id = nil
    @contactinfo.region_id = nil
    assert !@contactinfo.save
  end
  
  
  
  def test_get_website_urls
    @contactinfo.website_urls = "http://www.test.com"
    assert_equal ["http://www.test.com"], @contactinfo.get_list_of_websites
  end
end
