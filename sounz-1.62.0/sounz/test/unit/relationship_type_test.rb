require File.dirname(__FILE__) + '/../test_helper'

class RelationshipTypeTest < Test::Unit::TestCase

  def test_for_no_duplicates
    types = RelationshipType.find(:all, :order => :relationship_type_desc)
    for type in types
      saved_ok = type.save
      puts "(#{saved_ok}) - "+type.relationship_type_desc+", "+ RelationshipType.find(type.inverse).relationship_type_desc
      assert saved_ok
    end
  end
end
