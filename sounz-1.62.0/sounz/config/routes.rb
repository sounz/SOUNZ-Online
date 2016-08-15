ActionController::Routing::Routes.draw do |map|
  map.resources :prov_bids,
                :member => {
                  :show_confirmation => :get
                }

  map.resources :prov_products,
                :member => {
                  :show_confirmation => :get
                }  

  map.resources :prov_contact_updates,
                :member => {
                  :show_confirmation => :get
                }

  map.resources :prov_work_updates,
                :member => {
                  :show_confirmation => :get
                }

  map.resources :prov_contributor_profiles,
            :member => {
              :show_confirmation => :get
            }

  map.resources :prov_feedbacks,
                :member => {
                  :show_confirmation => :get
                }

  map.resources :prov_events,
                :member => {
                  :show_confirmation => :get
                }

  map.resources :prov_composer_bios,
            :member => {
              :show_confirmation => :get
            }

  map.resources :samples

  map.resources :media_items,
                :member => {
                  :download => :get,
                  :manifestation_samples => :get      
                  }

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "home"



=begin
#---- FRBR CONTRIBUTOR LINKS ----
#Route to represent Arrangements
map.contributor_arrangements 'contributor/arrangements/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_arrangements'

#Route to represent Broadcasted Events
map.contributor_broadcasted_events 'contributor/broadcasted_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_broadcasted_events'

#Route to represent Broadcasted Expressions
map.contributor_broadcasted_expressions 'contributor/broadcasted_expressions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_broadcasted_expressions'

#Route to represent Commissioned Works
map.contributor_commissioned_works 'contributor/commissioned_works/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_commissioned_works'

#Route to represent Compilations
map.contributor_compilations 'contributor/compilations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_compilations'

#Route to represent Compositions
map.contributor_compositions 'contributor/compositions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_compositions'

#Route to represent Conceptions
map.contributor_conceptions 'contributor/conceptions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_conceptions'

#Route to represent Concepts Identifies With
map.contributor_concepts_identifies_withs 'contributor/concepts_identifies_withs/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_concepts_identifies_withs'

#Route to represent Creations
map.contributor_creations 'contributor/creations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_creations'

#Route to represent Descriptive Resource
map.contributor_descriptive_resources 'contributor/descriptive_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_descriptive_resources'

#Route to represent Distinctions
map.contributor_distinctions 'contributor/distinctions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_distinctions'

#Route to represent Distinctions
map.contributor_distinctions 'contributor/distinctions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_distinctions'

#Route to represent Exhibitions
map.contributor_exhibitions 'contributor/exhibitions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_exhibitions'

#Route to represent Funded Events
map.contributor_funded_events 'contributor/funded_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_funded_events'

#Route to represent Funded Or Sponsored Distinctions
map.contributor_funded_or_sponsored_distinctions 'contributor/funded_or_sponsored_distinctions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_funded_or_sponsored_distinctions'

#Route to represent Funded Works
map.contributor_funded_works 'contributor/funded_works/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_funded_works'

#Route to represent Held Events
map.contributor_held_events 'contributor/held_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_held_events'

#Route to represent Improvised Expressions
map.contributor_improvised_expressions 'contributor/improvised_expressions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_improvised_expressions'

#Route to represent Improvised Works
map.contributor_improvised_works 'contributor/improvised_works/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_improvised_works'

#Route to represent Influential Concepts
map.contributor_influential_concepts 'contributor/influential_concepts/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_influential_concepts'

#Route to represent Licensed Manifestations
map.contributor_licensed_manifestations 'contributor/licensed_manifestations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_licensed_manifestations'

#Route to represent Licensed Resources
map.contributor_licensed_resources 'contributor/licensed_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_licensed_resources'

#Route to represent Managed Events
map.contributor_managed_events 'contributor/managed_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_managed_events'

#Route to represent Managed Venues
map.contributor_managed_venues 'contributor/managed_venues/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_managed_venues'

#Route to represent Managers
map.contributor_managers 'contributor/managers/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_managers'

#Route to represent Manifestations Dedicated
map.contributor_manifestations_dedicateds 'contributor/manifestations_dedicateds/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_manifestations_dedicateds'

#Route to represent Notations
map.contributor_notations 'contributor/notations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_notations'

#Route to represent Owned Venues
map.contributor_owned_venues 'contributor/owned_venues/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_owned_venues'

#Route to represent Owners
map.contributor_owners 'contributor/owners/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_owners'

#Route to represent Performances
map.contributor_performances 'contributor/performances/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_performances'

#Route to represent Performed Events
map.contributor_performed_events 'contributor/performed_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_performed_events'

#Route to represent Performed Venues
map.contributor_performed_venues 'contributor/performed_venues/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_performed_venues'

