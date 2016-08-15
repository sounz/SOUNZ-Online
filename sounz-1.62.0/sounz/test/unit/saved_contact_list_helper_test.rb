require File.dirname(__FILE__) + '/../test_helper'



class SavedContactListHelperTest < Test::Unit::TestCase

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  include SavedContactListsHelper



  def test_valid_person
    p = get_person_or_organisation("person34")
    assert p.person_id == 34
  end
  
  
    def test_nonexisting_person
    p = get_person_or_organisation("person340000")
    assert p == nil
  end
  
      def test_nonexisting_organisation
    org = get_person_or_organisation("organisation340000")
    assert org == nil
  end
  
  
    def test_valid_organisation
    org = get_person_or_organisation("organisation34")
    assert org.organisation_id == 34
  end
  
end
