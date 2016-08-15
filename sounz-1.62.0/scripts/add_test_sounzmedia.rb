#!/usr/bin/env ../sounz/script/runner

#using an existing composer (/contributor/composer/1048) create a work, expression and test manifestations

USER = Login.find(1000)
COMPOSER = Contributor.find(1048)

def create_work(title)
  begin
    Work.transaction do    
      @work = Work.new
      @work.work_title = title
      @work.no_duration = false
      @work.difficulty_note = ""
      @work.commissioned_note = ""
      @work.iswc_code = ""
      @work.internal_note = ""
      @work.instrumentation = ""
      @work.programme_note = ""
      @work.dedication_note = ""
      @work.work_description = ""
      @work.duration_varies = "0"
      @work.year_of_revision = ""
      @work.contents_note = ""
      @work.text_note = ""
      @work.status_id = 3
      @work.difficulty = 0
      @work.year_of_creation = 2010
      @work.work_subcategory_id = 1
      @work.intended_duration = nil
      @work.login_updated_by = USER
      
      @work.superwork=Superwork.create(:superwork_title=>@work.work_title + " - " + COMPOSER.role.contributor_names,:updated_by=>USER.login_id,:status_id=>3)
      
      @composers = Array.new
      @composers.push(COMPOSER)
      @work.save_with_composers(@composers)
      @work.frbr_updateImplicitRelationships(USER.login_id)
      
      @work.save
    end
  end
  puts @work.to_yaml
    
  return @work
end

def create_expression(work)
  begin
    Expression.transaction do  
      @expression = Expression.new
      @expression.work = work
      @expression.expression_start = nil
      @expression.expression_finish = nil
      @expression.updated_by = USER.login_id
      @expression.duration = nil
      @expression.partial_expression = false
      @expression.general_note = ""
      @expression.internal_note = ""
      @expression.players_count = ""
      @expression.mode_id = 1
      @expression.expression_title = "SOUNZMEDIA Stub Expression"
      @expression.status_id = 3
      @expression.use_restriction_note = "available"
      @expression.edition = "ORG"
    
      @expression.save_with_frbr
    end
  end
  puts @expression.to_yaml
    
  return @expression
end

def create_manifestation(expression, sounzmedia, title, format, filename)
  manifestation_type_sounzmedia = ManifestationType.find(:first, :conditions => ["manifestation_type_desc = 'Media on Demand'"]).manifestation_type_id
  begin
    Manifestation.transaction do
    @manifestation = Manifestation.new
    @manifestation.manifestation_title_alt = ""
    @manifestation.freight_code = ""
    @manifestation.publisher_note = ""
    @manifestation.download_file_name = ""
    @manifestation.isbn = ""
    @manifestation.ismn = ""
    @manifestation.imprint = ""
    @manifestation.parts_location_external = ""
    @manifestation.general_note = "description"
    @manifestation.internal_note = ""
    @manifestation.available_for_hire = false
    @manifestation.clonable  = false
    @manifestation.downloadable = false
    @manifestation.sounzmedia = sounzmedia
    @manifestation.dedication_note = ""
    @manifestation.format_id =  format
    @manifestation.mw_code = ""
    @manifestation.publication_year = 2010
    @manifestation.isrc = ""
    @manifestation.copyright = ""
    @manifestation.available_for_loan = false
    @manifestation.status_id = 3
    @manifestation.manifestation_title = title
    @manifestation.series_title = ""
    @manifestation.manifestation_type_id = manifestation_type_sounzmedia
    @manifestation.collation = ""
    @manifestation.available_for_sale = false
    @manifestation.duration = nil
    @manifestation.updated_by = USER.login_id
    
    @manifestation.add_expression(expression)
    
    if !@manifestation.save
      puts "Save failed"
    end
    end
  rescue Exception => e
    puts  e.message
  end
  puts   @manifestation.to_yaml
  create_attachment(@manifestation, filename)
end

