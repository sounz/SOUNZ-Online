


class AuthenticationController < ApplicationController


  def login
    debug_message "+++++++++ LOGGING IN +++++++"
    if request.post?
      begin
      debug_message "Attempting to login as #{params[:username]} "
      myLogin=Login.authenticate(params[:username], params[:password])
      if myLogin != nil
        #get our zencart id
        
        username=myLogin.username
        password=myLogin.password
        logger.debug("ZENCART FETCH:" + external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?main_page=login&action=process'),"encrypted=true&email_address=#{username}&password=#{password}").to_s)
        
        session[:login] = myLogin.id
        zencart_login(myLogin.id)
        debug_message "Session login id is now #{session[:login]}"
        #
        intended_uri = session[:intended_uri]
		
		# check if the login has any memberships due to expire 
		expired_memberships = false
		member_types = Array.new
		myLogin.memberships.each do |m|
		  			  
		  if m.is_expired?
		  	member_type = m.member_type.member_type_desc
		    member_types.push(member_type + 'ship')
		    logins = [m.login]
				 
		    if m.destroy
			  MembershipHelper.expired_membership_notification_email_to_administrators(logins, member_type)
		      expired_memberships = true  			  
		    end
		
		  end
	    end
	    
		# if the login has expired membership, advise and redirect to
		# 'cart/memberships_page 
		if expired_memberships
		  flash[:error] = "According to our records your " + member_types.join(', ') + " expired. You can renew your membership now on this page."
		  intended_uri = "/cart/memberships_page"
		end		
				
        if intended_uri.blank?
          redirect_to(:controller => "home")
        else
          redirect_to(intended_uri)
        end
      end
      rescue LoginException
        debug_message "Failed login for user #{params[:username]}"
        #flash[:notice]="Either your username or password was incorrect"
        redirect_to(:action => "login")
        session[:login] = nil
      end
    end
  end
  
  #----------------------
  #- Log out of a session
  #----------------------
  def logout
    #logger.debug("Logged out:" + session[:login])
    session[:login] = nil
    session[:cookie_jar]=nil
    reset_session
    redirect_to(:action => "index", :controller => "home")
  end
  
  
  
end
