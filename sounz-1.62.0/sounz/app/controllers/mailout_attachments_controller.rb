class MailoutAttachmentsController < ApplicationController
  def index
    @mailout_images = MediaItem.find(:all, :select => "DISTINCT(media_item_id), media_item_desc, filename", 
                                     :joins => "inner join mailout_attachments using (media_item_id)")
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @mailout_images.to_xml }
      format.js
    end
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @mailout_attachments = MailoutAttachment.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @mailout_attachment = MailoutAttachment.find(params[:id])
  end

  def new
    @mailout_attachment = MailoutAttachment.new
  end

  def create
    @mailout_attachment = MailoutAttachment.new(params[:mailout_attachment])
    if @mailout_attachment.save
      flash[:notice] = 'MailoutAttachment was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @mailout_attachment = MailoutAttachment.find(params[:id])
  end

  def update
    @mailout_attachment = MailoutAttachment.find(params[:id])
    if @mailout_attachment.update_attributes(params[:mailout_attachment])
      flash[:notice] = 'MailoutAttachment was successfully updated.'
      redirect_to :action => 'show', :id => @mailout_attachment
    else
      render :action => 'edit'
    end
  end

  def destroy
    MailoutAttachment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
