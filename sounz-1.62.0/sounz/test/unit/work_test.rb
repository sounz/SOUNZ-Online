require File.dirname(__FILE__) + '/../test_helper'

class WorkTest < Test::Unit::TestCase
  
  
  def setup
    @work = Work.find(12448)
    @current_year = Time.now.year
  end


  #Test on the FRBr relationship - ideally I think a more generic
  def test_get_manifestations
    w = @work
    
    #There should be 3 manifestations
    mans = w.related_manifestations
    #FIXME - assert that the expression  manifestations are all included int he work related manifesations
    #... they should be the same
    assert mans.length == 3
    for exp in w.expressions
      for man in exp.manifestations
        puts "#{man.manifestation_id} : #{man.manifestation_title}"
      end
    end 
  end
  
  #Test the condition where a revision date is provided, but no creation date
  def test_revision_no_creation_date
    @work.year_of_creation = nil
    @work.year_of_revision = 1994
    assert !@work.save
  end
  
  
  #---- tests for duration ----
  def test_has_no_duration
    @work.no_duration = true # We can ignore the other fields related to duration
    assert @work.save
  end
  
  def test_has_no_intended_duration
    @work.no_duration = false
    @work.intended_duration = nil
    assert !@work.save
  end
  
  def test_negative_intended_duration
    @work.no_duration = false
    @work.intended_duration = -100
    assert !@work.save
  end
  
 
 def test_fractional_intended_duration
   @work.no_duration = false
   @work.intended_duration = 34.34589734897
   assert !@work.save
 end
 
 
 def test_valid_duration
   @work.no_duration = false
   @work.intended_duration = "00:00:34"
   assert @work.save
 end
  
  


  
  
  #FIXME: What is the requirement here?
  def test_both_dates_nil
    @work.year_of_creation = nil
    @work.year_of_revision = nil
    assert @work.save
  end
  
  def test_revision_less_than_creation_date
    @work.year_of_creation = 1996
    @work.year_of_revision = 1994
    assert !@work.save
  end
  
  def test_revision_same_as_creation
    @work.year_of_creation = 1996
    @work.year_of_revision = 1996
    assert @work.save
  end
  
  def test_valid_revision_creation
    @work.year_of_creation = 1996
    @work.year_of_revision = 1998
    result = @work.save
    puts @work.to_yaml
    assert result == true
  end
  
  def test_future_year_creation
    @work.year_of_creation = 1996
    @work.year_of_revision = @current_year+4 # This is too far in the future
    assert !@work.save
  end
  
  def test_future_year_creation_and_revision
    @work.year_of_creation = @current_year+1
    @work.year_of_revision = @current_year+2
    assert @work.save
  end
  
  def test_revision_same_as_creation_this_year
    @work.year_of_creation = @current_year
    @work.year_of_revision = @current_year
    assert @work.save
  end
  
  def test_early_revision_year
    @work.year_of_creation = 1839
    @work.year_of_revision = 1839
    assert !@work.save
  end
  
  def test_early_creation_year
    @work.year_of_creation = 1839
    @work.year_of_revision = 1920
    assert !@work.save
  end
  
  
  
  def test_fractional_year
    @work.year_of_creation = 1900.141592653589793
    assert !@work.save
  end
  
  def test_gibberish_year
    @work.year_of_creation = "aiosdufioasudf"
    assert !@work.save
  end
  
  
  def test_set_composers
    compies = Contributor.find(:all, :limit => 10) #Find 10 composers
    result = @work.set_composers(compies)
    puts result
    puts "****"
    assert @work.composers.length == compies.length
    assert result == true
  end
  
  def test_save_with_composers
    compies = Contributor.find(:all, :limit => 10) #Find 10 composers
    result = @work.save_with_composers(compies)
    puts "Work composers size is #{@work.composers.length}"
   # @work.reload
    assert @work.composers.length == compies.length
    assert result == true
  end
  
  def test_update_with_composers
    compies = Contributor.find(:all, :limit => 10) #Find 10 composers
    result = @work.update_attributes_with_composers({:work_title => 'New title'},compies)
    puts "Work composers size is #{@work.composers.length}"
 #   @work.reload
    assert @work.composers.length == compies.length
    assert result == true
  end
  
  
  def test_compulsory_main_category
    @work.main_category = nil
    assert !@work.save
    
  end
  
  
  def test_empty_title
    @work.work_title = nil
    assert !@work.save
    
    @work.work_title = ""
    assert !@work.save
  end
  
  
  def test_no_duration_human_readable
    @work.no_duration = true
    assert @work.duration_human_readable == ""
    
    #Check the no duration flag overrides any actual value
    @work.intended_duration = "00:00:10"
    assert @work.duration_human_readable == ""
  end
  
  def test_duration_seconds_only
    @work.no_duration = false
    @work.intended_duration = "00:00:40"
    readable = @work.duration_human_readable 
    puts readable
    assert_equal "0' 40\"", readable
  end
  
  def test_duration_mins_seconds
    @work.no_duration = false
    @work.intended_duration = "00:07:20"
    assert @work.duration_human_readable == "7' 20\""
  end
  
  def test_duration_hours_mins_secs
    @work.no_duration = false
    @work.intended_duration = "01:40:28"
    assert @work.duration_human_readable == "1.40' 28\""
  end
  
  def test_duration_can_vary
    @work.no_duration = false
    @work.duration_varies = true
    @work.intended_duration = "01:40:28"
    assert @work.duration_human_readable == "1.40' 28\" (can vary)"
  end
  
  
  def blank_iwsc_code
    @work.iswc_code = nil
    assert @work.save
  end
  
  def test_invalid_iwsc_codes
    for ic in ["asdf", "993897378934", "===asd9dsf90dfs"]
      @work.iswc_code = ic
      assert !@work.save
    end
  end
  
  
  def test_valid_iwsc_codes
      @work.iswc_code = "T-345246800-1"
      assert @work.save
  end
  
  
  #Test that one can make the names of all the cats/subcats teh same length
  def test_misc_helper_spacing
    desired_len = 43
    ws_all = WorkSubcategory.find(:all)
    for wsc in ws_all
      desc = wsc.work_subcategory_desc
      desc_padded = MiscHelper.pad_string(desc, desired_len)
      puts "#{desc}, #{desc.length}, #{desc_padded.length}"
      assert_equal desired_len, desc_padded.length
      assert (desc_padded.length <= desired_len)
    end
  end
  
  
  #FIgure out which works are valid from the data import
  def test_import
    works = Work.find(:all)
    for work in works
      if !work.valid?
        puts work.work_id.to_s+":"+work.work_title
      end
    end
  end

  
  
  
end
