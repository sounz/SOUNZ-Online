class ProvContributorProfiles < ActiveRecord::Base
  set_primary_key :prov_contributor_profile_id
  belongs_to :status
end