#Route to represent Performers
map.contributor_performers 'contributor/performers/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_performers'

#Route to represent Performs According To
map.contributor_performs_according_tos 'contributor/performs_according_tos/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_performs_according_tos'

#Route to represent Presentations
map.contributor_presentations 'contributor/presentations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_presentations'

#Route to represent Presented Distinctions
map.contributor_presented_distinctions 'contributor/presented_distinctions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_presented_distinctions'

#Route to represent Presented Distinctions
map.contributor_presented_distinctions 'contributor/presented_distinctions/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_presented_distinctions'

#Route to represent Presented Events
map.contributor_presented_events 'contributor/presented_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_presented_events'

#Route to represent Presented Events
map.contributor_presented_events 'contributor/presented_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_presented_events'

#Route to represent Published Manifestations
map.contributor_published_manifestations 'contributor/published_manifestations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_published_manifestations'

#Route to represent Published Resources
map.contributor_published_resources 'contributor/published_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_published_resources'

#Route to represent Recorded Events
map.contributor_recorded_events 'contributor/recorded_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_recorded_events'

#Route to represent Recorded Resources
map.contributor_recorded_resources 'contributor/recorded_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_recorded_resources'

#Route to represent Recordings
map.contributor_recordings 'contributor/recordings/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_recordings'

#Route to represent Related Resources
map.contributor_related_resources 'contributor/related_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_related_resources'

#Route to represent Released Manifestations
map.contributor_released_manifestations 'contributor/released_manifestations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_released_manifestations'

#Route to represent Released Resources
map.contributor_released_resources 'contributor/released_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_released_resources'

#Route to represent Resources Dedicated
map.contributor_resources_dedicateds 'contributor/resources_dedicateds/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_resources_dedicateds'

#Route to represent Roles Commissioned
map.contributor_roles_commissioneds 'contributor/roles_commissioneds/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_roles_commissioneds'

#Route to represent Roles Funded
map.contributor_roles_fundeds 'contributor/roles_fundeds/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_roles_fundeds'

#Route to represent Roles Worked With By
map.contributor_roles_worked_with_bies 'contributor/roles_worked_with_bies/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_roles_worked_with_bies'

#Route to represent Roles Working With
map.contributor_roles_working_withs 'contributor/roles_working_withs/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_roles_working_withs'

#Route to represent Selected Works
map.contributor_selected_works 'contributor/selected_works/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_selected_works'

#Route to represent Sold Events
map.contributor_sold_events 'contributor/sold_events/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_sold_events'

#Route to represent Sold Manifestations
map.contributor_sold_manifestations 'contributor/sold_manifestations/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_sold_manifestations'

#Route to represent Sold Resources
map.contributor_sold_resources 'contributor/sold_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_sold_resources'

#Route to represent Venues Has Commonalities With
map.contributor_venues_has_commonalities_withs 'contributor/venues_has_commonalities_withs/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_venues_has_commonalities_withs'

#Route to represent Venues Things In Common With
map.contributor_venues_things_in_common_withs 'contributor/venues_things_in_common_withs/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_venues_things_in_common_withs'

#Route to represent Works Dedicated
map.contributor_works_dedicateds 'contributor/works_dedicateds/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_works_dedicateds'

#Route to represent Writes According To
map.contributor_writes_according_tos 'contributor/writes_according_tos/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_writes_according_tos'

#Route to represent Writings
map.contributor_writings 'contributor/writings/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_writings'

#Route to represent Written Resources
map.contributor_written_resources 'contributor/written_resources/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role',
:mode => 'frbr_written_resources'


=end

#---- FRBR CONCEPT LINKS ----

=begin 

#Route to represent Genred Distinctions
map.concept_genred_distinctions 'concepts/genred_distinctions/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_genred_distinctions'

#Route to represent Genred Events
map.concept_genred_events 'concepts/genred_events/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_genred_events'

#Route to represent Genred Manifestations
map.concept_genred_manifestations 'concepts/genred_manifestations/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_genred_manifestations'

#Route to represent Genred Resources
map.concept_genred_resources 'concepts/genred_resources/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_genred_resources'

#Route to represent Genred Works
map.concept_genred_works 'concepts/genred_works/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_genred_works'

#Route to represent Influenced Events
map.concept_influenced_events 'concepts/influenced_events/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_influenced_events'

#Route to represent Influenced Manifestations
map.concept_influenced_manifestations 'concepts/influenced_manifestations/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_influenced_manifestations'

#Route to represent Influenced Resources
map.concept_influenced_resources 'concepts/influenced_resources/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_influenced_resources'

#Route to represent Influenced Superworks
map.concept_influenced_superworks 'concepts/influenced_superworks/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_influenced_superworks'

#Route to represent Influenced Works
map.concept_influenced_works 'concepts/influenced_works/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_influenced_works'

