class LoginsController < ApplicationController

  include FinderHelper

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @user_logins = Login.paginate(:page => params[:page], :per_page => 50, :order => 'username')
  end
  
  def newest_first
    @user_logins = Login.paginate(:page => params[:page], :per_page => 50, :order => 'created_at desc')
    render :action => :list
  end

  def show
    @user_login = Login.find(params[:id])
    @member_types=@user_login.member_types.uniq
  end
  
  def find
    @search_term = params[:searchTerm]
    fields = [
      {:name => 'username_for_solr_t', :boost => 4},
      {:name => 'name_for_solr_t', :boost => 3}
    ]
    lucene_query = FinderHelper.build_query(Login, @search_term, fields)
    @logins = solr_query(lucene_query)[0][:docs].map{|f|f.objectData}
    logger.debug @logins.to_yaml
    
  end

  def new
    @user_login = Login.new
    
  end

  def create
  	convert_datetime_to_db_format_in_params(params, 'user_login', 'password_valid_until')
    
	@user_login = Login.new(params[:user_login])
    if ! params[:login_extra][:password].blank?
    @user_login.new_password=params[:login_extra][:password]
    end
		
    if @user_login.save
      @user_login.create_moneyworks_file()
      flash[:notice] = 'Login was successfully created.'
      redirect_to :action => 'edit', :id => @user_login.id
    else
      render :action => 'new'
    end
    
    
  end

  def edit
    @user_login = Login.find(params[:id])
    @member_types=@user_login.member_types.uniq
    prepare_edit
  end
  
  def prepare_edit
    @available_member_types = MemberType.find(:all, :order => 'member_type_desc')
    if !@user_login.is_superuser?
      @available_member_types.delete(MemberType::SUPERUSER)
    end
  end

  def update
    @user_login = Login.find(params[:id])
    @member_types = @user_login.member_types
    
	if !params[:user_login][:password_valid_until_date].blank?
	  convert_datetime_to_db_format_in_params(params, 'user_login', 'password_valid_until')
	else
	  params[:user_login][:password_valid_until] = nil
	  params[:user_login].delete(:password_valid_until_time)
	  params[:user_login].delete(:password_valid_until_date) 
	end
	
	if @user_login.update_attributes(params[:user_login])
      if ! params[:login_extra][:password].blank?
      @user_login.new_password=params[:login_extra][:password]
      end
      @user_login.save()
      flash[:notice] = 'Login was successfully updated.'
      redirect_to :action => 'edit', :id => @user_login
    else
      prepare_edit
      render :action => 'edit'
    end
  end

  def destroy
    Login.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

def addMemberType
    @user_login = Login.find(params[:id])
  myMemberTypeId=params[:member_type][:member_type_id]
  if ! myMemberTypeId.blank?
    #check to see we havent already assigned this
    myMemberType=MemberType.find(myMemberTypeId)
    if ! @user_login.member_types.include?(myMemberType)
      @user_login.member_types << myMemberType  
    end
  end
  
  redirect_to :action => 'edit', :id => @user_login
end

def removeMemberType
  @user_login = Login.find(params[:id])
  myMemberTypeId=params[:member_type_id]
  if !myMemberTypeId.blank?  
    @user_login.member_types.delete(MemberType.find(myMemberTypeId))
  end
  redirect_to :action => 'edit', :id => @user_login
end


def membershipPaid
  @user_login = Login.find(params[:id])
  myMembershipId=params[:membership_id]
  if !myMembershipId.blank?  
  myMembership=Membership.find(myMembershipId)
  myMembership.pending_payment=false
  myMembership.save()
  end
  redirect_to :action => 'edit', :id => @user_login
end

def removeMembership
 @user_login = Login.find(params[:id])
  myMembershipId=params[:membership_id]
  if !myMembershipId.blank?  
    @login.memberships.delete(Membership.find(myMembershipId))
  end
  redirect_to :action => 'edit', :id => @user_login 
end

#extend the period of a loan item
def extendLoan
  login = Login.find(params[:id]) unless params[:id].blank?
	
  if !login.blank?
  
	controller = params[:from]
	user = login.person if controller.match('people')
	user = login.organisation if controller.match('organisations')
	
    myItem = BorrowedItem.find(params[:borrowed_item])
    
	if myItem != nil
	  #extend by x number of days
	  days_to_extend=7 #(default)
	  
	  if ! params[:days_to_extend].blank?
	    days_to_extend=params[:days_to_extend].to_i
	  end
	  
	  myReturnTime=Time.parse(myItem.date_due.to_s)+(60*60*24*days_to_extend)
	  myItem.date_due=myReturnTime
	  myItem.date_renewed=Time.now()
      myItem.save()
    end
  
    redirect_to :controller => controller, :action => 'privileges_list', :id => user
  end
