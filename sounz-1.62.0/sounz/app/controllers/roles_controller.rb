class RolesController < ApplicationController
  
  
  include ApplicationHelper
  include AttachmentHelper
  include StatusesHelper
  
  #
  # Shows a screen for creating a new role
  #
  def new
    logger.debug("Role new")
    @role=Role.new
    setup_role
    if params[:from] == 'organisation'
    @organisation = Organisation.find(params[:id])
    @from='organisation'
    else
    @person = Person.find(params[:id])
    @from='person'
    end
    # explicitly set role_type_id to nil
    # so that the first role type in the
    # list is not displayed in role type
    # drop-down
    @role.role_type_id = nil
	
	set_default_status(@role)
    
  end

  #
  # Creates a role for a given person
  #
  def create
    logger.debug("Role create")
    if params[:from] == 'organisation'
      @organisation = Organisation.find(params[:id])
      @role = Role.new(params[:role])
      @role.organisation_id = @organisation.organisation_id
      @from='organisation'
    else
      @person = Person.find(params[:id])
      @role = Role.new(params[:role])
      @role.person_id = @person.person_id
      @from='person'
    end
    
    @role.updated_by = get_user.login_id
    
	# if the editing user does have permission to publish CRM, set the role status to 'Pending'
	@role.status_id = Status::PENDING.status_id if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
	    
    if @role.create_self(@login)
      
	  # Role.crm_privileges_check(@login, @role)
	  
	  contact_name = ''
      # name of the contact
      if !@role.person.blank?
        contact_name = ' for ' + @role.person.full_name
      else
        contact_name = ' for ' + @role.organisation.organisation_list_name(true) unless @role.organisation.blank?
      end
                        
      flash[:notice] = 'Role' + contact_name + ' was successfully created.'
      redirect_to :controller => 'role_contactinfos', :action => 'edit', :id => @role
    else
      render :action => 'new', :locals => {@from => params[:from]}
    end
  end

  #
  # Shows a screen for editing the given role, and the contact information for this role
  #
  def edit
  logger.debug("Role edit")
    @role = Role.find(params[:id])
    @person = @role.person
  end

  #
  # Updates the given role
  #
  def update_role
    organisation_change_notice = nil
    @role = Role.find(params[:id])
        
	prev_organisation = @role.organisation
    
	# if the editing user does have permission to publish CRM, set the role status to 'Pending'
	@role.status_id = Status::PENDING.status_id if !PrivilegesHelper.has_permission?(@login, 'CAN_PUBLISH_CRM')
	
	is_contributor = @role.is_contributor
	is_contributor = params[:role][:is_contributor] if (@role.contributor.blank? && !params[:role][:is_contributor].blank?) || (! @role.contributor.blank? && @role.contributor_info_empty?)
	
	@role.send('is_contributor=', is_contributor)
	params[:role][:is_contributor] = is_contributor
	
	if !params[:role][:role_type_id].blank? && @role.is_a_contributor? && !RoleType.contributor_role_types.include?(RoleType.find(params[:role][:role_type_id]))
      
	  flash[:error] = "An error has occured. You cannot change the role type to a non-contributor type if 'Contributor' field is checked."
	  
	  redirect_to :action => 'edit', :id => @role
	
	else
			
	  if @role.update_attributes(params[:role])

	    if ! @role.person_id.blank? && !params[:role][:organisation_id].blank?
		  # create default_contactinfos
		  # for every person's contactinfo and appropriate
		  # organisation contactinfo
		  @role.default_contactinfos_update
	    end      
	  	       
        organisation_change_notice=""
        # role has been assigned an organisation
        if ! @role.person_id.blank? && !params[:role][:organisation_id].blank?
	   
	      # destroy marketing categorisation of the person from the db
	      # as person gets marketing categorisation of the organisation
	      @role.role_categorizations.each do |rc|
	   	    rc.destroy
	      end
	   
          organisation_change_notice = "<br/> The organisation has been changed. Please check and update the contact information and make sure that it is consistent."
        end
      
        # delete default_contactinfo if organisation was previously
        # assigned to a role together with person but has been deleted
        if @role.organisation_id.blank? && !@role.person_id.blank? && !prev_organisation.blank?
          # do we need to default it to 'Person' or 'preferred' contact infos????
      	  # if yes, just call @role.default_contactinfos_update instead of the line below
		  @role.delete_default_contactinfos(prev_organisation.organisation_id)
        end
      
        # update all role role_contactinfos for
        # solr indexing
        RoleContactinfo.index_objects(@role.role_contactinfos)
            
        # update all communications for
        # solr indexing
        Communication.index_objects(@role.communications)
      
        # update appropriate person if any
        # for solr idexing
        if ! @role.person.blank?
          @role.person.save
        end

        # destroy contributor record if 'is_contributor' of the role set to false
        @role.contributor.destroy_self if ! @role.contributor.blank? && ! @role.is_a_contributor?

        flash[:notice] = 'Role was successfully updated.' + organisation_change_notice
        redirect_to :action => 'edit', :id => @role
      else
        @person = @role.person
        @organisation = @role.organisation unless @role.organisation.blank?
        render :action => 'edit', :id => @role
      end
 
	end
   
  end  
  
