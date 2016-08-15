#This is used to store the details of an advanced contributor search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class EventAdvancedSearchDetails
  
  attr_reader :title, :venue, :general_note, :booking_ticket_note, 
              :locality, :prize_info_note, :internal_note,
              :event_type_id, :region_id, :country_id, :status_id,
              :event_start_from, :event_start_to,
              :title_not, :venue_not, :general_note_not, :booking_ticket_note_not, 
             :locality_not, :prize_info_note_not, :internal_note_not,
              :event_type_id_not, :region_id_not, :country_id_not, :status_id_not
              
  attr_writer             :title, :venue, :general_note, :booking_ticket_note, 
                          :locality, :prize_info_note, :internal_note,
                          :event_type_id, :region_id, :country_id, :status_id,
                          :event_start_from, :event_start_to,
                          :title_not, :venue_not, :general_note_not, :booking_ticket_note_not, 
                         :locality_not, :prize_info_note_not, :internal_note_not,
                          :event_type_id_not, :region_id_not, :country_id_not, :status_id_not


 
 #Do we have hte relevant data to make a solr search?
 def contains_solr_query_data?
   !(
     title.blank? and
     venue.blank? and
     general_note.blank? and
     booking_ticket_note.blank? and
     locality.blank? and
     prize_info_note.blank? and
     internal_note.blank? and
     event_start_from.blank? and
     event_start_to.blank? and
     region_id.blank? and
     country_id.blank? and
     locality.blank?
   )
 end
 
  def contains_sql_query_data?
   !(
     status_id.blank? and
     event_type_id.blank?
   )
  end
end