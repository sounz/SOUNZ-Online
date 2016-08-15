class Region < ActiveRecord::Base
    set_primary_key :region_id
    belongs_to :country
    has_many :contactinfos
    
    acts_as_dropdown :text => "region_name"
end
