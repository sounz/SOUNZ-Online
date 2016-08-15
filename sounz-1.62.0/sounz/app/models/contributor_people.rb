class ContributorPeople < ActiveRecord::Base
set_sequence_name "contributor_people_id_seq"

belongs_to :contributor
belongs_to :person
end
