class PasswordController < ApplicationController
  
  #Process a request to change a password
  # If the username does not exist or is blank, redirect back to the password form
  # If it does exist, display a message saying an email has been sent
  def request_change
    show_params(params)
    flash[:notice] = ''
    captcha_was_valid = simple_captcha_valid?
    logger.debug "CAPTCHA VALID? #{captcha_was_valid}"
    username = params[:forgotten][:username]
    logger.debug "FORGOTTEN_PARAM:"+@forgotten.to_s
    
    logger.debug "T1"
    
    #Is this an email address
    if !username.include?('@')
      flash[:notice] = "Please provide a valid email address"
      render_action "forgotten"
      return
    end
    
    if captcha_was_valid==false
       
        render_action "forgotten"
      return
    elsif !username.blank?
      logger.debug "T2"
      @login = Login.find_by_username(username)
      logger.debug @login.to_yaml
      if @login.blank?
        logger.debug "T3"
        flash[:notice] = "Username '#{username}' not found"
        render_action "forgotten"
        return
      end
    else
        logger.debug "T4"
        flash[:notice] = "Please enter a username"
        render_action "forgotten"
        return
    end
    
    
    # If we have got his far, then we need to send the email and add information regarding the password request.
    PasswordHelper.request_change_for_login(@login)

  end
  
  
  
  #After an email is sent, a link is provided - it comes here
  # * Check that the activation key exists
  # * Check it has not expired
  # If all ok render the form, otherwise render error message
  def change
    @activation_key = params[:id]
    @pcr = PasswordChangeRequest.find_by_activation_key(@activation_key)
    @valid = false
    logger.debug "T1"
    
    if @pcr.blank?
      logger.debug "T2"
      flash[:notice] = "The activation key, #{@activation_key}, is invalid"
    elsif @pcr.processed == true
      logger.debug "T2A"
      flash[:notice] = "The activation key, #{@activation_key}, has already been used"
    elsif @pcr.expired?
      logger.debug "T3"
        flash[:notice] = "The activation key, #{@activation_key} has expired."
    else
      logger.debug "T4"
      @valid = true
    end
  end
  
  
  #Update a password
  def update
    show_params(params)
    password1 = params[:password1]
    password2 = params[:password2]
    @activation_key = params[:id]
    
    
    captcha_was_valid = simple_captcha_valid?
    
    
    if captcha_was_valid==false
       flash[:notice] = "The value for the security check was invalid"
       redirect_to :action => :change, :id => @activation_key.to_s
      return
    elsif password1 == password2
      if password1.length >= 6
        logger.debug "T7"
        @pcr = PasswordChangeRequest.find_by_activation_key(@activation_key)
        @pcr.processed = true
    
      
        @login = @pcr.login_requested_by
        @login.new_password = password1
        @login.save!
      
          @pcr.save!
        #flash[:notice] = "Password successfully updated"
      else
        logger.debug "T8"
        flash[:notice] = "Please provide a password of at least 6 characters"
        redirect_to :action => :change, :id => @activation_key.to_s
      end
    else
       logger.debug "T9"
      flash[:notice] = "Password confirmation failed"
      redirect_to :action => :change, :id => @activation_key.to_s
      return
    end
    
  end
  
end
