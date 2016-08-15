require File.dirname(__FILE__) + '/../test_helper'



class RelationshipHelperTest < Test::Unit::TestCase

  
  # grab a work that is populated
  def setup
    @work = Work.find(12447)
  end

  #Delete all comopsers from a work
  def test_delete_all_frbr_relationships
    puts "Work cmopsers are #{@work.composers}"
    assert @work.composers.length == 1
    
    @role = @work.composers[0]
    puts @role
    RelationshipHelper.delete_all_frbr_relationships(:work, 12447, :is_composed_by)
 #   @work.reload
    assert @work.composers.length == 0
 
    
    puts "** LEN OF COMPS = #{@role.compositions.length}"
    assert @role.compositions.length == 71
    
    RelationshipHelper.delete_all_frbr_relationships(:role, @role.role_id, :composes)
    assert @role.compositions.length == 0
  end
  
  
  #Test that one can delete a single FRBR relationship
  def test_single_frbr_deletion
    #find the total number of relationships - dont wanna delete more than we have to..
    total_rels = Relationship.count
    work_rels = WorkRelationship.count
    role_rels = RoleRelationship.count
    
    assert @work.composers.length == 1
    relationship_type_id = RelationshipType.find_by_symbol(:is_composed_by).relationship_type_id
    wr = WorkRelationship.find(:first, :conditions => ["work_id = ? and relationship_type_id = ?",
       @work.work_id, relationship_type_id])
    puts "****"
    puts wr
    puts "****"
    
    #Get the relationship id
    relationship = wr.relationship
    
    #grab a role relationship
    rr = RoleRelationship.find(:first, :conditions => ["relationship_id=?", relationship.relationship_id])   
    related_role = rr.role
    
    puts related_role
    
    #ok we have got this far, we have
    #* a known work
    #* a known relationship type
    #* a know role
    #so lets dlete it
    valid_save = RelationshipHelper.delete_frbr_relationship(:work, @work.work_id, :is_composed_by,
                                                                            :role, related_role.role_id)
    assert valid_save
    assert_equal 0, @work.composers.length
    
    #Check relevant tables have reduced in size by 1
    assert_equal total_rels -1, Relationship.count
    assert_equal work_rels-1, WorkRelationship.count
    assert_equal role_rels-1, RoleRelationship.count
    
    #Check the original rels are now invalid, ie findable in the db
    
    #first the work relationship
    assert_raise ActiveRecord::RecordNotFound do
        wr.reload
    end
    
    #secondly the role relationship
    assert_raise ActiveRecord::RecordNotFound do
        rr.reload
    end


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
