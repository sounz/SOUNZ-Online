#This is used to store the details of an advanced contributor search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class ManifestationResourceSearchDetails
  
  attr_reader :entity_to_search, :title, :author_note, :series_title, :publication_year, :isbn, :ismn, :isrc, :imprint,
              :publisher_note, :dedication_note, :general_note, :mw_code, :code, 
              :manifestation_type_id, :manifestation_type_format_id, 
              :resource_type_id, :resource_type_format_id,
              :main_category_id, :additional_subcategory_id, 
              :item_exists, :available_for_loan, :available_for_sale, 
              :available_for_hire, :cloneable, :status_id,
              :work_category_id, :work_subcategory_id,
              :work_title, :downloadable, :freight_code, :item_type_id, :internal_note, :created_at_from, :created_at_to,
              
              #the not cases.
              :title_not, :author_note_not, :series_title_not, :publication_year_not, :isbn_not, 
              :ismn_not, :isrc_not, :imprint_not,
              :publisher_note_not, :dedication_note_not, :general_note_not, :mw_code_not, :code_not, 
              :manifestation_type_id_not, :manifestation_type_format_id_not, 
              :resource_type_id_not, :resource_type_format_id_not,
              :main_category_id_not, :additional_subcategory_id_not, 
              :item_exists_not, :available_for_loan_not, :available_for_sale_not, 
              :available_for_hire_not, :cloneable_not, :status_id_not,
              :work_category_id_not, :work_subcategory_id_not,
              :work_title_not, :downloadable_not, :freight_code_not, :item_type_id_not, :internal_note_not

    attr_writer :entity_to_search, :title, :author_note, :series_title, :publication_year, :isbn, :ismn, :isrc, :imprint,
                :publisher_note, :dedication_note, :general_note, :mw_code, :code, 
                :manifestation_type_id, :manifestation_type_format_id, 
                :resource_type_id, :resource_type_format_id,
                :main_category_id, :additional_subcategory_id, 
                :item_exists, :available_for_loan, :available_for_sale, 
                :available_for_hire, :cloneable, :status_id,
                :work_category_id, :work_subcategory_id,
                :work_title, :downloadable, :freight_code, :item_type_id, :internal_note, :created_at_from, :created_at_to,

                #the not cases.
                :title_not, :author_note_not, :series_title_not, :publication_year_not, :isbn_not, 
                :ismn_not, :isrc_not, :imprint_not,
                :publisher_note_not, :dedication_note_not, :general_note_not, :mw_code_not, :code_not, 
                :manifestation_type_id_not, :manifestation_type_format_id_not, 
                :resource_type_id_not, :resource_type_format_id_not,
                :main_category_id_not, :additional_subcategory_id_not, 
                :item_exists_not, :available_for_loan_not, :available_for_sale_not, 
                :available_for_hire_not, :cloneable_not, :status_id_not,
                :work_category_id_not, :work_subcategory_id_not,
                :work_title_not, :downloadable_not, :freight_code_not, :item_type_id_not, :internal_note_not
                

                
 
 #Do we have hte relevant data to make a solr search?
 def contains_solr_query_data?
   !(title.blank? and work_title.blank? and author_note.blank? and series_title.blank? and
   publication_year.blank? and isbn.blank? and ismn.blank? and
   isrc.blank? and imprint.blank? and publisher_note.blank? and dedication_note.blank? and
   general_note.blank? and mw_code.blank? and code.blank? and
   status_id.blank? and
   downloadable.blank? and freight_code.blank? and item_type_id.blank? and
   internal_note.blank? and
   created_at_from.blank? and
   created_at_to.blank?
    )
 end
 
 def contains_sql_query_data?
   !(manifestation_type_id.blank? and
   	manifestation_type_format_id.blank? and 
	resource_type_id.blank? and
	resource_type_format_id.blank? and
	item_exists.blank? and
	available_for_loan.blank? and 
	available_for_sale.blank? and 
	available_for_hire.blank? and
	cloneable.blank?
    )	
 end
  
end