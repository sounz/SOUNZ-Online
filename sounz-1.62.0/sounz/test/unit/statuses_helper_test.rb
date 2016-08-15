require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/helpers/statuses_helper'

class StatusesHelperTest < Test::Unit::TestCase

  include StatusesHelper
  
  def test_pending_default
    @venue = Venue.find(:first)
     puts @venue.status.status_desc
     @venue.status = Status.find_by_symbol(:published)
     @venue.save
     assert @venue.status.status_desc = "Published"
    get_statuses(@venue)
    puts @venue.status.status_desc
     assert @venue.status.status_desc = "Pending"
  end
  
end