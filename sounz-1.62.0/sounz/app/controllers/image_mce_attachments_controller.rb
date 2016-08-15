class ImageMceAttachmentsController < ApplicationController

  include ModelAsStringHelper
  
  
  #Entry point is /index/<model_name_plural>?source_id=N
  #e.g. /index/cm_contents/10
  def index
    @relevant_object = get_object(params[:id], params[:source_object_id])
    @images = @relevant_object.media_items
    
    #Note the name of the table has been checked for validity in get_object method
    #An argument exception is thrown
    attachments_table_name = params[:id].singularize+"_attachments"
    query_main = "DISTINCT(media_item_id), media_item_desc, filename, updated_at "
    query_join = " inner join #{attachments_table_name} using (media_item_id)"
    @images = MediaItem.find(:all, :select => query_main, 
                                    :joins => query_join,
                                    :order => 'updated_at desc')
    
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
    @attachments = MailoutAttachment.paginate(:page => parmas[:page], :per_page => 10)
  end

  def show
    @mailout_attachment = MailoutAttachment.find(params[:id])
  end

  
  #get the images for this item only
  def item_only_attachments
    @relevant_object = convert_id_to_model(params[:id])
    @images = @relevant_object.media_items
  end


  #get the images for any items of the same class
  def all_group_attachments
    @relevant_object = convert_id_to_model(params[:id])
    @images = get_all_media_items_for_model_type(@relevant_object.class.to_s.tableize)
  end
  
  #grab all the images used for MCE, ie those in news articles, content managed pages and mailouts
  def all_mce_attachments
    @relevant_object = convert_id_to_model(params[:id])
    @images = get_all_images_used_in_mce
  end


  private
  
  def get_object(controller_class,id)
    raise ArgumentError, "Cannot add tiny mce images to class #{controller_class}" if !["cm_contents", "news_articles"].include?controller_class
    controller_class.singularize.camelize.constantize.find(id)
  end
  
  
  def get_all_images_used_in_mce
    @images = get_all_media_items_for_model_type('cm_content')+
              get_all_media_items_for_model_type('news_article')+
              get_all_media_items_for_model_type('mailout')
    
  end
  
  

  
  
  
  
  
  
  
  #Get all the images for a model name (e.g. 'cm_content')
  def get_all_media_items_for_model_type(model_name)
    attachments_table_name = model_name.tableize.singularize+"_attachments"
    query_main = "DISTINCT(media_item_id), media_item_desc, filename, updated_at "
    query_join = " inner join #{attachments_table_name} using (media_item_id)"
    @images = MediaItem.find(:all, :select => query_main, 
                                      :joins => query_join,
                                      :order => 'updated_at desc')
      @images
    
  end
  
end
