class DurationAsIntervalController < ApplicationController
  
  #When the text in the three boxes (hours,mins,seconds) is typed, the hidden field ot correctly
  #update the interval duration is altered
  def update_hidden_field
    @hours = params[:hours]
    @minutes = params[:minutes]
    @seconds = params[:seconds]
    @object_name = params[:object_name]
    @field_name = params[:field_name]
    @valid = true
    begin
      @interval_duration = IntervalDuration.create_from_string(@hours+":"+@minutes+":"+@seconds)
      logger.debug "DURATION:#{@interval_duration.to_postgres_string}"
    rescue
      @erroneous_values = @hours+":"+@minutes+":"+@seconds
      @valid = false
    end
    
    #The output will display an error message if @valid is not true
    render :layout => false
  end
  
  
  #Cancel a duration - this involves hiding it on the screen
  def cancel_duration
    #These need to be passed on to recreate the original form should cancel then set be pressed
    @object_name = params[:object_name]
    @field_name = params[:field_name]
    @prefix = params[:prefix]
    @optional = params[:optional]
    logger.debug "DURATION: HIDING"
    
  end
  
  
  #Set teh duration, or at least provide the option to do so
  def set_duration
    #These need to be passed on to recreate the original form should cancel then set be pressed
    @object_name = params[:object_name]
    @field_name = params[:field_name]
    @optional = params[:optional]
    @prefix = params[:prefix]
  end

  
end
