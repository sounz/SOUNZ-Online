module ImageMceAttachmentsHelper
  
  
  # -------------------------------------------------------------
  # - Update associated with object attachments                 -
  # - from a TinyMCE field                                      -
  # - Done it two stages:                                       -
  # - STAGE 1 save new object attachments,                      -
  # - STAGE 2 delete object attachments that are no longer in   -
  # - use                                                       -
  # -------------------------------------------------------------
  def self.update_object_attachments(field, model_id_string)
    RAILS_DEFAULT_LOGGER.debug "******* SAVE OBJECT ATTACHMENT ********"
    RAILS_DEFAULT_LOGGER.debug "** model_id_string: #{model_id_string}"
    
    bits = model_id_string.split("_")
    gid = bits.pop
    model_name = bits.join('_').camelize
    object = model_name.constantize.find(gid.to_i)
    
    klass = object.class.to_s.underscore
    
    # ids of media items inserted in the TinyMCE field - from UI   
    ui_media_items_ids = Array.new
      
    # existent object media items ids - from DB
    object_media_items_ids = object.media_items.collect{|mi| mi.media_item_id}
      
    if !field.blank? && !object.blank?
            
      # get media items ids from the content
      field.scan(/(id="media_item_[0-9]*")/) {|mi| 
        # get media item id
        mi = mi.to_s.gsub(/[^0-9]/, ' ')
        mi = mi.strip
        
        # does the media item exist?
        media_item = MediaItem.find(mi)
        
        if !media_item.blank?
          ui_media_items_ids.push(media_item.media_item_id)
          
          if !object_media_items_ids.include?(media_item.media_item_id)
          
            # STAGE 1 - create object attachment NewsArticleAttachment, CmContentAttachment for media item
            # that is not in object attachments already 
            attachment_class_string = object.class.to_s+"Attachment"
            
            RAILS_DEFAULT_LOGGER.debug "** attachment_class_string #{attachment_class_string}"
            attachment_class_string.gsub!("CampaignMailout", "Mailout") #fix for attachment table with non standard name
            attachment_class = attachment_class_string.constantize
            klass_attachment = attachment_class.send('new')
      
            RAILS_DEFAULT_LOGGER.debug "KLASS attachment is #{klass_attachment}"
            RAILS_DEFAULT_LOGGER.debug "Sending to klass_attachment: #{klass}_id, #{object.id}"
            klass_attachment.send(klass+"_id=",object.id)
            
            RAILS_DEFAULT_LOGGER.debug "klass attachment is now #{klass_attachment.to_yaml}"
            klass_attachment.media_item = media_item
      
            if klass_attachment.respond_to?('attachment_type_id')
              klass_attachment.attachment_type_id = AttachmentType::TINY_MCE.attachment_type_id
            end            
          
            # save object attachment
            if klass_attachment.save
              RAILS_DEFAULT_LOGGER.debug "*********** media item #{media_item} is added to #{klass_attachment} attachments "
              # update existent campaign_mailout media items ids
              object_media_items_ids.push(klass_attachment.media_item_id)
            else
              RAILS_DEFAULT_LOGGER.debug "*** ERROR: media item #{media_item} is NOT added to #{klass_attachment} attachments "
            end
          
          end     
        
        end 
      }
    end
    
    # STAGE 2 - delete media items from mailout_attachments,
    # if not in the main_content ( ui_media_items_ids )
    attachment_class_string = object.class.to_s+"Attachment"
    attachment_class_string.gsub!("CampaignMailout", "Mailout") #fix for attachment table with non standard name
    attachment_class = attachment_class_string.constantize
    query_string = klass + '_id =' + object.id.to_s
    object_attachments = attachment_class.find(:all, :conditions => query_string)     
   
    object_attachments.each do |ma|
      
      if !ui_media_items_ids.include?(ma.media_item_id) && (ma.attachment_type_id != AttachmentType::PDF.attachment_type_id)
        RAILS_DEFAULT_LOGGER.debug "********** media item #{ma.media_item} is to be deleted *****"
        ma.destroy
      end
    end
    
  end
end
