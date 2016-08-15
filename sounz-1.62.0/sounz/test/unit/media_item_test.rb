require File.dirname(__FILE__) + '/../test_helper'

class MediaItemTest < Test::Unit::TestCase
  
  def setup
    @media_item = MediaItem.find(:first)
  end

  def test_audio_mime_type
    @media_item.content_type = 'audio/mp3'
    assert @media_item.is_audio? == true
    assert @media_item.is_pdf? == false
  end
  
  def test_pdf_mime_type
    @media_item.content_type = 'application/pdf'
    assert @media_item.is_audio? == false
    assert @media_item.is_pdf? == true
    puts "** icon is #{@media_item.mime_type_icon_path}"
  end
  
end
