#
# Organisations are part of the CRM. People can have roles which are bound to
# specific organisations. Organisations can also have their own communications,
# and can be contributors
#
class OrganisationsController < ApplicationController

  include ApplicationHelper
  include AttachmentHelper
  include StatusesHelper
  
  #def index
  #  list
  #  render :action => 'list'
  #end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @organisations = Organisation.paginate( :page => params[:page], :per_page => 10)
  end

  #
  # Sets up the display of the form for creating a new organisation
  #
  def new
    logger.debug "** ORGANISATION NEW **"
    @organisation = Organisation.new
    setup_organisation
  end

  #
  # Creates a new organisation
  #
  def create
  
    # if an editing user does not have permission to publish CRM
    # set status to 'Pending'
    if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
      params[:organisation][:status_id] = Status::PENDING.status_id
    end
    
    logger.debug "**** ORGANISATION CREATE ****"
    @organisation = Organisation.new(params[:organisation])
    @organisation.updated_by = get_user.login_id
    @role = Role.new(:role_type_id => RoleType::ORGANISATION.role_type_id)
    @contributor_role = (params[:contributor]) ? Role.new(:role_type_id => RoleType::CONTRIBUTOR.role_type_id) : nil
    @role.updated_by = get_user.login_id if !@role.blank?
    @contributor_role.updated_by = get_user.login_id if !@contributor_role.blank?
    
    logger.debug "==TRACE1"
    if @organisation.create_self(@role, @contributor_role, @login)
      # for solr indexing
      @organisation.save
      logger.debug "==TRACE2"
      flash[:notice] = 'Organisation \'' + @organisation.organisation_list_name(true) + '\' created successfully'
      redirect_to :action => 'edit', :id => @organisation.organisation_id
    else
      logger.debug "==TRACE3"
      logger.debug "ORG: #{@organisation.to_yaml}"
      flash[:notice] = 'Organisation \'' + @organisation.organisation_list_name(true) + '\' could not be created'
      setup_organisation
      render :action => 'new'
    end
  end

  #
  # Sets up the display of the form for editing an organisation
  #
  def edit
    @organisation = Organisation.find(params[:id])
    setup_organisation
  end

  #
  # Updates an organisation
  #
  def update
    
    # if an editing user does not have permission to publish CRM
    # set status to 'Pending'
    if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
      params[:organisation][:status_id] = Status::PENDING.status_id
    end
    
    @organisation = Organisation.find(params[:id])
    @organisation.updated_by = get_user.login_id
    if @organisation.update_self(params[:organisation], params[:contributor])
      flash[:notice] = 'Organisation \'' + @organisation.organisation_list_name(true) + '\' was successfully updated'
      
      # update all role role_contactinfos for
      # solr indexing
      @organisation.role_contactinfo_solr_update
      
      redirect_to :action => 'edit', :id => @organisation
    else
      flash[:notice] = 'Organisation \'' + @organisation.organisation_list_name(true) + '\' could not be updated'
      setup_organisation
      render :action => 'edit'
    end
  end

  #
  # Shows all related organisations to this organisation, and allows
  # adding/removing of them
  #
  def related
    @organisation = Organisation.find(params[:id])
  end

  #
  # Called by AJAX to add a relationship
  #
  def add_relationship
    if !params[:related][:org_organisation_id].blank?
      params[:related][:organisation_id] = params[:id]
      related_organisation = RelatedOrganisation.new(params[:related])
      if related_organisation.save
        # if an editing user does not have permission to publish CRM
        # set status of both organisations to 'Pending'
        if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
          organisation_1 = Organisation.find(params[:id])
          organisation_2 = Organisation.find(params[:related][:org_organisation_id])
          
          organisation_1.update_attribute('status_id', Status::PENDING.status_id)
          organisation_2.update_attribute('status_id', Status::PENDING.status_id)
          
          organisation_1.role_contactinfo_solr_update
          organisation_2.role_contactinfo_solr_update
        end
      else
        #FIXME
      end
    end
    @organisation = Organisation.find(params[:id])
  end

  #
  # Called by AJAX to delete a relationship
  #
  def delete_relationship
    related_organisation = RelatedOrganisation.find(params[:id])
    @related_organisation_id = generate_id(related_organisation)
    # For updating the select dropdown
    @organisation = Organisation.find(related_organisation.organisation_id)
    
    # if an editing user does not have permission to publish CRM
    # get organisations involved to set their status to 'Pending'
    if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
      organisation_1 = @organisation
      organisation_2 = Organisation.find(related_organisation.org_organisation_id)
    end
    
    if related_organisation.destroy
      # set status of both organisations to 'Pending' if an editing user does not have permission to publish CRM
      if !organisation_1.blank?
        organisation_1.update_attribute('status_id', Status::PENDING.status_id)
        organisation_1.role_contactinfo_solr_update
      end
      if !organisation_2.blank?
        organisation_2.update_attribute('status_id', Status::PENDING.status_id)
        organisation_2.role_contactinfo_solr_update
      end
    end
  end

  def communications_list
    @organisation = Organisation.find(params[:id])
    
    role_id_list=""
    @organisation.roles.map{|r|role_id_list+=r.role_id.to_s+"," }
    
    @open_communications = Communication.find(
      :all, :include => :role, 
      :conditions => ["roles.role_id IN (?) and communications.status = ?", @organisation.roles, Communication.statuses[:open]], 
      :order => 'communications.created_at desc')
    @page_title = "#{@organisation.organisation_name}'s Open Communications"
  
  end

  #
  # Displays a form for editing the contributor information for an organisation
  # 
  def contributor_details
    @organisation = Organisation.find(params[:id])
    if !@organisation.is_contributor?
      flash[:notice] = 'Please make this organisation a contributor before editing contributor information'
      redirect_to :action => 'edit', :id => @organisation
      return
    end
    setup_contributor
  end

  #
  # Updates contributor information for an organisation
  # NOTE: This is very similar to the person contributor_details_update method.
  # Changes here may also have to be duplicated there
  #
  def contributor_details_update
    @organisation = Organisation.find(params[:id])
    @organisation.contributor = Contributor.new if !@organisation.contributor
    @contributor = @organisation.contributor
    @contributor.updated_by = get_user.login_id

    if @organisation.update_contributor_details(params[:contributor])
      flash[:notice] = 'Contributor record was successfully updated'
      redirect_to :action => 'contributor_details', :id => @organisation
    else
      setup_contributor
      flash[:notice] = 'Contributor record was not able to be updated'
      render :action => 'contributor_details'
    end
  end

 #
  # Shows a list of roles for this organisztion, with links to view/edit the role and
  # its related contact information
  #
  def roles
    @organisation = Organisation.find(params[:id])
  end

  def privileges_list
    @organisation = Organisation.find(params[:id])
    @user_logins = @organisation.logins
    @page_title = "#{@organisation.organisation_name}'s Privileges"
  end



