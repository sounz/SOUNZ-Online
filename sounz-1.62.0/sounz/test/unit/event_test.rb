require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  
     YEAR_SECS = 31536000
  
  def setup
    @event = Event.find(:first)
    @event.event_title = "Valid title for an event"
    @now = Time.now
    @past = @now - 100000
    @future = @now + 100000
  end

  def test_length_of_venue_name
    test_long_value_boundaries_of_model_field(@event, :event_title, 2, 100)
  end
  

  
  #== updated by ==
  def test_updated_by_necessary
    @event.updated_by = nil
    assert !@event.save
  end

  
  def test_valid_updated_by
    @event.updated_by = Login.find(:first).login_id
    assert @event.save
  end
  
  #Contact info
  def test_contactinfo_valid
    @event.contactinfo = Contactinfo.find(:first)
    @event.save
  end
  
  
  def test_contactinfo_nil
    @event.contactinfo = nil
    !@event.save
  end
  
  #Event types
  def test_event_type_nil
    @event.event_type = nil
    assert !@event.save
  end
  
  def test_all_event_types
    for et in EventType.find(:all)
      @event.event_type = et
      assert @event.save
    end
  end
  
  
  #check the related event foreign key is happy
  def test_related_event
    flunk "Todo"
  end
  
  
  #- test dates -
  def test_start_before_end_date_valid
    @event.event_start = @past
    @event.event_finish = @future
    assert @event.save
  end
  
  def test_start_after_end_date_valid
    @event.event_start = @future
    @event.event_finish = @past
    assert !@event.save
  end
  
  
  #== optional fields ==
  def test_optional_fields
    @event.event_finish = nil
    fields = ['event_start','entry_age_limit', 'internal_note', 'entry_fee_note', 'prize_info_note']
    fields = fields + ['event_finish','entry_deadline','tickets_note', 'general_note']
    
    for field in fields
      puts "***SETTING TO NIL:#{field}"
      @event.send(field << '=' , nil)
      assert @event.save
    end
  end
  
  
  
  def test_years_for_solr
    current_time = Time.now
    year = current_time.year
    a_year_from_now = (current_time+31536000) #a year of secs
    
    #no dates for event
    @event.event_start = nil
    @event.event_finish = nil
    assert_equal "", @event.years_for_solr
    
    #start date for event
    @event.event_start = current_time
    assert_equal year.to_s, @event.years_for_solr
    
    #start and finish date for event, same year
    @event.event_finish = current_time
    assert_equal year.to_s, @event.years_for_solr
    
    @event.event_finish = a_year_from_now
    assert_equal year.to_s+" "+a_year_from_now.year.to_s, @event.years_for_solr
  end
  
  
  def test_year_group_for_solr
    current_time = Time.now
    year = current_time.year
    a_year_from_now = (current_time+YEAR_SECS) #a year of secs
    
    #no dates for event
    @event.event_start = nil
    @event.event_finish = nil
    assert_equal "none", @event.year_group_for_solr
    
    #start date for event
    @event.event_start = current_time-YEAR_SECS
    assert_equal "previous", @event.year_group_for_solr
    
    #start date for event
    @event.event_start = current_time-2*YEAR_SECS
    assert_equal "previous", @event.year_group_for_solr
    
    #start date for event
    @event.event_start = current_time+YEAR_SECS
    assert_equal "next", @event.year_group_for_solr
    
    #start date for event
    @event.event_start = current_time+2*YEAR_SECS
    assert_equal "future", @event.year_group_for_solr
    
    #start date for event
    @event.event_start = current_time
    assert_equal "this", @event.year_group_for_solr
    
    #start and finish date for event, same year
    @event.event_finish = current_time
    assert_equal "this", @event.year_group_for_solr
    
    
    #this year to next year
    @event.event_finish = a_year_from_now
    assert_equal "next this", @event.year_group_for_solr
    
    
    #last year to next year
    @event.event_start = current_time-YEAR_SECS
    assert_equal "next previous this", @event.year_group_for_solr
    
    #3 years ago to next year
    @event.event_start = current_time-3*YEAR_SECS
    assert_equal "next previous this", @event.year_group_for_solr
    
    #add super future use case not thought about
    @event.event_finish = current_time+3*YEAR_SECS
    assert_equal "future next previous this", @event.year_group_for_solr
  end
  
  
  
  def test_associated_months
    mar_date_2007 = Time.parse("3/24/2007 17:20")
    oct_date_2007 = Time.parse("10/14/2007 10:17") #month day year
    mar_date_2008 = Time.parse("3/24/2008 17:20")
    
    #no dates for event
    @event.event_start = nil
    @event.event_finish = nil
    assert_equal [], @event.associated_months
    
    #start date only
    @event.event_start = oct_date_2007
    @event.event_finish = nil
    assert_equal [10], @event.associated_months
    
    #same day
    @event.event_start = oct_date_2007
    @event.event_finish = oct_date_2007 + 1000
    assert_equal [10], @event.associated_months
    
    #same month, different days
    @event.event_start = oct_date_2007
    @event.event_finish = oct_date_2007 + 12.days
    assert_equal [10], @event.associated_months
    
    #range in one year
    @event.event_start = mar_date_2007
    @event.event_finish = oct_date_2007
    assert_equal [3,4,5,6,7,8,9,10], @event.associated_months
    
    #range over a year end
    @event.event_start = oct_date_2007
    @event.event_finish = mar_date_2008
    assert_equal [10, 11, 12, 1, 2, 3], @event.associated_months
  end
  
  
  
  
  def test_previous_year_facet
    mar_date_2007 = Time.parse("3/24/2007 17:20")
    oct_date_2007 = Time.parse("10/14/2007 10:17") #month day year
    mar_date_2008 = Time.parse("3/24/2008 17:20")
    mar_date_2006 = Time.parse("3/24/2006 17:20")
    mar_date_2003 = Time.parse("3/24/2003 17:20")
    mar_date_2000 = Time.parse("3/24/2000 17:20")
    mar_date_1997 = Time.parse("3/24/1997 17:20")
    mar_date_1980 = Time.parse("3/24/1980 17:20")
    
    
     
    
    
    
    
    #no dates for event
    @event.event_start = nil
    @event.event_finish = nil
    assert_equal "", @event.previous_year_sub_group_for_solr
    
    #--- note current year is not facetted ----
    #start date only
    @event.event_start = oct_date_2007
    @event.event_finish = nil
    assert_equal "", @event.previous_year_sub_group_for_solr
    
    #same day
    @event.event_start = oct_date_2007
    @event.event_finish = oct_date_2007 + 1000
    assert_equal "", @event.previous_year_sub_group_for_solr
    
    #same month, different days
    @event.event_start = oct_date_2007
    @event.event_finish = oct_date_2007 + 12.days
    assert_equal "", @event.previous_year_sub_group_for_solr
    
    
    #time go back in time
    @event.event_start = mar_date_1980
    @event.event_finish = mar_date_2006
    assert_equal "1995-1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, Before 1995", @event.previous_year_sub_group_for_solr
    
    #time go back in time
    @event.event_start = mar_date_1997
    @event.event_finish = mar_date_2006
    assert_equal "1995-1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006", @event.previous_year_sub_group_for_solr
    
    
     
    
    #time go back in time
    @event.event_start = mar_date_2003
    @event.event_finish = mar_date_2006
    assert_equal "2003, 2004, 2005, 2006", @event.previous_year_sub_group_for_solr
    
    #last year
       @event.event_start = mar_date_2006
       @event.event_finish = mar_date_2006
       assert_equal "2006", @event.previous_year_sub_group_for_solr
       
    
    
       #time go back in time
         @event.event_start = mar_date_2000
         @event.event_finish = mar_date_2006
         assert_equal "2000, 2001, 2002, 2003, 2004, 2005, 2006", @event.previous_year_sub_group_for_solr

    
    
  end
  
  
  def test_facet_sort_field_for_solr_test_opportunity
    #Sort by entry deadline
    e = Event.find(:first)
    e.event_type = EventType::OPPORTUNITY
    e.entry_deadline = Time.parse("10/17/2007")
    assert_equal "20071017", e.facet_sort_field_for_solr
    
    #Put these last
    e.entry_deadline = nil
    assert_equal "20371231", e.facet_sort_field_for_solr
  end
  
  def test_facet_sort_field_for_solr_test_event
    #Sort by entry deadline
    e = Event.find(:first)
    e.event_type_id = 12 # not an opportunity
    e.event_start = Time.parse("10/17/2007")
    assert_equal "20071017", e.facet_sort_field_for_solr
    
    #Put these last
    e.event_start = nil
    assert_equal "20371231", e.facet_sort_field_for_solr
  end
  
  
  

  def test_facet_year_grouping
    x = {}
    for year in 1995..2030
      RAILS_DEFAULT_LOGGER.debug "===== #{year}===="
      RAILS_DEFAULT_LOGGER.debug FacetHelper.event_facet_previous_years(year).to_yaml
    end
  end
end

=begin
 event_id         | integer                     | not null default nextval('events
_event_id_seq'::regclass)
 related_event_id | integer                     | 

 status_id        | integer                     | not null

 event_start      | timestamp without time zone | 
 event_finish     | timestamp without time zone | 
 entry_deadline   | timestamp without time zone | 
 entry_anonymous  | boolean                     | default false
                     | 
 created_at       | timestamp without time zone | not null
 updated_at       | timestamp without time zone | not null
 updated_by       | integer                     | not null
=end
