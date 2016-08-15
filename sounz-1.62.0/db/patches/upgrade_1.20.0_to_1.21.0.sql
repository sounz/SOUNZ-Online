-- Patch for SOUNZ database upgrade
-- 1.20.0 to 1.21.0
--

BEGIN;

-- WR#54537 - Fixing NZ Courier costs
update zencartconfiguration set configuration_value = '0,0,200,6.00,750,8.00,2000,10.00' 
  where configuration_key = 'MODULE_SHIPPING_TABLE2_COST';

-- WR#53662 - solving performance issues for saved contact lists and mailout contacts when
-- there are a lot of role contactinfos assigned
-- These views are needed for effective pagination of saved list role contactinfos and
-- mailout contacts in sorted by last_name, first_names and organisation_name order
CREATE OR REPLACE VIEW saved_lists_contacts AS

SELECT src.saved_contact_list_id, 
       src.role_contactinfo_id, 
       p.last_name ||' '|| p.first_names ||' '|| o.organisation_name AS contact_name
   FROM saved_role_contactinfos src
     LEFT JOIN role_contactinfos rc ON rc.role_contactinfo_id = src.role_contactinfo_id
     LEFT JOIN roles r ON r.role_id = rc.role_id
     LEFT JOIN people p ON p.person_id = r.person_id
     LEFT JOIN organisations o ON o.organisation_id = r.organisation_id
    WHERE r.person_id IS NOT NULL AND r.organisation_id IS NOT NULL

UNION

SELECT src.saved_contact_list_id, 
       src.role_contactinfo_id, 
       p.last_name ||' '|| p.first_names AS contact_name
   FROM saved_role_contactinfos src
     LEFT JOIN role_contactinfos rc ON rc.role_contactinfo_id = src.role_contactinfo_id
     LEFT JOIN roles r ON r.role_id = rc.role_id
     LEFT JOIN people p ON p.person_id = r.person_id
    WHERE r.person_id IS NOT NULL AND r.organisation_id IS NULL

UNION

SELECT src.saved_contact_list_id, 
       src.role_contactinfo_id, 
       o.organisation_name AS contact_name
   FROM saved_role_contactinfos src
     LEFT JOIN role_contactinfos rc ON rc.role_contactinfo_id = src.role_contactinfo_id
     LEFT JOIN roles r ON r.role_id = rc.role_id
     LEFT JOIN organisations o ON o.organisation_id = r.organisation_id
   WHERE r.person_id IS NULL AND r.organisation_id IS NOT NULL
;

CREATE OR REPLACE VIEW campaign_mailouts_contacts AS

SELECT campaign_mailout_id,
       mailout_contact_id, 
       p.last_name ||' '|| p.first_names ||' '|| organisation_name AS contact_name 
   FROM mailout_contacts mc
     LEFT JOIN role_contactinfos rc ON rc.role_contactinfo_id = mc.role_contactinfo_id
     LEFT JOIN roles r ON r.role_id = rc.role_id
     LEFT JOIN people p ON p.person_id = r.person_id
    WHERE name IS NOT NULL AND organisation_name IS NOT NULL

UNION

SELECT campaign_mailout_id,
       mailout_contact_id, 
       p.last_name ||' '|| p.first_names AS contact_name 
   FROM mailout_contacts mc
     LEFT JOIN role_contactinfos rc ON rc.role_contactinfo_id = mc.role_contactinfo_id
     LEFT JOIN roles r ON r.role_id = rc.role_id
     LEFT JOIN people p ON p.person_id = r.person_id
    WHERE name IS NOT NULL AND organisation_name IS NULL

UNION

SELECT campaign_mailout_id,
       mailout_contact_id,
       organisation_name AS contact_name 
   FROM mailout_contacts
     WHERE name IS NULL AND organisation_name IS NOT NULL
;

-- WR#51338 - Moneyworks Import/Export details
-- Restriction for /moneyworks_data_checker/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('moneyworks_data_checker', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /moneyworks_data_checker/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('moneyworks_data_checker', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /moneyworks_data_checker/ALL, for a privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('moneyworks_data_checker', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /moneyworks_data_checker/ALL, for a privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('moneyworks_data_checker', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- WR#53722 - Jazz/Jazz as a concept of 'Genre' type
insert into concepts (concept_name, updated_by, concept_type_id, parent_concept_id,
	 created_at, updated_at)  values
	(
		'Jazz',
		(select login_id from logins where username = 'batch'),
		(select concept_type_id from concept_types where concept_type_desc = 'Genre'),
		(select concept_id from concepts where concept_name = 'Jazz' and
		concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Genre')
		),
		now(),
		now()
	);

-- WR#53722 - Jazz/Jazz as a concept of 'Influence' type
insert into concepts (concept_name, updated_by, concept_type_id, parent_concept_id,
	 created_at, updated_at)  values
	(
		'Jazz',
		(select login_id from logins where username = 'batch'),
		(select concept_type_id from concept_types where concept_type_desc = 'Influence'),
		(select concept_id from concepts where concept_name = 'Jazz' and
		concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence')
		),
		now(),
		now()
	);

-- WR#53721 - Adding new field 'is_contributor' BOOL to roles table to distinguish contributors 
-- from those with contributor roles
ALTER TABLE roles ADD COLUMN is_contributor BOOL;

UPDATE roles SET is_contributor = true WHERE role_id IN (SELECT role_id FROM contributors);

UPDATE roles SET is_contributor = false WHERE role_id NOT IN (SELECT role_id FROM contributors);

ALTER TABLE roles ALTER COLUMN is_contributor SET DEFAULT FALSE;

ALTER TABLE roles ALTER COLUMN is_contributor SET NOT NULL;

-- Restriction for /roles/contributor_role_type_check, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_role_type_check, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('roles', 'contributor_role_type_check', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);
COMMIT;