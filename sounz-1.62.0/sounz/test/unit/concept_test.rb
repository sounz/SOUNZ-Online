require File.dirname(__FILE__) + '/../test_helper'

class ConceptTest < Test::Unit::TestCase


  def setup
    @concept = Concept.find(:first)
  end
  
  def test length_of_concept_name
    test_long_value_boundaries_of_model_field(@concept, :concept, 2, 100)
  end
  
  def test_optional_description
    @concept.concept_description = nil
    assert @concept.save
  end
  
  def test_bad_concept_type
    @concept.concept_type_id=100
    saved = @concept.save
    puts "Concept type saved:#{saved}"
  end
  
  def test_cant_do_sub_sub_concept
    
    sub_concept = @concept.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => 2)
    assert sub_concept.save
    
    puts "CREATING SUB SUB CONCEPT"
    sub_sub_concept = sub_concept.children.create(:updated_by => 1000, :concept_name => "Space 2", :concept_type_id => 3)
    saved = sub_sub_concept.save
    puts "Sub concept saved? #{saved}"

    assert !saved
    
    puts sub_sub_concept.parent.parent
  end
  
  
  def test_ui_desc_with_parent
    @concept = Concept.find(:first, :conditions => ["parent_id is not null"])
    assert @concept.frbr_ui_desc.include?('/')
  end
  
  
  def test_ui_desc_without_parent
    @concept = Concept.find(:first, :conditions => ["parent_id is null"])
    assert !@concept.frbr_ui_desc.include?('/')
  end
  
  
  def test_unique_children
    puts "Testing unique children"
    @parent_concepts = Concept.find(:all, :conditions => ["parent_id is null"],
                        :order => 'concept_type_id, concept_name')
    puts "n parent concepts = #{@parent_concepts.length}"
    for pc in @parent_concepts
      puts pc.frbr_ui_desc
      for kid in pc.children
        puts "\t#{kid.frbr_ui_desc}"
      end
      puts "------------"
      puts
      puts
      puts
    end
    puts "/test"
  end
  
  
  #Test the antartica bug that highlighted the initial problem
  def test_antartica
    #landscape other, influence, parent
    landscape_other_influence = Concept.find(24)
    assert_equal "Landscape - other", landscape_other_influence.concept_name
    antarctica_ct = 0
    for kid in landscape_other_influence.children
      if kid.concept_name.include?("Antarctica")
        puts "FOUND Antartica"
        antarctica_ct = antarctica_ct + 1
      end
    end
    
    assert_equal 1, antarctica_ct
  end
  
  

end
