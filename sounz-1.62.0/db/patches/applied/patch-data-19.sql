-- fix errors in valid entity entity relationships
-- Note this should only update one row in the veer table

begin;
update valid_entity_entity_relationships set ruby_method_name = 'manifestations_documented',
	page_title = 'Manifestations Documented'
	where
		
		entity_type_from_id = (select entity_type_id from entity_types where entity_type='resource')
	and entity_type_to_id = (select entity_type_id from entity_types where entity_type='manifestation')
	and relationship_type_id = (select relationship_type_id from relationship_types where relationship_type_desc = 'Documents');


commit;