begin;

-- WR#50297 - conroller restrictions for rss_feeds_controller.rb

-- Restriction for /rss_feeds/ALL, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('rss_feeds', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /rss_feeds/ALL, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('rss_feeds', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- WR#50297 - view for manifestations/resources for sale

CREATE OR REPLACE VIEW sounz_manifestations_resources_for_sale AS

SELECT 'manifestation'       AS product_class, 
       m.manifestation_id    AS product_id,
       m.manifestation_title AS product_title,
       m.general_note        AS product_desc,
       m.item_count          AS product_quantity, 
       m.item_cost           AS product_price,
       m.created_at          AS product_date_added,
       m.status_id           AS product_status     
   FROM sounz_products_for_sale m

UNION

SELECT 'resource'       AS product_class, 
       r.resource_id    AS product_id,
       r.resource_title AS product_title,
       r.general_note   AS product_desc, 
       r.item_count     AS product_quantity, 
       r.item_cost      AS product_price,
       r.created_at     AS product_date_added,
       r.status_id      AS product_status
   FROM sounz_resources_for_sale r;

--WR#50294
CREATE SEQUENCE distinction_instance_relationships_distinction_instance_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE distinction_instance_relationships (
    distinction_instance_relationship_id integer DEFAULT nextval('distinction_instance_relationships_distinction_instance_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    distinction_instance_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);

ALTER TABLE ONLY distinction_instance_relationships
    ADD CONSTRAINT pk_distinction_instance_relationships PRIMARY KEY (distinction_instance_relationship_id);

CREATE INDEX distinction_instance_entity_fk ON distinction_instance_relationships USING btree (distinction_instance_id);

CREATE INDEX distinction_instance_relationship_fk ON distinction_instance_relationships USING btree (relationship_id);

CREATE UNIQUE INDEX distinction_instance_relationship_uix ON distinction_instance_relationships USING btree (relationship_id, relationship_type_id, distinction_instance_id);

CREATE INDEX distinction_instance_reltype_fk ON distinction_instance_relationships USING btree (relationship_type_id);

ALTER TABLE ONLY distinction_instance_relationships
    ADD CONSTRAINT fk_distinction_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY distinction_instance_relationships
    ADD CONSTRAINT fk_distinction_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


ALTER TABLE ONLY distinction_instance_relationships
    ADD CONSTRAINT fk_distinction_instance_relationship3 FOREIGN KEY (distinction_instance_id) REFERENCES distinction_instances(distinction_instance_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

INSERT INTO entity_types (entity_type) VALUES ('distinction');

-- 'Is presented by' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'event'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is presented by'),
'happening_distinctions',
'Happening Distinctions',
't'
);

INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is presented by'),
'presenters',
'Presenters',
't'
);

-- 'Is managed by' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is managed by'),
'managers',
'Managers',
't'
);

-- 'Is funded by' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded or sponsored by'),
'funders_or_sponsors',
'Funders',
't'
);

-- 'Has as its genre' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'concept'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Has as its genre'),
'concept_genres',
'Concept Genres',
't'
);

-- 'Presents' for event and distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'event'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Presents'),
'distinctions_offered',
'Distinctions offered',
't'
);

INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Presents'),
'presenters',
'Presenters',
't'
);

-- 'Manages' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Manages'),
'managers',
'Managers',
't'
);

-- 'Funds' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Funds or sponsors'),
'funded_or_sponsored_distinctions',
'Funders',
't'
);

-- 'Has as its genre' for distinction
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'concept'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Describes the genre of'),
'genred_distinctions',
'Concept Genres',
't'
);

ALTER TABLE distinction_relationships DROP COLUMN distinction_instance_id;

ALTER TABLE distinction_relationships ADD COLUMN distinction_id INTEGER;

ALTER TABLE distinction_relationships ALTER COLUMN distinction_id SET NOT NULL;

CREATE INDEX distinction_entity_fk ON distinction_relationships USING btree (distinction_id);

CREATE UNIQUE INDEX distinction_relationship_uix ON distinction_relationships USING btree (relationship_id, relationship_type_id, distinction_id);

--WR#50294
-- 'Is funded or sponsored by'
DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded or sponsored by')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'role')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance');

DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Funds or sponsors')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'role');

--'Is administered by'
DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is administered by')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'role')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance');

DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Administers')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'role');

--'Has as its genre'
DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Has as its genre')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'concept')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance');

DELETE FROM valid_entity_entity_relationships WHERE 
	relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Describes the genre of')
AND
	entity_type_to_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'distinction_instance')
AND
	entity_type_from_id = (SELECT entity_type_id FROM entity_types WHERE entity_type = 'concept');

-- Fix for a bug where the inverse relationship of 'Is funded or sponsored by' was 'Writes'
-- and 'Funders or sponsors' was 'Is written by'
UPDATE relationship_types SET inverse = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Funds or sponsors')
    WHERE relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded or sponsored by');

UPDATE relationship_types SET inverse = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded or sponsored by')
    WHERE relationship_type_id = (SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Funds or sponsors');

-- Restriction for /distinction_instances/search, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'search', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/search, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'search', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/search, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'search', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/search, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'search', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/search, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'search', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/find, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'find', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/find, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'find', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/find, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'find', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/find, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'find', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/find, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'find', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

commit;