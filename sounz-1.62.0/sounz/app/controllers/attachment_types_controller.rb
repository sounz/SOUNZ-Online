class AttachmentTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
   @attachment_types = AttachmentType.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @attachment_type = AttachmentType.find(params[:id])
  end

  def new
    @attachment_type = AttachmentType.new
  end

  def create
    @attachment_type = AttachmentType.new(params[:attachment_type])
    if @attachment_type.save
      flash[:notice] = 'AttachmentType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @attachment_type = AttachmentType.find(params[:id])
  end

  def update
    @attachment_type = AttachmentType.find(params[:id])
    if @attachment_type.update_attributes(params[:attachment_type])
      flash[:notice] = 'AttachmentType was successfully updated.'
      redirect_to :action => 'show', :id => @attachment_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    AttachmentType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
