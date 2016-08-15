-- Patch for SOUNZ database upgrade
-- 1.8.0 to 1.9.0
--
begin;

-- WR#51202 - added missed region_id field

drop view event_advanced_search;

create view event_advanced_search as
select e.event_id, e.status_id,e.event_type_id, c.contactinfo_id, c.region_id, c.locality, e.event_start, e.event_finish
from events e
left join contactinfos c on c.contactinfo_id = e.contactinfo_id
order by event_id;



-- Prevent deletion of composers in the association widget
update valid_entity_entity_relationships set user_maintainable= false
	where entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
	and entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'work')
	and relationship_type_id = (select relationship_type_id from relationship_types where 
		relationship_type_desc = 'Is composed by')
	;

-- WR#51123 - change people/organisations statuses from 'Published' to 'Pending'
-- (there should be no 'Published' status in CRM entities)
update people set status_id=(select status_id from publishing_statuses where status_desc = 'Pending') 
  where status_id = (select status_id from publishing_statuses where status_desc = 'Published');
  
update organisations set status_id=(select status_id from publishing_statuses where status_desc = 'Pending') 
  where status_id = (select status_id from publishing_statuses where status_desc = 'Published');

commit;