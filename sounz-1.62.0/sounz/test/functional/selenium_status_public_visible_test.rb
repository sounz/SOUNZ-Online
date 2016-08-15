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
  def test_status_against_anonymous_user
     classes = [Expression, Event, Manifestation, Resource, Superwork, Work]
     statuses = Status.find(:all)
     check_class_list(classes, statuses, "You are not authorised to view the intended page")
  end
  
  def test_status_against_public_member_types
    for username in ["barry_composer", "barry_library_member", "barry_online_member", "barry_guest"]
      check_class_list_against_login(username)
    end
  end
  
  
  private
  
  def check_class_list_against_login(username)
    login_as(username)
    classes = [Expression, Event, Manifestation, Resource, Superwork, Work]
    classes = [Work]
     statuses = Status.find(:all)
     check_class_list(classes, statuses, "Action forbidden")
     open "/finder/show/works"
     wait_for_page_load
    logout
  end
  
  def check_class_list(classes, statuses,text_to_check_for)

    for status in statuses
      for frbr_class in classes
        puts "Checking object of class #{frbr_class} for status #{status.status_desc}"
        frbr_object = frbr_class.find(:first, :conditions => ["status_id = ?", status.status_id])
        if !frbr_object.blank?
          puts frbr_object
          url = "#{frbr_class.to_s.tableize}/show/#{frbr_object.id}"
          open url
          wait_for_page_load
          if status != Status::PUBLISHED
            assert_text_in_html(text_to_check_for)
          else
            assert_text_not_in_html(text_to_check_for)
          end
        else
          puts "\tNo object found with that status type"
        end
        puts
      end
    end
    

  end
  
  
  

end

