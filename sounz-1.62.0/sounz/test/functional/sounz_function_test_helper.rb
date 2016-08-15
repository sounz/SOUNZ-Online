module SounzFunctionTestHelper
  def hello
    puts "hello"
  end
  
  
  def login_as_gordon
    login_as('gordon', 'sounz00')
  end
  
  def login_as_valid_user
    login_as_gordon
  end
  
  def login_as(username, password)
    get "/authentication/login"
    # assert_response :success
    post "/authentication/login", {'username' => username, 'password' => password}
    assert_response :redirect
    follow_redirect!
    assert_template "home/index"
    
    #Check that there is an id logged in
    login = Login.find_by_username(username)
    assert login.id.to_s == session[:login].to_s
  end
  
  
  def logout
    assert session[:login] != nil
    get "/authentication/logout"
     assert session[:login] == nil
  end
end