#
# Contributors are either people or organisations that have "contributed" -
# i.e. they are composers, arrangers, performers or any one of many different
# things that Sounz considers have 'contributed'. They are searchable through
# the faceted search tabs.
#
# People and organisations become contributors when they get the contributor
# role.
#
# FIXME: This controller needs cleaning up and documenting
#
class Contributor < ActiveRecord::Base

  include FrbrHelper
  include FrbrMethodsContributor
      
  set_primary_key "contributor_id"
  set_sequence_name "contributors_contributor_id_seq"
  
  #belongs_to :contactinfo
  belongs_to :status
  belongs_to :role
  
  has_many :contributor_attachments
  has_many :media_items, :through => :contributor_attachments
  
  #has_many :contributor_relationships
  #has_many :relationships, :through => :contributor_relationships, :select => "contributor_relationships.relationship_type_id, relationships.*"
  
 
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
            
  
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by          
            
  # validation of the model
  # Test booleans exist and are non nil
  validates_inclusion_of :apra_member, :in => [true, false]
  validates_inclusion_of :canz_member, :in => [true, false]
  
  validates_length_of :known_as, :in => 2..100,
                      :allow_nil => true,
                      :message => "is not between 2 and 100 chars",
                      :if => ModelHelper.only_check_if_not_empty( :known_as )
  
  #use :string if you wont want the string broken up, ie indexed as is
  #e.g. 1980-1990 gets indexed as 1980, 1990 as text but "1980-1990" as a string
  acts_as_solr :fields => [
                           :known_as_for_solr,
                           :has_known_as_for_solr,
                           :profile_for_solr, 
                           :profile_other_for_solr, 
                           :pull_quote_for_solr, 
                           :description_for_solr,
                           :internal_note_for_solr,
                           :role_type_id_for_solr,
                           :status_for_solr,
                           {:year_of_creation_range_for_solr => :string},
                           {:facet_sort_field_for_solr => :string},
                           {:known_as_as_string_for_solr => :string},
                           #:last_name_for_solr,
                           {:last_name_range_for_solr => :string},
                           {:person_or_organisation_for_solr => :string},
                           {:fully_represented_for_solr => :string},
                           {:inside_nz_for_solr => :string},
                           {:outside_nz_for_solr => :string},
                           {:countries_facet_for_solr => :string},
                           :nz_regions_facet_for_solr,
                           {:role_type_group_for_solr => :string},
						               :awards_received_for_solr,
                           :regions_for_solr,
                           :countries_for_solr,
                           ],
                :include => [:role] #FIXME: Investigate behaviour here
   
   FACET_COUNTRIES = [Country::AUSTRALIA,Country::UNITED_STATES, Country::UNITED_KINGDOM, Country::CANADA]

   YEAR_RANGES = [
     [0,1899], 
     [1900,1949],
     [1950,1959],
     [1960,1969],
     [1970,1979],
     [1980,1989],
     [1990,1999],
     [2000,2009]
   ]
   
   #- Public display of 'known_as'
   def known_as_public
	 known_as_public = known_as
	 
	 # person contributor 'known_as' needs to be
	 # in 'first names' 'last name' format
	 if ! role.person.blank? && !known_as.blank?
	   contributor_names = known_as.split(',')
			
	   if !contributor_names[1].blank?
	     known_as_public = contributor_names[1].to_s.strip << ' ' << contributor_names[0].to_s.strip
	   else
	     known_as_public = contributor_names[0]
	   end
	 end
			
	 return known_as_public   	 
   end   
   
   def internal_contributor_name
     internal_contributor_name = known_as
	 
	 if known_as.blank?
	   # Deal with person case 
	   if !role.person.blank?
		 # we need 'last name, first names' format for person contributor
		 internal_contributor_name = role.person.last_name + ', ' + role.person.first_names
		 					   
		#This is the organisation case
		else
		  internal_contributor_name = role.organisation.organisation_name if !role.organisation.blank?
		end
	 end
	 
	 return internal_contributor_name
	  
   end
   
   def status_for_solr
     return status_id
   end
   
   def distinctions_received
   	 return role.distinctions.map{|di| di.distinction}.uniq
   end
   
   def awards_received_for_solr
     return distinctions_received.map{|d| d.distinction_types.map{|dt| dt.distinction_type_id}}.flatten.uniq.join(', ')
   end
   
   def facet_sort_field_for_solr	 	 	 
	   return FinderHelper.strip(internal_contributor_name.downcase)
   end
   
   #index the reqiured range for 
   def last_name_range_for_solr
     result = 'Other'
     letter = nil
     name = FinderHelper.strip(internal_contributor_name)
     
	   letter = name.first.downcase unless name.blank?
          
       
     for range_pair in [
        ['a','a'],
        ['b','b'],
        ['c','c'],
        ['d','e'],
        ['f','g'],
        ['h','j'],
        ['k','l'],
        ['m','m'],
        ['n','q'],
        ['r','s'],
        ['t','w'],
        ['x','z']
      ]
      
        from = range_pair[0]
        to = range_pair[1]
      
        if letter == from and letter == to
          result = "#{letter}"
        elsif letter >= from and letter <= to
          result="#{from}-#{to}"
        end
		
     end
     
   #  puts "RESULT:#{result}"
     result
   end
   
   #Index the role type grouping, ie composer, performer, commissioner, presenter, publisher, writer
    def role_type_group_for_solr
      return role.role_type.facet_role_type
    end
   
    #This only applies to regions in NZ
    def nz_regions_facet_for_solr
        region_ids = []
        for ci in role.contactinfos
          ci.initialize_contactinfo_associated_with_another_contactinfo( ci.default_contactinfo ) unless ci.default_contactinfo.blank?
          region_ids << ci.region_id
        end
        
       # puts "REGION IDS:"+region_ids.to_yaml
        result = FacetHelper.remove_duplicates_and_blank(region_ids)
       # puts "FILTERED REGION_IDS:"+result.to_yaml
       # puts result.length
       # puts "======="
        for region_id in result
         # puts "REGION_ID:#{region_id}"
          if !Region.find(region_id).country == Country::NEW_ZEALAND
            result.delete(region_id)
          end
        end
        result.join(', ')
    end
    
    
    
    
    
   #it is a requirement to facet by country, showing UK, Canada, Australia, US and Other
   def countries_facet_for_solr
     result_array = []
     ac = associated_countries
     
     #check for the in facets
     for country in FACET_COUNTRIES
       result_array << country.country_name if ac.include?(country)
     end
     
     #now check for NZ - we only want non nz countries
     if (ac.length == (result_array.length+1) and (ac.include?(Country::NEW_ZEALAND)))
       #ignore
     #now check for another country
     elsif ac.length > result_array.length #we must have another country in this case
       result_array << 'Other'
     end
     
     temp_array = []
     for r in result_array
       temp_array << r.gsub(' ','').downcase
     end
     
 #    result_array << "Mars"
 #    result_array << "The Moon"
     
     temp_array.join(', ')
   end
   
   
  
   
  #Separating inside and outside like this allows for the possiblity of someone having a physical address
  #in one country and a postal in another
  def inside_nz_for_solr
    associated_countries.include?(Country::NEW_ZEALAND)
  end
  
  #Separating inside and outside like this allows for the possiblity of someone having a physical address
  #in one country and a postal in another
  def outside_nz_for_solr
    !associated_countries.include?(Country::NEW_ZEALAND) and !associated_countries.blank?
  end
  
  #Get a list of all the countries that this contributor is associated with in addresses
  def associated_countries

    contactinfos = []
    role.contactinfos.each do |ci|
      ci.initialize_contactinfo_associated_with_another_contactinfo( ci.default_contactinfo ) unless ci.default_contactinfo.blank?
      contactinfos << ci
    end

    result = contactinfos.map{|ci| ci.country}
    for region in contactinfos.map{|ci| ci.region}
     result << region.country  if !region.blank?
    end
    result.map{|r|result.delete(r) if r.blank?}
    result.uniq
  end
  
   
  
  def fully_represented_for_solr
    composer_status == 2
  end
          
              
  #For facetting creation years, its necessary to get either the person or organisation year of creation.
  #Annoyingly they have different field names.  
  def year_of_creation_range_for_solr
    result = ""
    if !role.person.blank?
      actual_year = role.person.year_of_birth
    elsif !role.organisation.blank?
      actual_year = role.organisation.year_of_establishment
    end
    
    result = ""
    #this needs to be converted into a range
    if !actual_year.blank?
      for range in YEAR_RANGES
        start_year = range[0]
        end_year = range[1]
        if actual_year >= start_year and actual_year <= end_year
          result = "#{start_year}-#{end_year}"
          break
        end
      end
    end
    result
  end
  
  
  #Return either P for person or O for organisation
  def person_or_organisation_for_solr
    result = "P" if !role.person.blank?
    result = "O" if !role.organisation.blank?
    result
  end
                
  def role_type_id_for_solr
    return role.role_type_id
  end
  
  
  #This is either the person's last name or the known_as last word
  #def last_name_for_solr
  #  result = ""
    
  #  result = description.split(' ').last
  #  return FinderHelper.strip(result)
  #end
  
  
  # used for solr indexing
  def known_as_for_solr
    return FinderHelper.strip(known_as_public)
  end
  
  # used for solr indexing
  def known_as_as_string_for_solr
    known_as_l_case = known_as
    known_as_l_case = known_as.downcase if !known_as.blank?
    return FinderHelper.strip(known_as_l_case)
  end
  
  
  def has_known_as_for_solr
    result = 0
    result = 1 if !known_as.blank?
    result
  end
  
   
  
  def profile_for_solr
    return FinderHelper.strip(profile)
  end
  
  def profile_other_for_solr
    return FinderHelper.strip(profile_other)
  end
  
  def internal_note_for_solr
    return FinderHelper.strip(internal_note)
  end
  
  def pull_quote_for_solr
    return FinderHelper.strip(pull_quote)
  end
  
  def description_for_solr
    return FinderHelper.strip(description)
  end

  def regions_for_solr
    region_ids = []
    for ci in role.contactinfos
      ci.initialize_contactinfo_associated_with_another_contactinfo( ci.default_contactinfo ) unless ci.default_contactinfo.blank?
      region_ids << ci.region_id
    end

    result = region_ids.uniq.join(' ').strip
    return result
  end

  def countries_for_solr
    country_ids = []
    for ci in role.contactinfos
      ci.initialize_contactinfo_associated_with_another_contactinfo( ci.default_contactinfo ) unless ci.default_contactinfo.blank?
      country_ids << ci.country_id
    end

    result = country_ids.uniq.join(' ').strip
    return result
  end
  
  def self.composer_statuses
    {
      :not_applicable => 0,
      :tier_1 => 1,
      :tier_2 => 2,
   
    }
  end
  
  
  def self.contributor_agent_classes
    {
      :person => 'P',
      :organisation => 'O',
    }
  end
    
  def frbr_type
    "contributor"
  end
  
  def frbr_id
    contributor_id
  end
  
  def frbr_ui_desc
    return description
  end
  
  
  #These methods are used when rendering lists of FRBR objects, e.g. a composers writings
   #The naming needs to be common to maintain a single partial for list rendering
   def frbr_list_title
     known_as_public
   end

   def frbr_list_description
     description
   end
   
  #----------------------------------------------------------------------------------
  #- A list of contributor names 
  #- Note the database allows many to many but the business rules are such that only
  #- one person or organisation would normally show.
  #----------------------------------------------------------------------------------
  # FIXME: Above description no longer true, the database has been fixed. This method needs fixing
  def description
    result = known_as_public
    
    #Deal with person case
    if result.blank? #default to contributor known as public, otherwise go hunting
    
     if !role.person.blank?
        result = role.person.full_name
        if result.blank?
          result = 'PERSON NAME NOT FOUND'
        end
       
      #This is the organisation case
      else
        result = role.organisation.organisation_name if !role.organisation.blank?
        if result.blank?
          result = 'ORGANISATION NAME NOT FOUND'
        end
      end
    end
    result
  end
  
  
  
  def frbr_relationships
    frbr_relationships=Array.new()
    for rel in relationships.uniq
      reltype=RelationshipType.find(rel.relationship_type_id)
      
      #Choose the entity_type that does not match this one.
      #Where both are the same, it does not matter which we pick
      my_entity=EntityType.entityTypeToId(rel.ent_entity_type_id)
      if EntityType.entityTypeToId(rel.ent_entity_type_id) == frbr_type() then 
        my_entity= EntityType.entityTypeToId(rel.entity_type_id)
      end
      
      related_objects=eval('rel.'+my_entity+'s')
      
      for related_object in related_objects
        if rel.entity_type_id == rel.ent_entity_type_id then
          if related_object.id != id then
            frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
          end
        else 
        frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
        end
      end
    end
    frbr_relationships
  end
  
  
  #Heuristic to be replaced later by proper role related stuff
  def what_kind_of_contributor?
    puts composer_status
    if composer_status == 1 or composer_status == 2
      result = :composer
    else
      performer_ct = number_of_performances + number_of_exhibitions + number_of_presentations + number_of_improvised_expressions
      puts "PERFORMER COUNT:"+performer_ct.to_s
      if performer_ct > 0
        result = :performer
      else
        result = :general
      end
    
    end
    
  end
  
  
  #Business requirement is this for public website
  #Tier 1 - show nothing
  #Tier 2 - show "Fully Represented Sounz Composer"
  def composer_status_as_public_site_string
    result = ""
    if composer_status == Contributor.composer_statuses[:tier_2]
        result = "Fully Represented SOUNZ Composer"
    end
    result
  end
  
  
  #See WR???? - we only show the first website URL from the postal contact info
  def get_contributor_website_url
    role.get_contributor_url
  end
  
  def get_website_urls
    urls = []
    urls << role.get_list_of_websites
    
    
    urls.flatten!
 #   puts "URLS are #{urls}, len is #{urls.length}, class is #{urls.class}, urls[0].class is #{urls[0].class}"
    urls
  end
  
  
  
  
  #---- this is not in the FRBR stuff as its a combo ---
  
  def themes_and_influences
    return concept_themes+concept_influence
  end
  
  #for rendering on the public website
  def year_to_string
    result = ""
    if !role.organisation.blank? && role.person.blank?
      result = "Established: "+role.organisation.year_of_establishment.to_s unless role.organisation.year_of_establishment.blank?
    elsif !role.person.blank?
      result = "Born: "+role.person.year_of_birth.to_s unless role.person.year_of_birth.blank?
      result << " Deceased: #{role.person.year_of_death}" if !role.person.year_of_death.blank?
    end
    result
  end
  
  #- Return false if any fields except default ones    -
  #- (created_at, updated_at, updated_by, status) are  -
  #- not empty, this to check if any data has been     -
  #- entered by user and that particular contributor   -
  #- was not just a creation of the system process     -
  #- as a contributor record is created automatically  -
  #- when a role is created with the is_contributor    -
  #- set to true                                       -
  def is_empty?
  	result = true
	
	# check the contributor record fields
	if status_id == Status::PUBLISHED.status_id ||
	   status_id == Status::MASKED.status_id ||
	   !(known_as.blank? and
		 #photo_credit.blank? and
		 apra_member.blank? and
		 canz_member.blank? and
		 profile.blank? and
		 profile_other.blank? and
		 profile_source.blank? and
		 composer_status.blank? and
		 pull_quote.blank? and
		 permission_note.blank? and
		 internal_note.blank? and
		 legacy4d_identity_code.blank?
	    )
	  result = false
	end
	
	# check if contributor has any attachments
	result = false unless contributor_attachments.blank?
	
	# check if contributor has any TAP relationships	
	result = false unless role.role_relationships.blank?
	 
	return result

  end

  # Delete the contributor record and the appropriate record from
  # saved_searches if any to avoid errors in selected results lists
  # due to the lost of contributor frbr object type
  def destroy_self

    saved_search_known_as = "known_as: #{self.known_as}"
    saved_searches = SavedSearch.find(:all, :conditions => ['search_data ILIKE ?', '%' + saved_search_known_as + '%'])

    if self.destroy
      saved_searches.each do |ss|
        ss.destroy
      end

      result = true

    else
      result = false
    end

    return result
  end
  
end
