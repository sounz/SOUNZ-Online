require File.dirname(__FILE__) + '/../test_helper'

class ModeTest < Test::Unit::TestCase

  def test_modes_with_date_required
    assert Mode::PERFORMANCE.requires_date_and_premiere?
    assert Mode::COMPILED_COMPUTER_CODE.requires_date_and_premiere?
    assert Mode::INSTALLATION.requires_date_and_premiere?
  end
  
  def test_modes_with_no_date_required
    assert !Mode::MUSIC_NOTATION.requires_date_and_premiere?
    assert !Mode::ALPHA_NUMERIC_NOTATION.requires_date_and_premiere?
  end
  
end
