-- Fix for the good old pouro, pouru that was missed from WR50259

begin;
	update work_subcategories set  work_subcategory_desc = 'Includes Taonga Puoro'
		where  work_subcategory_desc  = 'Includes Taonga Puoru';
		
-- Outstanding fix for WR42440 - adding an extra genre
insert into concepts(concept_name, updated_by, concept_type_id, parent_concept_id,
	 created_at, updated_at)  values
	(
		'Taonga Puoro',
		(select login_id from logins where username = 'batch'),
		(select concept_type_id from concept_types where concept_type_desc = 'Genre'),
		(select concept_id from concepts where concept_name = 'Maori Music' and
		concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Genre')
		),
		now(),
		now()
	);
	
-- WR50289 - fix for non additional site specific
update work_subcategories set additional='true' where work_subcategory_desc = 'Site specific';
	
-- Now fix the display ordering...

select work_subcategory_desc, display_order from work_subcategories where additional = true order by display_order;

update work_subcategories set display_order = display_order +1 where display_order > 
--(select display_order from work_subcategories where work_subcategory_desc = 'Includes Taonga Puoro')	
178
and additional = true;

select work_subcategory_desc, display_order from work_subcategories where additional = true order by display_order;


update work_subcategories set display_order = 179
	where additional=true and work_subcategory_desc = 'Site specific';
	
-- Restriction for /advanced_finder/type_formats, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'type_formats', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/type_formats, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'type_formats', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);
	

	
-- Add a new table to monitor password change requests


CREATE SEQUENCE password_change_requests_password_change_request_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;



-- Note expiry is handed at the Ruby level
CREATE TABLE password_change_requests (
    password_change_request_id integer DEFAULT nextval('password_change_requests_password_change_request_id_seq'::regclass) NOT NULL,
    requested_by_login_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
	processed boolean DEFAULT false NOT NULL,
	activation_key text NOT NULL
);

ALTER TABLE ONLY password_change_requests
    ADD CONSTRAINT fk_password_request__login_all_logins FOREIGN KEY (requested_by_login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY password_change_requests
	    ADD CONSTRAINT pk_password_change_requests PRIMARY KEY (password_change_request_id);


-- Restriction for /password/ALL, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('password', 'ALL', 'get',
                (select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /password/request_change, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('password', 'request_change', 'post',
                (select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /password/update, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('password', 'update', 'post',
                (select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /role_categorizations/add_categorization, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'add_categorization', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_categorizations/add_categorization, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'add_categorization', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_categorizations/marketing_category_change, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'marketing_category_change', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_categorizations/marketing_category_change, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'marketing_category_change', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_categorizations/destroy_categorization_for_role, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'destroy_categorization_for_role', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_categorizations/destroy_categorization_for_role, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_categorizations', 'destroy_categorization_for_role', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Privileges for OS Commerce
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_SALES_HISTORY','User can edit sales history (SOUNZ Administrator and TAP administrator only)');

UPDATE privileges set privilege_desc = 'User can edit borrowed items (SOUNZ Administrator and TAP administrator only)'
  WHERE privilege_name = 'CAN_EDIT_BORROWED_ITEM';

-- OS Commerce privileges for 'Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_SALES_HISTORY'));
  
-- OS Commerce privileges for 'TAP Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_SALES_HISTORY'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_BORROWED_ITEM'));

DELETE FROM member_type_privileges WHERE member_type_id = 
  (SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator')
 AND privilege_id =
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_BORROWED_ITEM');

-- Restriction for /cart/show_orders, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'show_orders', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

-- Restriction for /cart/show_orders, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'show_orders', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

-- Restriction for /cart/update_status, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'update_status', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

-- Restriction for /cart/update_status, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'update_status', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

-- Restriction for /hard_association/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('hard_association', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /hard_association/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('hard_association', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- WR#51710 - added more FRBR relationships
-- 'Is funded by' for manifestation and resource
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'manifestation'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded by'),
'funder',
'Funder',
't'
);

INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'resource'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'role'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Is funded by'),
'funder',
'Funder',
't'
);

-- 'Describes' for resource
INSERT INTO valid_entity_entity_relationships (entity_type_from_id, entity_type_to_id, relationship_type_id, ruby_method_name, page_title, user_maintainable) 
VALUES (
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'resource'), 
(SELECT entity_type_id FROM entity_types WHERE entity_type = 'resource'),
(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc = 'Describes'),
'resources_described',
'Resources Described',
't'
);

commit;
