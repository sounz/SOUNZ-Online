#-------------------------------
#- Helper for model validation -
#-------------------------------
class ModelHelper
  
 
  def self.is_optional_field(field_value)
   # puts "** CHECKING FIELD VALUE #{field_value}"
  
    check_field = true
    
    if field_value == nil
     # puts "Check field is nil"
      check_field = false
    #Cant do length on a non string....
    elsif field_value.class.to_s=="String" and field_value.length == 0
    #  puts "Check field is empty string"
      check_field = false
    end
    
    return check_field
  end
  
  
 #WORKS def self.only_check_if_not_empty(thing, field_name)
  def self.only_check_if_not_empty( field_name)
   # puts "**** CHECKING FIELD #{field_name}"
   return Proc.new {|model| (ModelHelper.is_optional_field(model.send(field_name))) }
    end
  
end