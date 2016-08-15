#This is used to store the details of a CRM borrowed items search in order to render the form.
#Note these details are NOT saved in the database, they are merely collected here for convenience.
#A serialised version of the object could be saved, this would provide for a "saved search" option
class CrmBorrowedItemsSearchDetails
  
  attr_reader :item_title, :borrower_login, :borrower_name, :borrowing_note, :date_borrowed_from,
              :date_borrowed_to, :date_due_from, :date_due_to, :status,
                           
              # 'not' fields
              :item_title_not, :borrowing_note_not
              
            
  attr_writer :item_title, :borrower_login, :borrower_name, :borrowing_note, :date_borrowed_from,
              :date_borrowed_to, :date_due_from, :date_due_to, :status,
                           
              # 'not' fields
              :item_title_not, :borrowing_note_not
 
  
end