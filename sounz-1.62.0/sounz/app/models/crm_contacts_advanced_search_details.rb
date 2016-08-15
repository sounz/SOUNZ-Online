#This is used to store the details of an advanced CRM contacts search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class CrmContactsAdvancedSearchDetails
  
  attr_reader :person, :role_title, :organisation_name, :organisation_abbrev, :locality,
              :postcode, :created_at_from, :created_at_to, :updated_at_from, :updated_at_to,
              :internal_note, :person_internal_note, :saved_list, :marketing_campaign, :country_id, :region_id, 
              :category_filter, :role_id_ids, :membership_id_ids, :role_status_id_ids, 
			  :contributor_status_id_ids, :role_contactinfo_type, :has_person, :has_contributor, :has_email, :has_website, 
			  :has_phone,
              
              # 'not' fields
              :person_not, :role_title_not, :organisation_name_not, :organisation_abbrev_not,
              :locality_not, :postcode_not, :internal_note_not, :person_internal_note_not, :saved_list_not, :marketing_campaign_not,
              :country_id_not
              
            
  attr_writer :person, :role_title, :organisation_name, :organisation_abbrev, :locality,
              :postcode, :created_at_from, :created_at_to, :updated_at_from, :updated_at_to,
              :internal_note, :person_internal_note, :saved_list, :marketing_campaign, :country_id, :region_id, 
              :category_filter, :role_id_ids, :membership_id_ids, :role_status_id_ids, 
			  :contributor_status_id_ids, :role_contactinfo_type, :has_person, :has_contributor, :has_email, :has_website, 
			  :has_phone,
              
              # 'not' fields
              :person_not, :role_title_not, :organisation_name_not, :organisation_abbrev_not,
              :locality_not, :postcode_not, :internal_note_not, :person_internal_note_not, :saved_list_not, :marketing_campaign_not,
              :country_id_not
 
  
end