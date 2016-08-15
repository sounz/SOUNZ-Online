require 'session_storage_helper'
require 'application_helper'

class ContactinfosController < ApplicationController
  include SessionStorageHelper
  include ApplicationHelper

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @contactinfos = Contactinfo.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @contactinfo = Contactinfo.find(params[:id])
  end

  # distributes where to go
  def contactinfo
    @id = nil
    # TODO similar processing for organisation session variable
    @person = get_person_from_session
    if !@person.blank?
      # find all person's contact infos
      @person_contactinfos = PersonContactinfo.find(:all, :conditions => ['person_id =?', @person.person_id])
      if @person_contactinfos.empty?
        redirect_to :action => 'new'
      else
        for contactinfo in @person_contactinfos
          if contactinfo.preferred == true
            @id = contactinfo.contactinfo_id
          else 
            if contactinfo.preferred == false && @id == nil
              @id = contactinfo.contactinfo_id
            end
          end
        end
        redirect_to :action => 'edit', :id => @id
      end
    end
  end
  
  # check if a person/organisation (TODO organisation has to be coded)
  # has already one
  # contact info as preferred
  def entity_contactinfo_preferred_check
    @entity_contactinfo_exists = false
    # find all person's contact infos
    @person_contactinfos = PersonContactinfo.find(:all, :conditions => ['person_id =?', @person.person_id])
    if !@person_contactinfos.empty?
      for contactinfo in @person_contactinfos
        # if any person contact info is preferred
        # set the check to true
        if contactinfo.preferred == true
          @entity_contactinfo_exists = true
        end
      end
    end
    return @entity_contactinfo_exists
  end

  def new
    @contactinfo = Contactinfo.new
    @person = get_person_from_session
    if !@person.blank?
      @entity_contactinfo = PersonContactinfo.new
      
      # get a person contact info type from params if any
      @entity_contactinfo.contactinfo_type = params[:contactinfo_type]
      
      @entity_contactinfo_exists = entity_contactinfo_preferred_check
    end
    # the default value for country is New Zealand
    @contactinfo.country = Country.find(:first, :conditions => ['country_name = ?', 'New Zealand'])      
  end

  def create
    @contactinfo = Contactinfo.new(params[:contactinfo])   
    
    # updated by
    @contactinfo.updated_by = get_user.login_id
    
    @person = get_person_from_session
    
    # process person contact info
    contactinfo_type = nil
    preferred = 'f'
    if !@person.blank?
      if params[:entity_contactinfo] 
        contactinfo_type = params[:entity_contactinfo][:contactinfo_type]
        if params[:entity_contactinfo][:preferred] && params[:entity_contactinfo][:preferred] != nil
          preferred = 't'
        end
      end        
    end
    
    # if contact info type is nil
    # the user returned to copy method
    # this is to prevent contact info being saved without
    # related person contact info
    # FIXME can this be done through transactions???
    if contactinfo_type == ''
      flash[:notice] = 'Contact info type cannot be empty'
      redirect_to :action => 'copy'
    else    
      if @contactinfo.save
        if @person.add_contactinfo_to_person(@contactinfo, contactinfo_type, preferred)
          flash[:notice] = 'Contact info was successfully created.'
          if session[:selected_contributor_id] != nil
            contributor=Contributor.find(session[:selected_contributor_id])
            contributor.contactinfo_id=@contactinfo.id
            contributor.save
            redirect_to :controller => 'contributors', :action => 'edit', :id => session[:selected_contributor_id]
          else
            redirect_to :action => 'edit', :id => @contactinfo
          end 
        else
          render :action => 'new'
        end
      end
    end  
  end
  
  def copy
    prev_contactinfo_id = session[:contactinfo_id]
    @person = get_person_from_session
    contactinfo_to_clone = Contactinfo.find(prev_contactinfo_id)
    @contactinfo = contactinfo_to_clone.clone
    # if the processing is for person
    @person = get_person_from_session
    if !@person.blank?
      @entity_contactinfo = PersonContactinfo.new
      @entity_contactinfo.contactinfo_type = nil
      @entity_contactinfo_exists = entity_contactinfo_preferred_check
    end 
  end

  def edit
    @contactinfo = Contactinfo.find(params[:id])
    session[:contactinfo_id] = @contactinfo.contactinfo_id
    @person = get_person_from_session
    @region = @contactinfo.region
    if !@person.blank?
      @entity_contactinfo = PersonContactinfo.find(:first, :conditions => ['contactinfo_id =?', @contactinfo.contactinfo_id])
      @entity_contactinfo_exists = entity_contactinfo_preferred_check
    end
  end

  def update
    @contactinfo = Contactinfo.find(params[:id])
       
    # updated by
    @contactinfo.updated_by = get_user.login_id
    
    # country and region
    @contactinfo.region_id = params[:contactinfo][:region_id]
    @contactinfo.country_id = params[:contactinfo][:country_id]
    
    if @contactinfo.region_id == nil && @contactinfo.country_id != nil
      @contactinfo.region_id = nil
    end
        
    if @contactinfo.update_attributes(params[:contactinfo])
      @person = get_person_from_session
      if !@person.blank?
        if params[:entity_contactinfo][:preferred] && params[:entity_contactinfo][:preferred] != nil
          preferred = 't'
        else
          preferred = 'f'
        end 
        @entity_contactinfo = PersonContactinfo.find(:first, :conditions => ['contactinfo_id =?', @contactinfo.contactinfo_id])
        if @person.update_person_contactinfo(@entity_contactinfo.person_contactinfo_id, @contactinfo, 
                                              params[:entity_contactinfo][:contactinfo_type], preferred)
          flash[:notice] = 'Contact Info was successfully updated.'
          redirect_to :action => 'edit', :id => @contactinfo
        else
          render :action => 'edit'
        end
      else
        flash[:notice] = 'Contact Info was successfully updated.'
        redirect_to :action => 'show', :id => @contactinfo
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    Contactinfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  #TODO there is the same method in search controller
  # might need to change processing in both, so
  # there is no duplication
  #------------------
  #- Choose a country, and update the region box
  #------------------
  
  def countryChosen
    
    show_params(params)
        
    if !params[:id].blank?
      @country = Country.find(params[:id])
    elsif !params[:country].blank?
      @country = Country.find(params[:country])
    else 
      @country = nil
      logger.debug "ID parameter was blank"
    end
    
    render :layout => false
  end
end
