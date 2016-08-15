#
# Controller for searching contacts
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# FIXME: DEPRECATED!! search_contacts_controller contains a solr based search
# and is more recent. Functionality should be moved there
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#
class SearchController < ApplicationController
  
  include SavedContactListsHelper
  include SearchContactsHelper
  
  auto_complete_for :organisation, :organisation_name
  
  
  LAST_SEARCH_DETAILS = :last_search_details  
  
  
  
  def people_organisations
    # @countries = Country.find(:all)
    # @country_names = []
    # @regions = Region.find(:all)
  end
  
  def show_regions
    for key in params.keys
      logger.debug "*************************"
      logger.debug "#{key} => #{params[key]}"
      
      logger.debug "**************"
    end
    @country_id = params.invert[""]
    logger.debug "################"
    logger.debug "country_id = #{@country_id}"
    @country = Country.find( @country_id ) 
    @regions = Region.find(:all, :conditions => ["country_id = ?",@country.id])
    render :layout => false
    
  end
  
  
  
  #----------------------------------------------------------------------
  #- Find contacts menu - set the in session selected list to empty -
  #----------------------------------------------------------------------
  def find_contacts_menu
    if session[SELECTED_CONTACTS] == nil
      session[SELECTED_CONTACTS] = []
    end
    @contacts = session[SELECTED_CONTACTS]  
  end
  
  
  #----------------------------------------------------------------------
  #- Advanced find contacts menu - set the in session selected list to empty -
  #----------------------------------------------------------------------
  def find_contacts_menu_advanced
    if session[SELECTED_CONTACTS] == nil
      session[SELECTED_CONTACTS] = []
    end
    @contacts = session[SELECTED_CONTACTS]
    @role_types = RoleType.find(:all, :order => 'role_type_desc')
  end
  
  
  #-------------------------------------
  #- Add contacts to selected list -
  #-------------------------------------
  def add_contacts_to_selection
    logger.debug "**** ADD CONTACTS to SELN ****"
    show_params(params) #debug params and put them in logs
    @role_contactinfos_ids = params[:role_contactinfos][:ids]
    
    previous_contacts = session[SELECTED_CONTACTS]
    saved_list_contacts = session[:list_contacts]
    mailout_list_contacts = session[:mailout_contacts]
    existent_contacts = previous_contacts
    
    # add saved list contacts or mailout contacts if any
    # so they are not added again to the list
    if saved_list_contacts != nil
      existent_contacts = existent_contacts + saved_list_contacts
    end
    
    if mailout_list_contacts != nil
      existent_contacts = existent_contacts + mailout_list_contacts
    end
    
    new_contacts = []
    for new_contact_id in @role_contactinfos_ids
      #new_contact = get_person_or_organisation(new_contact_id)
      # get the contact to add
      new_contact_id = new_contact_id.gsub('role_contactinfo_', '')
      new_contact = RoleContactinfo.find( new_contact_id )
      new_contacts = new_contacts + [new_contact] unless existent_contacts.include?new_contact
    end
    
     
    session[SELECTED_CONTACTS] = previous_contacts + new_contacts
    
    @contacts =  session[SELECTED_CONTACTS] 
    
    @already_selected = session[SELECTED_CONTACTS]
    
    # processing for existent contacts from mailout or saved contact lists
    if saved_list_contacts != nil
      @already_selected = @already_selected + saved_list_contacts
    end
    
    if mailout_list_contacts != nil
      @already_selected = @already_selected + mailout_list_contacts
    end
    
    render :layout => false
  end
  
  
  #------------------------------------------------------------
  #- Deal with removing people from the selected results list -
  #------------------------------------------------------------
  def remove_contacts_from_selection
    logger.debug "**** remove CONTRIBUTORS from SELN ****"
    show_params(params) #debug params and put them in logs
    @role_contactinfos_ids = params[:role_contactinfos][:ids]
    previous_contacts = session[SELECTED_CONTACTS]
    for removed_contact_id in @role_contactinfos_ids
      # get the contact to remove
      removed_contact_id = removed_contact_id.gsub('role_contactinfo_', '')
      removed_contact = RoleContactinfo.find( removed_contact_id )
      
      # remove contact
      previous_contacts.delete(removed_contact)
      #   new_contacts = new_contacts + [new_person_contact] unless !previous_contacts.include?new_person_contact
    end
    session[SELECTED_CONTACTS] = previous_contacts
    @contacts =  session[SELECTED_CONTACTS]
    @already_selected = session[SELECTED_CONTACTS]
    
    # processing for existent contacts from mailout or saved contact lists
    saved_list_contacts = session[:list_contacts]
    mailout_list_contacts = session[:mailout_contacts]
    if saved_list_contacts != nil
      @already_selected = @already_selected + saved_list_contacts
    end
    if mailout_list_contacts != nil
      @already_selected = @already_selected + mailout_list_contacts
    end 
    
    render :layout => false
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
  
  #--------------------------------------------------
  #- Add selected contacts to a saved contacts list -
  #--------------------------------------------------
  def add_to_contact_list
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
  
  #-------------------------------------------------------------------------------------------------
  #- From the drop down find all the people associated with a list and populate the search results -
  #-------------------------------------------------------------------------------------------------
  def use_saved_list
    logger.debug "**** USE SAVED LIST ****"
    
    show_params(params) #debug params and put them in logs
    saved_contact_list_id = params[:search][:list_id]
    if saved_contact_list_id != ''
      @saved_contact_list = SavedContactList.find(saved_contact_list_id)
      @contacts = @saved_contact_list.contributors
    
      session[:contacts_from_search] = @contacts
    
      @already_selected = session[SELECTED_CONTACTS]
      logger.debug "Contributors from saved list @ #{@contacts}"
      
      # processing for existent contacts from mailout or saved contact lists
      saved_list_contacts = session[:list_contacts]
      mailout_list_contacts = session[:mailout_contacts]
      if saved_list_contacts != nil
        @already_selected = @already_selected + saved_list_contacts
      end
      if mailout_list_contacts != nil
        @already_selected = @already_selected + mailout_list_contacts
      end 
      
      #Given we have got this far, store the search details in the session
      session[:last_search_details ] = {:list => @saved_contact_list.id}
    end
    render :layout => false
  end
  
  
  
  
  #- Perform a search for contacts
  #
  #spods
  #select first_names, last_name, street  from people, contactinfos,
  # person_contactinfos where people.person_id = 
  # person_contactinfos.person_id 
  # and contactinfos.contactinfo_id = person_contactinfos.contactinfo_id 
  # order by people.person_id;
  # 
  # Organisations
  # select organisation_name,street  from organisations, contactinfos where organisations.contactinfo_id = contactinfos.contactinfo_id order by organisations.organisation_id;


  def find_contacts
    logger.debug "**** FIND CONTRIBUTORS ****"
    show_params(params) #debug params and put them in logs
    
    
    @person_query = params[:search][:person]
    @org_query = params[:search][:organisation]
    
    
    #This populates @contacts 
    @found_contacts = search_by_name_and_organisation(@person_query, @org_query)
    session[:contacts_from_search] = @found_contacts
    
    @already_selected = session[SELECTED_CONTACTS]
    
    # processing for existent contacts from mailout or saved contact lists
    saved_list_contacts = session[:list_contacts]
    mailout_list_contacts = session[:mailout_contacts]
    if saved_list_contacts != nil
      @already_selected = @already_selected + saved_list_contacts
    end
    if mailout_list_contacts != nil
      @already_selected = @already_selected + mailout_list_contacts
    end 
    
    render :layout => false
  end
  
  
  
  #------------------
  #- Perform the advanced search
  #------------------
  
  def find_contacts_advanced
    show_params(params)

    @person_query = params[:search][:person]
    @org_query    = params[:search][:organisation]

    @role_ids = params[:search][:role_id_ids].select {|r| r != ""}.compact
    
    # Get country and region if they were chosen
    @country_id = @region_id = ""
    if params[:search][:country_id] and params[:search][:country_id] != ""
      @country_id = params[:search][:country_id]
    end
    if params[:search][:region_id] and params[:search][:region_id] != ""
      @region_id  = params[:search][:region_id]  
    end

    @valid_email    = params[:search][:valid_email]
    @keywords_query = params[:search][:keywords]
    @modified_since = params[:search][:modified_since]
    
    @subcategory_filters = params[:category_filter].select {|v| !v.blank? }
    
    #This populates @contacts 
    @found_contacts = search_by_name_and_organisation(@person_query, @org_query, @keywords_query)

    # Filter by subcategory
    if @subcategory_filters.length != 0
      @found_contacts = @found_contacts.select do |c|
        !@subcategory_filters.select do |f|
          c.marketing_subcategories.collect{|ms| ms.marketing_subcategory_id}.include?(f.to_i)
        end.empty?
      end
    end

    # Filter by role if a role is selected
    # FIXME: question for client: this returns all organisations that have
    # someone with the given role, if organisations are searched for. Is that
    # desired behaviour?
    if @role_ids.length != 0
      @found_contacts = @found_contacts.select do |c|
        c.roles.select {|r| @role_ids.include?(r.role_type_id.to_s) }.length > 0
      end
    end

    # Filter by country/region
    if @country_id != "" or @region_id != ""
      @found_contacts = @found_contacts.select do |c|
        if @region_id != ""
          c.regions.collect{|r| r.region_id }.include?(@region_id.to_i)
        elsif @country_id != ""
          c.countries.collect{|c| c.country_id }.include?(@country_id.to_i)
        else
          true
        end
      end
    end

    # Only show results with a valid e-mail address
    if @valid_email.to_i > 0
      @found_contacts = @found_contacts.select {|c| c.valid_email? }
    end

    # Only show contacts modified since the specified date
    if !@modified_since.blank?
      modified_since_time = Time.parse @modified_since
      @found_contacts = @found_contacts.select {|c| !c.updated_at.blank? and modified_since_time < c.updated_at }
    end

    session[:contacts_from_search] = @found_contacts
    
    render :layout => false
    
  end
  
  
  
  #------------------
  #-helper method for the free text search
  #------------------
  include FinderHelper
  
  def search_by_name_and_organisation(person_query, organisation_query, keyword_query='')
    flash[:search_error] = nil
    
    contacts = []

    # FIXME: In reality, there needs to be a better way to add the wildcards so
    # that the search works as expected, and it needs to be used both here and
    # with the finder stuff. They need to be added in a way that doesn't cause
    # a syntax error, and so that all terms in the search get the wildcard
    person_keyword_query = FinderHelper.build_query(Person, person_query)
    organisation_keyword_query = FinderHelper.build_query(Organisation, organisation_query)

    # If a keyword query is supplied, build up the solr queries for it
    if !keyword_query.blank?
      organisation_keyword_query << " OR internal_note:{#{keyword_query.downcase}} OR organisation_abbrev:{#{keyword_query.downcase}}"
    end
    
    #Deal with the name search
    if person_query.length > 2 and organisation_query.length == 0
      contacts, paginator = solr_query(person_keyword_query)
      contacts = contacts[:docs]
      contacts.map! {|c| c.objectData }
    elsif organisation_query.length > 2 and person_query.length == 0
      contacts, paginator = solr_query(organisation_keyword_query)
      contacts = contacts[:docs]
      contacts.map! {|c| c.objectData }
    elsif organisation_query.length > 2 and person_query.length > 2
      @both_query = true
      contacts = find_people_who_work_for_organisation_by_solr(person_query.downcase, organisation_query.downcase, keyword_query.downcase)
    else
      flash[:search_error]="Please type at least 3 characters into one or both of the search fields"
      contacts = []
    end
    
    # get 'already_selected' processing
    @already_selected = session[SELECTED_CONTACTS]
    saved_list_contacts = session[:list_contacts]
    mailout_list_contacts = session[:mailout_contacts]
    
    # add saved list contacts or mailout contacts if any
    # so they don't have an opportunity to be added 
    # accidentally to the selected results list
    if saved_list_contacts != nil
      @already_selected = @already_selected + saved_list_contacts
    end
    
    if mailout_list_contacts != nil
      @already_selected = @already_selected + mailout_list_contacts
    end
    
    
    if @already_selected == nil
      @already_selected = []
    end
    
    
    #Store the search details
    session[:last_search_details ] = {:freetext => {:person=> person_query, :organisation => organisation_query}}
    
    return contacts
  end
  
  
  
  
  #----------------------
  #- Details about search_for_person with name and address
  #  <p>This is called by a form observable, possibly revisit as regards non AJAX</p>
  #----------------------
  #def search_for_person
  #  @person_query = params[:person][:name].strip
  #  @address_query = params[:search][:person_address].strip
    
  #  flash[:search_error] = nil
    
