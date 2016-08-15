class RelatedOrganisation < ActiveRecord::Base
  set_primary_key :related_organisation_id
  belongs_to :organisation

  def related_organisation
    Organisation.find(org_organisation_id)
  end
end