#Route to represent Inspired Superworks
map.concept_inspired_superworks 'concepts/inspired_superworks/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_inspired_superworks'

#Route to represent Performance Affected By
map.concept_performance_affected_bies 'concepts/performance_affected_bies/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_performance_affected_bies'

#Route to represent Related Concepts
map.concept_related_concepts 'concepts/related_concepts/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_related_concepts'

#Route to represent Roles Influenced
map.concept_roles_influenceds 'concepts/roles_influenceds/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_roles_influenceds'

#Route to represent Roles Who Identify
map.concept_roles_who_identifies 'concepts/roles_who_identifies/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_roles_who_identifies'

#Route to represent Themed Events
map.concept_themed_events 'concepts/themed_events/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_themed_events'

#Route to represent Themed Manifestations
map.concept_themed_manifestations 'concepts/themed_manifestations/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_themed_manifestations'

#Route to represent Themed Resources
map.concept_themed_resources 'concepts/themed_resources/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_themed_resources'

#Route to represent Themed Works
map.concept_themed_works 'concepts/themed_works/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_themed_works'

#Route to represent Writings Affected By
map.concept_writings_affected_bies 'concepts/writings_affected_bies/:id',
:controller => 'concepts',
:action => 'related',
:mode => 'frbr_writings_affected_bies'


=end

#---- FRBR METHODS FOR EVENTS -----
#Route to represent Broadcasters
=begin
map.event_broadcasters 'event/broadcasters/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_broadcasters'

#Route to represent Commissioned Expressions
map.event_commissioned_expressions 'event/commissioned_expressions/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_commissioned_expressions'

#Route to represent Commissioned Works
map.event_commissioned_works 'event/commissioned_works/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_commissioned_works'

#Route to represent Concept Genres
map.event_concept_genres 'event/concept_genres/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_concept_genres'

#Route to represent Concept Influences
map.event_concept_influences 'event/concept_influences/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_concept_influences'

#Route to represent Concept Themes
map.event_concept_themes 'event/concept_themes/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_concept_themes'

#Route to represent Distinctions
map.event_distinctions 'event/distinctions/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_distinctions'

#Route to represent Funders
map.event_funders 'event/funders/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_funders'

#Route to represent Happening Expressions
map.event_happening_expressions 'event/happening_expressions/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_happening_expressions'

#Route to represent Included Events
map.event_included_events 'event/included_events/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_included_events'

#Route to represent Is Included In These Events
map.event_is_included_in_these_events 'event/is_included_in_these_events/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_is_included_in_these_events'

#Route to represent Managers
map.event_managers 'event/managers/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_managers'

#Route to represent Manifestations Launched
map.event_manifestations_launcheds 'event/manifestations_launcheds/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_manifestations_launcheds'

#Route to represent Performers
map.event_performers 'event/performers/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_performers'

#Route to represent Presented Expressions
map.event_presented_expressions 'event/presented_expressions/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_presented_expressions'

#Route to represent Presenters
map.event_presenters 'event/presenters/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_presenters'

#Route to represent Recorders
map.event_recorders 'event/recorders/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_recorders'

#Route to represent Related Events
map.event_related_events 'event/related_events/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_related_events'

#Route to represent Resources Launched
map.event_resources_launcheds 'event/resources_launcheds/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_resources_launcheds'

#Route to represent Sellers
map.event_sellers 'event/sellers/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_sellers'

#Route to represent Venues Held At
map.event_venues_held_at 'event/venues_held_at/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_venues_held_at'

#Route to represent Venues Presented At
map.event_venues_presented_ats 'event/venues_presented_ats/:id',
:controller => 'events',
:action => 'related',
:mode => 'frbr_venues_presented_ats'

=end



  map.edit_person_and_reset_session_var 'people/edits/:person_id',
  :controller => 'people',
  :action => 'edits'

=begin  

  OLD NON GENERIC ROUTES
  map.contributor_as_composer_intro 'contributor/composer/intro/:id',
    :controller => 'contributors',
    :action => 'composer_intro'
    
    
  map.contributor_as_composer_compositions 'contributor/composer/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role',
      :mode => "frbr_compositions"
      

      
      
      
  map.contributor_as_composer_arrangements 'contributor/composer/arrangements/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_arrangements'

  map.contributor_as_composer_commissions 'contributor/composer/commissions/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_commissions'

      map.contributor_as_composer_creations 'contributor/composer/creations/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_creations'

      map.contributor_as_composer_improvisations 'contributor/composer/improvisations/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_improvisations'


      map.contributor_as_composer_presentations 'contributor/composer/presentations/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_presentations'

      map.contributor_as_composer_writings 'contributor/composer/writings/:id',
      :controller => 'contributors',
      :action => 'composer_show_all_writings'
