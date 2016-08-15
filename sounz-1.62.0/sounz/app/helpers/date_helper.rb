#
# Distributed with Rails Date Kit
# http://www.methods.co.nz/rails_date_kit/rails_date_kit.html
#
# Author:  Stuart Rackham <srackham@methods.co.nz>
# License: This source code is released under the MIT license.
#
module DateHelper

  # Rails text_field helper plus drop-down calendar control for date input. Same
  # options as text_field plus optional :format option which accepts
  # same date display format specifiers as calendar_open() (%d, %e, %m, %b, %B, %y, %Y).
  # If the :format option is not set the the global Rails :default date format
  # is used or failing that  '%d %b %Y'.
  #
  # Explicitly pass it the date value to ensure it is formatted with desired format.
  # Example:
  #
  # <%= date_field('person', 'birthday', :value => @person.birthday) %>
  #
  def date_field(object_name, method, options={})
    format = options.delete(:format) ||
             ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[:default] ||
             '%d %b %Y'
    if options[:value].is_a?(Date)
      options[:value] = options[:value].strftime(format)
    end
    months = Date::MONTHNAMES[1..12].collect { |m| "'#{m}'" }
    months = '[' + months.join(',') + ']'
    days = Date::DAYNAMES.collect { |d| "'#{d}'" }
    days = '[' + days.join(',') + ']'
    options = {:onfocus => "this.select();calendar_open(this,{format:'#{format}',images_dir:'/images',month_names:#{months},day_names:#{days}})",
               :onclick => "event.cancelBubble=true;this.select();calendar_open(this,{format:'#{format}',images_dir:'/images',month_names:#{months},day_names:#{days}})",
              }.merge(options);
    text_field object_name, method, options
  end
  
  
  # Rails text_field helper plus drop-down calendar control for date input. Same
  # options as text_field plus optional :format option which accepts
  # same date display format specifiers as calendar_open() (%d, %e, %m, %b, %B, %y, %Y).
  # If the :format option is not set the the global Rails :default date format
  # is used or failing that  '%d %b %Y'.
  #
  # Explicitly pass it the date value to ensure it is formatted with desired format.
  # Example:
  #
  # <%= date_field('person', 'birthday', :value => @person.birthday) %>
  
  def date_field_with_time(actual_date, object_name, method, options={})
    actual_date = Time.now if actual_date == nil
    if actual_date != nil
    hash = separate_date_time(actual_date)
    date_part = date_field(object_name, method+'_date', :size => 15, :value => hash[:date])
    time_part = text_field object_name, method+'_time', :size => 4,:value => hash[:time]
    else
      date_part= "* SHOULD BE DATE STUFF HERE * "
      time_part= "* SHOULD BE TIME STUFF HERE * "
    end
    return date_part+'&nbsp;'  + time_part
  end
  
  
    # extracts date and time format from timestamp
  def separate_date_time(entity_date_time_timestamp)
    time = entity_date_time_timestamp.strftime("%H:%M")
    date = entity_date_time_timestamp.strftime("%d %b %Y")
     logger.debug "Returning date stamp separated for #{time}, #{date}"
     
    datetime = {
                :time => time,
                :date => date
               }
               
   
    return datetime
  end
  
  # Similar to date_field_with_time but allowing blank values to be displayed in
  # date boxes
  def date_field_with_time_allowing_blank(date, object_name, method, options={})
    hash = { :date => '', :time => '' } 
    
	hash = separate_date_time(date) if date != nil
	
    date_part = date_field(object_name, method+'_date', :size => 15, :value => hash[:date])
    time_part = text_field object_name, method+'_time', :size => 4, :value => hash[:time]
    
    return date_part+'&nbsp;'  + time_part
  end  
  
=begin
      def initialize(object_name, method_name, template_object, local_binding = nil, object = nil)
        @object_name, @method_name = object_name.to_s.dup, method_name.to_s.dup
        @template_object, @local_binding = template_object, local_binding
        @object = object
        if @object_name.sub!(/\[\]$/,"")
          if object ||= @template_object.instance_variable_get("@#{Regexp.last_match.pre_match}") and object.respond_to?(:id_before_type_cast)
            @auto_index = object.id_before_type_cast
          else
            raise ArgumentError, "object[] naming but object param and @object var don't exist or don't respond to id_before_type_cast: #{object.inspect}"
          end
        end
      end
=end

end
