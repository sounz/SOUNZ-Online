class Sample < ActiveRecord::Base
  set_primary_key "sample_id"
  set_sequence_name "samples_sample_id_seq"
  
  belongs_to :status

  has_many :sample_attachments, :dependent => :destroy
  has_many :media_items, :through => :sample_attachments
  
  belongs_to :manifestation
  
#  validates_presence_of :sample_copyright
    validates_presence_of :sample_description
    validates_presence_of :status_id 
    
    #Updated by relationship 
    validates_presence_of :login_updated_by
    #validates_associated :login_updated_by

    belongs_to :login_updated_by, 
              :class_name => 'Login',
              :foreign_key => :updated_by


   #Return true if one of the sample attachments is audio
   def contains_audio?
     result = false
     sample_attachments.map{|sa| result = true if sa.is_audio?}
     result
   end

  #Return true if one of the sample attachments is video
  def contains_video?
    result = false
    sample_attachments.map{|sa| result = true if sa.is_video?}
    result
  end

  #Return true if one of the sample attachments is document
  def contains_document?
    result = false
    sample_attachments.map{|sa| result = true if sa.is_document?}
    result
  end

  #Return true if one of the sample attachments is image
  def contains_image?
    result = false
    sample_attachments.map{|sa| result = true if sa.is_image?}
    result
  end
  
  #Human readable version for website
  def copyright
    result = ""
    if !sample_copyright.blank?
      result = "&copy; "
      result << sample_copyright
      result.gsub!('(c)', '')
      
    end
    result
  end

end
