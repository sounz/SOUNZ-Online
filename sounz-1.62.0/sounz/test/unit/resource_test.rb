require File.dirname(__FILE__) + '/../test_helper'

class ResourceTest < Test::Unit::TestCase
  
  def setup
    @resource = Resource.find(:first)
  end
  

  #Some of these copied from the similar manifestations

  def test_invalid_durations
    for invalid_duration in ["12:10","poaiopsdf", "oisadfioasdiofuo", "123786", "20 past 7", " a while", "20 minutes long"]
      @resource.duration = invalid_duration
      assert !@resource.save
    end
    
    @resource.duration = "1:2:3"
    assert !@resource.save
    
    @resource.duration = "00:20:3"
    assert !@resource.save
    
    @resource.duration = "00:2:30"
    assert !@resource.save
    
    @resource.duration = ":2:30"
    assert !@resource.save
  end
  
  
  
  def test_necessary_author_note
    @resource.author_note = nil
    assert !@resource.save
  end 
  
  
  #== optional fields ==
  def test_optional_fields
    fields = ['resource_code', 'resource_date', 'physical_description', 'publication_year','isbn','ismn','isrc']
    fields = fields + ['imprint', 'collation', 'general_note', 'internal_note', 'contents_note', 'copyright', 'duration']

    
    for field in fields
      @resource.send(field << '=' , nil)
      assert @resource.save
    end
  end
  
  
  def test_nil_duration
    @resource.duration = nil
    assert @resource.save
  end
  
  def test_empty_format
    @resource.format = nil
    assert !@resource.save
  end
  
  def test_empty_type
    @resource.resource_type = nil
    assert !@resource.save
  end
  
  
  def test_duration_hours_mins_secs
    @resource.duration = "1:20:30"
    assert @resource.save
    
    @resource.duration = "1001:20:30"
    assert @resource.save
    
    @resource.duration = "00:20:30"
    assert @resource.save
  end
  
  def test_valid_publication_year
    @resource.publication_year = 1972
    assert @resource.save
  end
  
  def test_too_early_publication_year
    @resource.publication_year = 1839
    assert !@resource.save
  end
  
  def test_invalid_future_publication_year
    @resource.publication_year = Time.now.year+2
    assert !@resource.save
  end
  
  
  
end
