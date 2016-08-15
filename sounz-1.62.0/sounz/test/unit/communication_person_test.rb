require File.dirname(__FILE__) + '/../test_helper'

class CommunicationPersonTest < Test::Unit::TestCase
  
  def setup
    @comm_peep = communication_people(:cp_1, :communication, :person)
    @role = @comm_peep.role
  end
  
  def test_optional
    check_optional_fields(@comm_peep, [:role])
  end
  
  def test_necessary
    check_necessary_fields(@comm_peep, [:person,:communication])
  end
  
  # ------------------------------------------------------------------
  # - This join has a person id, as does the role - check they match -
  # ------------------------------------------------------------------
  def test_person_and_role_id_match
    assert @role.person_id == @comm_peep.person_id
    
    # Choose a difference person
    @role.person_id = @role.person_id + 1
   
    # The person id in the join is different from the role so this should fail
    assert !@comm_peep.save
    
    check_for_error_messages(["associated with the role does not belong to the same person as the communication"], @comm_peep, :person_id)
  end
  
  
  def test_can_only_belong_to_one_person
    #Check the ids are happy
    assert @role.person_id == @comm_peep.person_id
    assert @comm_peep.save
    
    
    #Create another person linked to the same communication
    new_person_id = @role.person_id+1
    new_role = Role.find(:first, :conditions =>["person_id = ?",new_person_id])
    assert new_role != nil
    
    assert new_role.person_id != @role.person_id
    
    @comm_peep2 = CommunicationPerson.new(:person_id => new_person_id, :communication_id => @comm_peep.communication_id, :role_id => new_role.role_id)
    
    
    saved_ok = @comm_peep2.save
    puts @comm_peep2.errors.to_xml
    assert !saved_ok
    check_for_error("A communication can only be associated with one person is thus invalid", @comm_peep, :person_id)
  end
  
  
   def test_cant_have_same_person_and_communication_twice
   #Check the ids are happy
    assert @role.person_id == @comm_peep.person_id

     
    @comm_peep2 = @comm_peep.clone
    saved_ok = @comm_peep2.save
   puts @comm_peep2.errors.to_xml
    assert !saved_ok
    check_for_error("A communication can only be associated with one person is thus invalid", @comm_peep, :person_id)
  end
  
end