end

#manually mark item due
 def markDue
   login = Login.find(params[:id]) unless params[:id].blank?
	 
   if !login.blank?
	 
	 controller = params[:from]
	 user = login.person if controller.match('people')
	 user = login.organisation if controller.match('organisations')
     
	 myItem = BorrowedItem.find(params[:borrowed_item])
  
     if myItem != nil
	   myItem.date_due=Time.now()
	   myItem.date_renewed=nil;
	   myItem.save()
     end
  
	 redirect_to :controller => controller, :action => 'privileges_list', :id => user
  end
  
end

#manually return a loan item
def markReturned
  
  login = Login.find(params[:id]) unless params[:id].blank?
  
  if !login.blank?
		 
	controller = params[:from]
	user = login.person if controller.match('people')
	user = login.organisation if controller.match('organisations')
		 
	myItem = BorrowedItem.find(params[:borrowed_item])
  
    if myItem != nil
	  myItem.active=false
	  myItem.date_returned=Time.now()
	  myItem.item.out_on_loan_or_hire=false
	  myItem.item.save()
	  myItem.save()
    end
  
	redirect_to :controller => controller, :action => 'privileges_list', :id => user
  end
end


#send a reminder notice
def sendReminder
  #look up our users email address
  #assemble the text of the message
  #send it
  login = Login.find(params[:id]) unless params[:id].blank?

  if !login.blank?
			 
  	controller = params[:from]
  	user = login.person if controller.match('people')
  	user = login.organisation if controller.match('organisations')
    
    salutation = params[:salutation]
  	
    note = params[:library_reminder][:note]
        
    # check that at least one item was selected
    email_items = params[:email_items]
    selected = false
    for email_item in email_items
     if email_item[1] == "1"
       selected = true
     end
    end
    
    #now create our item text
    item_text=""
    if selected
      for email_item in email_items
        if email_item[1] == "1"
          logger.debug "ITEMID:" + email_item[0] + email_item[1]
          borrowed_item = BorrowedItem.find(email_item[0])
          if borrowed_item.item.manifestation != nil
            item_text+="#{borrowed_item.item.manifestation.manifestation_title}\n"
          elsif borrowed_item.item.resource != nil
            item_text+="#{borrowed_item.item.resource.resource_title}\n"
          end
          item_text += "(#{borrowed_item.item.physical_description})\n"
          item_text += "Borrowed date: #{borrowed_item.date_borrowed}\n"
          item_text += "Renewed date: #{borrowed_item.date_renewed}\n"
          item_text += "Due date: #{borrowed_item.date_due}\n\n"
          if Time.now() >= Time.parse(borrowed_item.date_due.to_s)
            item_text += "\nITEM IS OVERDUE!\n\n"
          end  
        end
      end
    else
      flash[:error] = "No items selected for Email reminder!"
      redirect_to :controller => controller, :action => 'privileges_list', :id => user
      return
    end
  
    if ! params[:override_email_address].blank?
  	  recipient = params[:override_email_address]
  	else
  	  recipient = params[:email]
  	end
   
  	if ! recipient.blank?
  	  if ReminderNotice.deliver_email_reminder(recipient, salutation, note, item_text) 
  	    flash[:notice] = "Reminder notice is sent"
  		  redirect_to :controller => controller, :action => 'privileges_list', :id => user
        return
  	  end
  	else
  	  flash[:error] = "Reminder notice cannot be sent - there is no recipient"
      redirect_to :controller => controller, :action => 'privileges_list', :id => user
      return
  	end
  else
	    flash[:error] = "An error occured retrieving the appropriate login for this. Please inform the system administrator."
      redirect_to :controller => controller, :action => 'privileges_list', :id => user
      return
  end
  
end