=begin    
    #FIXME include region in search
    #Deal with the name search
    if @person_query.length > 2 and @address_query.length == 0
      @people = Person.find(:all, :conditions => ["lower(first_names || ' ' || last_name) like ?",'%'+ @person_query.downcase + '%'])
      
      
    elsif @person_query.length == 0 and @address_query.length > 2
      @people = Person.find(:all, :include => :contactinfos, :conditions => ["lower(contactinfos.street || ' ' || contactinfos.locality) like ?",
       '%'+@address_query.downcase+'%'])
    elsif (@person_query.length > 2 and @address_query.length > 2)
      @people = Person.find(:all, :include => :contactinfos, 
                            :conditions => ["lower(contactinfos.street || ' ' || contactinfos.locality) like ?"+
      "and (lower(people.first_names || ' ' || people.last_name) like ?)", 
       '%'+@address_query.downcase+'%',
        '%'+@person_query.downcase+'%'
      ])
    else
      @people = []
      flash[:search_error]="Please type at least 3 characters into one or both of the search fields"
    end
=end   
    
    
    #Person.find_by_solr("(contributor_name:Michael Randal) AND (all_addresses_as_text:Road)", :rows => 100).length
    
    
   # query = ""
   # if @person_query.length > 2
   #   query = query +"contributor_name:(#{@person_query})"
   # end
    
   # if @address_query.length > 2
   #   if query.length > 0
   #    query = query + " AND "
   #   end
   #   query = query +"all_addresses_as_text:(#{@address_query})"
   # end
    
   # if @person_query.length <= 2 and @address_query.length <= 2
   #   @people = []
   #   flash[:search_error]="Please type at least 3 characters into one or both of the search fields"
   # end
    
    #Remove excess whitespace
    #query.strip!
    
    #logger.debug "LUCENE QUERY IS "+query
    
    #if query.length > 0
    #  begin
    #    @people = Person.find_by_solr(query, :rows => 100)
    #  rescue SyntaxError
    #    flash[:search_error] = "Sorry, your search was malformed"
    #    @people = []
    #  end
    #else 
    #  @people = []
    #end
    
    # get 'already_selected' processing
    #@already_selected = session[SELECTED_CONTACTS]
    #saved_list_contacts = session[:list_contacts]
    #mailout_list_contacts = session[:mailout_contacts]
    
    # add saved list contacts or mailout contacts if any
    # so they don't have an opportunity to be added 
    # accidentally to the selected results list
    #if saved_list_contacts != nil
    #  @already_selected = @already_selected + saved_list_contacts
    #end
    
    #if mailout_list_contacts != nil
    #  @already_selected = @already_selected + mailout_list_contacts
    #end
    
    
    #if @already_selected == nil
    #  @already_selected = []
    #end
    
    #render :layout => false
  #end
  
  
  #----------------------
  #- Search both the first and second names
  #----------------------
  def auto_complete_for_person_name
    @items = Person.find(:all, :conditions => [ 'LOWER(first_names) LIKE ? or LOWER(last_name) like ? ',
    '%' + params[:person][:name].downcase + '%','%' + params[:person][:name].downcase + '%' ], 
    :order => 'last_name ASC, first_names ASC',
    :limit => 20)
    render :partial => 'shared/autocomplete_list', :locals => {:field => 'full_name'}
  end
  
  #----------------------
  #- Details about auto_complete_for_search_person_address
  #----------------------
  def auto_complete_for_search_person_address
    show_params(params)
    address_query = params[:search][:person_address]
    logger.debug("Address query is " + address_query)
    
    
    @items = Contactinfo.find(:all, 
                              :conditions => [ 'LOWER(street) LIKE ? or LOWER(locality) like ? ',
    '%' + address_query.downcase + '%','%' +  address_query.downcase + '%' ], 
    :order => 'locality ASC, street ASC',
    :limit => 20)
    render :partial => 'shared/autocomplete_list', :locals => {:field => 'full_address'}
  end
  
  
  
  
  #------------------
  #- Choose a country, and update the region box
  #------------------
  
  def countryChosen
    
    show_params(params)
    logger.debug "Params id is #{params[:id]}"
    
    if params[:id] != ""
      @country = Country.find(params[:id])
      @regions = @country.regions
    else
      @country = nil
    end
    render :layout => false
  end
  
  
  
  
  
end
