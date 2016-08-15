class BorrowedItem < ActiveRecord::Base

  set_primary_key 'borrowed_item_id'
  set_sequence_name 'borrowed_items_borrowed_item_id_seq'

  belongs_to :item
  belongs_to :login

  # for searching borrowed_items
  acts_as_solr :fields => [
    :item_title_for_solr,
    :date_borrowed_for_solr,
    :date_due_for_solr, 
    :borrowing_note_for_solr,
    :borrower_login_for_solr,
    :borrowed_status_for_solr,
    :overdue_status_for_solr,
    :borrower_names_for_solr
  ]
  
  def self.statuses
    {
      "overdue" => 'overdue',
      "pending overdue" => 'pendingoverdue',
      "borrowed" => 'borrowed',
      "returned" => 'returned'
    }
  end
  
  # solr fields in the appropriate format
  def item_title_for_solr
    return FinderHelper.strip(item.item_title)
  end
  
  def date_borrowed_for_solr
    return FinderHelper.strip(date_borrowed.strftime("%Y%m%d").to_i) unless date_borrowed.blank?
  end
  
  def date_due_for_solr
    return FinderHelper.strip(date_due.strftime("%Y%m%d").to_i) unless date_due.blank?
  end
  
  def borrowing_note_for_solr
    return FinderHelper.strip(borrowing_note)
  end
  
  def borrower_login_for_solr
    return FinderHelper.strip(borrower_login)
  end

  def borrowed_status_for_solr
    return date_returned.blank? ? 'borrowed' : 'returned'
  end
  
  def borrower_names_for_solr
    return FinderHelper.strip(borrower_names.join(", "))
  end
  
  # currently, we have 2 'overdue' statuses:
  # Overdue, Pending Overdue
  def overdue_status_for_solr
    status = ''
    today = Date.today
    if date_returned.blank? && active
      status = 'overdue' if date_due < today || date_due == today
      # due within 14 days of today's date
      status = 'pendingoverdue' if date_due > today && date_due < today+(14)
    end

    return status
  end

  def borrower_login
    return login.username
  end
  
  # names assigned to the borrowed item login
  # person and organisation names returned as an array
  def borrower_names
    names = Array.new
    names.push(login.person.full_name) unless login.person.blank?
    names.push(login.organisation.organisation_name, login.organisation.organisation_abbrev) unless login.organisation.blank?

    return names
  end
end
