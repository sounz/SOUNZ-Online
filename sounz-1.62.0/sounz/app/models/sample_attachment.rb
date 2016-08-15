class SampleAttachment < ActiveRecord::Base
set_primary_key "sample_attachment_id"
set_sequence_name "sample_attachments_sample_attachment_id_seq"

belongs_to :media_item
belongs_to :sample
belongs_to :attachment_type


VIDEO_EXTENSIONS = ['mpg','flv','mpeg', 'mp4', 'divx','mp2']

AUDIO_EXTENSIONS = ['mp3','ogg', 'ram']

DOCUMENT_EXTENSIONS = ['doc', 'pdf']

IMAGE_EXTENSIONS = ['jpg', 'jpeg', 'gif', 'tiff']

  #is this sample attachment video?
  def is_video?
    check_extension(VIDEO_EXTENSIONS)
  end

  #is this sample attachment audio?
  def is_audio?
    check_extension(AUDIO_EXTENSIONS)
  end

  #is this sample attachment is a document?
  def is_document?
    check_extension(DOCUMENT_EXTENSIONS)
  end

  #is this sample attachment video?
  def is_image?
    check_extension(IMAGE_EXTENSIONS)
  end
  
  
private
  #Check if the filename of a sample attachment is in an array.  Note this is case insensitive :)
  def check_extension(array_to_check)
    result = false
    if !media_item.filename.blank?
      splits = media_item.filename.split('.')
      #puts splits.length
      if splits.length > 1
        extension = splits.last.downcase
       # puts "EXT:#{extension}"
        result = array_to_check.include?(extension)
      end
    end
    result
  end

end
