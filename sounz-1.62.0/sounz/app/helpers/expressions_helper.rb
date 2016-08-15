module ExpressionsHelper
  
  

  
  #Parse the start time and return it in a form suitable for the site, or return a blank
  def self.get_start_time(expression)
    result = ""
    result = parse_time(expression.expression_start, true) if !expression.expression_start.blank?
    result
  end
  
  
  #Parse the end time and return it in a form suitable for the site, or return a blank
  def self.get_end_time(expression)
    result = ""
    result = parse_time(expression.expression_finish, expression.supress_times) if !expression.expression_finish.blank?
    result
  end
  
  
  #Return a string of the form event start to event finish
  def self.expression_time_string(expression)
    result = ""
    if !expression.expression_start.blank?
      result << get_start_time(expression)
      if !expression.expression_finish.blank?
        result << " to "
        result << get_end_time(expression)
      end
    end
    result
  end
  

  
  private
  def self.parse_time(the_time, supress_times)
    result = "" # for nil time
    if supress_times
      result = the_time.strftime("%d %b %Y")
    else
      result = the_time.strftime("%d %b %Y %I:%M%p")
    end
  end
  
  
end
