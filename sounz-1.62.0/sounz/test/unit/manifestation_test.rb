require File.dirname(__FILE__) + '/../test_helper'

class ManifestationTest < Test::Unit::TestCase
  
  include ManifestationsHelper
  
  def setup
    @manifestation = Manifestation.find(:first)
    @current_year = Time.now.year
  end

  def test_samples
    w = Work.find(16837)
    rm = w.related_manifestations
    scores = ManifestationsHelper.scores_only(rm)
    samples = ManifestationsHelper.samples(scores)
    puts "ALL:"+samples.to_s
    for sample in samples
      puts sample.to_s
    end
    assert_same(samples.length,1)
    
    for sample in samples
      for attachment in sample.sample_attachments
        path = attachment.media_item.media_item_path
        puts path
        assert_equal(path, "/samples/samples of scores - pdfs/non-NZMS samples/6259_108087_smp.pdf")
      end
    end
    
    puts "===="
  end
  
  
  def test_no_cost
    assert !@manifestation.respond_to?(:cost)
  end
  
  def test_mandatory_title
    @manifestation.manifestation_title = nil
    assert !@manifestation.save
  end
  
  
  def test length_of_manifestation_name
    test_long_value_boundaries_of_model_field(@manifestation, :manifestation_title, 2, 100)
  end
  
  def test_necessary_title
    @manifestation.manifestation_title = nil
    assert !@manifestation.save
  end
  
  def test_necessary_status
    @manifestation.status = nil
    assert !@manifestation.save
  end
  
  def test_optional_general_note
    @manifestation.general_note = nil
    assert @manifestation.save
  end
  
  def test_optional_internal_note
    @manifestation.internal_note = nil
    assert @manifestation.save
  end
  
  
  def test_empty_duration_field
    @manifestation.duration = ""
    assert !@manifestation.save
  end
  
  
  def test_empty_format
    @manifestation.format = nil
    assert !@manifestation.save
  end
  
  def test_empty_type
    @manifestation.manifestation_type = nil
    assert !@manifestation.save
  end
  
  
  def test_duration_hours_mins_secs
    @manifestation.duration = "1:20:30"
    assert @manifestation.save
    
    @manifestation.duration = "1001:20:30"
    assert @manifestation.save
    
    @manifestation.duration = "00:20:30"
    assert @manifestation.save
  end
  
  
  def test_validate_new_does_not_break
    m = Manifestation::new
    assert !m.save
  end
  
  def test_nil_duration
    @manifestation.duration = nil
    assert @manifestation.save
  end
  
  
  def test_invalid_durations
    for invalid_duration in ["12:10","poaiopsdf", "oisadfioasdiofuo", "123786", "20 past 7", " a while", "20 minutes long"]
      @manifestation.duration = invalid_duration
      assert !@manifestation.save
    end
    
    @manifestation.duration = "1:2:3"
    assert !@manifestation.save
    
    @manifestation.duration = "00:20:3"
    assert !@manifestation.save
    
    @manifestation.duration = "00:2:30"
    assert !@manifestation.save
    
    @manifestation.duration = ":2:30"
    assert !@manifestation.save
  end
  
  
  
  def test_valid_publication_year
    @manifestation.publication_year = 1972
    assert @manifestation.save
  end
  
  def test_too_early_publication_year
    @manifestation.publication_year = 1839
    assert !@manifestation.save
  end
  
  def test_invalid_future_publication_year
    @manifestation.publication_year = @current_year+2
    assert !@manifestation.save
  end
  
  
  
  #--------- TESTS FOR ADDING AN EXPRESSION TO A MANIFESTATION ----
  
  #Find an existing expression and attach it - this should work though semantically does not make any sense
  def test_add_valid_expression
      n_manifestations = Manifestation.count
      expression = Expression.find(:first)
      assert_equal true, @manifestation.add_expression(expression)
      join_objects = ExpressionManifestation.find(:all, 
        :conditions => ["expression_id = ? and manifestation_id = ?",expression.expression_id,@manifestation.manifestation_id])
      assert_equal 1, join_objects.length  
      
  end
  
  
  def test_add_invalid_expression
      n_manifestations = Manifestation.count
      expression = Expression.new
      assert_equal false, @manifestation.add_expression(expression)
      assert_equal n_manifestations, Manifestation.count
  end
  
  
  def test_publication_year_or_zero
    @manifestation.publication_year = 2007
    assert_equal  2007, @manifestation.publication_year_or_zero
    
    @manifestation.publication_year = nil
    assert_equal  0, @manifestation.publication_year_or_zero
  end
  
  
  
  def test_destruction
    m = Manifestation.find(9000)
    
    puts "Manifestation 9000 has #{m.relationships.length} relationships"
    
    #This is a expression manifestation rel
    rel = m.relationships[0]
    puts EntityType.find(rel.entity_type_id).entity_type
    puts EntityType.find(rel.ent_entity_type_id).entity_type
    n_manifestation_rels = ManifestationRelationship.count
    n_expression_rels = ExpressionRelationship.count
    n_rels = Relationship.count
    
    m.destroy
    
    #check its been destroyed
    assert_raise ActiveRecord::RecordNotFound do
        m.reload
    end
    
    puts "Number of manifestation rels before was #{n_manifestation_rels}"
    puts "Number now:#{ManifestationRelationship.count}"
    assert_equal n_expression_rels -1, ExpressionRelationship.count
    assert_equal n_rels-1, Relationship.count
    assert_equal n_manifestation_rels -1, ManifestationRelationship.count

  end
  
  #test that deleting a relationship deletes dependent entries also
  def test_relationship_deletion
    #This is a superwork work rel
    rel = Relationship.find(309)
    n_superwork_rels = SuperworkRelationship.count
    n_work_rels = WorkRelationship.count
    
    rel.destroy
    assert_raise ActiveRecord::RecordNotFound do
        rel.reload
    end
    
    #check dependent columns are deleted
    assert_equal n_superwork_rels-1, SuperworkRelationship.count
    assert_equal n_work_rels -1, WorkRelationship.count
  end
  
  
  
end
