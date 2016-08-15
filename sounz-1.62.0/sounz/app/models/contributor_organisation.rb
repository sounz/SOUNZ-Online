class ContributorOrganisation < ActiveRecord::Base
belongs_to :contributor
belongs_to :organisation
end
