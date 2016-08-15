class TimeHelper
  # --------------------------------------------------------
   # - Convert a time in seconds to hours and minute format -
   # --------------------------------------------------------
   def self.convert_duration_to_hours_and_minutes(duration_string)
     
     result = "Unparseable duration"
     
     begin

       interval = IntervalDuration.create_from_string(duration_string)
       if !interval.seconds.blank?

         result = ''
         if interval.hours > 0
           result = "#{interval.hours}h "
         end
         
         if interval.minutes > 0 && interval.minutes < 10
		   result = result + "0#{interval.minutes}'"
         elsif interval.minutes > 9
		   result = result + "#{interval.minutes}'"
		 elsif interval.minutes == 0
		   result = result + "00'"
         end

		 
		 if interval.seconds > 9
           result = result + ' '+interval.seconds.to_s+'"'
		 elsif interval.seconds > 0 && interval.seconds < 10
		   result = result + ' 0'+interval.seconds.to_s+'"'
         elsif interval.seconds == 0
       	   result = result + ' 00"'
		 end

      end
     rescue Exception => e
      RAILS_DEFAULT_LOGGER.debug "DurationException: #{e.class}: #{e.message}\n\t#{e.backtrace.join('\n\t')}"
      #do nothing, message already set
     end
     result
   end
   
   
   #------------------------------------------------------
   #- Return a date in day mon year hour:minute format -
   #------------------------------------------------------
   def self.dby_date(date)
     result = ""
     if date != nil
       result = date.strftime("%d %b %Y %H:%M")
     end
     result
   end
   
   def self.dmy_date(date)
     result = ""
     if date != nil
       result = date.strftime("%d %b %Y")
     end
     result
   end
end