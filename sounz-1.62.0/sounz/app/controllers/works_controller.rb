
require 'session_storage_helper'

class WorksController < ApplicationController
  
  include SessionStorageHelper
  include AttachmentHelper
  include ApplicationHelper
  include StatusesHelper
  include ModelAsStringHelper
  include DurationAsIntervalHelper
  include PrivilegesHelper
  include FinderHelper
  include HardAssociationHelper
  include AccessRightHelper
  include FrbrLinksHelper
  include SounzmediaHelper
  
  
  
  
  #These require the contributor object to be available from the id field - may as well use the same method
  #to save on repetition
  before_filter :get_work_from_id, 
  :only => [:work_introduction, :work_show_all_compositions, :work_show_all_arrangements,
    :work_show_all_commissions, :work_show_all_creations, :work_show_all_improvisations, 
    :work_show_all_presentations, :work_show_all_writings
    ]

   WORK_HEADINGS = {
      :work_introduction => 'introduction',
      :work_show_all_compositions => 'composed works',
      :work_show_all_arrangements => 'arranged works',
      :work_show_all_commissions => 'commissioned works',
      :work_show_all_creations => 'created works',
      :work_show_all_improvisations => 'improvised works',
      :work_show_all_presentations => 'presented works',
      :work_show_all_writings => 'written works'
   }
   

  
  
  
  
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @works = Work.paginate(:page => params[:page], :per_page => 10, :order => 'work_title')
  end

  def show
    @work = Work.find(params[:id])
    @page_title= @work.work_title
    composers = @work.composers #fetch our composer roles
    @page_title = @page_title +" - " + composers.map{|r| r.contributor.known_as_public}.join(',') if !composers.blank?
    @media_items=attachments(@work)
    @resources = @work.descriptive_resources
    related_manifestations = PrivilegesHelper.permitted_objects(@login, @work.related_manifestations)
    related_resources = PrivilegesHelper.permitted_objects(@login, @work.related_resources)
    @sounzmedia_manifestations = ManifestationsHelper.sounzmedia_only(related_manifestations)
    @sounzmedia_resources =  ResourcesHelper.sounzmedia_only(related_resources)
    @sounzmedia = @sounzmedia_manifestations | @sounzmedia_resources  
    @sounzmedia, @sounzmedia_embedded = get_sounzmedia_by_format(@sounzmedia)
    if @sounzmedia.size > 0
      playlist(@sounzmedia, @work.work_id)
    end
  end
  
  def availability
    @work = Work.find(params[:id])
    @page_title= @work.work_title
    composers = @work.composers #fetch our composer roles
    @page_title = @page_title +" - " + composers.map{|r| r.contributor.known_as_public}.join(',') if !composers.blank?
    @media_items=attachments(@work)
    @resources = @work.descriptive_resources
  end
  
  
  #- This is for the frbr related data -
  def related
    @work = Work.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@work, "frbr_"+mode) #hide frbr_ from URL
    @sub_partial_path = "shared/frbr/objects/full/work/frbr_list_wrapper"
  end
  
  

  #Prepare variables and render the new form
  def new
    logger.debug "**** WORK NEW ****"
    @work = Work.new
    @work.login_updated_by = @login
    @popup_title = 'Superwork'
    
    #Reset the in memory array of composers - only do this for new when its not redirected after a failed edit
    session[:composers] = []
    @composers = session[:composers]
    
    prepare_new
  end
  
  
  #Set up variables in order to render the new form
  def prepare_new
    @work_categories=WorkCategory.find(:all, :conditions => ["additional is NOT TRUE"],:order => 'display_order')
    @work_additional_subcategories=WorkSubcategory.find(:all, :conditions => ["additional is TRUE"],:order => 'display_order')
    
    if !@work.superwork_id.blank?
    @assignedSuperwork=FrbrObject.new("superwork",Superwork.find(@work.superwork_id)) if !@work.superwork.blank?
    end
    
    get_statuses(@work)
    set_default_status(@work)
    session[:work_subcategories]=Array.new()
    session[:title_entered]=""
    @subcategories=session[:work_subcategories]
    
    logger.debug "Work cats are #{@work_categories}"
    logger.debug "Work addsubcats are #{@work_additional_subcategories}"
    logger.debug "Statuses are #{@statuses}"
    prepare_duration_new

  end


  #This method is reached by a post from the new form
  def create
    logger.debug "**** WORK CREATE ****"
 
    #Fix the value coming back from the check box
    if params[:work][:no_duration] == "on"
      params[:work][:no_duration] = "true"
    else
      params[:work][:no_duration] = "false"
    end
    @work = Work.new(params[:work])
    logger.debug "Created work, fields are #{@work.to_yaml}"

        
    @work.intended_duration = nil if params[:work][:intended_duration].blank?
    
    @main_category = @work.main_category #Used by form
    
	@composers = session[:composers]
	
    #add a superwork with the same name as the work in question if no superwork is attached
      if ! @work.superwork
        logger.info("No superwork assigned!")
		
		composers_names = @composers.map{|c| c.contributor.role.contributor_names}.flatten.uniq.join(', ')
        
		@work.superwork=Superwork.create(:superwork_title=>@work.work_title + " - " + composers_names,:updated_by=>@login.login_id,:status_id=>params[:work][:status_id])
      end
    
    show_params(params)
    
    
    logger.debug "WORK SUBCATS are #{@work.work_subcategories.length}"
    
    #Create implicit FRBR relationships

     @work.login_updated_by = @login
     
    if @work.save_with_composers(@composers)
      logger.debug "WORK SAVED OK"
      @work.frbr_updateImplicitRelationships(@login.login_id)
      @subcategories=session[:work_subcategories]
      for subcategory in @subcategories
          @work.work_subcategories << subcategory
      end
      @work.save()  
      flash[:notice] = 'Work was successfully created.'
    
      redirect_to :action => 'show', :id => @work
    else
      logger.debug "WORK DID NOT SAVE - RENDERING NEW FORM"
      prepare_new
      @interval_duration = IntervalDuration.create_from_string_no_validation(@work.intended_duration)

      
      render :action => 'new'
    end
  end
  

  
  def findSubcategories
    if params[:category]!="0"
    @matchingSubcategories=WorkSubcategory.find(:all, :order => :display_order, :conditions => ["work_category_id= ?",params[:category]])
    render :partial => 'subcategory_item', :collection => @matchingSubcategories
    else
    render :text => "<option value='0'>Select a category in the box above</option>"
    end   
  end
  
  
  #Assign a main or additional category
  def assignSubcategory
    #@work=Work.find(params[:id])
    @subcategories=session[:work_subcategories]
    logger.info("SUBCATEGORY_COUNT "+@subcategories.length.to_s)
    
    if params[:subcategory_id]!="0"
    
      mySubcategory=WorkSubcategory.find(params[:subcategory_id]) 
      
      if (mySubcategory.additional)
        #check we aren't adding a dupe
        @subcategories.push(mySubcategory) if !@subcategories.include?(mySubcategory)      
        render :partial => 'additional_subcategories'  
      else
        @main_category = mySubcategory
      
        #This adds a hidden field into the form to set the main category, so taht update attributes is happy
        render :partial => 'subcategories' 
      end 
  
    else
    
    if params[:additional]
    render :partial =>'additional_subcategories'
    else
    render :partial =>'subcategories'
    end
    
    
    end
  
  end


  #Remove an additional category
  def removeSubcategory
    @subcategories=session[:work_subcategories]
    mySubCat = WorkSubcategory.find(params[:subcategory_id])
    @subcategories.delete(mySubCat)
    if mySubCat.additional
      render :partial => 'additional_subcategories' 
    else
      render :partial => 'subcategories' 
    end  
  end
  

  # Search for superworks using the work title - note this is called from a field observer in the work form.
  # The title observed is also stored in the session for populating the superwork popup
  def findSuperworks
    @results=Array.new
    
    #Grab the search term, in this case the work title, and store it - this is used for the popup
    @search_term = params[:query]
    session[:title_entered] = @search_term
      @search_term = FinderHelper.strip(params[:query]) +'*'
    if FinderHelper.strip(params[:query]).length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
     # @matchingSuperworks=Superwork.find(:all,:conditions => ["superwork_title like ? or superwork_title_alt like ?", '%'+params[:query]+'%','%'+params[:query]+'%'] )
     # search_term = FinderHelper.strip(params[:query].downcase)+'*'
      
      #This took a bit of figuring out!
      fields = [
        {:name => 'superwork_title_for_solr_t', :boost => 4},
        {:name => 'superwork_title_alt_for_solr_t', :boost => 2.5}
      ]
      the_query = FinderHelper.build_query(Superwork, FinderHelper.strip(params[:query]), fields)
      @matchingSuperworks = solr_query(the_query)[0][:docs].map{|f|f.objectData}
      
      for superwork in @matchingSuperworks
          @results.push((FrbrObject.new("superwork",superwork)))
      end
 #   render :partial => 'result', :collection => @results
    render :partial => 'superworks_solr_search'
    end
  
  end
  
  
  # Assign a superwork
  def assignSuperwork
    type=Inflector.camelize(params[:type])
    superwork=eval(type+".find("+params["object_id"]+")")
    #FIXME: Why is this wrapped in a FrbrObject?
    @assignedSuperwork=FrbrObject.new("superwork",superwork)
  end
  
  
  #---- deal with the popup superwork creation ----
  
  #This is the callback from the popup
  def assignSuperworkFromPopup
    assignSuperwork
     render :partial => 'superwork', :locals => {:object => @assignedSuperwork}
  end

 #This is called from the 'New' button and appears visually as a popup
 def addSuperwork
   @superwork = Superwork.new
   set_default_status(@superwork)
   get_statuses(@superwork)
   logger.debug "**** WORK TITLE STORED IN SESH:#{session[:title_entered]}"
   @superwork.superwork_title = session[:title_entered]
  
   render :partial => 'new_superwork_popup', :layout => 'popup'
 end
 
 
 #This should really be create... and now it is
 def createSuperworkFromPopup
    @superwork = Superwork.new(params[:superwork])
     @superwork.login_updated_by = @login
    if @superwork.save()
      render :partial => 'window_closer', :locals => {:superwork_id => @superwork.id}
    else
      get_statuses(@superwork)
      render :partial => 'new_superwork_popup', :layout => 'popup'
    end
  end
  
  
  #-- Deal with popup superwork editing --
 def editSuperwork
   @popup_title = "Editing Superwork"
   @superwork = Superwork.find(params[:superwork_id])
   get_statuses(@superwork)
    render :partial => 'edit_superwork_popup', :layout => 'popup'
 end
 
 
 def updateSuperworkFromPopup
   @superwork = Superwork.find(params[:superwork_id])
   @superwork.login_updated_by = @login
   if @superwork.update_attributes(params[:superwork])
     flash[:notice] = 'Superwork was successfully updated.'
      render :partial => 'window_closer', :locals => {:superwork_id => @superwork.id}
   else
     get_statuses(@superwork)
     render :partial => 'edit_superwork_popup', :layout => 'popup'
   end
 end
 
   
  def edit
    debug_message "Starting work edit"
    show_params(params)
    @work = Work.find(params[:id])
    #Initialise this, but leave it in session for an update
    session[("composers_" + @work.id.to_s).to_sym] = @work.composers
    prepare_edit
    @media_items=attachments(@work)
  end
  
  
  def prepare_edit
    #FIXME: Why is this wrapped in a FrbrObject?
    @assignedSuperwork=FrbrObject.new("superwork",Superwork.find(@work.superwork_id))
    get_statuses(@work)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
    @work_categories=WorkCategory.find(:all, :order => :work_category_desc, :conditions => ["additional is not TRUE"],:order => 'display_order')
    @work_additional_subcategories=WorkSubcategory.find(:all, :order => :work_subcategory_desc, :conditions => ["additional is TRUE"],:order => 'display_order')
    session[:work_subcategories]=@work.work_subcategories
    @subcategories=session[:work_subcategories]
    logger.info("TYPE: "+@subcategories.type.to_s)
    @page_title='Editing work "' + @work.work_title+"'"
    @popup_title = "New Superwork"
    @main_category = @work.main_category #Used by form
    prepare_duration_edit(@work.intended_duration)
    @intended_duration = nil if @work.no_duration == true
    #This is required for the composers widget
    @composers = session[("composers_" + @work.id.to_s).to_sym]
    
    #Enable the hard association controller
    prime_hard_association_for_work_expressions(@work)
    
    populate_access_right_variables(@work)
  end



  def update
    @subcategories=session[:work_subcategories]
    @work = Work.find(params[:id])
    @composers = session[("composers_" + @work.id.to_s).to_sym]
    show_params(params)

    
    logger.debug "===================="
    logger.debug "composers in session are #{@composers.length}"

