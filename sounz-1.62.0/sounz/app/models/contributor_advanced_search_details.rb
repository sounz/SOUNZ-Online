#This is used to store the details of an advanced contributor search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class ContributorAdvancedSearchDetails
  
  attr_reader :known_as, :year_of_birth, :profile, :pull_quote, :internal_note,
              :work_category_id, :work_subcategory_id, :role_type_id, :composer_status,:gender,
              #insert relationships info here
              :deceased, :apra, :canz, :status_id, :region_id, :country_id,
              
              :known_as_not, :year_of_birth_not, :profile_not, :pull_quote_not, :internal_note_not,
              :work_category_id_not, :work_subcategory_id_not, :role_type_id_not, :composer_status_not,
              :region_id_not, :country_id_not, :gender_not,
              #insert relationships not info here
              :deceased_not, :apra_not, :canz_not, :status_id_not
              
  attr_writer :known_as, :year_of_birth, :profile, :pull_quote, :internal_note,
              :work_category_id, :work_subcategory_id, :role_type_id, :composer_status, :gender,
              #insert relationships info here
              :deceased, :apra, :canz, :status_id, :region_id, :country_id,
              
              :known_as_not, :year_of_birth_not, :profile_not, :pull_quote_not, :internal_note_not,
              :work_category_id_not, :work_subcategory_id_not, :role_type_id_not, :composer_status_not,
              :region_id_not, :country_id_not, :gender_not,
              #insert relationships not info here
              :deceased_not, :apra_not, :canz_not, :status_id_not

 
 #Do we have hte relevant data to make a solr search?
 def contains_solr_query_data?
   !(known_as.blank? and 
     profile.blank? and
     pull_quote.blank? and
     internal_note.blank? and
     region_id.blank? and
     country_id.blank?
   )
 end
  
end