def assignLogin
  @organisation=Organisation.find(params[:id]) 
  myLoginId=params[:assign_login][:login_id]
  if ! myLoginId.blank?
    #check to see we havent already assigned this
    myLogin=Login.find(myLoginId)
    if ! @organisation.logins.include?(myLogin)
      @organisation.logins << myLogin
      # update all role role_contactinfos for
      # solr indexing
      @organisation.role_contactinfo_solr_update
    end
  else
	flash[:notice] = "Please select a login"
	redirect_to :action => 'privileges_list', :id => @organisation
	return
  end  
  
  
  redirect_to :action => 'privileges_list', :id => @organisation
end

def removeLogin
  @organisation=Organisation.find(params[:id]) 
  myLoginId=params[:organisation_login_id]
  if !myLoginId.blank?  
    @organisation.logins.delete(Login.find(myLoginId))
    # update all role role_contactinfos for
    # solr indexing
    @organisation.role_contactinfo_solr_update
  end
  redirect_to :action => 'privileges_list', :id => @organisation
end

def createLogin
   @organisation=Organisation.find(params[:id])
   
   convert_datetime_to_db_format_in_params(params, 'ent_login', 'password_valid_until')
   
   myLogin=Login.new(params[:ent_login])
   myLogin.login_agent_class='O'
   
   
   myLogin.new_password=params[:ent_login][:password] unless params[:ent_login][:password].blank?
   #generate the salt from the password
   #myLogin.salt='Something'
      
   if !myLogin.valid?
		flash[:error] = 'Login details are not valid'
		redirect_to :action => 'privileges_list', :id => @organisation
		return
   else
		@organisation.logins << myLogin
		@organisation.save()
		myMemberTypeId=params[:member_type][:member_type_id]
		myMemberType=MemberType.find(myMemberTypeId)
		myLogin.member_types << myMemberType
		myLogin.save()
	  
        # update all role role_contactinfos for
        # solr indexing
        @organisation.role_contactinfo_solr_update
		flash[:notice] = 'Login was successfully created'
   end
   
   redirect_to :action => 'privileges_list', :id => @organisation
   
   
end  
  
  
  
  
  
  
  
  private


  #
  # Gets information required to display the organisation form
  #
  def setup_organisation
    get_statuses(@organisation)
    set_default_status(@organisation)
    @media_items = attachments(@organisation)
  end

  #
  # Gets information required to display the contributor form
  #
  def setup_contributor
    if @organisation.contributor
      @editing = true
    else
      @organisation.contributor = Contributor.new
    end
    @contributor = @organisation.contributor

    attachments @contributor
  end




end
