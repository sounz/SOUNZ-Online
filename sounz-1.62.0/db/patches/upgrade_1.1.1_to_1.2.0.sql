-- Patch for SOUNZ database upgrade
-- 1.1.0 to 1.1.1
--

begin;

-- WR#50430
update valid_entity_entity_relationships set page_title = 'Distinctions' where page_title = 'Genred Distinctions' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Events' where page_title = 'Genred Events' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Manifestations' where page_title = 'Genred Manifestations' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Resources' where page_title = 'Genred Resources' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Works' where page_title = 'Genred Works' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Events' where page_title = 'Influenced Events' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Manifestations' where page_title = 'Influenced Manifestations' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Resources' where page_title = 'Influenced Resources' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Superworks' where page_title = 'Influenced Superworks' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Works' where page_title = 'Influenced Works' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Superworks' where page_title = 'Inspired Superworks' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Events' where page_title = 'Themed Events' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Manifestations' where page_title = 'Themed Manifestations' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Resources' where page_title = 'Themed Resources' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');

update valid_entity_entity_relationships set page_title = 'Works' where page_title = 'Themed Works' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='concept');
	
	
	
	
	-- Fix the administrators relationship, was erroneously called presenters
update valid_entity_entity_relationships set ruby_method_name= 'administrators',  page_title ='Administrators'
where entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'distinction_instance')
and entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
and relationship_type_id = (select relationship_type_id from relationship_types where 
	relationship_type_desc = 'Is administered by')
;

-- Fix distinction funded or awarded with is written by relationship to
-- distinctions fundered or sponspored by with "Is funded or sponsored by" rel
update valid_entity_entity_relationships set ruby_method_name= 'funders_or_sponsors',  
page_title ='Funders or Sponsors',
relationship_type_id = (select relationship_type_id from relationship_types where relationship_type_desc =
	'Is funded or sponsored by')
where entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'distinction_instance')
and entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
and relationship_type_id = (select relationship_type_id from relationship_types where 
	relationship_type_desc = 'Is written by')
;


update valid_entity_entity_relationships set ruby_method_name= 'administered_distinctions', 
 page_title ='Administratored Distinctions'
where entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'distinction_instance')
and entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'role')
and relationship_type_id = (select relationship_type_id from relationship_types where 
	relationship_type_desc = 'Administers')
;



-- Fix for missing miss
insert into nomens (nomen, display_order) values ('Miss',0);

-- New constraint for communication priority as there are now 6 possible values
alter table communications drop constraint ckc_priority_communic;
alter table communications add constraint CKC_PRIORITY_COMMUNIC check (priority in (0,1,2,3,4,5));

commit;