=end


#-- simpler way of deal with frbr related --
map.work_frbr_related 'work/related/:mode/:id',
:controller => 'works',
:action => 'related'

map.manifestation_frbr_related 'manifestation/related/:mode/:id',
:controller => 'manifestations',
:action => 'related'

map.resource_frbr_related 'resource/related/:mode/:id',
:controller => 'resources',
:action => 'related'

map.concept_frbr_related 'concept/related/:mode/:id',
:controller => 'concepts',
:action => 'related'

map.event_frbr_related 'event/related/:mode/:id',
:controller => 'events',
:action => 'related'

map.contributor_frbr_related 'contributor/related/:mode/:id',
:controller => 'contributors',
:action => 'show_appropriate_for_role'


map.distinction_frbr_related 'distinction/related/:mode/:id',
:controller => 'distinctions',
:action => 'related'

map.distinction_instance_frbr_related 'distinction_instance/related/:mode/:id',
:controller => 'distinction_instances',
:action => 'related'


  
      
      #-- Routing for works --
      map.work_introduction 'work/intro/:id',
      :controller => 'works',
      :action => 'work_introduction'
      
     
      #These all default a mode to 'main'
      map.contributor_as_venue 'contributor/venue/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      
      map.contributor_as_presenter 'contributor/presenter/intro/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      
      map.contributor_as_composer 'contributor/composer/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      
      map.contributor_as_performer 'contributor/performer/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      
      
      map.contributor_as_commissioner 'contributor/commissioner/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      
      map.contributor_as_presenter 'contributor/presenter/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      

      map.contributor_as_publisher 'contributor/publisher/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      

      map.contributor_as_writer 'contributor/writer/:id',
      :controller => 'contributors',
      :action => 'show_appropriate_for_role'
      

      
           
      
      #--------

 
      map.contributor_as_performer_intro 'contributor/performer/intro/:id',
        :controller => 'contributors',
        :action => 'performer_intro' 
        
     map.contributor_as_performer_commissions 'contributor/performer_commissions/:id',
      :controller => 'contributors',
      :action => 'performer_show_all_commissions'
    
      map.contributor_as_performer_performances 'contributor/performer_performances/:id',
      :controller => 'contributors',
      :action => 'performer_show_all_performances'
      
      map.contributor_as_performer_improvisations 'contributor/performer_improvisations/:id',
      :controller => 'contributors',
      :action => 'performer_show_all_improvisations'
      
      map.contributor_as_performer_exhibitions 'contributor/performer_exhibitions/:id',
      :controller => 'contributors',
      :action => 'performer_show_all_exhibitions'
      
      map.contributor_as_performer_presentations 'contributor/performer_presentations/:id',
      :controller => 'contributors',
      :action => 'performer_show_all_presentations'
      
      
      map.contributor_as_general_intro 'contributor/general/intro/:id',
        :controller => 'contributors',
        :action => 'general_intro'
        
        
      map.contributor_as_general_funder 'contributor/general_funder/:id',
      :controller => 'contributors',
      :action => 'general_show_all_funded_works'
      
      map.venue_performers 'venue/performers/:id',
      :controller => 'venues',
      :action => 'performers'
      
      map.venue_events 'venue/events/:id',
      :controller => 'venues',
      :action => 'events'
      
      #This is not used
      #map.purchase_manifestation 'shop/purchase/:id',
      #:controller => 'shop',
      #:action => 'purchase'
      
      map.under_construction 'todo/under_construction',
      :controller => 'todo',
      :action => 'under_construction'
      
      map.venue_events 'venue/events/:id',
      :controller => 'venues',
      :action => 'events'
      
      map.new_manifestation_for_expression 'expression/:id/new_manifestation',
      :controller => 'manifestations',
      :action => 'new_for_expression'
      
      map.flash_video_player 'video/:id',
      :controller => 'media_items',
      :action => 'show_flash_video'
      
      map.flash_music_player 'recording/:id',
      :controller => 'media_items',
      :action => 'show_flash_music'
      
      map.flash_sample_video_player 'sample_video/:id',
      :controller => 'media_items',
      :action => 'show_flash_video_for_sample'
      
      map.flash_sample_music_player 'sample_recording/:id',
      :controller => 'media_items',
      :action => 'show_flash_music_for_sample'
      
      
      map.memberships 'memberships',
      :controller  => 'cart',
      :action => 'show_memberships'
      
      map.donations 'donations',
      :controller  => 'cart',
      :action => 'show_donations'
      
      
      map.content_page 'content/:name',
      :controller => 'cm_contents',
      :action => 'show_by_name'
      
        
       
        
  map.modal_loading 'modal/loading/:title',
  :controller => 'modal',
  :action => 'loading'






  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
