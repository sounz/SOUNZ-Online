class CommunicationPerson < ActiveRecord::Base
  set_primary_key :communication_person_id
  belongs_to :communication
  belongs_to :person
  
  #Role is optional
  belongs_to :role
  
  validates_associated :role,:if => Proc.new {|u| !u.role.blank?}
  
  
  #Check for key for communication
  validates_presence_of :communication
  validates_associated :communication
  
  #Check for key for person
  validates_presence_of :person
  validates_associated :person
  
  
  
  #Check that 
  #<ul>
  #<li>the role belongs to the correct person</li>
  #FIXME: Check for multiple people associated with the same communication
  #</ul>
  def validate
    
    if role != nil
      puts "Checking role person id of "+role.person_id.to_s+" matched with "+person_id.to_s
      if role.person_id != person_id
        errors.add :person_id, "associated with the role does not belong to the same person as the communication"
      end
    end
  end
  
  
  
end
