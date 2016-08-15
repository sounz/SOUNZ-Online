class EventType < ActiveRecord::Base
    set_primary_key "event_type_id" 
    set_sequence_name "event_types_event_type_id_seq" 
    has_many :events
    
    validates_uniqueness_of :event_type_desc
    
    OPPORTUNITY = EventType.find(:first, :conditions => ["event_type_desc = ? ","Opportunity"])
    
end
