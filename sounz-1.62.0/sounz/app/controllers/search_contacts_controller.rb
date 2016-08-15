require 'yaml'
#require 'finder_helper'
#
# Controller for searching contacts in the CRM
#
class SearchContactsController < ApplicationController
  include FinderHelper
  include SearchContactsHelper
  include PrivilegesHelper #needed for saved searches

  #
  # Entry methods for users for each form
  #

  def index
    # Set session variables
    # we start with two session variables: contacts_to_add
    # and SELECTED_CONTACTS
    # difference between them - SELECTED_CONTACTS collects
    # all contacts selected from Search Results section of
    # search_contacts/, contacts_to_add contains only those
    # contacts who were ticked to be added to the list
    if session[SELECTED_CONTACTS] == nil
      session[SELECTED_CONTACTS] = Array.new
    end
    
	#session[:contacts_to_add] = session[SELECTED_CONTACTS] if session[:contacts_to_add].blank?
    
	@selected_contacts = Array.new
	
    # previously Selected Contacts if any
    contacts = session[SELECTED_CONTACTS]
	@contacts = contacts.sort{|rc, orc| rc.role.role_contact_name <=> orc.role.role_contact_name } if contacts != []
	
	paginated_selected_results
		
  end

  def advanced
    # Set session variables
    if session[SELECTED_CONTACTS] == nil
      session[SELECTED_CONTACTS] = Array.new
    end
    
    #session[:contacts_to_add] = session[SELECTED_CONTACTS]
    
    # reset search param
    if !params[:from].blank? && params[:from].match('reset_search')
      session[:adv_crm_contacts_search_details] = nil
    end
    
    # any previous advanced search in session?
    if session[:adv_crm_contacts_search_details] != nil
      @search = session[:adv_crm_contacts_search_details]
    else
      @search = CrmContactsAdvancedSearchDetails.new
    end
    
    # previously Selected Contacts if any
	@selected_contacts = Array.new
	
    # previously Selected Contacts if any
    contacts = session[SELECTED_CONTACTS]
	@contacts = contacts.sort{|rc, orc| rc.role.role_contact_name <=> orc.role.role_contact_name } if contacts != []
	
	paginated_selected_results
		
  end

  #
  # Finds contacts matching the search and renders the results partial
  #
  # FIXME:
  #  * Each search result should display each role for the person, with
  #    checkboxes for choosing those particular roles and adding them to the
  #    selected results
  #  * Selected results should work
  #  * Should be able to do stuff with the selected results (see spec, page 17)
  #
  def find_contacts
    show_params(params)
    @data = process_search(params[:search], params[:page].to_i)
    render :partial => 'search_results_wrapper'
  end

  def find_role_contactinfos
    
    # set saved search params only once from
    # params from the UI form
    if params[:page].to_i < 1
      prepare_saved_search_params
    end
    
    @data = process_search(params[:search], params[:page].to_i, advanced_search=true)
    render :partial => 'advanced_search_results_wrapper'
  end
  
  #
  # Display a list of appropriate regions on the country selection
  #
  def country_chosen
    if !params[:id].blank?
      @country = Country.find(params[:id])
      @regions = Region.find(:all, :conditions => ['country_id =?', @country.country_id], :order => 'region_order')
    else
      @country = @regions = nil
    end
    render :layout => false
  end

  # FIXME do some cleaning in the method
  # -------------------------------------------
  # - Prepare saved search params             -
  # - in case if the search is going          -
  # - to be saved later                       -
  # -------------------------------------------
  def prepare_saved_search_params
    # get previous advanced search from session if any
    if session[:adv_crm_contacts_search_details] != nil
      @search = session[:adv_crm_contacts_search_details]
    else
      @search = CrmContactsAdvancedSearchDetails.new
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
      session[:adv_crm_contacts_search_details]=[]
            
      if !search_params.blank?
        search_params.keys.map{|k| @search.send(k+'=', search_params[k])}
      end      
      session[:adv_crm_contacts_search_details] = @search
    end
    
  end
  
  #-------------------------------------------------------------------------------------------------
  #- From the drop down find all the people associated with a list and populate the search results -
  #-------------------------------------------------------------------------------------------------
  def use_saved_list
    logger.debug "**** USE SAVED LIST ****"
    
    show_params(params) #debug params and put them in logs
    
	saved_contact_list_id = params[:saved_contact_list][:saved_contact_list_id] if !params[:saved_contact_list].blank?
    saved_contact_list_id = params[:saved_contact_list_id] unless params[:saved_contact_list_id].blank?
	 
    if !saved_contact_list_id.blank?
      
      @saved_contact_list = SavedContactList.find(saved_contact_list_id)
	  
	  # Paginate saved contact list role contactinfos
	  # to make the pagination quick and efficient for large lists and 
	  # the role contactinfos sorted by person full name (last_name first)
	  # or by organisation name we have to use specially created
	  # saved_lists_contacts	  
	  number_of_contacts_per_page = 25
	  total_number_of_contacts = SavedRoleContactinfo.find(:all, :select => 'role_contactinfo_id', :conditions => ['saved_contact_list_id = ?', saved_contact_list_id])
	  
	  @saved_list_contacts_pages = Paginator.new self, total_number_of_contacts.length, number_of_contacts_per_page, params[:page]

	  selected_list_contacts = ActiveRecord::Base.connection.execute("SELECT role_contactinfo_id " +
																	 " FROM saved_lists_contacts " +
																	 "  WHERE saved_contact_list_id=#{@saved_contact_list.saved_contact_list_id} " +
																	 "    ORDER BY contact_name " +
																	 "  LIMIT #{@saved_list_contacts_pages.items_per_page.to_i} " +
																	 "   OFFSET #{@saved_list_contacts_pages.current.offset.to_i}"
																	  )
	  @contacts = Array.new
	  selected_list_contacts.each do |c_id|
	    @contacts.push(RoleContactinfo.find(c_id['role_contactinfo_id']))
	  end
	  
      session[:contacts_from_search] = @contacts
    
      @already_selected = session[SELECTED_CONTACTS]
      logger.debug "Contacts from saved list @ #{@contacts}"
      
      # processing for existent contacts from mailout or saved contact lists
      saved_list_contacts = session[:list_contacts]
      mailout_list_contacts = session[:mailout_contacts]
      if saved_list_contacts != nil
        @already_selected = @already_selected + saved_list_contacts
      end
      if mailout_list_contacts != nil
        @already_selected = @already_selected + mailout_list_contacts
      end 
            
    end
        
    render :partial => 'use_saved_list'
  end
  
  #-------------------------------------
  #- Add contacts to 'selected' list -
  #-------------------------------------
  def add_contacts_to_selection
  	session[:from] = params[:from] if !params[:from].blank?
    
	@role_contactinfos_ids = params[:role_contactinfos][:ids] unless params[:role_contactinfos].blank?
	
	# case for adding all contacts of the saved contact list
	if !params[:saved_contact_list].blank?
	  saved_contact_list = SavedContactList.find(params[:saved_contact_list])
	  @role_contactinfos_ids = saved_contact_list.role_contactinfos.map{|rc| "role_contactinfo_" + rc.role_contactinfo_id.to_s} unless saved_contact_list.role_contactinfos.blank?
	end
	
	if ! @role_contactinfos_ids.blank?
	  logger.debug "**** ADD CONTACTS TO SELN ****"
      show_params(params) #debug params and put them in logs
      
    
      previously_selected_contacts = session[SELECTED_CONTACTS]
        
      # existent_contacts combine session[SELECTED_CONTACTS]
      # and session contacts from saved contact and mailing lists
      # so that they are not added again to the Selected Results
      # section
      existent_contacts = previously_selected_contacts
      existent_contacts = existent_contacts + session[:list_contacts]    unless session[:list_contacts].blank?
      existent_contacts = existent_contacts + session[:mailout_contacts] unless session[:mailout_contacts].blank?
        
      # add selected contacts to new_contacts
      new_contacts = Array.new
      for new_contact_id in @role_contactinfos_ids
        # get the contact to add
        new_contact = RoleContactinfo.find( new_contact_id.to_s.gsub('role_contactinfo_', '') )
        new_contacts.push(new_contact) unless existent_contacts.include?new_contact
      end
      
	  @role_contactinfos_ids = nil if !params[:saved_contact_list].blank?
	  
      # update session variables with newly added contacts 
      session[SELECTED_CONTACTS] = previously_selected_contacts + new_contacts
      session[:contacts_to_add] = session[SELECTED_CONTACTS]
    
      # UI variables
      @contacts =  session[SELECTED_CONTACTS] 
      @already_selected = get_already_selected()
		
	  paginated_selected_results
    
	  render :layout => false
	  
    else
      action = 'index'
	  action = session[:from] unless session[:from].blank?
	  session[:from] = nil
      redirect_to :action => action, :page => params[:page]
    end
  end
  
  #------------------------------------
  #- Set 'contacts to add' in session -
  #------------------------------------
  def set_selected_contacts
    logger.debug "****** UPDATE SELECTED CONTACTS *****"
    show_params(params)
	
	role_contactinfos_ids = Array.new
	role_contactinfos = params[:role_contactinfos][:ids]
    
	if !role_contactinfos.blank?
	  role_contactinfos.each do |rc|
        role_contactinfo = RoleContactinfo.find(rc.gsub('role_contactinfo_', ''))
        role_contactinfos_ids.push(role_contactinfo) if !session[:contacts_to_add].include?(role_contactinfo)
      end
    end
	
	session[:contacts_to_add] = session[:contacts_to_add] + role_contactinfos_ids
    
	selected_a = params[:role_contactinfos][:selected].split(",")
	
	selected_a.each do |s|
	  selected_s = "role_contactinfo_" + s.to_s
	  if role_contactinfos.blank? || (!role_contactinfos.blank? && !role_contactinfos.include?(selected_s))
	  	session[:contacts_to_add] = session[:contacts_to_add].select {|c| c != RoleContactinfo.find(s)}
	  end
	end
	
    render :text => ''
  end
  
  #---------------------------------------------------
  #- Add selected contacts to a mailout contact list -
  #---------------------------------------------------
  def add_to_mailout
    session[:mailout_contacts] = nil
    
    if session[:campaign_mailout_id] != nil
      campaign_mailout_id = session[:campaign_mailout_id]
      redirect_to( :controller => 'campaign_mailouts', 
                   :action => 'add_to_mailout', 
                   :id => campaign_mailout_id )
    else
      if session[:campaign_mailout_id] == nil
        flash[:notice] = " A session has expired, try again"
        redirect_to :action => '/index'
      end
    end
  end
  
  #-----------------------------------------
  #- Add contacts to a saved contacts list -
  #-----------------------------------------
  def add_to_contact_list
    logger.debug "**** ADD TO CONTACT LIST FROM SELN ****"
    show_params(params)
    session[:list_contacts] = nil
        
    if session[:saved_contact_list_id] != nil
      saved_contact_list_id = session[:saved_contact_list_id]
      redirect_to( :controller => "saved_contact_lists", 
                   :action => "add_search_results_contacts_to_list", 
                   :id => saved_contact_list_id )
    else
      if session[:saved_contact_list_id] == nil
        flash[:notice] = " A session has expired, try again"
        redirect_to( :controller => 'saved_contact_lists', :action => 'list' )
      end
    end
  end
  
  #------------------------------------------------------------
  #- Deal with removing people from the selected results list -
  #------------------------------------------------------------
  def remove_contacts_from_selection
    logger.debug "**** REMOVE CONTACTS FROM SELN ****"
    show_params(params) #debug params and put them in logs
    #@role_contactinfos_ids = params[:role_contactinfos][:ids]
    
	# case for removing all
	if params[:remove] == 'all'
	  session[SELECTED_CONTACTS] = Array.new
	  session[:contacts_to_add]  = Array.new
	
	# case for removing seleted only 
	else
	  @selected_role_contactinfos = session[:contacts_to_add]
	
	  @role_contactinfos_ids = @selected_role_contactinfos.map{|rc| "role_contactinfo_" + rc.role_contactinfo_id.to_s}
	
      previously_selected_contacts = session[SELECTED_CONTACTS]
    
      # remove contacts
      for removed_contact_id in @role_contactinfos_ids
        # get the contact to remove
        removed_contact = RoleContactinfo.find( removed_contact_id.gsub('role_contactinfo_', '') )
        previously_selected_contacts.delete(removed_contact)
	    session[:contacts_to_add].delete(removed_contact)
        # new_contacts = new_contacts + [new_person_contact] unless previously_selected_contacts.include?new_person_contact
      end
    
      # update session variable with removed contacts
      session[SELECTED_CONTACTS] = previously_selected_contacts
    end
	
    # UI variables
    @contacts =  session[SELECTED_CONTACTS]
    @already_selected = get_already_selected()
    
	paginated_selected_results
	
	render :layout => false
  end
  
  # Ajax display of selected results based on the page requested
  def selected_results
  	
  	@contacts =  session[SELECTED_CONTACTS]
	
  	paginated_selected_results
	
	render :layout => false
  end
  
  # Paginate selected results if any
  def paginated_selected_results
  	if ! @contacts.blank?
	  number_of_contacts_per_page = 25
	  @selected_contacts_pages = Paginator.new self, @contacts.length, number_of_contacts_per_page, params[:page]
	  from = @selected_contacts_pages.current.offset.to_i
	  to   = (from + @selected_contacts_pages.items_per_page.to_i) - 1
	  
	  @selected_contacts = @contacts[from..to] unless @contacts.blank?
	end	
  end
  
  private

  #---------------------------------------------------
  #- Return an array of selected previously contacts -
  #---------------------------------------------------
  def get_already_selected()
    # already_selected combine session[SELECTED_CONTACTS]
    # and session contacts from saved contact and mailing lists
    # and are displayed without check boxes
    # so that they are not added again to the Selected Results
    # section
    already_selected = Array.new
    already_selected = session[SELECTED_CONTACTS]
    already_selected = already_selected + session[:list_contacts]    unless session[:list_contacts].blank?
    already_selected = already_selected + session[:mailout_contacts] unless session[:mailout_contacts].blank? 
    
    return already_selected
  end

  #
  # Performs a search for contacts and returns various data about the search
  # TODO simplify
  def process_search(search_params, page, advanced_search=false)
    if !search_params
      flash[:search_error] = "No search was specified"
      return
    end
    


    page = 1 if page < 1
    
    if !advanced_search
      [ :person, :organisation, :status_id].each do |p|
        search_params[p] ||= ""
      end
    end

    search_params[:category_filter] ||= []
    search_params[:category_filter] = ((search_params[:category_filter].is_a? Array) ? search_params[:category_filter].join(', ') : search_params[:category_filter])
    search_params[:role_id_ids]     ||= []
    search_params[:role_id_ids]     = ((search_params[:role_id_ids].is_a? Array) ? search_params[:role_id_ids].join(', ') : search_params[:role_id_ids])
    search_params[:membership_id_ids] ||= []
    search_params[:membership_id_ids] = ((search_params[:membership_id_ids].is_a? Array) ? search_params[:membership_id_ids].join(', ') : search_params[:membership_id_ids])
    search_params[:role_status_id_ids] ||= []
    search_params[:role_status_id_ids]   = ((search_params[:role_status_id_ids].is_a? Array) ? search_params[:role_status_id_ids].join(', ') : search_params[:role_status_id_ids])
    search_params[:contributor_status_id_ids] ||= []
    search_params[:contributor_status_id_ids]   = ((search_params[:contributor_status_id_ids].is_a? Array) ? search_params[:contributor_status_id_ids].join(', ') : search_params[:contributor_status_id_ids])
        
    search_params[:updated_at_from_s] = (Time.parse(search_params[:updated_at_from]) rescue Time.now).to_i.to_s if !search_params[:updated_at_from].blank?
    search_params[:updated_at_to_s]   = (Time.parse(search_params[:updated_at_to]) rescue Time.now).to_i.to_s if !search_params[:updated_at_to].blank?
    search_params[:created_at_from_s] = (Time.parse(search_params[:created_at_from]) rescue Time.now).to_i.to_s if !search_params[:created_at_from].blank?
    search_params[:created_at_to_s]   = (Time.parse(search_params[:created_at_to]) rescue Time.now).to_i.to_s if !search_params[:created_at_to].blank?
    
    # default to basic search
    if !advanced_search
      
      results, paginator = find_contacts_by_solr(search_params, page)
      {
      :person_query       => search_params[:person],
      :organisation_query => search_params[:organisation],
      :results            => results,
      :paginator          => paginator,
      }
    else
      results, paginator = find_role_contactinfos_by_solr(search_params, page)
      {
       :results   => results,
       :paginator => paginator
      }
    end
        
    
  end
  
  #
  # Finds role_contactinfos (advanced contacts search) using solr to search
  #
  def find_role_contactinfos_by_solr(search_params, page)
    flash[:search_error] = nil

    options = {:q => []}
        
    fields = []
    
    # fields with 'not' check boxes checked
    not_fields = []
    
    role_contactinfos  = []
    paginator = nil
        
    # dates processing
    # created_at
    created_at_from   = "*"
    created_at_from   = search_params[:created_at_from_s] if !search_params[:created_at_from_s].blank?
    created_at_to     = "*"
    created_at_to     = search_params[:created_at_to_s]   if !search_params[:created_at_to_s].blank?
    
    # updated_at
    updated_at_from   = "*"
    updated_at_from   = search_params[:updated_at_from_s] if !search_params[:updated_at_from_s].blank?
    updated_at_to     = "*"
    updated_at_to     = search_params[:updated_at_to_s]   if !search_params[:updated_at_to_s].blank?
    
    # some fields have 'not' check boxes
    # distribute where to put fields based
    # on checked or not checked 'not' boxes
    role_title_field = AdvancedFinderHelper.create_search_term_if_not_blank('role_title_for_solr_t',  search_params[:role_title])
    fields     << role_title_field if search_params[:role_title_not] == '0'
    not_fields << role_title_field if search_params[:role_title_not] == '1'
    
    organisation_name_field = AdvancedFinderHelper.create_search_term_if_not_blank('organisation_name_for_solr_t', search_params[:organisation_name])
    fields     << organisation_name_field if search_params[:organisation_name_not] == '0'
    not_fields << organisation_name_field if search_params[:organisation_name_not] == '1'
    
    organisation_abbreviation_field = AdvancedFinderHelper.create_search_term_if_not_blank('organisation_abbrev_for_solr_t', search_params[:organisation_abbrev])
    fields     << organisation_abbreviation_field if search_params[:organisation_abbrev_not] == '0'
    not_fields << organisation_abbreviation_field if search_params[:organisation_abbrev_not] == '1'
    
    locality_field = AdvancedFinderHelper.create_search_term_if_not_blank('locality_for_solr_t',  search_params[:locality])
    fields     << locality_field if search_params[:locality_not] == '0'
    not_fields << locality_field if search_params[:locality_not] == '1'
    
    contactinfo_internal_note = AdvancedFinderHelper.create_search_term_if_not_blank('internal_note_for_solr_t', search_params[:internal_note])
    fields     << contactinfo_internal_note if search_params[:internal_note_not] == '0'
    not_fields << contactinfo_internal_note if search_params[:internal_note_not] == '1'
    
    
    
    person_internal_note = AdvancedFinderHelper.create_search_term_if_not_blank('person_internal_note_for_solr_t', search_params[:person_internal_note])
    fields     << person_internal_note if search_params[:person_internal_note_not] == '0'
    not_fields << person_internal_note if search_params[:person_internal_note_not] == '1'
    
    
    
    saved_list_field = AdvancedFinderHelper.create_search_term_if_not_blank('saved_contact_lists_for_solr_t', search_params[:saved_list])
    fields     << saved_list_field if search_params[:saved_list_not] == '0'
    not_fields << saved_list_field if search_params[:saved_list_not] == '1'
    
    marketing_campaign_field = AdvancedFinderHelper.create_search_term_if_not_blank('marketing_campaigns_for_solr_t', search_params[:marketing_campaign])
    fields     << marketing_campaign_field if search_params[:marketing_campaign_not] == '0'
    not_fields << marketing_campaign_field if search_params[:marketing_campaign_not] == '1'
    
    #country_field = AdvancedFinderHelper.create_search_term_if_not_blank('country_for_solr_t', search_params[:country_id])
    #fields     << country_field if search_params[:country_id_not] == '0'
    #not_fields << country_field if search_params[:country_id_not] == '1'
    
    # fields without 'not' check boxes
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('region_for_solr_t',                  search_params[:region_id])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('role_type_for_solr_t',               search_params[:role_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('marketing_subcategories_for_solr_t', search_params[:category_filter])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('has_person_for_solr_t',              search_params[:has_person])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('has_contributor_for_solr_t',         search_params[:has_contributor])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('has_phone_for_solr_t',               search_params[:has_phone])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('has_email_for_solr_t',               search_params[:has_email])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('has_website_for_solr_t',             search_params[:has_website])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('role_contactinfo_membership_types_for_solr_t', search_params[:membership_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('role_status_for_solr_t',             search_params[:role_status_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('contributor_status_for_solr_t',      search_params[:contributor_status_id_ids])
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('types_for_solr_t',                    search_params[:role_contactinfo_type])
	
    # filter to get only 'non-empty' contactinfos
    fields << AdvancedFinderHelper.create_search_term_if_not_blank('contactinfo_is_empty_for_solr_t', '0')
    
    # Remove nil fields
    fields.map{|f| fields.delete(f) if f.blank?}
    not_fields.map{|nf| not_fields.delete(nf) if nf.blank?}
    
    # preparing options
    # those are special processing fields, they form a query string in a hash to be processed by solr_query
    # which will be added to a base query as it is
    # FIXME need to implement a proper method for handling those cases
    if !search_params[:postcode].blank?
      options[:q] << 'AND postcode_for_solr_t:(' + search_params[:postcode] + ')' if search_params[:postcode_not] == '0'
      options[:q] << 'NOT postcode_for_solr_t:(' + search_params[:postcode] + ')' if search_params[:postcode_not] == '1'
    end
    
    if !search_params[:country_id].blank?
      options[:q] << 'AND country_for_solr_t:(' + search_params[:country_id] + ')' if search_params[:country_id_not] == '0'
      
      # display only contacts that have a non-empty country_for_solr_t field
      # using exclusive range query syntax 
      if search_params[:country_id_not] == '1'
        options[:q] << 'AND (country_for_solr_t:{0 TO ' + search_params[:country_id] + '}'
        options[:q] << 'OR country_for_solr_t:{' + search_params[:country_id] + ' TO *})'
      end
   
    end
    
    options[:q] << 'AND created_at_for_solr_t:[' + created_at_from + ' TO ' + created_at_to + ']' unless created_at_from == "*" && created_at_to == "*"
    options[:q] << 'AND updated_at_for_solr_t:[' + updated_at_from + ' TO ' + updated_at_to + ']' unless updated_at_from == "*" && updated_at_to == "*"
       
    options[:sort]=''
    # special case for person name with application of boost for sorting
    if !search_params[:person].blank?
      if search_params[:person_not] == '1'
        options[:q] << ' NOT '
      else
        options[:q] << ' AND '
      end
      options[:q] << '((person_last_name_for_solr_as_string_s:(' + search_params[:person] + '))^10000'
      options[:q] << 'OR (person_first_names_for_solr_as_string_s:(' + search_params[:person] + '))^100'
      options[:q] << 'OR (person_full_name_for_solr_t:(' + search_params[:person] + '))^100)'
      options[:sort] << 'score desc, '
    end
	
    options[:rows] = 25
    options[:page] = page

    options[:sort] << 'person_last_name_for_solr_as_string_s asc, person_first_names_for_solr_as_string_s asc, organisation_name_for_solr_as_string_s asc, organisation_abbrev_for_solr_as_string_s asc'
    
    # prepare a query        
    role_contactinfos_query = FinderHelper.build_query(RoleContactinfo, "", fields, query_param_boolean='AND', not_fields, defined_models_only=true)
    # it is an advanced query, replace 'OR' joining search terms
    # by 'AND'
    role_contactinfos_query = role_contactinfos_query.gsub('* OR', ' AND ')
    
    logger.debug "RCI********"
    logger.debug "IN FIELDS:#{fields.to_yaml}"
    logger.debug "NOT FIELDS:#{not_fields.to_yaml}"
    # run query
    logger.debug "RCI QUERY:#{role_contactinfos_query}"
    role_contactinfos, paginator = solr_query(role_contactinfos_query, options)
    
    # convert each contact back to its raw type
    role_contactinfos[:docs].map! { |rc| rc.objectData }
    
    # get 'already_selected'
    @already_selected = get_already_selected()    
        
    [role_contactinfos, paginator]
    
  end

  # TODO clean this method as the advanced search is changed to searching role_contactinfos indexes
  # and this method is only used for basic search (person name and organisation name & abbreviation)
  # 
  # Finds contacts according to the appropriate business rules, using solr to search
  #
  # The business rules are as follows:
  #
  # * If only the person query is specified, search all people
  # * If only the organisation query is specified, search all organisations
  # * If both are specified, search for the people working for the found organisations
  #
  def find_contacts_by_solr(search_params, page)
    flash[:search_error] = nil

    person_options = {:q => []}
	  organisation_options = {:q => []}
	  options = {:q => []}

    search_params[:organisation] = "" if !search_params[:organisation].blank? && search_params[:entity_to_search] == 'person'
    search_params[:person]       = "" if !search_params[:person].blank? && search_params[:entity_to_search] == 'organisation'

    person_query       = FinderHelper.strip(search_params[:person].strip.downcase)
    organisation_query = FinderHelper.strip(search_params[:organisation].strip.downcase)
	  status_query       = search_params[:status_id]
    
    contacts  = []
    paginator = nil
	
	if !search_params[:person].blank?
	  person_options[:q] << 'AND ((last_name_for_solr_t:(' + person_query + '*))^10000'
	  person_options[:q] << ' OR (first_names_for_solr_t:(' + person_query + '*))^100'
	  person_options[:q] << ' OR (full_name_for_solr_t:(' + person_query + '*))^100'
	  person_options[:q] << ' OR (known_as_for_solr_t:(' + person_query + '*)))'
	  person_options[:q] << 'AND (status_for_solr_t:(' + search_params[:status_id] + '))' unless search_params[:status_id].blank?
	  entities_to_search = get_entities_to_search(search_params[:entity_to_search])
    person_keyword_query  = FinderHelper.build_query(entities_to_search, "", [], query_param_boolean='AND', [], defined_models_only=true)
  end

  if !search_params[:organisation].blank?
	  organisation_options[:q] << 'AND ((organisation_name_for_solr_t:(' + organisation_query + '*))^100000'
	  organisation_options[:q] << ' OR (organisation_abbrev_for_solr_t:(' + organisation_query + '*))^10000'
	  organisation_options[:q] << ' OR (known_as_for_solr_t:(' + organisation_query + '*))^1000'
	  organisation_options[:q] << ' OR (related_organisation_names_for_solr_t:(' + organisation_query + '*))'
	  organisation_options[:q] << ' OR (related_organisation_abbrev_for_solr_t:(' + organisation_query + '*)))'
	  organisation_options[:q] << 'AND (status_for_solr_t:(' + search_params[:status_id] + '))' unless search_params[:status_id].blank?
    entities_to_search = get_entities_to_search(search_params[:entity_to_search])
	  organisation_keyword_query = FinderHelper.build_query(entities_to_search, "", [], query_param_boolean='AND', [], defined_models_only=true)
	end
	
	if (search_params[:organisation].blank? && search_params[:person].blank?) && !search_params[:status_id].blank?
	  options[:q] << 'AND (status_for_solr_t:(' + search_params[:status_id] + '))'
    entities_to_search = get_entities_to_search(search_params[:entity_to_search])
	  query = FinderHelper.build_query(entities_to_search, "", [], query_param_boolean='AND', [], defined_models_only=true)
	end
    

    # dates processing
    # created_at
    #created_at_from = "*"
    #created_at_from = search_params[:created_at_from] if !search_params[:created_at_from].blank?
    #created_at_to = "*"
    #created_at_to = search_params[:created_at_to]     if !search_params[:created_at_to].blank?
    # updated_at
    #updated_at_from = "*"
    #updated_at_from = search_params[:updated_at_from] if !search_params[:updated_at_from].blank?
    #updated_at_to = "*"
    #updated_at_to = search_params[:updated_at_to]     if !search_params[:updated_at_to].blank?
    
    #options[:q] << 'role_titles_for_solr_t:' + search_params[:role_title] if !search_params[:role_title].blank?
    #options[:q] << 'localities_for_solr_t:' + search_params[:locality] if !search_params[:locality].blank?
    #options[:q] << 'postcodes_for_solr_t:' + search_params[:postcode] if !search_params[:postcode].blank?
    #options[:q] << 'created_at_for_solr_t:[' + created_at_from + ' TO ' + created_at_to + ']' unless created_at_from == "*" && created_at_to == "*"
    #options[:q] << 'updated_at_for_solr_t:[' + updated_at_from + ' TO ' + updated_at_to + ']' unless updated_at_from == "*" && updated_at_to == "*"
    #options[:q] << 'marketing_subcategories_for_solr_t:(' + search_params[:category_filter].join(' OR ') + ')' if search_params[:category_filter].size > 0
    #options[:q] << 'role_types_for_solr_t:(' + search_params[:role_id_ids].join(' OR ') + ')' if !search_params[:role_id_ids].empty?
    #options[:q] << 'countries_for_solr_t:' + search_params[:country_id] if !search_params[:country_id].blank?
    #options[:q] << 'regions_for_solr_i:' + search_params[:region_id] if !search_params[:region_id].blank?
    #options[:q] << 'status_id_i:' + search_params[:status_id] if !search_params[:status_id].blank?
    #options[:q] << 'valid_email_for_solr_s:1' if search_params[:valid_email] == '1'
        
    person_options[:rows] = 10
    person_options[:page] = page
    
	  organisation_options[:rows] = 10
	  organisation_options[:page] = page
	
	  options[:rows] = 10
	  options[:page] = page
	
    #logger.debug "PERSON QUERY:#{person_query}"
    #logger.debug "ORGANISATION QUERY:#{organisation_keyword_query}"
    #logger.debug "OPTIONS[q] = #{person_options[:q]}"
        
    # Deal with the name search
    if person_query.length > 0 and organisation_query.length == 0
      person_options[:sort]= 'score desc, last_name_for_solr_as_string_s asc, first_names_for_solr_as_string_s asc'
      contacts, paginator = solr_query(person_keyword_query, person_options)
      # Convert each contact back to its raw type
      contacts[:docs].map! {|c| c.objectData }
    elsif organisation_query.length > 0 and person_query.length == 0
      organisation_options[:sort]= 'score desc, organisation_name_for_solr_as_string_s asc, organisation_abbrev_for_solr_as_string_s asc'
      contacts, paginator = solr_query(organisation_keyword_query, organisation_options)
      contacts[:docs].map! {|c| c.objectData }
    elsif organisation_query.length > 0 and person_query.length > 0
      person_options[:sort]= 'score desc, last_name_for_solr_as_string_s asc, first_names_for_solr_as_string_s asc'
      organisation_options[:sort]= 'score desc, organisation_name_for_solr_as_string_s asc, organisation_abbrev_for_solr_as_string_s asc'
	  # FIXME: need to port this method
      contacts, paginator = find_people_who_work_for_organisation_by_solr(person_keyword_query, organisation_keyword_query, person_options, organisation_options)
      contacts[:docs].map! {|c| c.objectData }
    elsif status_query.length > 0 && (search_params[:entity_to_search].blank? || search_params[:entity_to_search] == 'both')
      options[:sort]= 'organisation_name_for_solr_as_string_s asc, organisation_abbrev_for_solr_as_string_s asc, last_name_for_solr_as_string_s asc, first_names_for_solr_as_string_s asc'
	    contacts, paginator = solr_query(query, options)
	    contacts[:docs].map! {|c| c.objectData }
	  elsif status_query.length > 0 && search_params[:entity_to_search] == 'person'
	    options[:sort]= 'last_name_for_solr_as_string_s asc, first_names_for_solr_as_string_s asc'
	    contacts, paginator = solr_query(query, options)
	    contacts[:docs].map! {|c| c.objectData }
	  elsif status_query.length > 0 && search_params[:entity_to_search] == 'organisation'
	    options[:sort]= 'organisation_name_for_solr_as_string_s asc, organisation_abbrev_for_solr_as_string_s asc'
	    contacts, paginator = solr_query(query, options)
	    contacts[:docs].map! {|c| c.objectData }
    else
      flash[:search_error] = "Please type at least 3 characters into one or both of the search fields"
    end
        
    # get 'already_selected'
    @already_selected = get_already_selected()    
            
    [contacts, paginator]
  end
  
  #
  # The method name says it all :)
  #
  # The algorithm is as follows:
  #
  # 1) Search for all organisations that match the query given for them
  # 2) Search for all people matching the person query, that also have the IDs found in the organisation search
  #
  # This means that an organisation name can change without the search index becoming out of date
  #
  def find_people_who_work_for_organisation_by_solr(person_query, organisation_query, person_options, organisation_options)
    # FIXME: Should only request the organisation ID field because that's all we need for this search...
    organisation_options[:rows] = Organisation.count
	
    contacts, paginator = solr_query(organisation_query, organisation_options)

    organisation_ids = contacts[:docs].collect{|c| c.objectData.organisation_id }
	
	#logger.debug "DEBUG: find people who work for organisation by solr: organisation_ids #{organisation_ids.length} #{organisation_ids.join(',')}"

	  return [{:docs => [], :total => 0}, nil] if organisation_ids.empty?

    organisation_ids_s = organisation_ids.join(' OR ')
    person_query << ' AND organisations_for_solr_t:(' + organisation_ids_s + ')'
    
    contacts, paginator = solr_query(person_query, person_options)
  end

  def get_entities_to_search(entities)
    entities_to_search = []
    if entities.blank? || entities == 'both'
	    entities_to_search = [Person, Organisation]
	  else
	    entities_to_search = [Person] if entities == 'person'
	    entities_to_search = [Organisation] if entities == 'organisation'
	  end

    return entities_to_search
  end

end
