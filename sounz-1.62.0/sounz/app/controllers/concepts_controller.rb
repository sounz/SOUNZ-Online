class ConceptsController < ApplicationController
  
  include FrbrLinksHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    
    @parent_concepts= Concept.find(:all, :conditions => ["parent_concept_id is null"], :order => 'concept_name')
  end

  def show
    @concept = Concept.find(params[:id])
    @page_title=@concept.concept_name
  end

  def new
    @concept = Concept.new
    @concepttypes=ConceptType.find(:all)
    @statuses=Status.find(:all)
  end

  def create
    @concept = Concept.new(params[:concept])
    @concept.updated_by = @login.login_id
    if @concept.save
      flash[:notice] = 'Concept was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @concept = Concept.find(params[:id])
    @concepttypes=ConceptType.find(:all)
    @page_title = @concept.frbr_ui_desc

    
    @statuses=Status.find(:all, :order => :status_desc)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
    
  end

  def update
    @concept = Concept.find(params[:id])
	@concept.updated_by = @login.login_id
    if @concept.update_attributes(params[:concept])
     
      flash[:notice] = 'Concept was successfully updated.'
      redirect_to :action => 'show', :id => @concept
    else
      render :action => 'edit'
    end
  end

  def destroy
    Concept.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  def related
    @concept = Concept.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    @page_title = "NZ music - #{@concept.concept_name}"
    retrieve_frbr_objects_using_mode(@concept, "frbr_"+mode)
    @sub_partial_path = "shared/frbr/objects/full/concept/frbr_items"
  end
  
=begin
#- This is for the frbr related data -
def related
  @manifestation = Manifestation.find(params[:id])
  mode =  params[:mode]
  logger.debug "MODE:#{mode}"
  
  retrieve_frbr_objects_using_mode(@manifestation, "frbr_"+mode) #hide frbr_ from URL
  @sub_partial_path = "shared/frbr/objects/full/manifestation/frbr_list_wrapper"
end
=end
end
