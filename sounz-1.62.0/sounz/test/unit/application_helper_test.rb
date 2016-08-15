require File.dirname(__FILE__) + '/../test_helper'



class ApplicationHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  

  def test_generate_restore_id
    p1 = Person.find(100)
    mid = generate_id(p1)
    puts "#{p1} maps to #{mid}"
    p2 = convert_id_to_model(mid)
    assert p1 == p2
  end
  
  
  
  def test_generate_restore_id_with_two_words
    p1 = RoleType.find(1)
    mid = generate_id(p1)
    puts "#{p1} maps to #{mid}"
    p2 = convert_id_to_model(mid)
    assert p1 == p2
  end
 
end