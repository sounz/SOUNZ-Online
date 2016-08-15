
#require 'finder_helper'
#
# Controller for searching borrowed items in the CRM
#
class SearchBorrowedItemsController < ApplicationController
  include FinderHelper
  
  #
  # Entry methods for users
  #

  def index
    # Set session variables
    if session[:selected_borrowed_items].blank?
      session[:selected_borrowed_items] = Hash.new
    end
    
    # reset search param
    if !params[:from].blank? && params[:from].match('reset_search')
      session[:crm_borrowed_items_search_details] = nil
    end
    
    # any previous borrowed items search in session?
    if session[:crm_borrowed_items_search_details] != nil
      @search = session[:crm_borrowed_items_search_details]
    else
      @search = CrmBorrowedItemsSearchDetails.new
    end
    
  end

  #
  # Finds borrowed items matching the search and renders the results partial
  #
  def find_borrowed_items
    
    # set saved search params only once from
    # params from the UI form
    if params[:page].to_i < 1
      prepare_saved_search_params
    end
     
    params[:search].to_yaml    
    @data = process_search(params[:search], params[:page].to_i)
  
    render :partial => 'borrowed_items_search_results_wrapper'
  end

  # -------------------------------------------
  # - Prepare saved search params             -
  # - in case if the search is going          -
  # - to be saved later                       -
  # -------------------------------------------
  def prepare_saved_search_params
    # get previous advanced search from session if any
    if session[:crm_borrowed_items_search_details] != nil
      @search = session[:crm_borrowed_items_search_details]
    else
      @search = CrmBorrowedItemsSearchDetails.new
    end
    
    new_search = false
    search_params = params[:search]
          
    if !search_params.blank?
      search_params.keys.map{ |k| new_search = true unless @search.send(k) == search_params[k] }
    else
      new_search = true
    end
    
    if new_search
      session[:crm_borrowed_items_search_details] = []
            
      if !search_params.blank?
        search_params.keys.map{|k| @search.send(k+'=', search_params[k])}
      end      
      session[:crm_borrowed_items_search_details] = @search
    end
    
  end
  
  #
  # Performs a search for borrowed items and returns various data about the search
  #
  def process_search(search_params, page)
    if !search_params
      flash[:search_error] = "No search was specified"
      return
    end

    page = 1 if page < 1
     
    results, paginator = find_borrowed_items_by_solr(search_params, page)
        
    {      
      :results            => results,
      :paginator          => paginator,
    }
  end
  
  #
  # Finds borrowed items using solr to search
  #
  def find_borrowed_items_by_solr(search_params, page)
    flash[:search_error] = nil

    options = {:q => []}
        
    fields = []
    
    # fields with 'not' check boxes checked
    not_fields = []
    
    borrowed_items  = []
    paginator = nil

    # some fields have 'not' check boxes
    # distribute where to put fields based
    # on checked or not checked 'not' boxes
    item_title_field = AdvancedFinderHelper.create_search_term_if_not_blank('item_title_for_solr_t',  
                                                                    search_params[:item_title])
    fields     << item_title_field if search_params[:item_title_not] != '1'
    not_fields << item_title_field if search_params[:item_title_not] == '1'
        
    borrowing_note_field = AdvancedFinderHelper.create_search_term_if_not_blank('borrowing_note_for_solr_t', 
                                                                                     search_params[:borrowing_note])
    fields     << borrowing_note_field if search_params[:borrowing_note_not] != '1'
    not_fields << borrowing_note_field if search_params[:borrowing_note_not] == '1'
        
    # fields without 'not' check boxes
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('borrower_login_for_solr_t',      
                                                                    search_params[:borrower_login])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('borrower_names_for_solr_t', 
                                                                    search_params[:borrower_name])
    
    # Remove nil fields
    fields.map{|f| fields.delete(f) if f.blank?}
    not_fields.map{|nf| not_fields.delete(nf) if nf.blank?}

    # preparing options
    # those are special processing fields, they form a query string in a hash to be processed by solr_query
    # which will be added to a base query as it is
    # dates processing
    date_borrowed_search = AdvancedFinderHelper.create_range_search_term('date_borrowed_for_solr_t', search_params, :date_borrowed_from, :date_borrowed_to)
    date_due_search = AdvancedFinderHelper.create_range_search_term('date_due_for_solr_t', search_params, :date_due_from, :date_due_to)
    
    options[:q] << "AND #{date_borrowed_search}" unless date_borrowed_search.blank?
    options[:q] << "AND #{date_due_search}" unless date_due_search.blank?   
  
    unless search_params[:status].blank?
      options[:q] << 'AND (borrowed_status_for_solr_t:(' + search_params[:status] + ') '
      options[:q] << 'OR overdue_status_for_solr_t:(' + search_params[:status] + '))'
    end
    
    # sort by date_due, showing the oldest first
    options[:sort] = 'date_due_for_solr_t asc'
    
    options[:rows] = 10
    options[:page] = page

    # prepare a query        
    query = FinderHelper.build_advanced_query(BorrowedItem, fields, '', not_fields)
    query = FinderHelper.make_query_more_exact(query) 
        
    borrowed_items, paginator = solr_query(query, options)
    
    # convert each borrowed item back to its raw type
    borrowed_items[:docs].map! { |bi| bi.objectData}
                
    [borrowed_items, paginator]
  end

end
