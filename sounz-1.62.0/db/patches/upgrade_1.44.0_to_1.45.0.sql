-- Patch for SOUNZ database upgrade
-- 1.44.0 to 1.45.0
--
BEGIN;

--WR#67087 - Event 'Is performed by' Role relationship
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'event'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is performed by'),
'performers',
'Performers',
't'
);

COMMIT;