#
# Interface for editing people. People are part of the CRM. People can have
# many roles, through which they can belong to organisations and have
# communications
#
class PeopleController < ApplicationController

  include ApplicationHelper
  include AttachmentHelper
  include StatusesHelper
  include SessionStorageHelper

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ],
    :redirect_to => { :action => :new }

  #
  # Set up the 'new person' form
  #
  def new
    @person = Person.new
    # for role form
    @from = 'person'
    set_default_status(@person)

	@role = Role.new
	set_default_status(@role)

    setup_person
  end

  #
  # Processes a request to create a new person
  #
  def create

    # if an editing user does not have permission to publish CRM
    # set status to 'Pending'
    if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
      params[:person][:status_id] = Status::PENDING.status_id
    end

    @person = Person.new(params[:person])
    @person.updated_by = get_user.login_id
    @role   = Role.new(params[:role])
    # for role form
    @from = 'person'

    if @person.create_self(@role, @login)
      # save person again after the role is create
      # for solr indexing
      @person.save

      flash[:notice] = 'Person \'' + @person.full_name + '\' is created successfully'
      redirect_to :action => 'edit', :id => @person
    else
      flash[:notice] = 'Person \'' + @person.full_name + '\' could not be created'
      setup_person
      render :action => 'new'
    end
  end

  #
  # Sets up the 'edit' form
  #
  def edit
    #@media_items = attachments(@person)
    @person = Person.find(params[:id])
    setup_person
  end

  #
  # Updates a person record, including their categorization
  #
  def update

    # if an editing user does not have permission to publish CRM
    # set status to 'Pending'
    if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
      params[:person][:status_id] = Status::PENDING.status_id
    end

    @person = Person.find(params[:id])
    @person.updated_by = get_user.login_id

    if @person.update_attributes(params[:person])

        # update all role role_contactinfos for
        # solr indexing
        @person.role_contactinfo_solr_update

        flash[:notice] = 'Person \'' + @person.full_name + '\' was successfully updated.'
        redirect_to :action => 'edit', :id => @person


    #if person update fails from form submission
    else

      get_statuses(@person)
      render :action => 'edit'
    end
  end

  #
  # If "deceased" checkbox is changed when editing person details, this returns
  # the dropdown for choosing the date the person became deceased
  #
  def deceased_date_boxes
    @deceased = (params[:deceased] == '1') ? true : false
    @person = Person.find(params[:id]) if params[:id]
  end

  #
  # Displays a form for editing the contributor information for a person
  #
 # def contributor_details
 #   @role = Role.find(params[:id])
 #   #if !@person.is_contributor?
 #   #  flash[:notice] = 'Please make this person a contributor before editing contributor information'
 #   #  redirect_to :action => 'edit', :id => @person
    #  return
    #end

 #   setup_contributor
 # end

  #
  # Updates contributor information for a person
  #
  #def contributor_details_update
  #  @person = Person.find(params[:id])
  #  @person.contributor = Contributor.new if !@person.contributor
  #  @contributor = @person.contributor
  #  @contributor.updated_by = get_user.login_id

#    if @person.update_contributor_details(params[:contributor])
#      flash[:notice] = 'Contributor record was successfully updated'
#      redirect_to :action => 'contributor_details', :id => @person
#    else
#      setup_contributor
#      flash[:notice] = 'Contributor record was not able to be updated'
#      render :action => 'contributor_details'
#    end
#  end

  #
  # Shows a list of roles for this person, with links to view/edit the role and
  # its related contact information
  #
  def roles
    @person = Person.find(params[:id])
  end



  #
  # Sets up information required to display the contributor form
  #
 # def setup_contributor
 #   if @role.contributor
 #     @editing = true
 #   else
 #     @role.contributor = Contributor.new
 #   end
 #   @contributor = @role.contributor