#image files need to be in /tmp and of content type jpg
def create_attachment(manifestation, filename)
  require 'action_controller/assertions'
  require 'action_controller/test_case'
  require 'action_controller/test_process'
  @frbr_object = manifestation
  klass = @frbr_object.class.to_s.underscore
  begin MediaItem.transaction 
    @media_item = upload_file :filename =>  filename
    @media_item.copyright = "SOUNZ"
    @media_item.updated_by = USER.login_id
    @media_item.save 

    #Create a new class for the attachment for main image
    attachment_class_string = @frbr_object.class.to_s+"Attachment"
    attachment_class = attachment_class_string.constantize
    @klass_attachment = attachment_class.send('new')
    @klass_attachment.send(klass+"_id=",@frbr_object.id)
    @klass_attachment.media_item = @media_item
    @klass_attachment.attachment_type = AttachmentType::MAIN_IMAGE
    @klass_attachment.save
    puts @klass_attachment.to_yaml
    @frbr_object.save # This will save the attachment
    puts "Media Item created"
  end
end

def upload_file(options = {})
  use_temp_file options[:filename] do |file|
    att = MediaItem.create :uploaded_data => fixture_file_upload(file, options[:content_type] || 'image/jpg')
    att.reload unless att.new_record?
    return att
  end
end

def use_temp_file(fixture_filename)
  fixture_path = '/tmp'
  temp_path = File.join('/tmp', File.basename(fixture_filename))
  FileUtils.mkdir_p File.join(fixture_path, 'tmp')
  FileUtils.cp File.join(fixture_path, fixture_filename), File.join(fixture_path, temp_path)
  yield temp_path
ensure
  FileUtils.rm_rf File.join(fixture_path, 'tmp')
end
    
def fixture_file_upload(path, mime_type = nil, binary = false)

  ActionController::TestUploadedFile.new(
    Test::Unit::TestCase.respond_to?(:fixture_path) ? Test::Unit::TestCase.fixture_path + path : path, 
    mime_type,
    binary
  )
end
    
#work = create_work("SOUNZMEDIA Stub Work")
#expression = create_expression(work)

#expression = Expression.find(15040)

embedded_format_id = Format.find(:first, :conditions => ["format_desc='embedded'"]).format_id
internal_audio_format_id = Format.find(:first, :conditions => ["format_desc='internal - audio'"]).format_id
internal_video_format_id = Format.find(:first, :conditions => ["format_desc='internal - video'"]).format_id
external_video_format_id = Format.find(:first, :conditions => ["format_desc='external - video'"]).format_id
external_audio_format_id = Format.find(:first, :conditions => ["format_desc='external - audio'"]).format_id

filename_embedded = "schemata_thumb.jpg"
filename_internal = "vers_libre_image.jpg"
filename_ross = "ross.jpg"

chris_exp_embedded = Expression.find(13774)
chris_exp_internal = Expression.find(12027)
ross_exp_internal = Expression.find(15615)

create_manifestation(chris_exp_embedded, "<object width=\"400\" height=\"300\"><param name=\"allowfullscreen\" value=\"true\" /><param name=\"allowscriptaccess\" value=\"always\" /><param name=\"movie\" value=\"http://vimeo.com/moogaloop.swf?clip_id=6773478&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=&amp;fullscreen=1&amp;autoplay=0&amp;loop=0\" /><embed src=\"http://vimeo.com/moogaloop.swf?clip_id=6773478&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=&amp;fullscreen=1&amp;autoplay=0&amp;loop=0\" type=\"application/x-shockwave-flash\" allowfullscreen=\"true\" allowscriptaccess=\"always\" width=\"400\" height=\"300\"></embed></object>", "Chris Watson: schemata; video", embedded_format_id, filename_embedded)
create_manifestation(chris_exp_internal, "vers_libre_hard_file.flv", "Chris Watson: …vers libre…; video", internal_video_format_id, filename_internal)
create_manifestation(ross_exp_internal, "voglenish_320k.mp3", "Ross Harris: voglenish 320k", internal_audio_format_id, filename_ross)
create_manifestation(ross_exp_internal, "voglenish_128k.mp3", "Ross Harris: voglenish 128k", internal_audio_format_id, filename_ross)

