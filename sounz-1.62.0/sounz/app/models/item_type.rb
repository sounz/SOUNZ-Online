class ItemType < ActiveRecord::Base
  
  set_primary_key :item_type_id
  
  # relationships
  has_many :items
  
  # model validation
  validates_presence_of :item_type_desc,
                        :display_order,
                      :message => 'cannot be blank'
                      
  RESOURCE_LIBRARY_ITEM = ItemType.find_by_item_type_desc('Resource library item')
  MUSIC_LIBRARY_ITEM = ItemType.find_by_item_type_desc('Music library item')
  SALE_ITEM = ItemType.find_by_item_type_desc('Sale item')
  NO_ERP_STATUS = ItemType.find_by_item_type_desc('No ERP Status')
end
