require File.dirname(__FILE__) + '/../test_helper'

class IntervalDurationTest < Test::Unit::TestCase

  # Test a valid interval duration
  def test_valid_values
    interval = IntervalDuration.create_from_string("00:04:12")
    assert interval.hours == 0
    assert interval.minutes == 4
    assert interval.seconds == 12
  end
  
  
  def test_nil_case_no_validation
    interval = IntervalDuration.create_from_string_no_validation(nil)
    assert_equal nil, interval
  end
  
  def test_nil_case_with_validation
    interval = IntervalDuration.create_from_string(nil)
    assert_equal nil, interval
  end
  
  
  def test_gibberish
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("asdfosadfsadf")
    }
  end
  
  def test_one_colon
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("00:12")
    }
  end
  
  def test_letters
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("aa:bb:cc")
    }
  end
  
  def test_large_seconds
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("10:00:610")
    }
  end
  
  def test_large_minutes
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("10:61:30")
    }
    assert_raise(ArgumentError) {
      interval = IntervalDuration.create_from_string("10:610:30")
    }
  end
  
  
  def test_empty
    interval = IntervalDuration.create_from_string(nil)
    assert interval.hours == 0
    assert interval.minutes == 0
    assert interval.seconds == 0
    
    interval = IntervalDuration.create_from_string("")
    assert interval.hours == 0
    assert interval.minutes == 0
    assert interval.seconds == 0
  end
end
