class VenuesController < ApplicationController
 
  include StatusesHelper
  
 
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @venue_pages, @venues = paginate :venues, :per_page => 10
  end

  def show
    @venue = Venue.find(params[:id])
    @items = @venue.held_events
    @page = params['page']
    @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE)
    @page_title=@venue.venue_name
  end

  def new
    @venue = Venue.new
    @contactinfo=Contactinfo.new();
    @contactinfo.updated_by=@login.login_id
    @venue.contactinfo=@contactinfo
    #@contactinfos=Contactinfo.find(:all)
    get_statuses(@venue)
    set_default_status(@venue)
  end

  def create
    @venue = Venue.new(params[:venue])
    @contactinfo=Contactinfo.create(params[:contactinfo]);
    @venue.contactinfo=@contactinfo
    @venue.updated_by = @login.login_id
    @contactinfo.updated_by = @login.login_id
    
    if @venue.save
      flash[:notice] = 'Venue was successfully created.'
      redirect_to :action => 'show', :id => @venue.venue_id
    else
      get_statuses(@venue)
      render :action => 'new'
    end
  end
  

def findContactinfos
    if params[:query].length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
      @matchingPeople=Person.find(:all,:conditions => ["first_names like ? or last_name ilike ?", '%'+params[:query]+'%','%'+params[:query]+'%'] )
      @matchingOrganisations=Organisation.find(:all,:conditions => ["organisation_name ilike ?", '%'+params[:query]+'%'] )
      @matchingObjects=@matchingPeople+@matchingOrganisations
      render :partial => 'result', :collection => @matchingObjects      
      
    end
  
  end
  
  def assignContactinfo
  contactinfo=Contactinfo.find(params["object_id"])
  render :partial => 'contactinfo', :locals => {:object => contactinfo}
  end

  def edit
    @venue = Venue.find(params[:id])
    #@contactinfos=Contactinfo.find(:all)
    @contactinfo=@venue.contactinfo
    get_statuses(@venue)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
  end

  def update
    logger.debug "** UPDATING VENUE"
    show_params(params)
    @venue = Venue.find(params[:id])
    @venue.updated_by=@login.login_id
    @contactinfo=@venue.contactinfo
    @contactinfo.updated_by=@login.login_id
    
    if @venue.update_attributes(params[:venue])
      logger.debug "** Successfully updated venue"
      #FIXME this dont look right
      @contactinfo.update_attributes(params[:contactinfo])
      flash[:notice] = 'Venue was successfully updated.'
      redirect_to :action => 'show', :id => @venue
    else
      logger.debug "** Update of venue failed, rendering edit instead"
      @contactinfo=@venue.contactinfo
      @contactinfo.update_attributes(params[:contactinfo])
      @statuses=get_statuses(@venue)
      @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
      @entity_types=EntityType.find(:all, :order => :entity_type)
      render :action => 'edit'
    end
  end

  def destroy
    Venue.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  # FRBR stuff
  def events
    @venue = Venue.find(params[:id])
    @page_title = "#{@venue.venue_name} - Events"
    @items = @venue.held_events
    @page = params['page']
    @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE)
  end
  
  def performances
    @venue = Venue.find(params[:id])
    @page_title = "#{@venue.venue_name} - Performances"
    @items = @venue.performances
    @page = params['page']
    @paginator = Paginator.new(self, @items.length , LISTING_PAGE_SIZE)
  end
end
