class AttachmentController < ApplicationController
  include ModelAsStringHelper
  include AttachmentHelper
  
  def new_attachment_form
    frbr_model_as_string = params[:id]
    @frbr_object = convert_id_to_model(frbr_model_as_string)
     @mode = params[:mode]
     get_attachment_types(@frbr_object)
     @attachment_type = AttachmentType::new
    render :partial => 'shared/attachments/attachment_form', 
    :locals => {:object => @frbr_object, :submission => :new, :mode => @mode}
  end
  

  
  def cancel_add_attachment_form
    frbr_model_as_string = params[:id]
    @mode = params[:mode]
    @frbr_object = convert_id_to_model(frbr_model_as_string)
    render :partial => 'shared/attachments/new_attachment_form_button', :locals => {:object => @frbr_object,
                                                                                    :mode => @mode}
    
  end
  
  
  #-- FRBR attachments -
  # Input:
  #    params[:frbr][:object] - contains a string like 'manifestation_7569, representing Manifestation.find(7569)
  def update_attachment
    logger.debug "==== Create attachment ===="
    frbr_model_as_string = params[:frbr][:object]
    @frbr_object = convert_id_to_model(frbr_model_as_string)
    klass = @frbr_object.class.to_s.underscore
   
    logger.debug "Klass is #{klass}"
    
    valid = false
    begin MediaItem.transaction 
      @media_item = convert_id_to_model(params[:media_item][:id])
      
      show_params(params)
      @media_item.update_attributes(params[:media_item]) 
      @media_item.updated_by = @login.login_id
      logger.debug "** MEDIA ITEM UPDATED BY IS #{@media_item.updated_by}"
      
      valid = @media_item.save
      
      #get the attachment type from the drop down
      type_id = params[:attachment_type][:attachment_type_id]
      logger.debug "TYPE_ID: #{type_id}"
      raise ArgumentError, "Please provide an attachment type" if type_id.blank?
        
      #now check its valid
      new_attachment_type = AttachmentType.find(type_id)
      raise ArgumentError, "The selected attachment type of id #{type_id} is invalid" if new_attachment_type.blank?
      logger.debug "NEW ATT TYPE: #{new_attachment_type}"
     
     attachment_klass = (@frbr_object.class.to_s+"Attachment").constantize
     frbr_class_id = "#{@frbr_object.class.to_s.tableize.singularize}_id"
     attachments = attachment_klass.find(:all, 
      :conditions => ["media_item_id=? and #{frbr_class_id} = ?", 
          @media_item.media_item_id, 
          @frbr_object.send(frbr_class_id)]
      )
      for attach in attachments
        attach.attachment_type = new_attachment_type
        attach.save!
      end

    #Rescue a failed transaction
    rescue Exception => e
        logger.debug "Transaction was invalid"
        logger.debug "AttachmentException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        @error_message = "The upload failed, the error was #{e.message}"
        valid = false
    end

    respond_to do |format|
      if valid
        logger.debug "Valid response"
        flash[:attachment] = 'MediaItem was successfully updated.'
        
        #This is rather naughty... 
        #See http://khamsouk.souvanlasy.com/2007/5/1/ajax-file-uploads-in-rails-using-attachment_fu-and-responds_to_parent for background
        #Without the option of forcing .js routing from a form tag (as opposed to remote form tag) the
        #HTML response is doing javascript manipulation of the page
        format.html do
          logger.debug "VALID RESPONSE, HTML"
          responds_to_parent do
             @media_items = attachments(@frbr_object)
            render :update do |page|
  
              # Hide the form and redraw the media item
              gid = generate_id(@media_item)
               page.replace_html gid, :partial => 'shared/attachments/edit_media_item',
                    :locals => {:media_item => @media_item, :object => @frbr_object}
              
               page.visual_effect :highlight, gid
              
            end
          end
        end
        format.xml  { head :created, :location => media_item_url(@media_item) }
        
      else
        logger.debug "Response for invalid option"
        flash[:attachment] = 'The file upload failed for some reason'
        format.html { 
          #prepare_edit
          
          responds_to_parent do
            render :update do |page|
              page.replace_html 'uploadWidget', :partial => 'shared/attachments/upload_widget'
              page.visual_effect :shake, 'uploadWidget'
              page << "alert('#{@error_message}');"
            end
          end
           }
        format.xml  { render :xml => @media_item.errors.to_xml }
     
      end
    end
  end
  
