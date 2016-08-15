class ResourcesController < ApplicationController
  include AttachmentHelper
  include StatusesHelper
  include DurationAsIntervalHelper
  include AccessRightHelper
  include FrbrLinksHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }


  def list
    @resources = Resource.paginate( :page => params[:page], :per_page => 50, :order => :resource_title)
  end


  def show
    @resource = Resource.find(params[:id])
    @media_items = attachments(@resource)
	if @resource.is_recording?
	  @page_title = "Recording - #{@resource.resource_title}"
	else
	  @page_title = "Resource - #{@resource.resource_title}"
	end
	
  end


  def new
    @resource = Resource.new
    
    #Set to pending
    set_default_status(@resource)
    prepare_dropdowns
    prepare_duration_new
    save_resource_instance_in_session
  end
  
  
  #- This is for the frbr related data -
  def related
    @resource = Resource.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@resource, "frbr_"+mode) #hide frbr_ from URL
    @sub_partial_path = "shared/frbr/objects/full/resource/frbr_list_wrapper"
  end
  
  
  
  
  #These are required to populate dropdowns
  def prepare_dropdowns
    #Get a list of statuses
    get_statuses(@resource)

    
    #Get the valid formats
    @resource_types = Resource.all_resource_types
    @formats = Resource.all_valid_formats
  end
  

  def create
    #Deal with the javascript widget for calendar - this alters params to a standard date
    resource_date_ok = true
    if params[:resource][:resource_date_time]
      begin
        convert_datetime_to_db_format_in_params(params, 'resource','resource_date')
      rescue TimeParseException
        resource_date_ok = false
      end
    end
    
    @resource = Resource.new(params[:resource])
    @resource.updated_by = @login.login_id
      
    if @resource.save
      flash[:notice] = 'Resource was successfully created.'
      #create a moneyworks export file
      @resource.create_moneyworks_file()
      redirect_to :action => 'show', :id => @resource
    else
      #Keep the view rendering happy
      prepare_dropdowns
      prepare_duration_edit(@resource.duration)
      @interval_duration = IntervalDuration.create_from_string_no_validation(@resource.duration)
      render :action => 'new'
    end
  end
  

  def edit
    @resource = Resource.find(params[:id])
    @backlink = params[:backlink]
    prepare_dropdowns
    prepare_duration_edit(@resource.duration)
    save_resource_instance_in_session
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
    @media_items = attachments(@resource)
    populate_access_right_variables(@resource)
  end
  

  def update
    @resource = Resource.find(params[:id])
	  @resource.updated_by = @login.login_id
	  if params[:resource][:duration].nil? 
		  params[:resource][:duration] = nil
	  end
    if @resource.update_attributes(params[:resource])
      flash[:notice] = 'Resource was successfully updated.'
      if !params[:back][:link].blank?
        redirect_to params[:back][:link]
      else
        redirect_to :action => 'show', :id => @resource
      end
    else
      prepare_dropdowns
      prepare_duration_edit(@resource.duration)
      @interval_duration = IntervalDuration.create_from_string_no_validation(@resource.duration)
      populate_access_right_variables(@resource)
      render :action => 'edit'
    end
  end

  def destroy
    Resource.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  #------------------------------------------------------
  #- Respond to the dropdown change of manifestation type
  #------------------------------------------------------
  def tweak_format_dropdown
    logger.debug "***** Tweak format dropdown"
    @found_type = true #If they choose the prompt then there is no type
    type_id = params[:type]
    logger.debug "Type is is #{type_id}"
    

        
    if !type_id.blank?
      @resource_type = ResourceType.find(type_id)
      @formats = @resource_type.formats
    else
      @found_type = false
      @resource_type = nil
    end
    
    #Get the resource instance
    load_resource_instance_from_session
    
    #Reset the format in order to get the prompt
    @resource.format=nil
    

    @resource.resource_type = @resource_type
    render :layout => false
  end
  
  
  
  # ---- Session storage of expressions ----
  
  #In order for the ajax to repopulate correctly the dates when a mode is changed, the resource being edited
  #needs to be stored in the session
  def save_resource_instance_in_session
    session[:resource_being_edited] = @resource
  end
  
  #Load the instance variable @manifestation with whats saved
  def load_resource_instance_from_session
    @resource = session[:resource_being_edited]
  end
end
