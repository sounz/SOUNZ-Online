module DurationAsIntervalHelper
  
  # prepare a new duration - this does the following
  # * Create a has_a_duration flag of false
  def prepare_duration_new
    @has_a_duration = false
  end
  
  #Check if we have a duration - prepare has_a_duration flag and interval duration accordingly
  def prepare_duration_edit(model_duration)
    if model_duration == nil
      @has_a_duration = false
    else
      @has_a_duration = true
      @interval_duration = IntervalDuration.create_from_string_no_validation(model_duration)
    end
  end
  

  
  
end