=begin

<form target="upload_frame" name="uploadForm" method="post" enctype="multipart/form-data" action="/attachment/create_attachment">
<input id="frbr_object" type="hidden" value="cm_content_2" name="frbr[object]"/>
<input id="attachment_mode_mode" type="hidden" value="tiny_mce" name="attachment_mode[mode]"/>
<table>
=end
  #-- FRBR attachments -
  # Input:
  #    params[:frbr][:object] - contains a string like 'manifestation_7569, representing Manifestation.find(7569)
  def create_attachment
    @mode = params[:mode]
    logger.debug "==== Create attachment ===="
    frbr_model_as_string = params[:frbr][:object]
    @mode = params[:attachment_mode][:mode]
    @frbr_object = convert_id_to_model(frbr_model_as_string)
    klass = @frbr_object.class.to_s.underscore
    
    logger.debug "Klass is #{klass}"
    
    valid = false
    begin MediaItem.transaction 
      @media_item = MediaItem.new(params[:media_item])
      @media_item.updated_by = @login.login_id
      logger.debug "** MEDIA ITEM UPDATED BY IS #{@media_item.updated_by}"
      logger.debug @media_item.to_yaml
      @media_item.save 
      logger.debug "MEDIA ITEM SAVED"
      
      #Create a new class for the attachment, such as SampleAttachment, VenueAttachment etc
      attachment_class_string = @frbr_object.class.to_s+"Attachment"
      attachment_class_string.gsub!("CampaignMailout", "Mailout") #fix for attachment table with non standard name
      attachment_class = attachment_class_string.constantize
      @klass_attachment = attachment_class.send('new')
      
      logger.debug "KLASS attachment is #{@klass_attachment}"
      logger.debug "Sending to klass_attachment: #{klass}_id, #{@frbr_object.id}"
      @klass_attachment.send(klass+"_id=",@frbr_object.id)
      #@klass_attachment.send("manifestation_id",@frbr_object.id)
      logger.debug "klass attachment is now #{@klass_attachment.to_yaml}"
      @klass_attachment.media_item = @media_item
      
      if @klass_attachment.respond_to?('attachment_type_id')
        if @mode == 'tiny_mce'
           @klass_attachment.attachment_type_id = AttachmentType::TINY_MCE.attachment_type_id
        else
         
        
          #get the attachment type from the drop down
          type_id = params[:attachment_type][:attachment_type_id]
          logger.debug "TYPE_ID: #{type_id}"
          raise ArgumentError, "Please provide an attachment type" if type_id.blank?
        
          #now check its valid
          new_attachment_type = AttachmentType.find(type_id)
          raise ArgumentError, "The selected attachment type of id #{type_id} is invalid" if new_attachment_type.blank?
          logger.debug "NEW ATT TYPE: #{new_attachment_type}"
          @klass_attachment.attachment_type = new_attachment_type
          
        end
      end
      
      @klass_attachment.save
      valid = @frbr_object.save # This will save the attachment
      logger.debug "Media Item created"
    #Rescue a failed transaction
    rescue Exception => e
        logger.debug "Transaction was invalid"
         logger.debug "AttachmentException: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        @error_message = "The upload failed, the error was #{e.message}"
        valid = false
   end

    respond_to do |format|
      if valid
        logger.debug "Valid response"
        flash[:attachment] = 'MediaItem was successfully created.'
        
        #This is rather naughty... 
        #See http://khamsouk.souvanlasy.com/2007/5/1/ajax-file-uploads-in-rails-using-attachment_fu-and-responds_to_parent for background
        #Without the option of forcing .js routing from a form tag (as opposed to remote form tag) the
        #HTML response is doing javascript manipulation of the page
        format.html do
          logger.debug "VALID RESPONSE, HTML"
          responds_to_parent do
             @media_items = attachments(@frbr_object)
            render :update do |page|
              edit_media_item_form = 'shared/attachments/edit_media_item'
              # special case for campaign mailouts
              edit_media_item_form = 'campaign_mailouts/media_item' if @frbr_object.class.to_s.match('CampaignMailout')
              
              page.insert_html :bottom, "attachments_"+generate_id(@frbr_object),
               :partial => edit_media_item_form, :locals => {:object => @frbr_object, :media_item => @media_item, :mode => @mode.to_sym}
               #Clear the text field of the image upload
              # page.replace_html 'uploadWidget', :partial => 'shared/attachments/upload_widget'
               page.replace_html 'new_attachment_form_'+generate_id(@frbr_object), :partial => 'shared/attachments/new_attachment_form_button', :locals => {:object => @frbr_object, :mode => @mode.to_sym}
              
               page.visual_effect :highlight, generate_id(@media_item)
              
            end
          end
        end
        format.xml  { head :created, :location => media_item_url(@media_item) }
        
      else
        logger.debug "Response for invalid option"
        flash[:attachment] = 'The file upload failed for some reason'
        
        #Ensure rendering in case where user does not select an attachment type
        @attachment_type = AttachmentType.new if @attachment_type.blank?
        format.html { 
          #prepare_edit
                get_attachment_types(@frbr_object)
          responds_to_parent do
            render :update do |page|
             
              dom_id = 'new_attachment_form_'+generate_id(@frbr_object)
        
              page.replace_html  dom_id,
                :partial => 'shared/attachments/attachment_form',
                :locals => {:object => @frbr_object, :submission => :new, :media_item => @media_item, :mode => @mode}
              page.visual_effect :shake, dom_id
               page << "alert('#{@error_message}');"
            end
          end
           }
        format.xml  { render :xml => @media_item.errors.to_xml }
     
      end
    end
  end
  
  
  def delete_attachment
    logger.debug "=== DELETE ATTACHMENT ==="
    @media_item = MediaItem.find(params[:media_item_id])
    @dom_id = generate_id(@media_item)
    get_frbr_object_from_id
    logger.debug "FRBR MODEL IS "+generate_id(@frbr_object)
    
    klass = @frbr_object.class.to_s.underscore
    
    #Create a new class for the attachment, such as SampleAttachment, VenueAttachment etc
    attachment_class_string = @frbr_object.class.to_s+"Attachment"
    attachment_class_string.gsub!("CampaignMailout", "Mailout") #fix for attachment table with non standard name
    attachment_class = attachment_class_string.constantize
    
    #Now find the attachment
    klass_attachment = attachment_class.send('find',:first,
    :conditions => ["#{klass}_id = ? and media_item_id = ?", @frbr_object.send("#{klass}_id"),
       @media_item.media_item_id]
    )
    
    logger.debug "klass attachment is #{klass_attachment.to_yaml}"
    klass_attachment.destroy
    
    render :update do |page|
      page.visual_effect :highlight, @dom_id
      page.visual_effect :fade, @dom_id
       page.visual_effect :fold, @dom_id
    end
 
  end
  
  # To update an attachment we replace the the contents of the li element,
  # demarcated by the id of the media item, with a form to update the media item
  def show_update_attachment_form
    show_params(params)
    get_frbr_object_from_id
    logger.debug "+++++ UPDATE ATTACHMENT +++++"
    @media_item = MediaItem.find(params[:media_item_id])
    get_attachment_types(@frbr_object)
    @mode = params[:mode]
    #we need the attachment type
    
    attachment_klass = (@frbr_object.class.to_s+"Attachment").constantize
     frbr_class_id = "#{@frbr_object.class.to_s.tableize.singularize}_id"
     attachments = attachment_klass.find(:all, 
      :conditions => ["media_item_id=? and #{frbr_class_id} = ?", 
          @media_item.media_item_id, 
          @frbr_object.send(frbr_class_id)]
      )
      
    #There should be one
    @attachment_type = attachments[0].attachment_type
      
      logger.debug "ATTACHMENTS ARE:#{attachments} of len #{attachments.length}"
      logger.debug "ATT TYPE:#{@attachment_type.attachment_type_desc}"
      
      
  
    render :partial => 'shared/attachments/attachment_form',
     :locals => {:object => @frbr_object, :submission => :update, :media_item => @media_item, :mode => @mode}
  end
  
  
  def cancel_update_attachment_form
    @media_item = convert_id_to_model(params[:media_item_id])
    get_frbr_object_from_id
    @is_after_cancel = true
    render :partial => 'shared/attachments/edit_media_item',
     :locals => {:media_item => @media_item, :object => @frbr_object} 
  end
  
  
protected
  def get_frbr_object_from_id
    frbr_model_as_string = params[:id]
    @frbr_object = convert_id_to_model(frbr_model_as_string)
  end
  
  
  def get_attachment_types(frbr_object)
     @attachment_types = AttachmentType.find(:all, :order => :display_order)  
  end
  
end
