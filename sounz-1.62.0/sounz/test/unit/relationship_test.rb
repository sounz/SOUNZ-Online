require File.dirname(__FILE__) + '/../test_helper'

class RelationshipTest < Test::Unit::TestCase

  def test_adding_rel_does_not_feck_up
    RelationshipTypesHelper.add_restriction(:work, :is_evidence_of, :superwork, ["superwork_evidences", "works_evidenced"])
    assert true #if we reach here that is, fix for change in primary key
  end
  
  def test_is_user_maintainable
    rels = Relationship.find(:all, :limit => 100)
    for rel in rels
      puts rel.relationship_id
      puts rel.is_editable?
      puts
    end
  end
  
  
  #Double check that each relationship has an inverse
  def play_test_no_hanging_relationships
    for rel_id in Relationship.find(:all)
      n = RoleRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      SuperworkRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      DistinctionRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      WorkRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      EventRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      ExpressionRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      VenueRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      ResourceRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      ManifestationRelationship.count(:conditions => ["relationship_id = ?", rel_id])+
      ConceptRelationship.count(:conditions => ["relationship_id = ?", rel_id])
      if n != 2
        puts "BROKEN REL:#{rel_id}"
      end
    end
  end
end
