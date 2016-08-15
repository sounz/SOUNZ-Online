ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false
  
  # Add more helper methods to be used by all tests here...
  # 
  
  def check_for_error(message, obj, field)
    puts "---- CHECKING FOR ERROR MESSAGE \"#{message}\""
    saved_ok = !obj.save
    puts "============"
    obj.errors.each_full { |msg| puts " - ERROR MESSAGE: #{msg}" }
    puts "============"
    
    assert saved_ok
    puts "ASSERTED SAVED OK"
    assert_equal 1, obj.errors.count
    puts "ASSERTED 1 ERROR MESSAGE"
    assert_equal message, obj.errors.on(field)
    puts "ASSERTED ERROR MESSAGE CORRECT"
    
    puts "COMPLETED ERROR MESSAGE CHECK"
  end
  
  
  def check_for_error_messages(messages, obj, field)
    puts "---- CHECKING FOR ERROR MESSAGE \"#{messages}\""
    saved_ok = !obj.save
    puts "============"
    obj.errors.each_full { |msg| puts " - ERROR MESSAGE: #{msg}" }
    puts "============"
    
    assert saved_ok
    puts "ASSERTED DID NOT SAVE AS EXPECTED"
    assert_equal messages.length, obj.errors.count
    puts "ASSERTED #{messages.length} ERROR MESSAGE"
    # for message in messages
    assert_equal messages.sort, obj.errors.on(field).sort
    # end
    puts "ASSERTED ERROR MESSAGE CORRECT"
    
    puts "COMPLETED ERROR MESSAGE CHECK"
  end
  
  # --------------------------------------------------------------------
  # Test the permutations of length at the short and long end of a range
  # Test the following:
  # <ul>
  # <li>FAIL: One less than the smallest (unless already zero)</li>
  # <li>PASS: The smallest value</li>
  # <li>PASS: The largest value</li>
  # <li>FAIL: The largest value plus one</li>
  # <li>PASS: The average of large and small</li>
  # </ul>
  # --------------------------------------------------------------------
  def test_long_value_boundaries_of_model_field(model, field, small_size, large_size)
    #Test lower boundary
    test_long_value_of_model_field("is too short (minimum is #{small_size} characters)", model, field, (small_size - 1), false)
    test_long_value_of_model_field(nil, model, field, (small_size), true)
    
    
    #Test higher boundary
    test_long_value_of_model_field(nil, model, field, (large_size ), true)
    test_long_value_of_model_field("is too long (maximum is #{large_size} characters)", model, field, (large_size + 1), false)
    
    #Test middle
    test_long_value_of_model_field(nil, model, field, (small_size+large_size)/2, true)
    
  end
  
  
  # ------------------------------------------------------------------------------
  # - Set a given attribute to a long string and see if if the save fails or not -
  # ------------------------------------------------------------------------------
  def test_long_value_of_model_field(message,model, field, size, should_pass)
    puts "Testing field #{field} of model #{model} for size #{size} and expected result #{should_pass}"
    
    long_string = get_string_of_length size
    model_attributes = model.attributes
    model_attributes[field] = long_string
    model.attributes = model_attributes
    #puts model.to_yaml
    
    
    #Check we can or cannot save
    assert model.save == should_pass
    #Check error messages
    if message != nil
      check_for_error(message, model,field)
    end
  end  
  
  # --------------------------------------------------------------
  # - Set a given attribute to null and see if if the save fails -
  # --------------------------------------------------------------
  def test_necessary_existence_of_model_field(message,model, field)
    #Set the value to nil
    model_attributes = model.attributes
    model_attributes[field] = nil
    model.attributes = model_attributes
    puts model.to_yaml
    #Check we cannot save
    assert !model.save
    #Check error messages
    check_for_error(message, model,field)
  end
  
  # --------------------------------------------------------------
  # - Set a given attribute to null and see if if the save fails -
  # --------------------------------------------------------------
  def test_necessary_existence_of_model_field_multiple_errors(messages,model, field)
    #Set the value to nil
    model_attributes = model.attributes
    model_attributes[field] = nil
    model.attributes = model_attributes
    puts model.to_yaml
    #Check we cannot save
    assert !model.save
    #Check error messages
    check_for_error_messages(messages, model,field)
  end
  
  #------------------------------------------------------------------
  #- Create a string of an arbitrary number of characters in length -
  #------------------------------------------------------------------
  def get_string_of_length(number_chars)
    result = ""
    size = 0
    while size < number_chars do
      result << (size+1).to_s
      result << '.'
      size = result.length
    end
    
    #Crop if too long
    if result.length >> number_chars
      result = result[0..(number_chars-1)]
    end
    result
  end
  
  
  #------------------------------------------------------------------------
  #- Test an array of fields to see if they are optional.  Iterate through
  #  them 1 by 1, set the field to nil and check whether the object saves.
  #  At the end of the test all of the listed fields will be nil.
  #  Note this will not catch cases where certain combinations can or cant be nil
  #  e.g. roles with organisation and person id
  #------------------------------------------------------------------------
  
  def check_optional_fields(model, fields)
    for field in fields
      model_attributes = model.attributes
      model_attributes[field] = nil
      model.attributes = model_attributes
      
      x = model.save
      # puts model.errors.to_xml
      #Check we can save
      assert(x ,"Checking optionality of #{field}")
      
      
    end
  end
  
  
  def check_necessary_fields(model, fields)
    for field in fields
      model_attributes = model.attributes
      model_attributes[field] = nil
      model.attributes = model_attributes
      
      x = model.save
      # puts model.errors.to_xml
      #Check we can save
      assert(!x ,"Checking necessity of #{field}")
      
      
    end
  end
  
  
  # - Set the field id of a given model to something invalid and try to save -
  def check_foreign_key(model, field)
    
    model_attributes = model.attributes
    model_attributes[field.to_s+"_id"] = 1000000 # some big number that does not exist
    model.attributes = model_attributes
    
    assert !model.save
    #  puts "****"
    # puts model.errors.to_xml
    check_for_error("can't be blank", model, field)
  end
  
  
end
