require File.dirname(__FILE__) + '/../test_helper'
require 'home_controller'
require File.dirname(__FILE__) + '/sounz_function_test_helper'

class HomeStoryTest < ActionController::IntegrationTest


include SounzFunctionTestHelper

#Check the home page after login has some links
def test_links_exist
  login_as_valid_user
  puts "****"+session[:login].to_s
  
    assert_tag :tag => "a",
             :parent => { :tag => "li"},
             :descendant => {
                              :child => /Project Management/ }
  logout
end


end