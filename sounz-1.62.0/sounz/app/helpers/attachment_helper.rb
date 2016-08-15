module AttachmentHelper
  
  #Find all of the media items for a given FRBR model
  #Note this method is misnamed
  def attachments(frbr_instance)
      #klass = frbr_instance.class.to_s.downcase
      klass = frbr_instance.class.to_s.tableize.singularize
      klass.gsub!("campaignmailout", "campaign_mailout")
      
      query = "media_item_id in (select media_item_id from #{klass}_attachments where #{klass}_id = ?)"
      query.gsub!("campaign_mailout_attachments","mailout_attachments")
      media_items = MediaItem.find(:all, 
      :conditions => [query, 
        frbr_instance.send("#{klass}_id")])
      media_items
  end
  
  #This is a method on an instance
  def self.attachment_objects(frbr_instance)
    frbr_instance.send("#{frbr_instance.class.to_s.tableize.singularize}_attachments")
  end
  
  
  
  #From a list of attachment objects, get all those of a particular attachment type
  def self.attachments_of_type(the_attachments, attachment_type)
    result = []
    for attachment in the_attachments
      result << attachment if attachment.attachment_type == attachment_type
    end
    result
  end
  
  
  #Find a search image using the following algorithm:
  # - start with an image of type icon image
  # - if you cant find one use the main image
  # return the HTML for a thumbnail of that image
  def self.find_search_image(frbr_instance)
    all_attachments = attachment_objects(frbr_instance)
    possible_search_images = attachments_of_type(all_attachments, AttachmentType::ICON_IMAGE)
    if possible_search_images.length == 0
      possible_search_images = attachments_of_type(all_attachments, AttachmentType::MAIN_IMAGE)
    end
    result = nil
    result = possible_search_images[0] if possible_search_images.length > 0
    result
  end
  
  
  #Find a front page image using the following algorithm:
  # - start with an image of type icon image
  # - if you cant find one use the main image
  # - if the icon image is too small use the main image
  # return the HTML for a thumbnail of that image
  def self.find_front_page_image(frbr_instance)
    all_attachments = attachment_objects(frbr_instance)
    possible_search_images = attachments_of_type(all_attachments, AttachmentType::ICON_IMAGE)
   
    if possible_search_images.length == 0 
      possible_search_images = attachments_of_type(all_attachments, AttachmentType::MAIN_IMAGE)
    #Check for size also
    else
       media_item = possible_search_images[0].send('media_item')
       RAILS_DEFAULT_LOGGER.debug "MEDIAITEM IS NIL? #{media_item == nil}"
       
       #Seems to be a problem with some manifestation images having nil height and width - if this
       #is the case use the main image
       if media_item.width != nil
         if ((media_item.width < HomeHelper::DESIRED_WIDTH) || (media_item.height< HomeHelper::DESIRED_HEIGHT))
           possible_search_images = attachments_of_type(all_attachments, AttachmentType::MAIN_IMAGE)
         end
       else
        possible_search_images = attachments_of_type(all_attachments, AttachmentType::MAIN_IMAGE)
       end
    end
    result = nil
    result = possible_search_images[0] if possible_search_images.length > 0
    result
  end
  
  
  def self.find_main_image(frbr_instance)
    all_attachments = attachment_objects(frbr_instance)
    main_images = attachments_of_type(all_attachments, AttachmentType::MAIN_IMAGE)
 
    result = nil
    result = main_images[0] if main_images.length > 0
    result
  end
  
  
  
  def self.render_search_image(frbr_instance, size_sym)
    search_image_attachment = find_search_image(frbr_instance)
    result = ""
    if !search_image_attachment.blank?
      result = render_image(search_image_attachment, "Search", frbr_instance.frbr_list_title, size_sym)
    end
  end
  
  def self.render_main_image(frbr_instance, size_sym)
    search_image_attachment = find_search_image(frbr_instance)
    result = render_image(search_image_attachment, "Search", frbr_instance.frbr_list_title, size_sym)
  end
  
  private 
  
  #REnder an image or an empty string, keeps the view code tidier
  def self.render_image(an_attachment, mode, title, size_sym)
    if !an_attachment.blank?
      if an_attachment.media_item.image?
        result = '<img src="'
        result << an_attachment.media_item.public_filename(size_sym)
        result << '" alt="'
        result << "#{mode} image for #{title}"
        result << '"/>'
      end
    end
  end
  
end