#
#    attachments @contributor
#  end

  #
  #def destroy
  #  @person = Person.find(params[:id])
  #  # destroy associations
  #  for person_contactinfo in @person.person_contactinfos
  #    person_contactinfo.destroy
  #  end
  #  for contactinfo in @person.contactinfos
  #    contactinfo.destroy
  #  end
  #  for contributor_person in @person.contributor_people
  #    contributor_person.destroy
  #  end
  #  for contributor in @person.contributors
  #    contributor.destroy
  #  end
  #  for role in @person.roles
  #    role.destroy
  #  end
  #  for communication in @person.communication_people
  #    communication.destroy
  #  end
  #  for communication in @person.communications
  #    communication.destroy
  #  end
  #  for project in @person.projects
  #    project.destroy
  #  end
  #  for person_categorization in @person.people_categorizations
  #    person_categorization.destroy
  #  end
  #  for person_marketing_campaign in @person.marketing_campaigns
  #    person_marketing_campaign.destroy
  #  end
  #  for person_saved_lists in @person.saved_contact_lists
  #    person_saved_lists.destroy
  #  end
  #
  #  if @person.login != nil
  #    @person.login.destroy
  #  end
  #
  #  @person.destroy
  #  session[:selected_person_id] = nil
  #  redirect_to :action => 'list'
  #end
  #
  #
  #
  ## ---------------------------------------------------
  ## - Add a new communication - show the initial form -
  ## ---------------------------------------------------
  def add_communication
  #
    @person = Person.find(params[:id])
    @page_title = "New communication for #{@person.full_name}"
    @role_id = nil
    @status_text = Communication.statuses[:open]
    @communication = Communication.new
    @communication.created_at = Time.now # default value required for interface
  end
  #
  #
  #
  ##-------------------------------
  ## - Process creation of a new communication  -
  ## ------------------------------
  def add_communication_create
    @page_title = 'Add Communication'
    @person = Person.find(params[:person][:person_id])


    # If the form was submitted properly, deal with it
    if params[:communication]
      start_date_ok = false
      begin
        convert_datetime_to_db_format_in_params(params, 'communication','created_at')
        start_date_ok = true
      rescue TimeParseException
        @communication.errors.add("Start time")
      end

      closed_date_ok = false
      begin
        convert_datetime_to_db_format_in_params(params, 'communication','closed_at')
        closed_date_ok = true
      rescue TimeParseException
        @communication.errors.add("Closing time")
      end


      @communication = Communication.create(params[:communication])
      @status_text = get_key_for_value(@communication.status, Communication.statuses)

      #check for nil role here
      role_id = params[:communication][:role_id]
      if !role_id.blank?
        @role = Role.find(role_id)
      else
        @role = nil
      end

      if @person.add_communication(@communication, @role)
        flash[:notice] = 'Communication was successfully created.'
        redirect_to :action => 'communications_list', :id => @person.person_id
      else
        render :action => 'add_communication'
      end
    end
  end



  ##------------------
  ##- Edit a communication - this merely shows the form and follows the normal rails methodoloy of
  ## edit submitting to update
  ##------------------
  #
  #def edit_communication
  #
  #  @communication = Communication.find(params[:id])
  #  if @communication.created_at == nil
  #    @communication.created_at = Time.now
  #  end
  #
  #  # FIXME: there is an application helper for this - get_user
  #  last_person_to_update = @communication.updated_by
  #  if !last_person_to_update.blank?
  #    @last_login_to_update = Login.find(last_person_to_update)
  #  end
  #
  #  @role_info = @communication.person.role_information
  #  debug_message "#### EDIT COMM: role info from comm is #{@role_info}"
  #  if @role_info == nil
  #    @role_info= "None"
  #    debug_message "#### NIL ROLE SO SET IN CONTROLLER: role info from comm is #{@role_info}"
  #  end
  #
  #end
  #
  #
  ##--------------------------
  ## Updating a communication
  ##--------------------------
  #def update_communication
  #
  #  debug_message("In update communication")
  #
  #  @communication = Communication.find(params[:id])
  #  debug_message("Comm found from params is <%@communcation.to_yaml%>")
  #  if @communication.created_at == nil
  #    @communication.created_at = Time.now
  #  end
  #
  #
  #
  #  #FIXME: is this line needed?
  #  @start_time_separated = separate_date_time(@communication.created_at)
  #
  #
  #  #check for nil role here
  #  role_id = params[:role][:role_id]
  #  if role_id != "0"
  #    @role = Role.find(role_id.to_s)
  #  else
  #    @role = nil
  #  end
  #
  #  debug_message "Role found is #{@role}"
  #
  #
  #  #   @person = Person.find(@communication.person.person_id)
  #  @page_title = 'Update Communication for #{person.full_name}'
  #  @status_text = get_key_for_value(@communication.status, Communication.statuses)
  #  # If the form is submitted, deal with it
  #
  #  if params[:communication]
  #    debug_message "Found params for communication"
  #    start_date_ok = false
  #    close_date_ok = false
  #    #Fix the time and calendar stuff
  #    begin
  #      convert_datetime_to_db_format_in_params(params, 'communication','created_at')
  #      start_date_ok = true
  #    rescue TimeParseException
  #      @communication.errors.add("Start time")
  #    end
  #
  #    #Only convert closed if it exists
  #
  #    begin
  #      convert_datetime_to_db_format_in_params(params, 'communication','closed_at')
  #    rescue TimeParseException
  #      @communication.errors.add("End time")
  #    end
  #
  #
  #    was_date_errors = @communication.errors.length > 0
  #
  #    #Update the attributes but do not save communication
  #    if !@communication.update_attributes(params[:communication])
  #      flash[:notice] = 'The communication could not be saved due to errors'
  #      render :action => :edit_communication
  #
  #
  #    elsif
  #
  #      @person.update_communication(@communication, params[:role][:role_id])
  #
  #
  #      debug_message "updated person communication succesfully"
  #      #Check for date errors
  #      if was_date_errors
  #        debug_message "Was date errors"
  #        flash[:notice] = 'The communication could not be saved due to errors'
  #        render :action => :edit_communication
  #      else
  #        debug_message "No errors so succesful update"
  #        flash[:notice] = 'The communication was succesfully updated'
  #        redirect_to :action => :communications_list
  #      end
  #    else
  #      debug_message "Updating communication failed"
  #      flash[:notice] = 'The communication could not be saved due to errors'
  #      render :action => :edit_communication
  #    end
  #
  #    debug_message "Completed processing internally of form"
  #
  #  end
  #
  #  debug_message "/Update communication"
  #end
  #
  ##------------------
  ## When a role is selected for a communication, the following happen in the interface
  ## <ul>
  ## <li>The organisation name is changed to reflect the chosen role</li>
  ## </ul>
  ##------------------
  #
  def communication_role_selected
  #  show_params(params)
    role_id = params[:role_id]
    if !role_id.blank?
      @new_role = Role.find(role_id)
      #check if organisation exists
      if !@new_role.organisation.blank?
        render :text => @new_role.organisation.organisation_name
      else
        render :text => "No organisation associated with this role"
      end
    else
      render :text => "No role chosen"
    end
  end
  #
  #
  #
  ##------------------
  ## When a status is selected for a communication, the following happen in the interface
  ## <ul>
  ## <li>The closing date is shown if the status is set to closed</li>
  ## </ul>
  ##------------------
  #
  #def communication_status_selected
  #  show_params(params)
  #  @new_status_text = get_key_for_value(params[:status_code], Communication.statuses)
  #  comm_id = params[:comm_id]
  #
  #  #If this is a new communication being added,
  #  if comm_id == nil
  #    render(:partial => "communication_closed_date_field",
  #    :locals => { :status => @new_status_text, :closed_at => Time.now}, :layout => false)
  #  else
  #    @communication = Communication.find(comm_id)
  #    logger.debug("Communication id is #{comm_id}")
  #    render(:partial => "communication_closed_date_field",
  #    :locals => { :status => @new_status_text, :closed_at => @communication.closed_at}, :layout => false)
  #  end
  #end
  #
  #def test_text
  #  render_text Time.now.to_s
  #end
  #
  ##----------------------------------------------------------------------------------------
  ##- This is used from the popout - we create a new role there and re render the dropdown -
  ## <ul><li>Pass in the role id as a parameter for the selected item</li></ul>
  ##----------------------------------------------------------------------------------------
  #def roles_select_box
  #  debug_message "Calling roles select box"
  #  get_person_from_session
  #  @role_id = params[:id].to_i
  #  render :layout => false
  #end
  #
  #
  #
  #
  ##This is used from the communications form
  #def add_role
  #  set_popup_callback(:people, :roles_select_box, :role_role_id)
  #
  #  #<a href="#" onclick="update_from_popup('role_role_id','people', 'roles_select_box', <%=@role.role_id%>)">Close</a>
  #  redirect_to :controller => :roles, :action => :new_role_for_person_popup
  #end
  #
  ##This is the same popup but provides for a different callback
  #def add_role_from_person_edit_tab
  #  set_popup_callback(:people, :callback_roles_edit_person, :personRolesList)
  #  redirect_to :controller => :roles, :action => :new_role_for_person_popup
  #
  #end
  #
  #
  ## Note: teh person is obtained from the session using the before filter
  #def callback_roles_edit_person
  #  @person_roles = @person.roles
  # # person_roles_list(@person_roles)
  #  render :partial => 'person_roles_form'
  #  clear_popup_callback
  #end

  ##------------------
  ##- Get a list of all the open communications
  ## FIXME: How are we going to provide for access to closed communications
  ##------------------
  #
  def communications_list
    @person = Person.find(params[:id])

    role_id_list=""
    @person.roles.map{|r|role_id_list+=r.role_id.to_s+"," }
    logger.info("ROLE ID LIST: "+role_id_list)
    @open_communications = Communication.find(:all, :include => :role,
                                              :conditions => ["roles.role_id IN (?) and communications.status = ?", @person.roles, Communication.statuses[:open]],
   :order => 'communications.created_at desc')
    @page_title = "#{@person.full_name}'s Open Communications"
  end



  def privileges_list
    if params[:id].blank?
    @person = get_person_from_session
    else
    @person = Person.find(params[:id])
    end
    @user_logins = @person.logins
    @page_title = "#{@person.full_name}'s Privileges"
  end

  def assignLogin
    @person = Person.find(params[:id])
    logger.debug "PERSON:#{@person.full_name}"
    show_params(params)
    myLoginId = params[:assign_login][:login_id]
    logger.debug "My login id:#{myLoginId}, is null? <%=myLoginId.to_yaml%>"
    if ! myLoginId.blank?
      #check to see we havent already assigned this
      myLogin = Login.find(myLoginId)
      if ! @person.logins.include?(myLogin)
        @person.logins << myLogin
        # update all role role_contactinfos for
        # solr indexing
        @person.role_contactinfo_solr_update
      end

    else
      flash[:notice] = "Please select a login"
      redirect_to :action => 'privileges_list', :id => @person
      return
    end

    redirect_to :action => 'privileges_list', :id => @person
  end




