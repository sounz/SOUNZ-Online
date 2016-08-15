class ContributorsController < ApplicationController

      include FrbrLinksHelper

    PAGE_HEADINGS = {
  #     :composer_intro => 'introduction',
       :composer_show_all_compositions => 'composed works',
       :composer_show_all_arrangements => 'arranged works',
      :composer_show_all_commissions => 'commissioned works',
       :composer_show_all_creations => 'created works',
       :composer_show_all_improvisations => 'improvised works',
       :composer_show_all_presentations => 'presented works',
       :composer_show_all_writings => 'written works',
       :performer_show_all_commissions => 'commissions',
       :performer_show_all_performances => 'performances',
       :performer_show_all_improvisations => 'improvisations',
       :performer_show_all_exhibitions => 'exhibitions',
       :performer_show_all_presentations => 'presentations',
       :general_show_all_funded_works => 'funded works'
    }
    
    PAGE_METHODS= {
  #    :composer_intro => 'selected_works',
      :composer_show_all_compositions => 'compositions',
      :composer_show_all_arrangements => 'arrangements',
      :composer_show_all_commissions => 'commissioned_works',
      :composer_show_all_creations => 'creations',
      :composer_show_all_improvisations => 'improvised_works',
      :composer_show_all_presentations => 'presented works',
      :composer_show_all_writings => 'writings', #This means the likes of lyrics
      :performer_show_all_commissions => 'commissioned_works',
      :performer_show_all_performances => 'performances',
      :performer_show_all_improvisations => 'improvised_expressions',
      :performer_show_all_exhibitions => 'exhibitions',
      :performer_show_all_presentations => 'presentations',
      :general_show_all_funded_works => 'funded_works'
    }
    
      
  #These require the contributor object to be available from the id field - may as well use the same method
  #to save on repetition
  before_filter :get_contributor_from_id, 
  :only => PAGE_HEADINGS.keys

   
  
  def get_contributor_from_id
   #Get the contributor object
   @contributor = Contributor.find(params[:id])
   
   #This is the name of partial in shared/frbr/full/objects/contributors
   @template_name = action_name
   
   uc_title = PAGE_HEADINGS[action_name.to_sym].titleize
   
   @page_title = @contributor.role.contributor_names+' - '+uc_title || "TITLE NOT FOUND for action #{action_name}"
   
   if @page_title.ends_with?("introduction")
     @page_title = @page_title[0..(@page_title.length-15)]
   end
   
   @main_title = @contributor.known_as_public
   
   #The composer/performer blah screens are all similar, so use a generic template and fill in the gaps
   #using dynamically assigned sub partials - means look n feel changes are easier
   prefix = action_name.split('_')[0]
    @method_for_objects = PAGE_METHODS[action_name.to_sym]
    
    #Do this here for paging purposes
    @items = @contributor.role.send(@method_for_objects)

    @page = params['page'] || "1"
    @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE, @page)
    
   render :action => prefix+'_generic'
  end
  
  def composer_intro
       
       @contributor = Contributor.find(params[:id])
       @items = @contributor.role.selected_works
       @page = params['page']
       @page = "1" if @page.blank?
       @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE)
       @page_title = @contributor.role.contributor_names+' - Introduction'
       @main_title = @contributor.role.contributor_names
       
  end
  
  def performer_intro
       @contributor = Contributor.find(params[:id])
       @main_title = @contributor.role.contributor_names
       @page_title = @contributor.role.contributor_names+' - Introduction'
  end
  
  #Display a venue, as these are now contributors
  def venue
    @contributor = Contributor.find(params[:id])
    @main_title = @contributor.role.contributor_names
    @page_title = @contributor.role.contributor_names+' - Introduction'
  end


  #Display a presenter, as these are now contributors
  def presenter
    @contributor = Contributor.find(params[:id])
    @main_title = @contributor.role.contributor_names
    @page_title = @contributor.role.contributor_names
  end
  
  
  
  def relatedOBSOLETE
    
    @contributor = Contributor.find(params[:id])
    @role= @contributor.role
    
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@role, "frbr_"+mode)
    @sub_partial_path = "shared/frbr/objects/full/concept/frbr_items"
  end
  
  
  
  #In order to avoid having to wire lots of partials do the switch here and rely on convention
  #This renders the shell of a page and uses a partial of the form <tt>/shared/frbr/role/<role_type_group>/<mode></id></tt>
  #If the mode name starts with frbr, e.g. frbr_events_held_at, assume that we call the event_held_at method
  #on the contributor
  def show_appropriate_for_role
    @contributor = Contributor.find(params[:id])
    @mode = params[:mode]
    @mode = "main" if @mode.blank? #default to main
    @contains_frbr = false
    if @mode.starts_with?("frbr_")
      @mode = @mode.gsub("frbr_","")
      
      if !@mode.starts_with?("composite_")
        veer = ValidEntityEntityRelationship.find(:first, :conditions => ["ruby_method_name=?", @mode])
        raise ArgumentError, "Frbr method, #{@mode}, is not valid" if veer.blank?
        @frbr_title = veer.page_title
      elsif @mode == "composite_distinctions"
        veer = ValidEntityEntityRelationship.find(:first, :conditions => ["ruby_method_name=?", @mode.gsub("composite_", "")])
        raise ArgumentError, "Frbr method, #{@mode}, is not valid" if veer.blank?
        @frbr_title = veer.page_title
      else
        @frbr_title = @mode[10..@mode.length].split('_').map{|w| w.camelize}.join(' ')
      end
      

      @related_frbr_objects = @contributor.role.send(@mode)
      @page = params['page']
      @page = "1" if @page.blank?
      @paginator = Paginator.new(self, @related_frbr_objects.length , LISTING_PAGE_SIZE, @page)
      @contains_frbr = true
	  
    end
    raise ArgumentError, "Please provide a mode" if @mode.blank?
    @role_type_group = @contributor.role.role_type.role_type_group
    
    #This is the introduction page
    if !@contains_frbr
      if @role_type_group == "composer"
         @items = @contributor.role.selected_works
         @page = params['page']
         @page = "1" if @page.blank?
         @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE)
         @page_title = "NZ composer - #{@contributor.role.contributor_names}"
         @main_title = @contributor.role.contributor_names
      else
      	@page_title = "#{@contributor.role.role_type.role_type_desc.gsub('(c)','')} - #{@contributor.role.contributor_names}"
      end
      @sub_partial_path = "shared/frbr/objects/full/contributor/#{@role_type_group}/#{@mode}"
    else
      @page_title = "#{@contributor.role.contributor_names} - #{@frbr_title}"
      @sub_partial_path = "shared/frbr/objects/full/contributor/#{@role_type_group}/frbr_links"
    end
    
    @relevant_tab = :people
    @relevant_tab = :events  if @role_type_group == "venue"

    
  end



  #-This is the generic contributor case-
  def general_intro
       @contributor = Contributor.find(params[:id])
       @main_title = @contributor.known_as_public
  end
  
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @contributors = Contributor.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @contributor = Contributor.find(params[:id])
  end

  def new
    @contributor = Contributor.new
    @statuses=Status.find(:all)
    session[:selected_contributor_id] = @contributor.id
  end

  def create
    @contributor = Contributor.new(params[:contributor])
    if @contributor.save
      # update all role role_contactinfos for
      # solr indexing
      @contribitor.role.save
	  @contributor.role.role_contactinfos.each do |rc|
        rc.save
      end
      flash[:notice] = 'Contributor was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

 def findContactinfos
    if params[:query].length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
      @matchingPeople=Person.find(:all,:conditions => ["first_names like ? or last_name like ?", '%'+params[:query]+'%','%'+params[:query]+'%'] )
      @matchingOrganisations=Organisation.find(:all,:conditions => ["organisation_name like ?", '%'+params[:query]+'%'] )
      @matchingObjects=@matchingPeople+@matchingOrganisations
      render :partial => 'result', :collection => @matchingObjects      
      
    end
  
  end
  
  def assignContactinfo
    contactinfo=Contactinfo.find(params["object_id"])
    render :partial => 'contactinfo', :locals => {:object => contactinfo}
  end
  
  


  # -------------------------------------------------------------------------------
  # - If "deceased" checkbox is changed when editing person details, this returns -
  # - the dropdown for choosing the date the person became deceased               -
  # ------------------------------------------------------------------------------- 
  def deceased_date_box
    @deceased = (params[:deceased] == '1') ? true : false
    @person = Person.find(params[:id]) if params[:id]
  end  
  
end
