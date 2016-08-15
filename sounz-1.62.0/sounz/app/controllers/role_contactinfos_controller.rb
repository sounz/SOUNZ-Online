require 'session_storage_helper'
require 'role_contactinfos_helper'

class RoleContactinfosController < ApplicationController
  include SessionStorageHelper
  include ApplicationHelper
  include RoleContactinfosHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @role_contactinfos = RoleContactinfo.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @role_contactinfo = RoleContactinfo.find(params[:id])
  end

  #---------------
  #- Update role -
  #---------------
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

  #---------------------------------------------
  #- Dynamically delete organisation from role -
  #---------------------------------------------
  def detach_organisation_from_role
    
    if !params[:role_id].blank?
      organisation_id = params[:organisation]
      @role = Role.find(params[:role_id])
      
	  if ! @role.organisation_id.blank? && @role.organisation_id == organisation_id.to_i
        
        if @role.update_attribute('organisation_id', nil)
                       
          # delete default_contactinfo if organisation was previously
          # assigned to a role together with person but has been deleted
          @role.delete_default_contactinfos(organisation_id)
         		  
          # update appropriate person if any
          # for solr idexing
          if ! @role.person.blank?
            @role.person.save
          end
          
          # update all communications for
          # solr indexing
          Communication.index_objects(@role.communications)
          
		  Role.crm_privileges_check(@login, @role)
		  
        end
      
      end
    end
    
    # for role form
    if !@role.person.blank?
      @from = 'person'
    else
      @from = 'organisation'
    end
    
    # get preferred role_contactinfo
    @role_contactinfo = @role.get_preferred_role_contactinfo
    # get default role_contactinfo (currently 'postal')
    # if there is no preferred role_contactinfo
    @role_contactinfo = @role.get_default_role_contactinfo unless !@role_contactinfo.blank?
    
    if !@role_contactinfo.blank?
      get_role_contactinfos(@role, nil, @role_contactinfo)
      @contactinfo_type = @role_contactinfo.contactinfo_type       
    end
    
  end
  

  #---------------------
  #- Edit role details -
  #---------------------
  def edit

    session[:default_contactinfo] = nil
    @role = Role.find(params[:id]) unless params[:id] == nil
    
    if ! @role.blank?
      
      # create role role_contactinfos and contactinfos
      # if any of the three types of role_contactinfos do not exist
      if @role.role_contactinfos.blank? || (!@role.role_contactinfos.blank? && @role.role_contactinfos.length < 3)
        @role.create_set_of_role_contactinfos
      end
     
      
      # for tab functioning
      @person = @role.person
      @organisation = @role.organisation
      
      # for role form
      if !@person.blank?
        @from = 'person'
      else
        @from = 'organisation'
      end
                 
      # when there are role_contactinfo params
      # ex. search screens, saved_contact and mailing lists
      if !params[:role_contactinfo].blank?
        @role_contactinfo = RoleContactinfo.find(params[:role_contactinfo])
      else
        # get preferred role_contactinfo
        @role_contactinfo = @role.get_preferred_role_contactinfo
        # get default role_contactinfo (currently 'postal')
        # if there is no preferred role_contactinfo
        @role_contactinfo = @role.get_default_role_contactinfo unless !@role_contactinfo.blank?
      end
      
      # create/update default_contactinfos if needed
      # (all of the imported roles do not have default_contactinfos
      # for associated person and organisation)
      if ! @role.person.blank? && ! @role.organisation.blank?
        @role.default_contactinfos_update
      end
      
      if ! @role_contactinfo.blank?
        get_role_contactinfos(@role, nil, @role_contactinfo)
        @contactinfo_type = @role_contactinfo.contactinfo_type       
      end
      
      
               
      # if the preferred role_contactinfo of the role exists
      # the flag is set to true and other role_contactinfos of that role
      # are displayed with disabled 'Preferred' checkbox
      @role_contactinfo_exists = role_contactinfo_preferred_check(@role.role_id)
    
    else
      render :action => 'edit'
    end
 
  end


  #------------------------------------------------
  #- Set default_contactinfo field based on param -
  #------------------------------------------------
  def set_default_contactinfo_change
   
    if params[:role_id] != nil && params[:type] != nil
      #logger.debug "DEBUG: ***** set_default_contactinfo_change params #{params} ***"
      @role = Role.find(params[:role_id])
      @contactinfo_type = params[:type]
              
      if ! @role.blank?
      
        @person = @role.person
        @organisation = @role.organisation
        
        get_role_contactinfos(@role, @contactinfo_type) unless @contactinfo_type.blank?
        
        #logger.debug "DEBUG: ****** default_contactinfo: #{@default_contactinfo} ***"
        session[:default_contactinfo] = @default_contactinfo unless !session[:default_contactinfo].blank?
        #logger.debug "DEBUG: =========================="
        #logger.debug "DEBUG: ********* TRACE 1 ********"
        #logger.debug @default_contactinfo.to_yaml
        
        @default_contactinfo = session[:default_contactinfo] unless session[:default_contactinfo].blank?
               
        @default_contactinfo = @default_contactinfo.set_values(params)
        #logger.debug "DEBUG: ****** @default_contactinfo: #{@default_contactinfo} ***"
        #logger.debug "DEBUG: ********* TRACE 2 ********"
        #logger.debug @default_contactinfo.to_yaml
        
        @contactinfo.initialize_contactinfo_associated_with_another_contactinfo( @default_contactinfo ) unless @default_contactinfo.blank?
        
		# if the preferred role_contactinfo of the role exists
        # the flag is set to true and other role_contactinfos of that role
        # are displayed with disabled 'Preferred' checkbox
        @role_contactinfo_exists = role_contactinfo_preferred_check(@role.role_id)
      end
    
    else
      render :action => 'edit'
    end
 
  end
  
  #-----------------------------------------------------------
  #- Display contactinfo based on requested contactinfo_type -
  #-----------------------------------------------------------
  def display_contactinfo
    session[:default_contactinfo] = nil
    session[:contactinfo_type]    = nil
    
    if params[:role_id] != nil && params[:type] != nil
      @role = Role.find(params[:role_id])
      @contactinfo_type = params[:type]
      
      get_role_contactinfos(@role, @contactinfo_type)
      
      @role_contactinfo_exists = role_contactinfo_preferred_check(@role.role_id)
    end
    
  end
  
  #-------------------------------------------
  #- Update role_contactinfo and contactinfo -
  #-------------------------------------------  
  def update_role_contactinfo
    
    @role_contactinfo = RoleContactinfo.find(params[:id])
    
    # role_contactinfo params processing 
    role_contactinfo = Hash.new
    role_contactinfo = params[:role_contactinfo] unless params[:role_contactinfo].blank?
    
    # preferred checkbox
    if params[:role_contactinfo] != nil && params[:role_contactinfo][:preferred] != nil
      role_contactinfo.store("preferred", "t")
    else
      role_contactinfo.store("preferred", "f")
    end
   
    # role
    @role = @role_contactinfo.role
    # contactinfo_type
    @contactinfo_type = @role_contactinfo.contactinfo_type
    # contactinfo
    @contactinfo = @role_contactinfo.contactinfo
    
    # used in tabs
    @person = @role.person
    @organisation = @role.organisation
           
    # updated by
    @contactinfo.updated_by = get_user.login_id
    
    if !params[:default_contactinfo].blank?
      @default_contactinfo = DefaultContactinfo.find(params[:default_contactinfo][:default_contactinfo_id])
      @default_contactinfo.self_update(params[:default_contactinfo])
    end
    
    # for role form
    if !@person.blank?
      @from = 'person'
    else
      @from = 'organisation'
    end
	
	@contactinfo.region_id = nil if !params[:contactinfo].blank? && params[:contactinfo][:country_id] == ''
    
    # UPDATING
    # contactinfo
    if @contactinfo.update_attributes(params[:contactinfo])
     
      #logger.debug "DEBUG: update_role_contactinfo : contactinfo is updated"
      
      # blank fields based on default_contactinfo if the latter exists
      @contactinfo.override_contactinfo_with_null_values(@default_contactinfo) unless @default_contactinfo.blank?
      
      # role_contactinfo
      if @role_contactinfo.update_attributes(role_contactinfo)
      	
      	#logger.debug "DEBUG: update_role_contactinfo : role_contactinfo is updated"
		
      	# if an editing user does not have permission to publish CRM
		# set the role status to 'Pending' and re-index associated role contactinfos
		Role.crm_privileges_check(@login, @role)
		        	
        flash[:notice] = @role_contactinfo.contactinfo_type.capitalize + ' Contact Info was successfully updated.'
        session[:contactinfo_type] = @contactinfo_type
        redirect_to :action => 'edit', :id => @role, :role_contactinfo => @role_contactinfo.role_contactinfo_id
      else
        flash[:notice] = @role_contactinfo.contactinfo_type.capitalize + ' Contact Info could not be saved'
        get_role_contactinfos(@role, @contactinfo_type)
        render :action => 'edit'
      end
    
    else
      #flash[:notice] = @role_contactinfo.contactinfo_type.capitalize + ' Contact Info could not be saved.' +
      #                 ' Please make sure you enter the info in the correct format'
      render :action => 'edit'
    end
    
  end

  #FIXME at the moment neither destroy nor disactivate for 
  # role details is implemented
  #-------------------------------------------------------
  #- Delete role, all role_contactinfos and contactinfos -
  #-------------------------------------------------------
  def destroy
    session[:contactinfo_id] = nil
    role_contactinfo = RoleContactinfo.find(params[:id])
    role = role_contactinfo.role
    contactinfo = role_contactinfo.contactinfo
    
    # FIXME what do we do in case when a user wants to delete
    # the role_contactinfo??? Do we just delete role_contactinfo?
    # or based on some logic we also delete contact info record or role?
    # At the moment just deleting role_contactinfo record
    #if role.destroy
    #if contactinfo.destroy
        if role_contactinfo.destroy
          flash[:notice] = " Role Contact Info has been deleted"
          redirect_to( :controller => 'people', :action => 'edit')
        else
          render :action => 'edit'
        end
      #else
      #  render :action => 'edit'
      #end
    #else
    #  render :action => 'edit'
    #end
      
  end
  
  #---------------------------------------------------------
  #- Get role_contactinfo and contactinfo details based on -
  #- requested contactinfo_type or role_contactinfo        -
  #---------------------------------------------------------
  def get_role_contactinfos(role, contactinfo_type=nil, role_contactinfo=nil)
    # notification message
    @notification = ''
    
    @person = role.person
    @organisation = role.organisation
    
    @role_contactinfo = nil
    
    if role_contactinfo.blank?
      @role_contactinfo = role.get_role_contactinfo_by_contactinfo_type(contactinfo_type) unless contactinfo_type.blank?
    else
      @role_contactinfo = role_contactinfo
    end
    
    if ! @role_contactinfo.blank?
      @contactinfo = @role_contactinfo.contactinfo
         
      # get contactinfo default_contactinfo if any
      @default_contactinfo = @contactinfo.default_contactinfo

      @contactinfo.initialize_contactinfo_associated_with_another_contactinfo( @default_contactinfo ) unless @default_contactinfo.blank?
      
    end
          
     # set the empty country to New Zealand
     @contactinfo.country = Country.get_default_country unless !@contactinfo.country.blank?
    
  end
   
  #---------------------------------------------------
  #- Delete role_contactinfo from saved contact list -
  #---------------------------------------------------
  def delete_from_saved_contact_list
    role_contactinfo = RoleContactinfo.find(params[:role_contactinfo_id])
    saved_contact_list = SavedContactList.find(params[:saved_contact_list_id])
    if !role_contactinfo.blank? && !saved_contact_list.blank?
      saved_contact_list.remove_contact(role_contactinfo)
    end
    render :layout => false
  end  
  
  #-------------------------------------------------------------------
  #- Check if a preferred contactinfo for the particular role exists -
  #-------------------------------------------------------------------
  # check if a person/organisation
  # has already one role_contactinfo as preferred
  # FIXME do we need to use it?
  def role_contactinfo_preferred_check(role_id)
    @role_contactinfo_exists = false
    # find all role's role_contactinfos
    @role_contactinfos = RoleContactinfo.find(:all, :conditions => ['role_id =?', role_id])
    if !@role_contactinfos.empty?
      for contactinfo in @role_contactinfos
        # if any role contactinfo is preferred
        # set the check to true
        if contactinfo.preferred == true
          @role_contactinfo_exists = true
        end
      end
    end
    return @role_contactinfo_exists
  end
  
  ############# CURRENTLY NOT IN USE ##################################
  #-------------------------------------
  #- Copy a contactinfo for a new role -
  #-------------------------------------  
  def copy_contactinfo
    prev_contactinfo_id = session[:contactinfo_id]
    contactinfo_to_clone = Contactinfo.find(prev_contactinfo_id)
    @contactinfo = contactinfo_to_clone.clone
    # if the processing is for person
    @person = get_person_from_session
    if !@person.blank?
      @role = Role.new
      @role_contactinfo = RoleContactinfo.new
    end
    @section_title = "Copy of Contact Details"
    # display phones
    phones_in_display_format
  end
  
end
