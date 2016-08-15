class ProjectTeam < ActiveRecord::Base
    set_primary_key :project_team_id
    belongs_to :project
    belongs_to :person
    has_many :marketing_campaigns, :through => :project
end
