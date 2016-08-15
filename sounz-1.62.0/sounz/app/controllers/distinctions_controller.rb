class DistinctionsController < ApplicationController
  
  include FrbrLinksHelper
  include StatusesHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @distinctions = Distinction.paginate(:page => params[:page], :per_page => 50, :order => 'award_name')
  end

  def show
    @distinction = Distinction.find(params[:id])
	@page_title  = "Award - #{@distinction.award_name}"
  end

  def new
    @distinction = Distinction.new
    @contactinfo=Contactinfo.new()
    @distinction.contactinfo=@contactinfo
    get_statuses(@distinction)
    set_default_status(@distinction)
  end

  def create
    @distinction = Distinction.new(params[:distinction])
    @contactinfo=Contactinfo.create(params[:contactinfo])
    @distinction.contactinfo=@contactinfo
    @distinction.updated_by = @login.login_id
    @contactinfo.updated_by = @login.login_id
    if @distinction.save
      flash[:notice] = 'Distinction was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @distinction = Distinction.find(params[:id])
    @contactinfo=@distinction.contactinfo
    get_statuses(@distinction)
  end

  def update
    @distinction = Distinction.find(params[:id])
    @distinction.updated_by=@login.login_id
    get_statuses(@distinction)
    if @distinction.update_attributes(params[:distinction])
      @contactinfo=@distinction.contactinfo
      @contactinfo.updated_by=@login.login_id
      
      if @contactinfo.update_attributes(params[:contactinfo])
        flash[:notice] = 'Distinction was successfully updated.'
        redirect_to :action => 'show', :id => @distinction
    
      else
      flash[:notice] = 'Contactinfo updating was a problem!'
      redirect_to :action => 'show', :id => @distinction
      end
    else
    #@contactinfos=Contactinfo.find(:all)
    @contactinfo=@distinction.contactinfo
    @contactinfo.updated_by=@login.login_id
    @contactinfo.update_attributes(params[:contactinfo])
    render :action => 'edit'
    end
  end
  
  
  
  #- This is for the frbr related data -
  def related
    @distinction = Distinction.find(params[:id])
    mode =  params[:mode]
    logger.debug "MODE:#{mode}"
    
    retrieve_frbr_objects_using_mode(@distinction, "frbr_"+mode) #hide frbr_ from URL
    @sub_partial_path = "shared/frbr/objects/full/distinction/frbr_list_wrapper"
  end

  def update_old
    @distinction = Distinction.find(params[:id])
    @distinction.updated_by=@login.login_id
    if @distinction.update_attributes(params[:distinction])
      flash[:notice] = 'Distinction was successfully updated.'
      redirect_to :action => 'show', :id => @distinction
    else
      render :action => 'edit'
    end
  end

  def destroy
    Distinction.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  

  # - Dynamically add a distinction type -
  def add_distinction_type
    distinction_type = DistinctionType.find(params[:distinction_type_id]) unless params[:distinction_type_id].blank?
    @distinction = Distinction.find(params[:distinction_id]) unless params[:distinction_id].blank?
    
    if !distinction_type.blank? && ! @distinction.blank?
      distinction_distinction_type = DistinctionDistinctionType.new( :distinction_id => @distinction.id,
      	                                                             :distinction_type_id => distinction_type.id
                                                                    )
             
      distinction_distinction_type.save
    end
        
    render :partial => 'distinction_types_form', :locals => { :distinction => @distinction }
    
  end
  
  # - Dynamically remove a distinction distinction type -
  def remove_distinction_type
    distinction_distinction_type = DistinctionDistinctionType.find(params[:distinction_distinction_type_id]) unless params[:distinction_distinction_type_id].blank?
    @distinction = distinction_distinction_type.distinction
    
    if !distinction_distinction_type.blank?
      distinction_distinction_type.destroy
    end
    
    render :partial => 'distinction_types_form', :locals => { :distinction => @distinction }
  end  
end
