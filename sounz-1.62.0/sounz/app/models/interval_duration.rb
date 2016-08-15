#This is intended to hold the value of a duration field in postgres
class IntervalDuration
  
  attr_reader :hours, :minutes, :seconds
  attr_writer :hours, :minutes, :seconds
  
  VALID_CHARS = '0123456789:'

  #Convert this into a string such that rails and postgres can talk
  def to_postgres_string
    min_string = minutes.to_s
    sec_string = seconds.to_s
    
    min_string = "0" + min_string if minutes.to_s.length < 2
   sec_string = "0" + sec_string if seconds.to_s.length < 2
    
    return hours.to_s+":"+min_string+":"+sec_string
  end
  
  
  
  def self.create_from_string_no_validation(duration_as_string)
    result = nil
    if !duration_as_string.blank?
      result  = IntervalDuration::new
      bits = duration_as_string.split(':')
      if bits.length == 1
        result.hours = 0
        result.minutes = 0
        result.seconds = bits[0]
      elsif bits.length == 2
        result.hours = 0
        result.minutes = bits[0]
        result.seconds = bits[1]
      else
        result.hours = bits[0]
        result.minutes = bits[1]
        result.seconds = bits[2]
      end
    end
    result
  end

  #Factory method to create an internval duration from a strong of the form hhhh*:mm:ss 
  def self.create_from_string(duration_as_string)
    result = nil
    
    #Blank case is a special one, set to zero
    if !duration_as_string.blank?
    
      result = IntervalDuration::new
      #Iterate through all the characters checking for those not in the valid chars array above
      duration_as_string.each_char do |c| 
        raise ArgumentError, "The duration can only contain colons and numeric characters" if !VALID_CHARS.include?(c)
      end
    
      parts = duration_as_string.split(':')
    
      raise ArgumentError, "The duration must contain 2 colon characters and be numeric" if parts.length != 3
    
    
    
      result.hours = parts[0].to_i
      result.minutes = parts[1].to_i
      result.seconds = parts[2].to_i
    
      raise ArgumentError, "minutes must be less than 60" if result.minutes > 59
      raise ArgumentError, "seconds must be less than 60" if result.seconds > 59
=begin
    else
      result.hours = 0
      result.minutes = 0
      result.seconds = 0
=end
    end

    
    return result
  end
end