class MediaItem < ActiveRecord::Base
set_primary_key "media_item_id"
set_sequence_name "media_items_media_item_id_seq"
belongs_to :mime_type


  has_attachment  :storage => :file_system, 
                  :max_size => 10.megabytes,
                  :thumbnails => { :thumb => '80x80>', :normal => '300x300>', :large => '500x500>' },
                                    :processor => :rmagick # attachment_fu looks in this order: ImageScience, Rmagick, MiniMagick

  validates_as_attachment # ok two lines if you want to do validation, and why wouldn't you?

has_one :contributor_attachment
has_one :work_attachment

has_many :sample_attachments, :dependent => :destroy
has_many :samples, :through => :sample_attachments

has_many :manifestation_attachments
has_many :manifestations, :through => :manifestation_attachments

has_many :work_attachments
has_many :works, :through => :work_attachments

has_many :resource_attachments
has_many :resources, :through => :resource_attachments

has_many :contributor_attachments
has_many :contributors, :through => :contributor_attachments

   
has_many :person_attachments
has_many :people, :through => :person_attachments

has_many :organisation_attachments
has_many :organisations, :through => :organisation_attachments

has_many :event_attachments
has_many :events, :through => :event_attachments

has_many :cm_content_attachments
has_many :cm_contents, :through => :cm_content_attachments

has_many :mailout_attachments
has_many :campaign_mailouts, :through => :mailout_attachments

has_many :news_article_attachments
has_many :news_articles, :through => :news_article_attachments

#Updated by relationship 
#FIXME GBA 17 July 2007 - this does not for some reason appear to work correctly, its impossible to create
# a new media item unless this is turned off, even though the updated by flag is set.
#validates_presence_of :login_updated_by
#validates_associated :login_updated_by

belongs_to :login_updated_by, 
          :class_name => 'Login',
          :foreign_key => :updated_by


AUDIO = 'audio'
PDF='application/pdf'

MIME_TYPE_ICONS = {"application/pdf" => 'acroread.png'}


#Helper method for the views
def mime_type_and_size
#(<%=media_item.content_type%>, <%=bytes_to_size(media_item.size)%>)
  result = ""
  if !content_type.blank?
    result << content_type
  end
  
  if !size.blank?
    result << ', ' if !result.blank?
    result << bytes_to_size(size)
  end
    
  result = '(' << result << ')' if !result.blank?
end


def size_as_string
  result = ""
  if !size.blank?
    result << bytes_to_size(size)
  end
  result
end


def bytes_to_size(bytes)
  return (bytes/1024).to_s+"k"
end

#FIXME - use foreign key into other table - this is what the plugin returns
def mime_type
  return content_type
end


#Is this representing a PDF?
def is_pdf?
  mime_type == PDF
end


#Check if the mime type is audio/XXXX and return true if it is
def is_audio?
  result = false
  if !mime_type.blank?
      splits = mime_type.split('/')
      if splits[0] == AUDIO
        result = true
      end
  end
  
  result
end


#Check to see if the media item is an mp3, for the purposes of flash player rendering
def is_mp3?
  if filename != nil
  filename.ends_with?('.mp3')
  else
  false
  end
end


#Check to see if the media item is flash video, for the purposes of flash player rendering
def is_flv?
  if filename != nil
  filename.ends_with?('.flv')
  else
  false
  end
end


#FIXME - future expansion?
def is_video?
  return false
end


def name
  result = "NO filename recorded"
  result = filename if !filename.blank?
  result
end

#Return either the caption or the filename if the caption does not exist
def rendered_name
  result = filename
  result = caption if !caption.blank?
  result
end

#Return an appropriate icon for the mime type or failing that a generic one.
#The content type field is used here
def mime_type_icon_path
  result = "mime.png"
  
  matched_icon = MIME_TYPE_ICONS[mime_type]
  if !matched_icon.blank?
    result = "#{matched_icon}"
  elsif is_flv?
      result = "video.png"
  end
  
  "/icons/16x16/"<<result
end


end