=begin
    if params[:work][:intended_duration].blank?
      params[:work][:intended_duration]="00:00:00"  
    end
=end
    
    #Fix work no_duration field by checking for existence of h m s fields
    if params[:work_dur].blank?
      @work.no_duration = true
      @work.intended_duration = nil
    else
       @work.no_duration = false
    end
    
	@work.login_updated_by = @login
	
    if @work.update_attributes_with_composers(params[:work], @composers, @login.login_id)
      
      
      #add a superwork with the same name as the work in question if no superwork is attached
      if ! @work.superwork
        logger.info("No superwork assigned!")
      end
      
      
      @work.frbr_updateImplicitRelationships(@login.id)
      @work.work_categorizations.delete_all
      for subcategory in @subcategories
      @work.work_subcategories << subcategory
      end
      @work.save()
      flash[:notice] = 'Work was successfully updated.'
      redirect_to :action => 'show', :id => @work
    else
      prepare_edit
      render :action => 'edit'
    end
  end


  def destroy
    Work.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  
  #---- Deal with duration field AJAX ----
  
  #The no_duration flag name is a bit annoying......
  def tweak_duration_form
    logger.debug "**** TWEAKING DURATION"
    show_params(params)
    
    #Get a work if we can (ie not a new one)
    work_id = params[:id]
    if !work_id.blank?
      @work = Work.find(params[:id])
    end
    @no_duration_flag = params[:no_duration_flag]
    @show_duration = true
    if !@no_duration_flag.blank? and @no_duration_flag.to_s=='on'
      @show_duration = false
    end
    
    @work.no_duration = @show_duration
    
    logger.debug "NO DURATION:#{@work.no_duration}"

  end
  
  #Triggered by an ajax observable in compser form.
  #* Find a composer
  def find_composers
    show_params(params)
    @query = params[:composer_query]
    if params[:work_id]
      @work = Work.find(params[:work_id])
    else
      @work = Work.new
    end
    @composers=Array.new
    fields = [
  #      {:name => 'contributor_known_as_for_solr_t', :boost => 4},
        {:name => 'contributor_description_for_solr_t', :boost => 2.5}
  #      {:name => 'contributor_profile_for_solr_t', :boost => 0.6},
  #      {:name => 'contributor_pull_quote_for_solr_t'},
      ]
      @matches, @paginator = solr_query(FinderHelper.build_query(Role, @query, fields),{})
      for role in @matches[:docs]
        if role.objectData.is_a_contributor?
        @composers.push(role.objectData)
        end
      end
   
  end
  
  
  #This is called when the add button is hit
  def add_composer
    if params[:work_id]
      @work = Work.find(params[:work_id])
    else
      @work = Work.new
    end
    @new_composer = Role.find(params[:id])
    if params[:work_id]
      @composers = session[("composers_" + params[:work_id]).to_sym]
    else
      @composers = session[:composers]
    end
    @composers << @new_composer
    if params[:work_id]
      session[("composers_" + @work.id.to_s).to_sym] = @composers
    else
      session[:composers] = @composers
    end
    @dom_id = generate_id(@new_composer)
  end
  
  #This is called when the delete button is hit, and removes a composer from the list
  def delete_composer
    logger.debug "**** DELETE COMPOSER ****"
    @composer = Role.find(params[:id])
    if params[:work_id]
      @composers = session[("composers_" + params[:work_id]).to_sym]
    else
      @composers = session[:composers]
    end
    @composers.delete(@composer)
    if params[:work_id]
      session[("composers_" + params[:work_id]).to_sym] = @composers
    else
      session[:composers] = @composers
    end
    
    @dom_id = generate_id(@composer)
    
    logger.debug "Dom id is #{@dom_id}"
  end
  
  
  private
  def get_work_from_id
   #Get the work object
   @work = Work.find(params[:id])
   
   #This is the name of partial in shared/frbr/full/objects/contributors
   @template_name = action_name
   @page_title = @work.work_title+' - '+WORK_HEADINGS[action_name.to_sym] || "TITLE NOT FOUND for action #{action_name}"
   #The composer screens are all similar, so use a generic template and fill in the gaps
   #using dynamically assigned sub partials
   render :action => 'work_generic'
  end
  

  
  
  
  

end
