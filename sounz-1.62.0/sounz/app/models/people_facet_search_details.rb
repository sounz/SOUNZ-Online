#This contains the search terms and the
class PeopleFacetSearchDetails
  
  attr_reader :query, :born, :last_name, :person_organisation, :fully_represented, :country, :region,
              :role_group, :role_type, :where, :last_name, :status, :toggles, :distinction_type
              
  attr_writer :query, :born, :last_name, :person_organisation, :fully_represented, :country, :region,
            :role_group, :role_type, :where, :last_name, :status, :toggles, :distinction_type
  
end
