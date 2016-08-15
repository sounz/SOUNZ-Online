class DistinctionInstancesController < ApplicationController
  
  include StatusesHelper
  include FrbrLinksHelper
  include ApplicationHelper
  include FinderHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
  	@distinction_instances = DistinctionInstance.paginate(:page => params[:page], :per_page => 50, :order => 'award_year')
  end

  def show
    @distinction_instance = DistinctionInstance.find(params[:id])
    get_statuses(@distinction_instance)
	@page_title = "Award - #{@distinction_instance.distinction.award_name} #{@distinction_instance.award_year}"
  end

  def new
    @distinction_instance = DistinctionInstance.new
    get_statuses(@distinction_instance)
  end

  def create
    @distinction_instance = DistinctionInstance.new(params[:distinction_instance])
    @distinction_instance.updated_by=@login.id
        if @distinction_instance.save
      flash[:notice] = 'DistinctionInstance was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @distinction_instance = DistinctionInstance.find(params[:id])
    @assignedDistinction=FrbrObject.new("distinction",Distinction.find(@distinction_instance.distinction_id))
    @assignedEvent=nil
    if @distinction_instance.event_id != nil
    @assignedEvent=FrbrObject.new("event",Event.find(@distinction_instance.event_id))  
    end
    
    get_statuses(@distinction_instance)
  end

  def update
    @distinction_instance = DistinctionInstance.find(params[:id])
     @distinction_instance.updated_by=@login.id
    if @distinction_instance.update_attributes(params[:distinction_instance])
      flash[:notice] = 'DistinctionInstance was successfully updated.'
      redirect_to :action => 'show', :id => @distinction_instance
    else
      render :action => 'edit'
    end
  end
  
  
  #- This is for the frbr related data -
  def related
    @distinction_instance = DistinctionInstance.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@distinction_instance, "frbr_"+mode) #hide frbr_ from URL
    @sub_partial_path = "shared/frbr/objects/full/distinction_instance/frbr_list_wrapper"
  end

  def destroy
    DistinctionInstance.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def findDistinctions
    search_term=params[:query]
    results=[]
    matchingDistinctions=Distinction.find(:all, :conditions => ["award_name ilike ?", '%'+search_term+'%'] )
    for distinction in matchingDistinctions
    results.push((FrbrObject.new("distinction",distinction)))
    end
    if results.length > 0
    render :partial =>'distinction_instances/distinction_result',:collection=> results
    else
    render :text => 'No distinctions found'
    end
  end
  
  def assignDistinction
  logger.debug("IN ASSIGN DISTINCTION")
  @assignedDistinction=FrbrObject.new("distinction",Distinction.find(params["object_id"]))
  end
  
  
  def findEvents
    search_term=params[:query]
    results=[]
    matchingEvents=Event.find(:all, :conditions => ["event_title ilike ?", '%'+search_term+'%'] )
    for event in matchingEvents
    results.push((FrbrObject.new("event",event)))
    end
    if results.length > 0
    render :partial =>'distinction_instances/event_result',:collection => results
    else
    render :text => 'No events found'
    end
  end
  
  def assignEvent
  logger.debug("IN ASSIGN EVENT")
  @assignedEvent=FrbrObject.new("event",Event.find(params["object_id"]))
  end
  
  def removeEvent
    @assignedEvent=nil
    render :text => '<b>No event assigned!</b>'
  end
  
  def find
	 @search_term = params[:searchTerm]
   fields = [
      {:name => 'award_name_for_solr_t', :boost => 4},
      {:name => 'instance_info_for_solr_t', :boost => 3}
    ]
    lucene_query = FinderHelper.build_query(DistinctionInstance, @search_term, fields)
    @distinction_instances = solr_query(lucene_query)[0][:docs].map{|f|f.objectData}
  end
  
  # - WR#50294 - Create a copy of a distinction instance
  def copy
    distinction_instance_to_clone = DistinctionInstance.find(params[:id])
			  
	@distinction_instance = distinction_instance_to_clone.clone
	
	@distinction_instance.instance_info = "COPY of '#{distinction_instance_to_clone.instance_info}'"
	
	@distinction_instance.status = Status::PENDING # default to 'pending'
	
	# delete created_at assigned from distinction_instance_to_clone created_at value
	# as we need created_at be actual time of creating the copy
	@distinction_instance.created_at = nil	
		
	# updated by
	@distinction_instance.updated_by = get_user.login_id
	
			
	if @distinction_instance.save
	  	  
	  flash[:notice] = 'Distinction Instance clone was successfully created'
	  
	  redirect_to :action => 'edit', :id => @distinction_instance
	else
	  flash[:error] = 'Distinction Instance cloning has failed.'
	  redirect_to :action => 'edit'
	end			
  end  
  
  
end