def web_user_address_details
  @from = params[:from]
  @extra_messages=[]
  login_id = @login.id
  
  if login_id != nil
	 @user_login = Login.find(login_id)
	 
	 if @user_login != nil
		#now we need to get the contact associated with that login.
		@person = @user_login.person
		organisation = @user_login.organisation
		
		if ! @person.blank?
		  #now lets find our 'Person' role
		  role = Role.get_role_by_role_type('Person', @person.person_id, organisation_id = nil)
		  
		  # create 'Person' role with 'postal' role contactinfo - needed for ERP processing
		  if role.blank?
			role = Role.new
			
			role.person_id = @person.person_id
			role.updated_by = Login.find(:first, :conditions => ['username =?', 'batch']).login_id # updated by batch
					  
			role.create_self(@user_login)
			
			# zencart logging in as a person user does not exist as zencart customer
			# if there is no 'Person' role assigned to that user    
			username = @user_login.username
			password = @user_login.password  
			logger.debug("ZENCART FETCH:" + external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?main_page=login&action=process'),"encrypted=true&email_address=#{username}&password=#{password}").to_s)
			
			ecj = external_cookie_jar
			cookieString = ecj.cookies_for(URI.parse("http://"+ZENCART_SERVER.to_s+"/zencart")).to_s
			#extract our zencart id and attach to our cookie list
			cookieString =~/zenid=(.*)/
			cookies['zenid'] = $1
										    
		  end          
		  
		  logger.debug("ROLE: "+role.to_yaml)
          
		  #now lets find the postal contactinfo
		  rc = role.get_role_contactinfo_by_contactinfo_type('postal')
		  if !rc.blank?
		    @contactinfo=rc.contactinfo	
		  end
	    
		elsif !organisation.blank?
		  
		  organisation_primary_role = Role.get_organisation_primary_role(organisation.id)
		  
		  rc = organisation_primary_role.get_organisation_primary_role_contactinfo('postal')
		  
		  if !rc.blank?
		    @contactinfo=rc.contactinfo	
		  end		  
		
		end
	  end
	
  end  

#fall through to the show form
end

  def update_web_user_address_details
    success=true
    @extra_messages=[]
    @from = params[:from]
    
    #ensure we have the required details:
    if params[:contactinfo][:street].blank?
      @extra_messages << 'Street cannot be blank'
      success=false
    end
    
    if params[:contactinfo][:suburb].blank?
      @extra_messages << 'Suburb cannot be blank'
      success=false
    end
    
    if params[:contactinfo][:locality].blank?
      @extra_messages << 'Locality cannot be blank'
      success=false
    end
  
    if params[:contactinfo][:postcode].blank?
      @extra_messages << 'Postcode cannot be blank'
      success=false
    end
    
    
    if params[:contactinfo][:country_id].blank?
      @extra_messages << 'Country cannot be blank'
      success=false
    end
    
    if params[:contactinfo][:region_id].blank?
      if !params[:contactinfo][:country_id].blank?
        country = Country.find(params[:contactinfo][:country_id])
        if country.regions.length > 0
          @extra_messages << 'Region cannot be blank'
          success=false  
        end
      end
    end
    
    
    if params[:contactinfo][:email_1].blank?
      @extra_messages << 'Email cannot be blank'
      success=false
    end
    
    
    if params[:contactinfo][:phone].blank?
      @extra_messages << 'Phone number cannot be blank'
      success=false
    end
    
    login_id = @login.id
    
    if !login_id.blank?
  	@user_login = Login.find(login_id)
  		   
  	if @user_login != nil
  	  #now we need to get the contact associated with that login.
  	  @person = @user_login.person
  	  organisation = @user_login.organisation
  			  
  	  if ! @person.blank?
  		#now lets find our 'Person' role
  		for role in @person.roles
  		  logger.debug("ROLE: "+role.to_yaml)
  				
  		  if role.role_type_id == RoleType.roleTypeToId('Person').id
  			#we have our person role.
  			#now lets find the postal contactinfo
  			rc = role.get_role_contactinfo_by_contactinfo_type('postal')
  			if !rc.blank?
  			  @contactinfo=rc.contactinfo	
  			end
  		  end
  				
  		end
  			  
  	  elsif !organisation.blank?
  				
  		organisation_primary_role = Role.get_organisation_primary_role(organisation.id)
  				
  		rc = organisation_primary_role.get_organisation_primary_role_contactinfo('postal')
  				
  		if !rc.blank?
  		  @contactinfo=rc.contactinfo	
  		end		  
  			  
  	  end
  	
  	end
    
    end
    
    if success && !rc.blank?
      @contactinfo.updated_by = @user_login.login_id
      if @contactinfo.update_attributes(params[:contactinfo])
        role = rc.role
  	  
  	  Role.crm_privileges_check(@user_login, role)
  	  
      end
    end 
    
    
    #if we succeed, and from cart is set, send them back to the cart url
    if @from == 'checkout' && success
      redirect_to 'http://'+ZENCART_SERVER+'/zencart/index.php?main_page=shopping_cart'
    else
      @contactinfo.attributes=(params[:contactinfo])
      render :action => 'web_user_address_details'
    end
  
  end

end
