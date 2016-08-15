class ProvProducts < ActiveRecord::Base
	set_primary_key :prov_product_id
	
	belongs_to :status	
end
