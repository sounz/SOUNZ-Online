
#require 'finder_helper'
#
# Controller for searching communications in the CRM
#
class SearchCommunicationsController < ApplicationController
  include FinderHelper
  
  #
  # Entry methods for users
  #

  def index
    # Set session variables
    if session[:selected_communications].blank?
      session[:selected_communications] = Hash.new
    end
    
    # reset search param
    if !params[:from].blank? && params[:from].match('reset_search')
      session[:crm_communication_search_details] = nil
    end
    
    # any previous communication search in session?
    if session[:crm_communication_search_details] != nil
      @search = session[:crm_communication_search_details]
    else
      @search = CrmCommunicationSearchDetails.new
    end
    
  end

  #
  # Finds communications matching the search and renders the results partial
  #
  def find_communications
    
    # set saved search params only once from
    # params from the UI form
    if params[:page].to_i < 1
      prepare_saved_search_params
    end
     
    params[:search].to_yaml    
    @data = process_search(params[:search], params[:page].to_i)
    
    # decide whether to edit communication in the context of person
    # or organisation
    if !params[:search][:associated_person].blank?
      @from = 'person'
    elsif !params[:search][:associated_organisation_name].blank? || !params[:search][:associated_organisation_abbrev].blank?
      @from = 'organisation'
    else
      @from = 'person'
    end
    
    render :partial => 'communication_search_results_wrapper'
  end

  # FIXME do some cleaning in the method
  # -------------------------------------------
  # - Prepare saved search params             -
  # - in case if the search is going          -
  # - to be saved later                       -
  # -------------------------------------------
  def prepare_saved_search_params
    # get previous advanced search from session if any
    if session[:crm_communication_search_details] != nil
      @search = session[:crm_communication_search_details]
    else
      @search = CrmCommunicationSearchDetails.new
    end
    
    newSearch=false
    search_params = params[:search]
          
    if !search_params.blank?
      search_params.keys.map{ |k| 
      if @search.send(k) != search_params[k]
        newSearch=true
       
      end
      }
    else
      newSearch=true
    end
    
    if newSearch
      session[:crm_communication_search_details]=[]
            
      if !search_params.blank?
        search_params.keys.map{|k| @search.send(k+'=', search_params[k])}
      end      
      session[:crm_communication_search_details] = @search
    end
    
  end
  
  #
  # Performs a search for communications and returns various data about the search
  # TODO simplify
  def process_search(search_params, page)
    if !search_params
      flash[:search_error] = "No search was specified"
      return
    end

    page = 1 if page < 1
        
    search_params[:communication_type_id_ids]     ||= []
    search_params[:communication_type_id_ids]       = search_params[:communication_type_id_ids].reject{ |r| r.blank? }
    search_params[:communication_type_id_ids]       = search_params[:communication_type_id_ids].join(', ')
    search_params[:communication_method_id_ids]   ||= []
    search_params[:communication_method_id_ids]     = search_params[:communication_method_id_ids].reject{ |m| m.blank? }
    search_params[:communication_method_id_ids]     = search_params[:communication_method_id_ids].join(', ')
        
    search_params[:communication_closed_at_from_s]  = (Time.parse(search_params[:communication_closed_at_from]) rescue Time.now).to_i.to_s if !search_params[:communication_closed_at_from].blank?
    search_params[:communication_closed_at_to_s]    = (Time.parse(search_params[:communication_closed_at_to]) rescue Time.now).to_i.to_s if !search_params[:communication_closed_at_to].blank?
    search_params[:communication_created_at_from_s] = (Time.parse(search_params[:communication_created_at_from]) rescue Time.now).to_i.to_s if !search_params[:communication_created_at_from].blank?
    search_params[:communication_created_at_to_s]   = (Time.parse(search_params[:communication_created_at_to]) rescue Time.now).to_i.to_s if !search_params[:communication_created_at_to].blank?
       
    results, paginator = find_communications_by_solr(search_params, page)
        
    {      
      :results            => results,
      :paginator          => paginator,
    }
  end
  
  #
  # Finds communications using solr to search
  #
  def find_communications_by_solr(search_params, page)
    flash[:search_error] = nil

    options = {:q => []}
        
    fields = []
    
    # fields with 'not' check boxes checked
    not_fields = []
    
    communications  = []
    paginator = nil
        
    # dates processing
    # created_at
    communication_created_at_from   = "*"
    communication_created_at_from   = search_params[:communication_created_at_from_s] if !search_params[:communication_created_at_from_s].blank?
    communication_created_at_to     = "*"
    communication_created_at_to     = search_params[:communication_created_at_to_s]   if !search_params[:communication_created_at_to_s].blank?
    
    # closed_at
    communication_closed_at_from   = "*"
    communication_closed_at_from   = search_params[:communication_closed_at_from_s] if !search_params[:communication_closed_at_from_s].blank?
    communication_closed_at_to     = "*"
    communication_closed_at_to     = search_params[:communication_closed_at_to_s]   if !search_params[:communication_closed_at_to_s].blank?
    
    # some fields have 'not' check boxes
    # distribute where to put fields based
    # on checked or not checked 'not' boxes
    associated_person_field = AdvancedFinderHelper.create_search_term_if_not_blank('associated_person_name_for_solr_t',  
                                                                    search_params[:associated_person])
    fields     << associated_person_field if search_params[:associated_person_not] != '1'
    not_fields << associated_person_field if search_params[:associated_person_not] == '1'
        
    associated_organisation_name_field = AdvancedFinderHelper.create_search_term_if_not_blank('associated_organisation_name_for_solr_t', 
                                                                    search_params[:associated_organisation_name])
    fields     << associated_organisation_name_field if search_params[:associated_organisation_name_not] != '1'
    not_fields << associated_organisation_name_field if search_params[:associated_organisation_name_not] == '1'
    
    organisation_abbreviation_field = AdvancedFinderHelper.create_search_term_if_not_blank('associated_organisation_abbrev_for_solr_t', 
                                                                    search_params[:associated_organisation_abbrev])
    fields     << organisation_abbreviation_field if search_params[:associated_organisation_abbrev_not] != '1'
    not_fields << organisation_abbreviation_field if search_params[:associated_organisation_abbrev_not] == '1'
    
    communication_subject_field = AdvancedFinderHelper.create_search_term_if_not_blank('communication_subject_for_solr_t',  
                                                                                        search_params[:communication_subject])
    fields     << communication_subject_field if search_params[:communication_subject_not] != '1'
    not_fields << communication_subject_field if search_params[:communication_subject_not] == '1'
    
    communication_note_field = AdvancedFinderHelper.create_search_term_if_not_blank('communication_note_for_solr_t', 
                                                                                     search_params[:communication_note])
    fields     << communication_note_field if search_params[:communication_note_not] != '1'
    not_fields << communication_note_field if search_params[:communication_note_not] == '1'
        
    # fields without 'not' check boxes
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('communication_type_for_solr_t',      
                                                                    search_params[:communication_type_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('communication_method_for_solr_t', 
                                                                    search_params[:communication_method_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('communication_priority_for_solr_t', 
                                                                    search_params[:communication_priority])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('communication_status_for_solr_t',         
                                                                    search_params[:communication_status])
    
    
    # Remove nil fields
    fields.map{|f| fields.delete(f) if f.blank?}
    not_fields.map{|nf| not_fields.delete(nf) if nf.blank?}
    
    # preparing options
    # those are special processing fields, they form a query string in a hash to be processed by solr_query
    # which will be added to a base query as it is
    # FIXME need to implement a proper method for handling those cases
    if communication_created_at_from != "*" || communication_created_at_to != "*"
      options[:q] << 'AND created_at_for_solr_t:[' + communication_created_at_from + ' TO ' + communication_created_at_to + ']'
    end
    if communication_closed_at_from != "*" || communication_closed_at_to != "*"
      options[:q] << 'AND closed_at_for_solr_t:[' + communication_closed_at_from + ' TO ' + communication_closed_at_to + ']'
    end  
       
    options[:rows] = 5
    options[:page] = page

    # prepare a query        
    communication_query = FinderHelper.build_advanced_query(Communication, fields, '', not_fields)
    communication_query = FinderHelper.make_query_more_exact(communication_query) 
    
    logger.debug "RCI********"
    logger.debug "IN FIELDS:#{fields.to_yaml}"
    logger.debug "NOT FIELDS:#{not_fields.to_yaml}"
    # run query
    logger.debug "RCI QUERY:#{communication_query}"
    communications, paginator = solr_query(communication_query, options)
    
    # convert each communication back to its raw type
    communications[:docs].map! { |c| c.objectData}
                
    [communications, paginator]
  end
  
  # --------------------------------------------------
  # - Add a selected communication to                -
  # - session[:selected_communications]              -
  # - and displays them in 'Selected Communications' -
  # - side-bar section                               -
  # --------------------------------------------------
  def add_to_selected_communications
    selected_communication = params[:selected_communication]
    from = params[:from]
    communication = Communication.find(selected_communication) unless selected_communication.blank?
    previously_selected = session[:selected_communications]
    
    previously_selected.store(communication, from) unless previously_selected.include?communication
    
    session[:selected_communications] = previously_selected
    render :partial => 'selected_communications'
  end
  
  # ----------------------------------------------------
  # - Remove a selected communication from             -
  # - session[:selected_communications]                -
  # - and consecutively from 'Selected Communications' -
  # - side-bar section                                 -
  # ----------------------------------------------------
  def remove_from_selected_communications
    selected_communication = params[:communication_to_remove]
    communication = Communication.find(selected_communication) unless selected_communication.blank?
    previously_selected = session[:selected_communications]
    
    previously_selected.delete(communication)
    
    session[:selected_communications] = previously_selected
    
    render :partial => 'selected_communications'
  end
  
  # ----------------------------------------------------
  # - Clear session[:selected_communications]          -
  # - and consecutively 'Selected Communications'      -
  # - side-bar section                                 -
  # ----------------------------------------------------
  def clear_selected_communications
    session[:selected_communications] = Hash.new
    render :partial => 'selected_communications'
  end

end
