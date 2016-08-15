require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../selenium/selenium'
require "test/unit"
require File.dirname(__FILE__) + '/test_constants'
require File.dirname(__FILE__) + '/selenium_helper'

class SeleniumComposerTest < Test::Unit::TestCase
  
  include SeleniumHelper
  
  def setup
    @verification_errors = []
    puts "SETUP $SELENIUM is #{$selenium}"
    if $selenium
      puts "USING CACHED SELN"
      @selenium = $selenium
    else
      puts "CREATING NEW SELENIUM"
      @selenium = Selenium::SeleneseInterpreter.new("localhost", 4444, "*firefox", TestConstants::SERVER_URL, 10000);
      @selenium.start
    end
 #   @selenium.set_context("test_new", "info")
  end
  
  def teardown
    #@selenium.stop unless $selenium
    #assert_equal [], @verification_errors
  end
  

  #Check that barry the composer has the relevant forms for composers
  def test_composer_forms_exist
        login_as("barry_composer")
        
        @selenium.click "link=Community"
        wait_for_page_load
        assert_title("SOUNZ - SOUNZ COMMUNITY")
        
        assert_text_in_html '<h1>Composer Forms'
        community_page_location = @selenium.get_location
        @selenium.click "link=Lodge Event Form"
        wait_for_page_load
        
        @selenium.open community_page_location
        wait_for_page_load
        @selenium.click "link=Composer Biography"
        wait_for_page_load
        
        @selenium.open community_page_location
        wait_for_page_load
        @selenium.click "link=Update a Work"
        wait_for_page_load
        
        @selenium.open community_page_location
        wait_for_page_load
        @selenium.click "link=Contributor Profile Form"
        wait_for_page_load
        
       # logout
       

  end
  
  
  

end

