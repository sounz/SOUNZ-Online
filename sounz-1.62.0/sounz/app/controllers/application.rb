# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'net/http'

class ApplicationController < ActionController::Base

  # filter out the password parameter displayed as a clear text
  # from rails logs - for security reasons
  # any other sensitive parameters should be added here
  filter_parameter_logging :password

  # Key for the selected contacts, when creating a mailing list. We use a session to avoid saving in the database until required
  SELECTED_CONTACTS = :selected_contacts

  # Key for selected communications (CRM)
  SELECTED_COMMUNICATIONS = :selected_communications

  require_dependency "work_advanced_search_details"
  require_dependency "contributor_advanced_search_details"
  require_dependency "concept"
  require_dependency "contributor"
  require_dependency "distinction"
  require_dependency "event"
  require_dependency "expression"
  require_dependency "manifestation"
  require_dependency "resource"
  require_dependency "role"
  require_dependency "superwork"
  require_dependency "work"
  require_dependency "frbr_object"
  require_dependency "crm_contacts_advanced_search_details"
  require_dependency "crm_communication_search_details"
  require_dependency "crm_borrowed_items_search_details"
  require_dependency "work_facet_search_details"
  require_dependency "people_facet_search_details"
  require_dependency "event_facet_search_details"
  require_dependency "expression_advanced_search_details"
  require_dependency "work_access_right"
  require_dependency "access_right"
  require_dependency "work_categorization"  
  require_dependency "relationship"    
  require_dependency "mode"  
  require_dependency "status"
  require_dependency "expression_relationship"
  require_dependency "superwork_relationship"
  require_dependency "person"  
  require_dependency "role_relationship"  
  require_dependency "work_relationship"  
  require_dependency "work_attachment"  
  require_dependency "media_item"  
  require_dependency "concept_relationship"    

     #:work_resource_search_details

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_sounz_session_id'

  before_filter :check_authentication, :except => [:login, :logout, :loading, :nagios]

  after_filter :update_history,:except => [:login, :logout, :loading, :nagios]

  #Observe updates to FRBR objects, for reindexing purposes in SOLR
  #observer :frbr_observer moved to config/environment.rb

  helper :date

  def update_history

    @history=session[:history]
    if @page_title != nil
      itemHash={'title' => @page_title.to_s,'uri' => request.request_uri.to_s}
    else
      itemHash={'title' => request.request_uri.to_s,'uri' => request.request_uri.to_s}
    end


      #exclude known ajax calls
      if request.xhr?
      #do nothing
      elsif request.request_uri.to_s =~ /update/
      #do nothing
      else
      @history.push(itemHash)
      end

    if @history.length >3
      @history.delete_at(0)
    end

    session[:history]=@history
  end

  def zencart_login(login_id)
     user = Login.find(login_id)
     unless user.blank?
       username = user.username
       password = user.password
       logger.debug("CREATE USER ZENCART FETCH:" + external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?main_page=login&action=process'),"encrypted=true&email_address=#{username}&password=#{password}").to_s)

       ecj = external_cookie_jar
       cookieString = ecj.cookies_for(URI.parse("http://"+ZENCART_SERVER.to_s+"/zencart")).to_s
       #extract our zencart id and attach to our cookie list
       cookieString =~/zenid=(.*)/
       cookies['zenid'] = $1

       # Create a history in the session
       if session[:history] == nil
         session[:history] = Array.new()
       end

       @history = session[:history]
     end
  end


  #This method is called prior to every request and is a central point for permission checking
  #There are a number of things to do here
  # - Interact with Zencart
  # - Prime the session for searching
  # - Check privleges
  # - Allow access to public pages
  # - Take account of the status of objects
  # - Currently throw a 403 if the action is forbidden
  def check_authentication
    logger.debug "*************************** CHECK AUTH **"

    @controller_name_in_context = controller_name
    @action_in_context = action_name

    #Check if we have an object in context, either by explicitly passing it in or using standard rails conventions
    #e.g. @work for works_controller
    #From this we can check if the object responds to status or not


    #If an object cant be found in context teh status check will have to be delegated to teh controller method
    #in the class extending application controller, e.g. if for some reason the param name was different that id
    #This should cover most cases though
    status_to_check_for = nil

    #Look for an object in context using standard rails naming convention, e.g. Work.find(49) for /works/show/49
    if !params[:id].blank?
      begin
        class_name_to_check = controller_name.gsub("_controller", "").tableize.singularize
        object_in_context = class_name_to_check.camelize.constantize.find(params[:id])
        #logger.debug "OBJ IN CONTEXT:"+object_in_context.to_s

        #Now does it respond to status?
        status_to_check_for = object_in_context.status if object_in_context.respond_to?("status_id")
      rescue Exception => e
        #logger.debug "COULD NOT FIND INSTANCE IN CONTEXT:#{e.message}"
      end

    end


    #logger.debug "RESTRICTION: request is #{request}, method -  #{request.method}"

    if status_to_check_for.blank?
      #logger.debug "COULD NOT FIND A STATUS TO CHECK FOR"
    else
      #logger.debug "CHECK AUTH: STATUS TO CHECK FOR:#{status_to_check_for.status_desc}"
    end


    #Deal with zencart
    #logger.debug("ZENCART READING ZENID FROM LAST BROWSER REQUEST: "+cookies['zenid'].to_s)

    login_id = session[:login]
    if login_id != nil
      user = Login.find(login_id)
      if user != nil
        username=user.username
        password=user.password
        #logger.debug("ZENCART LOGGING INTO #{ZENCART_SERVER} with #{username} and #{password}")
        #logger.debug("ZENCART FETCH:" + external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?main_page=login&action=process'),"encrypted=true&email_address=#{username}&password=#{password}").to_s)
      end
    end


    ecj=external_cookie_jar
    cookieString=ecj.cookies_for(URI.parse("http://"+ZENCART_SERVER.to_s+"/zencart")).to_s
    #extract our zencart id and attach to our cookie list
    cookieString=~/zenid=(.*)/
    cookies['zenid']=$1
    #logger.debug("ZENCART SETTING ZENID FOR CURRENT BROWSER RESPONSE: #{$1}")
    #Create a history in the session
    if session[:history] == nil
      session[:history]= Array.new()
    end
    @history=session[:history]

    if session[:selected] == nil
        session[:selected] = Hash.new()
      end

    #logger.debug "RESTRICTION: CHECKING PERMISSIONS"
    #logger.debug "RESTRICTION CHECKING: #{controller_name} / #{action_name}"



    #If we dont have a login in session then we need to use a privilege of type guest
    unless session[:login]

      session[:intended_action] = action_name
      session[:intended_controller] = controller_name


      idio = params[:id]
      if idio != nil
        session[:intended_id] = params[:id]
      end


      #Public AJAX requests are valid, for example the facet toggling
      if request.xhr?
         if !ControllerRestrictionHelper.has_permission?(request.method, controller_name, action_name, session[:intended_id],
                                                            [Privilege::CAN_VIEW_PUBLIC], status_to_check_for)
                #logger.debug "RESTRICTED AJAX FOR PUBLIC USER URI #{request.request_uri}"
                #session[:intended_uri] = request.request_uri
                render :partial => 'shared/ajax_timeout'
            return false
          end

      else
        session[:intended_uri] = request.request_uri
        #If the page is viewable to the public then continue on and show, otherwise redirect to login
        if !ControllerRestrictionHelper.has_permission?(request.method, controller_name, action_name, session[:intended_id],
           [Privilege::CAN_VIEW_PUBLIC], status_to_check_for)
          #logger.debug "RESTRICTED FOR PUBLIC USER URI #{request.request_uri}, CONTOLLER:#{controller_name}, ACTION:#{action_name}"
          redirect_to :action => "unauthorised", :controller => "authentication"
          return false
        end
      end
    end

    #See pragmatic programmers, volume2 - storing the login user in  session
    #See also http://www.rubyonrailsblog.com/articles/2006/09/29/rails-expiration-of-sessions-due-to-inactivity for session inactivity
    if session[:login] != nil
      #If we have a user, check if they have expired
      #FIXME: testing
      session_length = 60*20 #20 Minutes for logged in users

      expire_time = session[:expire_time] || Time.now + 10
      #logger.debug("Session expirty time is #{expire_time}, now is #{Time.now}")
      session[:expire_time] = Time.now + session_length
      @login = Login.find(session[:login])
      #logger.debug "RESTRICTION: LOGIN is #{@login.username}, is superuser? #{@login.is_superuser?}"
    end


    #FIXME - status needs to be taken account of

    allowed_to_view = ControllerRestrictionHelper.login_has_permission?(request.method, controller_name, action_name,
    session[:intended_id], @login, status_to_check_for)
    #logger.debug "CHECK2:#{allowed_to_view}"

    if !allowed_to_view
      #logger.debug "ACTION FORBIDDEN: #{controller_name} / #{action_name}"
      render :file => "#{RAILS_ROOT}/public/403.html", :status => '403 Forbidden'
      return false #finish rendering here
    end

    # Needed for Event Quicklinks search
    # WR#53728
    @user_time_zone = get_user_time_zone

    #logger.debug "ALLOWED TO VIEW: #{allowed_to_view}"

    true #keep rendering
  end




  #This is called by an after filter
  #Before a view is rendered we need to check for the status of an object, we do this as follows
  # 1.  The normal rails conventions are used and an instance variable of say @work is found if you are using
  #     the works controller
  #
  # 2.  If an explicit override is required by a controller create a variable called @object_in_status_context
  def check_status
    if @object_in_status_context.blank? #Only check if we have to
       instance_var_to_check = controller_name.gsub("_controller", "").tableize.singularize
       instance_var_name = "@#{instance_var_to_check}"
        logger.debug instance_var_name
        if self.instance_variable_defined?(instance_var_name)
          logger.debug "==INSTANCE VAR IS DEFINED"
          @object_in_status_context = self.instance_variable_get(instance_var_name)
          logger.debug "==OBJ IN CONTEXT IS #{@object_in_context}"
        else
          logger.debug "INSTANCE VAR NOT DEFINIED"
        end
    end




    if !ControllerRestrictionHelper.allowed_to_access_for_status(@login, @object_in_context)
      logger.debug "ACTION FORBIDDEN: #{controller_name} / #{action_name}"

      render :file => "#{RAILS_ROOT}/public/403.html", :status => '403 Forbidden'
      @forbidden_by_status = true
          logger.debug "==== /IN CHECK STATUS with false ===="
      return false #finish rendering here
    end

        logger.debug "==== /IN CHECK STATUS with true ===="
    true
  end




  def show_params(params)
    if params == nil
      logger.debug "DEBUG: **PARAMS ARE NIL**"

    else
      logger.debug "DEBUG: **PARAMS ARE NOT NIL**"
    end



    for key in params.keys
      logger.debug "*************************"
      logger.debug "DEBUG: #{key} => #{params[key]}"

      logger.debug "**************"
    end
    logger.debug params.to_yaml
  end




  # takes date and time arguments
  # and combines them together returning
  # postgres timestamp
  def date_time_to_db_format(date, time)
    finish_date_time = date + " " + time
    # format datetime for the database
    postgrestimestamp = DateTime::strptime(finish_date_time, '%d %b %Y %H:%M').to_time
    return postgrestimestamp
  end


  # extracts date and time format from timestamp
  def separate_date_time(entity_date_time_timestamp)
    time = entity_date_time_timestamp.strftime("%H:%M")
    date = entity_date_time_timestamp.strftime("%d %b %Y")
    logger.debug "Returning date stamp separated for #{time}, #{date}"

    datetime = {'time' => time,
      :time => time,
                'date' => date,
      :date => date
    }


    return datetime
  end





  #------------------------------------------------------------------------------
  #Upon form submission for a date_field_with_time helper, the separate date and minute fields need to be merged
  #NB: This will leave the params alone if nothing is touched
  #------------------------------------------------------------------------------
  def convert_datetime_to_db_format_in_params(submitted_params, model, method_name)
    logger.debug "==== CONVERTING DATE TIME ===="
    show_params(submitted_params)
    date_field_name = method_name+'_date'
    time_field_name = method_name+'_time'


    timestamp_field = method_name

    logger.debug "DEBUG: submitted_params[#{model}][#{date_field_name}]"
    submitted_date_field = submitted_params[model][date_field_name]
    submitted_time_field = submitted_params[model][time_field_name]
    logger.debug "DEBUG: Submitted date field: #{submitted_date_field}"
    logger.debug "DEBUG: Submitted time field: #{submitted_time_field}"


    #Avoid nil fields and do nothing
    if !submitted_date_field.blank?# and submitted_time_field != nil
      #Try and parse the values entered
      begin
      	submitted_time_field = Time.now.strftime('%H:%M') if submitted_time_field.blank?
        postgres_timestamp = date_time_to_db_format(submitted_date_field,submitted_time_field)
        logger.debug "DEBUG: Postgres timestamp is #{postgres_timestamp}"

        #And add a happy one for updating the date
        submitted_params[model][timestamp_field] = postgres_timestamp

      rescue
        #Throw a nice exception
        raise TimeParseException.new('The datestring \"'+submitted_date_field+" " +submitted_time_field+'\" was not parseable')
      end

      show_params(submitted_params)


    end
	#Remove the field names that active record wont like
	submitted_params[model].delete(date_field_name)
	submitted_params[model].delete(time_field_name)

	logger.debug "==== /CONVERTING DATE TIME ===="

	return submitted_params
  end


  #------------------
  #- Get the key for a given value in a hash: get_key_for_value
  # FIXME: make this more efficient by caching inverted hashes?
  #------------------

  def get_key_for_value(value, hash)
    result =  hash.invert[value]

    if result == nil
      result = "Value #{value} not found in #{hash}"
    else
      result = result.to_s.capitalize
    end

    result
  end


  # Convert a list of symboled keys to pretty strings
  # FIXME - cache these?
  def hash_with_capitalised_keys(hash_in)
    hash_out = {}
    for key in hash_in.keys
      hash_out[key.to_s.capitalize] = hash_in[key]
    end
    return hash_out
  end

  #------------------
  #- Logs a message and prefixes with stars to make more obvious
  #------------------

  def debug_message(message)
    logger.debug "**** - #{message}"
  end

#------------------------------------------
#- Do pagination for arbitary collections -
#- collection - array of objects e.g. FrbrObj
#- options - will_paginate options
#- default for :page => 1 and :per_page => 10
#------------------------------------------
  def paginate_collection(collection, options = {})
    if options[:page].nil?
      options[:page] = 1
    end
    if options[:per_page].nil?
      options[:per_page] = 10
    end
    
    WillPaginate::Collection.create(options[:page] , options[:per_page], collection.length) do |pager|
      first = pager.offset
      last = [first + pager.per_page, pager.total_entries].min
      slice = collection[first...last]

      # inject the result array into the paginated collection:
      pager.replace(slice)

      pager.total_entries = slice.length unless pager.total_entries
    end   

  end
end

def external_cookie_jar
        session[:cookie_jar] ||= ExternalCookieJar.new
end

  def external_fetch(method,uri,data)

    ecj=external_cookie_jar
    headers =  {'Cookie' => ecj.cookies_for(uri).to_s }
    session[:headers]=headers
    args    = (method == 'POST' || method == 'PUT') ? [ data, headers ] : [ headers ]
    response=""
    begin
    response = Net::HTTP.start(uri.host,uri.port) { |x| x.send(method.downcase,[uri.path,uri.query].join('?'),*args) }
    #external_cookie_jar.parse_cookie_from(uri,response['set-cookie'])
    ecj.parse_cookie_from(uri,response['Set-Cookie'])
    rescue
    logger.debug("response invalid - is Zencart running?")
    end
    #recurse - this may not be desirable
    #response = external_fetch('GET',uri + response['location'],data) if response.is_a? Net::HTTPRedirection

    if response.class.to_s=='String'
    response
    else
    response.body
    end

  end


  #Editors, Superusers etc should not register google hits
  #If the user is a superuser, tap editor, crm editor, content editor dont register hits
  def should_register_google_analytic_hits(the_login)
    result = true
    if !the_login.blank?
      if the_login.is_superuser?
        result = false
      else
        member_type_names = the_login.memberships.map{|m|m.member_type}.map{|t|t.member_type_desc}
        for name in member_type_names
          if name.downcase.include?("administrator")
            result = false
            break
          end
        end
      end
    end
    result
  end

  def get_user_time_zone
    return nil if cookies[:tzoffset].blank?
    min = cookies[:tzoffset].to_i
    time_zone = TimeZone[-min.minutes]

    return time_zone
  end




#- Add generic exceptions here -
class TimeParseException < Exception
end
