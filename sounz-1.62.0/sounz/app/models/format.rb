class Format < ActiveRecord::Base
    set_primary_key "format_id" 
    set_sequence_name "formats_format_id_seq" 
    
    has_and_belongs_to_many :resource_types, :join_table => :resource_type_formats
    has_and_belongs_to_many :manifestation_types, :join_table => :manifestation_type_formats
    
    
    validates_presence_of :format_desc
    validates_uniqueness_of :format_desc
	
	# as defined for Quicklinks Music search
	# WR#51699
	def self.score_formats
	  ['hardcopy - computer set', 'hardcopy - facsimile', 'pdf - computer set', 'pdf - facsimile']
	end
	
	def self.cd_and_dvd_formats
	  ['CD', 'DVD', 'CD Rom']
	end
end