def removeLogin
  @person=Person.find(params[:id])
  myLoginId=params[:person_login_id]
  if !myLoginId.blank?
    @person.logins.delete(Login.find(myLoginId))
    # update all role role_contactinfos for
    # solr indexing
    @person.role_contactinfo_solr_update
  end
  redirect_to :action => 'privileges_list', :id => @person
end

def createLogin
   @person=Person.find(params[:id])

   convert_datetime_to_db_format_in_params(params, 'ent_login', 'password_valid_until')

   #create a new login, with the parameters supplied, and attach it to this organisation.
   myLogin=Login.new(params[:ent_login])
   myLogin.login_agent_class='P'
   myLogin.new_password=params[:ent_login][:password]
   #generate the salt from the password
   #myLogin.salt='Something'

   if !myLogin.valid?
     flash[:notice] = 'Login details are not valid'
     redirect_to :action => 'privileges_list', :id => @person
     return
   else
     @person.logins << myLogin
     @person.save()
     myMemberTypeId=params[:member_type][:member_type_id]
     myMemberType=MemberType.find(myMemberTypeId)
     myLogin.member_types << myMemberType
     myLogin.save()

     # update all role role_contactinfos for
     # solr indexing
     @person.role_contactinfo_solr_update

   end

   redirect_to :action => 'privileges_list', :id => @person


