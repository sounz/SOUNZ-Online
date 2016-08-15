class CmContentsController < ApplicationController
  
  include StatusesHelper
  include ModelAsStringHelper
  include AttachmentHelper   
  include ApplicationHelper
  
      
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cm_contents = CmContent.paginate(:page => params[:page], :per_page => 50, :order => 'cm_content_title')
  end

  def show
    @cm_content = CmContent.find(params[:id])
    @page_title = @cm_content.cm_page_title if ! @cm_content.cm_page_title.blank?
    redirect_to :action => 'show_by_name', :name => @cm_content.cm_content_name
  end
  
  
  def show_by_name
    @name = params[:name]
    @cm_content = CmContent.find(:first, :conditions => ["cm_content_name = ?", @name])
    @page_title = @cm_content.cm_page_title if ! (@cm_content.blank? and @cm_content.cm_page_title.blank?)
	if @cm_content.blank?
      render :action => :content_error
    end
  end

  def new
    @cm_content = CmContent.new
    get_statuses(@cm_content)
  end
  
  def new_with_name
    @cm_content = CmContent.new
    get_statuses(@cm_content)
    @cm_content.cm_content_name = params[:id]
    render :action => 'new'
  end

  def create
    @cm_content = CmContent.new(params[:cm_content])
    @cm_content.login_updated_by = @login
        
    if @cm_content.save
      flash[:notice] = @cm_content.cm_content_title + ' was successfully created.'
      redirect_to :action => 'show_by_name', :name => @cm_content.cm_content_name
    else
       get_statuses(@cm_content)
      render :action => 'new'
    end
  end

  def edit
    @cm_content = CmContent.find(params[:id])
	@page_title = @cm_content.cm_page_title if ! @cm_content.cm_page_title.blank?
    get_statuses(@cm_content)
  end

  def update
    @cm_content = CmContent.find(params[:id])
    @cm_content.login_updated_by = @login
    if @cm_content.update_attributes(params[:cm_content])
      flash[:notice] = @cm_content.cm_content_title + ' was successfully updated.'
      
      
      
      ImageMceAttachmentsHelper.update_object_attachments(
        params[:cm_content][:cm_content],
        generate_id(@cm_content)
      )
      
      redirect_to :action => 'show_by_name', :name => @cm_content.cm_content_name
    else
      get_statuses(@cm_content)
      render :action => 'edit'
    end
  end

  def destroy
    CmContent.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  #FIXME - move this

    
  
   
end
