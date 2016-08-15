require File.dirname(__FILE__) + '/../test_helper'

class CommunicationTest < Test::Unit::TestCase
  
  
  
  def setup
    @communication = Communication.find(:first)
    @person = Person.find(:first) # needed for testing comms
    @person2 = Person.find(:all, :limit =>2)[1] # used for testing multiple peeps in comms
    
    #These should all increment by one
    @number_of_comms = Communication.count
    @number_of_roles = Role.count
    @number_of_comm_peeps = CommunicationPerson.count
  end
  
  # Communication subject must be specified
  def test_necessary_existence_of_communication_subject
    test_necessary_existence_of_model_field("cannot be empty", @communication, :communication_subject)
  end
  
  # Communication note must be specified
  def test_necessary_existence_of_communication_note
    puts @communication.communication_note
    test_necessary_existence_of_model_field("cannot be empty", @communication, :communication_note)
  end
  
  # Communication agent class can only be P or O from the datamodel
  def test_communication_agent_class_is_person_or_organisation
    orig_class = @communication.communication_agent_class
    
    @communication.communication_agent_class = 'A'
    assert !@communication.save
    
    @communication.communication_agent_class = 'O'
    assert @communication.save
    
    @communication.communication_agent_class = orig_class
    assert @communication.save
  end
  
  # Communication priorities are defined in the communication model as a static method
  def test_communication_priorities
    [-1, 5, 6].each do |i|
      @communication.priority = i
      assert !@communication.save
    end
    
    [0, 4].each do |i|
      @communication.priority = i
      assert @communication.save
    end
  end
  
  # The only allowed statuses are currently 'o' and 'c'
  def test_statuses
    ['o', 'c'].each do |i|
      @communication.status = i
      assert @communication.save
    end
    
    ['a', 'Z', '0'].each do |i|
      @communication.status = i
      assert !@communication.save
    end
  end
  
  
  
  
  #------------------
  #- Add a valid communication
  #------------------
  
  def test_add_valid_communication
    
       # Create a new role to ensure the correct person id
    # Note that from the web interface, the role will already exist
    role = create_role(@person.person_id)
    assert role.save
    
    
    #Create a communication but dont save it just yet 
    communication = create_communication
    
    #Check that the communication is saved and added to the person
    assert  @person.add_communication(communication, role)
    
    #Assert that each of communications, roles and the join table are incremented by one
    assert(@number_of_comms+1 == Communication.count)
    assert(@number_of_roles+1 == Role.count)
    assert(@number_of_comm_peeps+1 == CommunicationPerson.count)
    
    
    #Check that the communication has been added
    assert(@person.communications.include?(communication), "Communication should be associated with person")
    
    
    #Now check the join table and ensure that only one person is associated with the communication - this is a business logic requirement
    cps = CommunicationPerson.find(:all, :conditions => ["person_id = ? and communication_id = ?",@person.person_id, communication.communication_id])
    
    # The business logic is such that a communication can only belong to one person
    assert cps.length == 1
    
    #Now check the role is set properly
    cp = cps[0]
    
    
    # Check the role is correct
    
    puts "Comm role is "+cp.role_id.to_s
    puts "original role id is #{role.role_id}"
    assert cp.role == role
    
    # Check that the communication only has one person
    spods = communication.people
    assert spods.length == 1
    
    # and that the person is the original person
    assert spods[0] == @person
    
    
  end
  
  
  
  
  #------------------
  #- Check that a communication with a nil role still saves ok
  #------------------
  
  def test_add_communication_with_nil_role
    
     
    #Create a communication but dont save it just yet 
    communication = create_communication
    
    #Check that the communication is saved and added to the person - the role is allowed to be nil
    assert(@person.add_communication(communication, nil), "person communication with nil role should still work")

    
    #Assert that each of communications, roles and the join table are incremented by one
    assert(@number_of_comms+1 == Communication.count)
    assert(@number_of_roles == Role.count)
    assert(@number_of_comm_peeps +1 == CommunicationPerson.count)
    
    
    #Check that the communication has been added
    assert(@person.communications.include?(communication), "Communication should be associated with person")
    
    
    #Now check the join table and ensure that only one person is associated with the communication - this is a business logic requirement
    cps = CommunicationPerson.find(:all, :conditions => ["person_id = ? and communication_id = ?",@person.person_id, communication.communication_id])
    
    # The business logic is such that a communication can only belong to one person
    assert cps.length == 1
    
    #Now check the role is set properly
    cp = cps[0]

    
    # Check that the communication only has one person
    spods = communication.people
    assert spods.length == 1
    
    # and that the person is the original person
    assert spods[0] == @person
    
    
  end
  
  
  
  
  
  
  #------------------
  #- Add a communication with an invalid role (person ids dont match)
  #------------------
  
  def test_add_communication_invalid_role_person_id
    
    # Create a new role  to ensure an incorrect person id
    # Note that from the web interface, the role will already exist
    role = create_role(@person2.person_id)
    assert role.save
    
    #Create a communication but dont save it just yet 
    communication = create_communication
    
    #Check that the communication is saved and added to the person
    assert  !@person.add_communication(communication, role)
    
    assert_increment_of_one
    
    #Check that the communication has been added
    assert(!@person.communications.include?(communication), "Communication should not have been added to the invalid person")
    
    
    #Now check the join table and ensure that only one person is associated with the communication - this is a business logic requirement
    cps = CommunicationPerson.find(:all, :conditions => ["person_id = ? and communication_id = ?",@person.person_id, communication.communication_id])
    
    # The business logic is such that a communication can only belong to one person
    assert cps.length == 0

    # Check that the communication only has one person
    spods = communication.people
    assert spods.length == 0
    
  end
  
  
  def assert_increment_of_one
  #Assert that each of communications, roles and the join table are incremented by one
    assert(@number_of_comms == Communication.count)
    assert(@number_of_roles+1 == Role.count)
    assert(@number_of_comm_peeps == CommunicationPerson.count)
  end
  
  
  
  #------------------
  #- Add two people to a communication - this should fail to comply with business logic
  #------------------
  
  def test_add_communication_to_two_people

    # Create a new role to ensure the correct person id
    # Note that from the web interface, the role will already exist
    role = create_role(@person.person_id)
    assert role.save
    
    role2 = create_role(@person2.person_id)
    role2.save
    
    #Create a communication but dont save it just yet 
    communication = create_communication
    
    #Check that the communication is saved and added to the person
    assert  @person.add_communication(communication, role)
    
    #Try to add the same communication to another person - this should fail
    assert  !@person2.add_communication(communication, role2)
    
    assert_increment_of_one
    
    #Check that the communication has been added
    assert(@person.communications.include?(communication), "Communication should be associated with person")
    
    #Now check the join table and ensure that only one person is associated with the communication - this is a business logic requirement
    cps = CommunicationPerson.find(:all, :conditions => ["person_id = ? and communication_id = ?",@person.person_id, communication.communication_id])
    
    # The business logic is such that a communication can only belong to one person
    assert cps.length == 1
    
    #Now check the role is set properly
    cp = cps[0]
    
    
    # Check the role is correct
    
    puts "Comm role is "+cp.role_id.to_s
    puts "original role id is #{role.role_id}"
    assert cp.role == role
    
    # Check that the communication only has one person
    spods = communication.people
    assert spods.length == 1
    
    # and that the person is the original person
    assert spods[0] == @person
    
    
  end
  
  
  # A communication needs to be linked to a person or organisation, it cannot exist stand alone
  # So create a communication stand alone and check it cannot be saved
  def test_communication_without_organisation_or_people
    communication = create_communication
    assert !communication.save
     puts 
  end
  
  
  # One can only add a communication to a person or an organisation, not both
  def test_communication_with_person_and_organisation
     raise NotImplementedError, 'Need to test a communication with both a person and an organisation'

  end
  
  def test_same_communication_with_two_organisations
     raise NotImplementedError, 'Need to test communications with two or more organisations'
  end
  
  
  
  
  
  #- DATE TESTS -
  def test_start_date_after_now
     raise NotImplementedError, 'Need to test a start date of later than now'
  end
  
  def test_start_date_after_closing_date
     raise NotImplementedError, 'Need to test an early closing date'
  end
  
  #------------------
  #- Create a communication for testing purposes
  #------------------
  
  def create_communication
    return Communication.new({
      :communication_type_id => 1,
      :communication_method_id => 1,
      :communication_agent_class => 'P',
      :communication_subject => 'Test communication',
      :communication_note => 'Note about test communication',
      :priority => 1,
      :status => 'o'
    }
    )
  end
  
  
  #------------------
  #- Create a test role
  #------------------
  
  def create_role(person_id)
    Role.new(
             :role_type_id => 20,
             :person_id => person_id,
             :organisation_id => 1,
             :contactinfo_id => 300,
             :role_title => 'Test role for person '+person_id.to_s,
    :general_note => 'Test note for person '+person_id.to_s
    )
  end
  
end