end






def new_web_user
  @person=Person.new()
  @user_login=Login.new()
  @contactinfo=Contactinfo.new()
  @extra_messages=[]
  @from = params[:from]
end

def create_web_user
  logger.debug("DEBUG: in Create Web User")
  success=true
  @extra_messages=[]

  captcha_was_valid = simple_captcha_valid?

  if !captcha_was_valid
    success=false
    @extra_messages << "The Captcha was not valid"
  end

  #check our terms and conditions are checked
  if params[:user_login_extra][:agree] != 'true'
    success=false
    @extra_messages << "You must agree to the terms and conditions when creating an account!"
  end

  #check our two supplied passwords match
  if params[:user_login][:password].to_s != params[:user_login_extra][:password]
    success=false
    @extra_messages << "Your supplied passwords do not match!"
  end

  # first/last name validation
  if params[:person].blank? || params[:person][:first_names].blank? || params[:person][:first_names].length < 2
    success = false
    @extra_messages << "Your first name should be more than 1 letter long"
  end

  if params[:person].blank? || params[:person][:last_name].blank? || params[:person][:last_name].length < 2
    success = false
    @extra_messages << "Your last name should be more than 1 letter long"
  end

  if !params[:person].blank? && !params[:person][:first_names].blank? && params[:person][:first_names].match(/[^a-zA-z -.]/)
    success = false
    @extra_messages << "Your first name can contain only letters"
  end

  if !params[:person].blank? && !params[:person][:last_name].blank? && params[:person][:last_name].match(/[^a-zA-z -.]/)
    success = false
    @extra_messages << "Your last name can contain only letters"
  end

  #country validation
  if params[:contactinfo][:country_id].blank?
    success = false
    @extra_messages << "You must select a country"
  end

  if !params[:contactinfo][:country_id].blank? && params[:contactinfo][:region_id].blank?
    country = Country.find(:first, :conditions => {:country_id => params[:contactinfo][:country_id]})
    if country.regions.size != 0
      success = false
      @extra_messages << "You must select a region"
    end
  end

  # email validation
  if params[:contactinfo][:email_1].blank?
	success = false
	@extra_messages << "Your email cannot be empty"
  end

  if !params[:contactinfo][:email_1].blank? && !params[:contactinfo][:email_1].match(Contactinfo::EMAIL_REGEX)
	success = false
	@extra_messages << "Your email has an invalid format"

  # username validation
  else
	username = params[:contactinfo][:email_1]
	user = Login.find(:first, :select => 'login_id', :conditions => ['username ILIKE ?', "#{username}"])

	if !user.blank?
	  success = false
	  @extra_messages << "Your username is already taken. Please choose another."
	end

  end

  # password validation
  if params[:user_login][:password].blank?
	success = false
	@extra_messages << "Your password cannot be empty"
  end

  @person = Person.new(params[:person])
  # temporary set to 'batch' otherwise person record won't pass validation
  @person.updated_by = Login.find(:first, :conditions => ['username=?', 'batch'])
  @person.status = Status::PENDING

  @user_login = Login.new(params[:user_login])
  @user_login.username = params[:contactinfo][:email_1]
  # do not set password and salt in case of any failures of creating new web user
  @user_login.salt='NOT_SET_YET'
  @user_login.login_agent_class='P'

  @contactinfo = Contactinfo.new(params[:contactinfo])

  role = Role.new()

  success=false if success && ! @person.create_web_user(role, @user_login)

