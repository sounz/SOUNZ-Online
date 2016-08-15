#!/usr/bin/ruby
require 'rexml/document'
#require 'date'
require 'time'

require 'fixer_yaml'


include REXML

FORMAT ="%d %b %Y %H:%M"



ctr = 1

#puts "  date_of_birth: " 

puts "#List of events from event finder API"

for i in 1..7
  file = File.new("#{i}.html")
  doc = Document.new(file)
  page = doc.root
  
  #puts page.methods.sort
  page.each_element('//event') {|event| 
    puts "event_"+ctr.to_s+":"
    puts "  event_id: "+ctr.to_s
     title = event.elements["title"].text
     title.gsub!(':', '-')
    puts "  event_title: "+title
    puts "  general_note: "+Fixer.indent_yaml(event.elements["description"].text, 17)
    event_date_str = event.elements["date"].text
    
    
    #Get the event date
    event_date = Time.parse(event_date_str) 

    #OK, now this event date is midnight.  Lets start events at between 1700 and 2100
    #600 secs is 10 mins, all deltas are mins in ruby
    event_date = event_date + 17*3600 +  600 * rand(24) 
    
    #Make the gig between 1 and 4 hours, in 10 min blocks
    event_length = 3600+ 600* rand(18)
    
    #Ditto the time before, deadline for tickets
    event_time_before = 3600 + 600* rand(18)
    
    
   # puts "PARSED DATE:#{event_date}"
    
    
    puts "  event_start: "+event_date.strftime(FORMAT)

    puts "  event_finish: "+((event_date+event_length).strftime(FORMAT))

    
    #puts '  event_end <%=ago_month.month.ago.strftime("%Y-%m-%d")%>'
    
    puts "  entry_anonymous: true"
    puts "  entry_age_limit: 18"

    puts "  entry_deadline: "+((event_date - event_time_before).strftime(FORMAT))
    puts "  venue_id: <%=rand(83)+1%>"
    puts "  contactinfo_id: <%=rand(3)+1%>" #FIXME, need more contacts
    puts "  internal_note: Internal note for "+title
    puts "  status_id: 1"
    puts "  prize_info_note: Prize note for "+title
    puts "  entry_fee_note: Entry fee note for " +title
    puts "  event_type_id: 1"
    
    puts
    
    ctr = ctr + 1
  }
  
end
