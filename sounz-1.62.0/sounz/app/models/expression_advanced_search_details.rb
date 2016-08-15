#This is used to store the details of an advanced contributor search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised verison of the object could be saved, this would provide for a "saved search" option
class ExpressionAdvancedSearchDetails
  
  attr_reader :title, :mode_id, :edition, :expression_start_from, :expression_start_to, :expression_finish_from, :expression_finish_to, 
              :premiere, :partial_expression, :has_manifestation, :players_count_param, :players_count, :restriction, :general_note, 
			  :internal_note, :relationship_type, :relationship_text, :status_id,
			  
			  # not fields 
			  :title_not, :mode_id_not, :edition_not, :premiere_not, :general_note_not, 
			  :internal_note_not, :relationship_not, :status_id_not
              
  attr_writer :title, :mode_id, :edition, :expression_start_from, :expression_start_to, :expression_finish_from, :expression_finish_to, 
              :premiere, :partial_expression, :has_manifestation, :players_count_param, :players_count, :restriction, :general_note, 
              :internal_note, :relationship_type, :relationship_text, :status_id,
  
              # not fields 
              :title_not, :mode_id_not, :edition_not, :premiere_not, :general_note_not, 
              :internal_note_not, :relationship_not, :status_id_not

  
end