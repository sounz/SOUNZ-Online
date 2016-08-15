module EventsHelper
  
  
  def self.add_events_to_create_umbrella(event,event_id_array)
      successful_addition = false
      
      begin
        event.transaction do
          successful_addition = true
          for sub_event_id in event_id_array
            sub_event = Event.find(sub_event_id)
            sub_event.parent = event
            sub_event.save
          end
        end
      
      rescue Exception => e
        successful_addition = false
        @error_message = Time.now.to_s+" - Addition failed, reason is: "+ e.message
        @alert = "alert('#{@error_message}');" #for javascript debugging
        RAILS_DEFAULT_LOGGER.debug "EventsHelper: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      end
      
      successful_addition

  end
  
  #Parse the start time and return it in a form suitable for the site, or return a blank
  def self.get_start_time(event)
    result = ""
    result = parse_time(event.event_start, event.supress_times) if !event.event_start.blank?
    result
  end
  
  
  #Parse the end time and return it in a form suitable for the site, or return a blank
  def self.get_end_time(event)
    result = ""
    result = parse_time(event.event_finish, event.supress_times) if !event.event_finish.blank?
    result
  end
  
  def self.get_deadline(event)
    result = ""
    result = parse_time(event.entry_deadline, true) if !event.entry_deadline.blank?
    result
  end
  
  def self.get_website_url(event)
    website_url = event.contactinfo.get_list_of_websites[0] unless event.contactinfo.blank?
  end
  
  private
  def self.parse_time(the_time, supress_times)
    result = "" # for nil time
    if supress_times
      result = the_time.strftime("%d %B %Y")
	  result = result.gsub(/^0/, '')
    else
      date = the_time.strftime("%d %B %Y")
      time = the_time.strftime("%I:%M %p")
      time = time.gsub(/^0/, '')
	  date = date.gsub(/^0/, '')
      result = date + ' ' + time
    end
    
    return result
  end
  
  
end
