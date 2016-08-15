module SeleniumHelper
  def wait_for_page_load
    @selenium.wait_for_page_to_load "30000"
  end
  
  
  def assert_location(location)
    puts "CURRENT LOCATION:#{@selenium.get_location}"
    puts "CHECKING FOR:#{TestConstants::SERVER_URL}#{location}"
    assert(@selenium.get_location ==  (TestConstants::SERVER_URL+location))
  end
  
  def assert_title(title)
    puts "CHECKING EXPECTED TITLE '#{title}' AGAINST REAL TITLE #{@selenium.get_title}'"
    assert(@selenium.get_title ==  title)
  end
  
  
  def check_for_lack_of_internal_menu
    puts "CHECKING FOR LACK OF LINK 'CRM Searches'"

  end
  
  
  def go_to_home_page_and_login(username, password)
     @selenium.open "/"
     wait_for_page_load
    # wait_for_page_load
     @selenium.type "username", username
     @selenium.type "password", password
     @selenium.click "link=Login"
     wait_for_page_load
     assert_location("")
     assert_title("SOUNZ :: Home")
     assert_text_in_html("You are logged in as")
     #{}" #{username}")
     #You are logged in as barry_contributor_member
  end
  
  def assert_text_in_html(some_text)
   # puts @selenium.get_html_source
    puts "Checking for text '#{some_text}'"
    assert @selenium.get_html_source.include?(some_text)
  end
  
  def assert_text_not_in_html(some_text)
    puts "Checking for lack of text '#{some_text}'"
    assert !@selenium.get_html_source.include?(some_text)
  end
  
  def login_as(username)
    go_to_home_page_and_login(username, TestConstants::PASSWORD)
  end
  
  def logout
     @selenium.click "link=Log Out"
      wait_for_page_load
  end
end
