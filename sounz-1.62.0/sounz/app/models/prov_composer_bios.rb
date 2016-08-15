class ProvComposerBios < ActiveRecord::Base
  set_primary_key :prov_composer_bio_id
  belongs_to :status
end
