require File.dirname(__FILE__) + '/../test_helper'



class FindCommunicationsHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  include FindCommunicatonsHelper
  
  
  
 def test_freetext

   debug_message "Freetext query: #{freetext_query}"
   communications = find_communications("", "", freetext_query, [], nil)
   show_results(communications)
 end
 
 
 def show_results(comms)
  for comm in comms
    puts comm.to_s
  end
 end
  
end