#  def index
#    list
#    render :action => 'list'
#  end
#  
#  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
#  verify :method => :post, :only => [ :destroy, :create, :update ],
#  :redirect_to => { :action => :list }
  
  def list
    @roles = Role.paginate( :page => params[:page], :per_page => 10, :order => 'role_id')
  end
  
  def show
    logger.debug("Role show")
    #here we can switch on the role type
    @role = Role.find(params[:id])
    roledesc=@role.role_type.role_type_desc
    
    #default to composer view (else clause)
    if roledesc == 'Performer'
      redirect_to :action => 'performer_intro', :controller => :contributors, :id => @role.contributor
    elsif roledesc == 'Composer'
      redirect_to :action => 'composer_intro', :controller => :contributors, :id => @role.contributor
    else
    redirect_to :action => 'composer_intro', :controller => :contributors, :id => @role.contributor
    #render :text => "Unrecognised role type"
    end
    
    
  end
  
  
  #
  # Displays a form for editing the contributor information for a person
  # 
  def contributor_details
    logger.debug("Role contributor_details")
    @role = Role.find(params[:id])
    #@role.updated_by= get_user.login_id
    
    @person = @role.person
    @organisation = @role.organisation
    #if !@person.is_contributor?
    #  flash[:notice] = 'Please make this person a contributor before editing contributor information'
    #  redirect_to :action => 'edit', :id => @person
    #  return
    #end
    setup_contributor
  end

  #
  # Updates contributor information for a person
  # as well as some person's fields like
  # 'year_of_birth', 'year_of_death', 'gender' and 
  # 'deceased' or organisation field 'year_of_establishment'
  #
  def contributor_details_update
    logger.debug("Role contributor_details_update")
    
    show_params(params)
    
    @role = Role.find(params[:id])
    @role.contributor = Contributor.new if !@role.contributor
    @contributor = @role.contributor
    @contributor.updated_by = get_user.login_id

    @person = @role.person
    @organisation = @role.organisation
    
    if @contributor.update_attributes(params[:contributor])
      # updating solr indexes
	  @role.save
      # if person is associated with the contributor role
      if !@person.blank?
        @person.updated_by    = get_user.login_id
        @person.year_of_birth = params[:date][:year_of_birth] unless params[:date].blank?
        @person.year_of_death = params[:date][:year_of_death] unless params[:date].blank?
        if @person.update_attributes(params[:person])
                    
          # update all role role_contactinfos for
          # solr indexing
          RoleContactinfo.index_objects(@role.role_contactinfos)
		  
          flash[:notice] = 'Contributor record was successfully updated'
          redirect_to :action => 'contributor_details', :id => @role.role_id  
        else
          setup_contributor
          flash[:notice] = 'Contributor record was not able to be updated'
          render :action => 'contributor_details'
        end
      
      else
        # if organisation is associated with the contributor role
        # and person is not
        if !@organisation.blank?
          @organisation.updated_by = get_user.login_id
          @organisation.year_of_establishment = params[:date][:year_of_establishment] unless params[:date].blank?
          if @organisation.update_attributes(params[:organisation])
                                  
            # update all role role_contactinfos for
            # solr indexing
            RoleContactinfo.index_objects(@role.role_contactinfos)
			
            flash[:notice] = 'Contributor record was successfully updated'
            redirect_to :action => 'contributor_details', :id => @role.role_id
          else
            setup_contributor
            flash[:notice] = 'Contributor record was not able to be updated'
            render :action => 'contributor_details'
          end
        end
      end
 
    else
      setup_contributor
      flash[:notice] = 'Contributor record was not able to be updated'
      render :action => 'contributor_details'
    end
  end

  #
  # Gets the information required to display the person form
  #
  def setup_role
    #get_statuses(@role)
    #set_default_status(@role)
  end

  #
  # Sets up information required to display the contributor form
  #
  def setup_contributor
    if @role.contributor != nil
      @editing = true
      @contributor=@role.contributor
    else
      @contributor=Contributor.new(:status_id => PENDING)
      @contributor.updated_by = get_user.login_id
      @role.contributor = @contributor
      
    end
    
    set_default_status(@contributor)
    attachments @contributor
  end
  
  def contributor_role_type_check
  	role_type = RoleType.find(params[:role_type]) unless params[:role_type].blank?
	
	if !role_type.blank?
	  @role = Role.new
	  
	  @role.send('role_type=', role_type)
	end
	
	render :partial => 'contributor_checkbox'
  end
  
  #
  #def new
  #  @role = Role.new
  #  populate_role_types
  #  session[:role_id] = @role.role_id
  #  session[:role_action] = 'new'
  #end
  #
  #
  ##------------------
  ##- Populate the role types
  ##------------------
  #
  #def populate_role_types
  #  @role_types = RoleType.find(:all, :order => 'role_type_desc')
  #end
  #
  ##------------------
  ##- Description for method: workout_contactinfo
  ##------------------
  #
  #def workout_contactinfo(role, parameters)
  #  #FIXME: **** This functionality needs fixed, temporary kludge for testing popups
  #  result = 1
  #  
  #  
  #  if result != nil
  #    logger.debug "Parameters are #{parameters}"
  #    logger.debug "Parameters[role] are #{parameters[:role]}"
  #    parameters[:role][:contactinfo_id] = result
  #  end
  #  
  #  parameters
  #end
  #
  #
  ##---------------------------------------------
  ##- Render a new role for a person as a popup -
  ##---------------------------------------------
  #def new_role_for_person_popup
  #  @role = Role.new
  #  populate_role_types
  #  @person = get_person_from_session
  #  render :layout => 'popup'
  #end
  #
  #
  #def show_in_popup
  #  @role = Role.find(params[:id])
  #  render :layout => 'popup'
  #end
  #
  #
  #
  ##------------------
  ##- Description for method: create_role_for_person
  ##------------------
  #
  #def create_role_for_person
  #  
  #  @role = Role.new(params[:role])
  #  
  #  #The other flag is used for rendering the correct dropdown after submission - ie the new role type button if data entered
  #  @other = false
  #  show_params(params)

  #  if params[:role_type] != nil
  #    new_role_type, saved_ok = create_new_role_type(params[:role_type][:role_type_desc])
  #    debug_message "Role type saved ok is "+saved_ok.to_s
  #    debug_message "Role type is "+new_role_type.to_s
  #    @role.role_type_id = new_role_type.role_type_id
  #    
  #    @other = true
  #  end
  #  
  #  @role_type = new_role_type
  #  
  #  @role.contactinfo_id = 1 #FIXME Remove hardwiring of contactinfo id
  #  
  #  get_person_from_session
  #  @role.person_id = @person.id
  #  
  #  
  #  populate_role_types
  #  
  #  if @role.save
  #    flash[:notice] = 'Role was successfully created.'
  #    redirect_to :action => 'show_in_popup', :id => @role
  #  else
  #      render :action => 'new_role_for_person_popup'
  #  end
  #  
  #end
  #
  #
  #
  ##------------------
  ##-Try and create a new role type,returning it if successful
  ##------------------
  #
  #def create_new_role_type(description)
  #  rt = RoleType::create(:role_type_desc => description)
  #  saved_ok = rt.save
  #  return rt, saved_ok
  #end
  #
  ##------------------
  ##- Create a role for a person after the form is submitted, or redirect back to edit
  ##------------------
  #
  #def update_role_for_person
  #  @role = Role.find(params[:id])
  #  get_person_from_session
  #  #The other flag is used for rendering the correct dropdown after submission - ie the new role type button if data entered
  #  @other = false
  #saved_ok = true
  #  if params[:role_type] != nil
  #    new_role_type, saved_ok = create_new_role_type(params[:role_type][:role_type_desc])
  #    debug_message "Role type saved ok is "+saved_ok.to_s
  #    debug_message "Role type is "+new_role_type.to_s
  #    debug_message "errors for save are "+new_role_type.errors.to_s
  #    params[:role][:role_type_id] = new_role_type.role_type_id
  #    @other = true
  #    
  #   # @role.role_type_id = new_role_type.role_type_id
  #  end
  #  @role_type = new_role_type
  #  
  #  @role.update_attributes(params[:role])
  #  @role.person_id = @person.id
  #  #FIXME: work out contact info id instead of ignoring it
  #  show_params(params)
  #  
  #  populate_role_types
  #  
  #  # Now add the person who created it
  #  #  if role_type_id != ""
  #  if @role.save and saved_ok
  #    flash[:notice] = 'Role was successfully updated.'
  #    session[:role_id] = nil
  #    session[:role_action] = nil
  #    
  #    
  #    redirect_to :action => 'show_in_popup', :id => @role
  #    
  #  else
  #    render :action => 'new_role_for_person_popup', :layout => 'popup'
  #  end
  #  
  #  
  #  
  #end
  #
  #
  #
  #
  #def get_params(role_id)
  #  # role type
  #  # if 'other' is selected
  #  # create new role type
  #  if params[:role_type][:id] == 'other'
  #    @role_type = RoleType.new(params[:role_type])
  #    @role_type.save
  #  else
  #    role_type_id = params[:role_type][:id]
  #    @role_type = RoleType.find(role_type_id)
  #  end
  #  @role.role_type_id = @role_type.role_type_id
  #  
  #  # person id if any
  #  person_id  = session[:selected_person_id]
  #  @role.person_id = person_id
  #  
  #  # person's contact info
  #  @role.contactinfo_id = PersonContactinfo.find(:first, :conditions => ["person_id = ? and preferred = true", person_id])
  #  
  #  # organisation associated if any
  #  if session[:organisation_id] != nil
  #    organisation_id = session[:organisation_id]
  #    session[:organisation_id] = nil
  #  else
  #    organisation_id = params[:organisation][:id]
  #  end
  #  # if organisation id is empty string
  #  if organisation_id && organisation_id == ""
  #    @role.organisation_id = nil      
  #  else
  #    @organisation = Organisation.find(organisation_id)
  #    @role.organisation_id = @organisation.organisation_id
  #  end   
  #end
  #
  #
  #
  #
  #def create
  #  @role = Role.new(params[:role])
  #  
  #  role_type_id = params[:role_type][:id]
  #  
  #  #get_params(@role.role_id)
  #  
  #  # Now add the person who created it
  #  if role_type_id != nil
  #    if @role.save
  #      flash[:notice] = 'Role was successfully created.'
  #      session[:role_id] = nil
  #      session[:role_action] = nil
  #      if session[:selected_person_id] != nil
  #        redirect_to( :controller => 'people', :action => 'edit', :id => session[:selected_person_id])
  #      else
  #        redirect_to :action => 'list'
  #      end
  #    else
  #      render :action => 'new'
  #    end
  #    
  #    
  #  else
  #    #Deal with the case of not having a role type
  #    flash[:notice] = 'Please select a role type.' 
  #    render :action => 'new'
  #  end
  #end
  #
  #
  #def edit_in_popup
  #  @role = Role.find(params[:id])
  #  @role_type = RoleType.find( @role.role_type_id)
  #  populate_role_types
  #  @organisation = Organisation.find( @role.organisation_id)
  #  session[:role_id] = @role.role_id
  #  session[:role_action] = 'edit'
  #  
  #  render  :layout => 'popup'
  #end
  #
  #def edit
  #  @role = Role.find(params[:id])
  #  @role_type = RoleType.find( @role.role_type_id)
  #  populate_role_types
  #  @organisation = Organisation.find( @role.organisation_id)
  #  session[:role_id] = @role.role_id
  #  session[:role_action] = 'edit'
  #end
  #
  #def update
  #  @role = Role.find(params[:id])
  #  get_params(@role.role_id)
  #  
  #  if @role.update_attributes(params[:role])
  #    flash[:notice] = 'Role was successfully updated.'
  #    session[:role_id] = nil
  #    session[:role_action] = nil
  #    if session[:selected_person_id] != nil
  #      redirect_to( :controller => 'people', :action => 'edit', :id => session[:selected_person_id])
  #    else
  #      redirect_to :action => 'list'
  #    end
  #  else
  #    render :action => 'edit'
  #  end
  #end
  #
  #
  ##Destroy the role, but use RJS to delete it visually
  #def destroy_role_for_person
  #  role = Role.find(params[:id])
  #  @role_element_id = generate_id(role) 
  #  
  #  role.destroy
  #  session[:role_id] = nil
  #  session[:role_action] = nil
  #  
  #end
  #
  #def destroy
  #  Role.find(params[:id]).destroy
  #  session[:role_id] = nil
  #  session[:role_action] = nil
  #  if session[:selected_person_id] != nil
  #    redirect_to(:controller => 'people', :action => 'edit', :id => session[:selected_person_id])
  #  else
  #    redirect_to :action => 'list'
  #  end
  #end
  #
  #
  #
  #def new_role_type
  #  @other = false
  #  show_params(params)
  # 
  #  if params[:id] == "other"
  #    @other = true
  #     @role_title=''
  #  else
  #    @role_title = RoleType.find(params[:id]).role_type_desc

  #  end
  #end
end
