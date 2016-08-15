require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < Test::Unit::TestCase
  
  def setup
    @venue = Venue.find(:first)
    
  end

  def test length_of_venue_name
    test_long_value_boundaries_of_model_field(@venue, :venue_name, 2, 100)
  end
  
  def test_necessary_venue_name
    @venue.venue_name = nil
    assert !@venue.save
  end
  
  def test_necessary_venue_status
    @venue.status = nil
    assert !@venue.save
  end
  
  def test_optional_general_note
    @venue.general_note = nil
    assert @venue.save
  end
  
  def test_optional_internal_note
    @venue.internal_note = nil
    assert @venue.save
  end
  
end
