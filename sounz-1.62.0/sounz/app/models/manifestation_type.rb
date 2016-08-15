class ManifestationType < ActiveRecord::Base
       set_primary_key "manifestation_type_id" 
     
     has_many :manifestations
     has_and_belongs_to_many :formats, 
                             :join_table => :manifestation_type_formats, 
                             :order => :format_desc #To make the dropdowns alphabetical
     
     validates_presence_of :manifestation_type_desc
     validates_uniqueness_of :manifestation_type_desc
     
end