if ! success
    @from = params[:from]
    render :action => 'new_web_user', :from => @from
    return
else
	@user_login.new_password = params[:user_login][:password]

	#now lets update the postal contactinfo
	rc = role.get_role_contactinfo_by_contactinfo_type('postal')
	if !rc.blank?
	  contactinfo = rc.contactinfo
	  contactinfo.update_attributes(params[:contactinfo])
	end

	#lets check if the user wants to sign up for the newsletter
	newsletter_status=params[:user_login_extra][:newsletter]
	if ! newsletter_status.blank?
	  #add the contactinfo to our saved list.
	  myList=SavedContactList.find(:all,:conditions => ['list_name=?','Requested Email Updates']).first
	  if myList != nil
		#add our contactinfo to the list
		myList.add_contact(rc)
	  else
		#create the list and add our contactinfo to it.
		myList=SavedContactList.new()
		myList.list_name='Requested Email Updates'
		myList.updated_by=1000
		myList.add_contact(rc)
	  end
	  myList.save()
	end

   #populate the membership items we wish to show new users
   serviceList=SounzService.find(:all)
   @services=[]
   for service in serviceList
     @services << service
   end


   onlineList=SounzService.find(:all,:order => 'sounz_service_price', :conditions => ['zencart_tag=?','ONLINE_MEMBERSHIP'])
   @online_services=[]
   for service in onlineList
     @online_services << service
   end


   libraryList=SounzService.find(:all, :order => 'sounz_service_price',:conditions => ['zencart_tag=?','LIBRARY_MEMBERSHIP'])
   @library_services=[]
   for service in libraryList
     @library_services << service
   end

   donationList=SounzDonation.find(:all)
   @donations=Hash.new()
   for donation in donationList
     @donations["#{donation.sounz_donation_price.to_i}"]=donation.sounz_donation_id
   end

   @user_login.create_moneyworks_file()

   # clear our cookies, and
   # log our newly created user in
   #session[:cookie_jar] = nil
   session[:login] = @user_login.id
   @login = @user_login

   # zencart logging in
   username = @login.username
   password = @login.password
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

   if !params[:from].blank? && params[:from] == 'login_from_checkout'
     redirect_to :controller => 'logins', :action => 'web_user_address_details', :from => 'checkout'
     return
   end
   return
end


  #get our services and donations for rendering in the resulting page
  serviceList=SounzService.find(:all)
  @services=[]
  for service in serviceList
    @services << service
  end
  #find our ids and put them in our id array
  donationList=SounzDonation.find(:all)
  @donations=Hash.new()
  for donation in donationList
    @donations["#{donation.sounz_donation_price.to_i}"]=donation.sounz_donation_id
  end

  # redirect to the new email signup page at /content/emailupdates (WR212272)
  redirect_to :controller => 'content', :action => 'emailupdates'
  return
end

  def login_from_checkout
    @person = Person.new()
    @user_login = Login.new()
    @contactinfo = Contactinfo.new()
    @extra_messages = []
    session[:intended_uri] = '/logins/web_user_address_details?from=checkout'
  end


   private

  #
  # Gets the information required to display the person form
  #
  def setup_person
    get_statuses(@person)

  end

end
