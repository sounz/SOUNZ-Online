#This is used to store the details of an CRM communication search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class CrmCommunicationSearchDetails
  
  attr_reader :associated_person, :associated_organisation_name, :associated_organisation_abbrev,
              :communication_subject, :communication_created_at_from, :communication_created_at_to,
              :communication_closed_at_from, :communication_closed_at_to, :communication_note,
              :communication_type_id_ids, :communication_method_id_ids, :communication_priority,
              :communication_status,
                           
              # 'not' fields
              :associated_person_not, :associated_organisation_name_not, :associated_organisation_abbrev_not,
              :communication_subject_not, :communication_note_not
              
            
  attr_writer :associated_person, :associated_organisation_name, :associated_organisation_abbrev,
              :communication_subject, :communication_created_at_from, :communication_created_at_to,
              :communication_closed_at_from, :communication_closed_at_to, :communication_note,
              :communication_type_id_ids, :communication_method_id_ids, :communication_priority,
              :communication_status,
                           
              # 'not' fields
              :associated_person_not, :associated_organisation_name_not, :associated_organisation_abbrev_not,
              :communication_subject_not, :communication_note_not
 
  
end