require File.dirname(__FILE__) + '/../test_helper'

class ExpressionTest < Test::Unit::TestCase

  def setup
    @expression = Expression.find(4089)
  end
  

  def test_same_day_with_nils
    @expression.expression_start = nil
    @expression.expression_finish = nil
    assert @expression.is_one_day_only? == true
  end
  
  def test_same_day_with_valid_dates
    t = Time.now
    @expression.expression_start = t
    @expression.expression_finish = t+2000
    assert @expression.is_one_day_only? == true
  end
  
  def test_same_day_with_identical_dates
    t = Time.now
    @expression.expression_start = t
    @expression.expression_finish = t
    assert @expression.is_one_day_only? == true
  end
  
  def test_same_day_not_with_valid_dates
    t = Time.now
    puts "Same day not with valid dates"
    @expression.expression_start = (t-86401)
    @expression.expression_finish = t
    assert @expression.is_one_day_only? == false
  end

  def test_same_day_not_with_nil_start
    t = Time.now
    puts "Same day not with valid dates"
    @expression.expression_start = nil
    @expression.expression_finish = t
    assert @expression.is_one_day_only? == false
  end
  
  def test_same_day_not_with_nil_end
    t = Time.now
    puts "Same day not with valid dates"
    @expression.expression_start = t
    @expression.expression_finish = nil
    assert @expression.is_one_day_only? == false
  end
  
  
  def test_contains_nil_both_dates_nil
      @expression.expression_start = nil
      @expression.expression_finish = nil
      assert @expression.contains_nil_dates  == true
  end
  
  
  def test_contains_nil_both_dates_not_nil
      @expression.expression_start = Time.now
      @expression.expression_finish = Time.now
      assert @expression.contains_nil_dates  == false
  end
  
  
  def test_contains_one_date_nil
    @expression.expression_start = nil
    @expression.expression_finish = Time.now
    assert @expression.contains_nil_dates  == true
    
    @expression.expression_finish = nil
    @expression.expression_start = Time.now
    assert @expression.contains_nil_dates  == true
  end
  
  

  def test_valid_edition_types
    expression = Expression.find(:first)
    expression.edition = 'ORG'
    assert_equal("Original",expression.get_edition_as_string)
    expression.edition = 'RFP'
    assert_equal("Revision Following Performance",expression.get_edition_as_string)
    expression.edition = 'GEN'
    assert_equal("General Revision",expression.get_edition_as_string)
    expression.edition = nil
    assert_equal('', expression.get_edition_as_string)
  end
  
  
  def test_title_compulsory
    test_long_value_boundaries_of_model_field(@expression, :expression_title, 2, 100)
  end
  
  
  def test_nil_dates_saves
    @expression.expression_start = nil
    @expression.expression_finish = nil
    assert @expression.save
  end
  
  def test_cant_save_with_only_finish_date
    @expression.expression_start = nil
    @expression.expression_finish = Time.now
    assert !@expression.save
  end
  
  def test_expression_with_only_start_date
    @expression.expression_finish = nil
    @expression.expression_start = Time.now
    assert @expression.save
  end
  
  def test_finish_before_start
    t = Time.now
    @expression.expression_start = t
    @expression.expression_finish = (10.minutes.ago)
    assert !@expression.save
  end
  
  def test_player_count_zero
    @expression.players_count = 0
    assert @expression.save
  end
  
  def test_player_count_fractional
    @expression.players_count = 3.77
    assert !@expression.save
  end
  
  def test_player_count_too_large
    @expression.players_count = 50
    assert @expression.save
    @expression.players_count = 51
    assert !@expression.save
  end
  
  def test_player_count_zero
    @expression.players_count = 0
    assert @expression.save
  end
  
  
  def test_frbr_rels_work

    #Check that we have a single frbr relationship and that its the same work as
    #referred to in the database
    wrt = @expression.works_realised_through
    assert_equal 1, wrt.length
    assert_equal @expression.work, wrt[0]
    
    puts wrt
    puts wrt.length
    
    #Ensure a different work id
    new_work_id = @expression.work.work_id + 1
    
    #Assign a new work
    @expression.work = Work.find(new_work_id)
    assert @expression.save_with_frbr
    
    #After the work is saved there should only be one FRBR relationship, and it should match the database
    wrt = @expression.works_realised_through

    assert_equal 1, wrt.length
    assert_equal @expression.work, wrt[0]
    
    #Double check
    assert_equal @expression.work.work_id, new_work_id
    
  end

  
  
end
