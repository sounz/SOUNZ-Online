class MediaItemsController < ApplicationController
  # GET /media_items
  # GET /media_items.xml
  def index
    @media_items = MediaItem.find(:all, :conditions => {:parent_id => nil}, :order => 'media_item_id DESC')

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @media_items.to_xml }
    end
  end

  # GET /media_items/1
  # GET /media_items/1.xml
  def show
    @media_item = MediaItem.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @media_item.to_xml }
    end
  end

  # GET /media_items/new
  def new
    @media_item = MediaItem.new
  end

  # GET /media_items/1;edit
  def edit
    @media_item = MediaItem.find(params[:id])
  end

  # POST /media_items
  # POST /media_items.xml
  def create
    @media_item = MediaItem.new(params[:media_item])

    respond_to do |format|
      if @media_item.save
        flash[:notice] = 'MediaItem was successfully created.'
        format.html { redirect_to media_item_url(@media_item) }
        format.xml  { head :created, :location => media_item_url(@media_item) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @media_item.errors.to_xml }
      end
    end
  end

  # PUT /media_items/1
  # PUT /media_items/1.xml
  def update
    @media_item = MediaItem.find(params[:id])

    respond_to do |format|
      if @media_item.update_attributes(params[:media_item])
        flash[:notice] = 'MediaItem was successfully updated.'
        format.html { redirect_to media_item_url(@media_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @media_item.errors.to_xml }
      end
    end
  end

  # DELETE /media_items/1
  # DELETE /media_items/1.xml
  def destroy
    @media_item = MediaItem.find(params[:id])
    @media_item.destroy

    respond_to do |format|
      format.html { redirect_to media_items_url }
      format.xml  { head :ok }
    end
  end
  
  
  
  def download
    @media_item = MediaItem.find(params[:id])
    send_file("#{RAILS_ROOT}/public"+@media_item.public_filename, 
      :disposition => 'attachment',
      :encoding => 'utf8', 
      :type => @media_item.content_type,
      :filename => URI.encode(@media_item.filename)) 
  end
  
  
  #This is shown as a popup
  def show_flash_video
    @media_item = MediaItem.find(params[:id])
    render :layout => 'flash_popup'
  end
  
  def show_flash_video_for_sample
    @sample_attachment = SampleAttachment.find(params[:id])
    @media_item = @sample_attachment.media_item
    @sample = @sample_attachment.sample
    render :layout => 'flash_popup'
  end
  
  #This is shown as a popup
  def show_flash_music
    @media_item = MediaItem.find(params[:id])
    render :layout => 'flash_popup'
  end
  
  def show_flash_music_for_sample    
    @sample_attachment = SampleAttachment.find(params[:id])
    @media_item = @sample_attachment.media_item
    @sample = @sample_attachment.sample
    render :layout => 'flash_popup'
  end
end
