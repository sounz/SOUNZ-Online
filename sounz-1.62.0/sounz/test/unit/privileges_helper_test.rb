require File.dirname(__FILE__) + '/../test_helper'



class PrivilegesHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  include PrivilegesHelper
  
  
  def setup
    @login = Login.find(:first)
  end
  
  def test_edit_permission
    assert_equal true, PrivilegesHelper.has_permission?(@login, :edit)
  end
  
  def test_invalid_verb
    assert_raise(ArgumentError) {
      assert_equal true, PrivilegesHelper.has_permission?(@login, :spoogle)
    }
  end
  
end
