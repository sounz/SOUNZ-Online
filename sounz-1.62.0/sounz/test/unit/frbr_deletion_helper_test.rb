require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/helpers/finder_helper'

class FrbrDeletionHelperTest < Test::Unit::TestCase
  def test_manifestation_what_will_be_deleted
    @manifestation = Manifestation.find(4990)
    hash = FrbrDeletionHelper.objects_to_delete_for_manifestation(@manifestation)
    puts FrbrDeletionHelper.convert_count_hash_for_popup(hash)
    
    assert @manifestation.destroy
    
    assert_raise(ActiveRecord::RecordNotFound){
       @manifestation.reload
    }
  end
  
  def test_expression_what_will_be_deleted
    @expression = Expression.find(4990)
    hash = FrbrDeletionHelper.objects_to_delete_for_expression(@expression)
    puts FrbrDeletionHelper.convert_count_hash_for_popup(hash)
    
    assert @expression.destroy
    
    assert_raise(ActiveRecord::RecordNotFound){
       @expression.reload
    }
  end
end