-- Patch for SOUNZ database upgrade
-- 1.17.0 to 1.18.0
--

BEGIN;

-- WR50274 - TAP/CRM - cleanup of entries to be deleted

-- Manifestations
delete from expression_manifestations where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
 );
delete from items where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
 );


-- delete the relationships for the affected manifestations
select relationship_id into temp_rels from manifestation_relationships where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
 );
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;


delete from manifestation_attachments where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
 );

delete from sample_attachments where sample_id in (
	select sample_id from samples where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
	)
 );

delete from samples where manifestation_id in (
	select manifestation_id from manifestations where manifestation_title ilike 'Delete%'
 );

delete from manifestations where manifestation_title ilike 'Delete%';
	

-- Works

-- delete the relationships for the affected expressions
select relationship_id into temp_rels from expression_relationships where expression_id in
	(select expression_id from expressions where 
		work_id in (select work_id from works where work_title ilike 'Delete%')
	)	
;
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;


delete from expression_manifestations where expression_id in
	(select expression_id from expressions where 
		work_id in (select work_id from works where work_title ilike 'Delete%')
	)	
;

delete from expression_languages where expression_id in
	(select expression_id from expressions where 
		work_id in (select work_id from works where work_title ilike 'Delete%')
	)	
;

delete from sample_attachments where sample_id in (
	select sample_id from samples where expression_id in (
		select expression_id from expressions where expression_title ilike 'Delete%'
	 )
 );

delete from samples where expression_id in (
	select expression_id from expressions where expression_title ilike 'Delete%'
 );


delete from expressions where work_id in (select work_id from works where work_title ilike 'Delete%');

-- and now direct work related data
delete from work_categorizations where work_id in (select work_id from works where work_title ilike 'Delete%'); 

	
-- Work relationships	
select relationship_id into temp_rels from work_relationships where work_id in (select work_id from works where work_title ilike 'Delete%');
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;

delete from work_access_rights where work_id in (select work_id from works where work_title ilike 'Delete%');

delete from works where work_title ilike 'Delete%';
	
	
-- Expressions
select relationship_id into temp_rels 	from expression_relationships where expression_id in
		(select expression_id from expressions where expression_title ilike 'Delete%');
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;


delete from expression_manifestations where expression_id in
	(select expression_id from expressions where expression_title ilike 'Delete%');

delete from expression_languages where expression_id in 
		(select expression_id from expressions where expression_title ilike 'Delete%');


delete from sample_attachments where sample_id in (
	select sample_id from samples where expression_id in (
		select expression_id from expressions where expression_title ilike 'Delete%'
	 )
 );

delete from samples where expression_id in (
	select expression_id from expressions where expression_title ilike 'Delete%'
 );		
delete from expressions where expression_title ilike 'Delete%';
	
	
-- Superworks

select relationship_id into temp_rels 		from superwork_relationships where superwork_id in (
		select superwork_id from superworks  where superwork_title ilike 'Delete%'
	);
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;



delete from work_categorizations where work_id in (
	select work_id from works where superwork_id in (
		select superwork_id from superworks  where superwork_title ilike 'Delete%'
	)
);

delete from work_relationships where work_id in (
	select work_id from works where superwork_id in (
		select superwork_id from superworks  where superwork_title ilike 'Delete%'
	)
);

 


select relationship_id into temp_rels 	from expression_relationships where expression_id in (
	select expression_id 	from expressions where work_id in (
			select work_id from works where superwork_id in (
				select superwork_id from superworks  where superwork_title ilike 'Delete%'
			)
		)
	);
	
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;


delete from expression_manifestations where expression_id in (
select expression_id 	from expressions where work_id in (
		select work_id from works where superwork_id in (
			select superwork_id from superworks  where superwork_title ilike 'Delete%'
		)
	)
);


delete from expression_languages where expression_id in (
select expression_id 	from expressions where work_id in (
		select work_id from works where superwork_id in (
			select superwork_id from superworks  where superwork_title ilike 'Delete%'
		)
	)
);


delete from sample_attachments where sample_id in (
select sample_id from samples where expression_id in (
select expression_id 	from expressions where work_id in (
		select work_id from works where superwork_id in (
			select superwork_id from superworks  where superwork_title ilike 'Delete%'
		)
	)
)
);


delete from samples where expression_id in (
select expression_id 	from expressions where work_id in (
		select work_id from works where superwork_id in (
			select superwork_id from superworks  where superwork_title ilike 'Delete%'
		)
	)
);

	
delete from expressions where work_id in (
	select work_id from works where superwork_id in (
		select superwork_id from superworks  where superwork_title ilike 'Delete%'
	)
);

delete from works where superwork_id in (
	select superwork_id from superworks  where superwork_title ilike 'Delete%'
);

delete from superworks where superwork_title ilike 'Delete%';

-- Organisations
delete from saved_role_contactinfos where role_contactinfo_id in (
	select role_contactinfo_id from role_contactinfos where role_id in (
		select role_id from roles where organisation_id in (
			select organisation_id from organisations where organisation_name ilike 'Delete%'
		)	
	)
);

delete from mailout_contacts where role_contactinfo_id in (
  (select role_contactinfo_id from role_contactinfos where role_id in
    (select role_id from roles where organisation_id in 
      (select organisation_id from organisations where organisation_name ilike 'Delete%')
     )
   )
);

delete from role_contactinfos where role_id in (
	select role_id from roles where organisation_id in (
		select organisation_id from organisations where organisation_name ilike 'Delete%'
	)	
);

select relationship_id into temp_rels 		from role_relationships where role_id in (
		select role_id from roles where organisation_id in (
			select organisation_id from organisations where organisation_name ilike 'Delete%'
		)
	);
	
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;


delete from contributors where role_id in (
	select role_id from roles where organisation_id in (
		select organisation_id from organisations where organisation_name ilike 'Delete%'
	)	
);

delete from role_categorizations where role_id in (
	select role_id from roles where organisation_id in (
		select organisation_id from organisations where organisation_name ilike 'Delete%'
	)	
);



delete from roles where organisation_id in (
	select organisation_id from organisations where organisation_name ilike 'Delete%'
);

delete from organisations where organisation_name ilike 'Delete%';
	
	
-- People

delete from saved_role_contactinfos where role_contactinfo_id in (
	select role_contactinfo_id from role_contactinfos where role_id in (
		select role_id from roles where person_id in (
			select person_id from people where first_names ilike 'Delete%'
		)
	)
);

delete from mailout_contacts where role_contactinfo_id in (
  (select role_contactinfo_id from role_contactinfos where role_id in
    (select role_id from roles where person_id in 
      (select person_id from people where first_names ilike 'Delete%')
     )
   )
);

delete from role_contactinfos where role_id in (
	select role_id from roles where person_id in (
		select person_id from people where first_names ilike 'Delete%'
	)
);




delete from communications where role_id in (
	select role_id from roles where person_id in (
		select person_id from people where first_names ilike 'Delete%'
	)
);


select relationship_id into temp_rels from role_relationships where role_id in (
		select role_id from roles where person_id in (
				select person_id from people where first_names ilike 'Delete%'
		)
	);
	
delete from concept_relationships where relationship_id in (select relationship_id from temp_rels);
delete from role_relationships where relationship_id in (select relationship_id from temp_rels);
delete from expression_relationships where relationship_id in (select relationship_id from temp_rels);
delete from manifestation_relationships where relationship_id in (select relationship_id from temp_rels);
delete from event_relationships where relationship_id in (select relationship_id from temp_rels);
delete from distinction_relationships where relationship_id in (select relationship_id from temp_rels);
delete from resource_relationships where relationship_id in (select relationship_id from temp_rels);
delete from work_relationships where relationship_id in (select relationship_id from temp_rels);
delete from superwork_relationships where relationship_id in (select relationship_id from temp_rels);
delete from relationships where relationship_id in (select relationship_id from temp_rels);
drop table temp_rels;

delete from contributors where role_id in (
	select role_id from roles where person_id in (
			select person_id from people where first_names ilike 'Delete%'
	)	
);

delete from role_categorizations where role_id in (
 (select role_id from roles where person_id in 
   (select person_id from people where first_names ilike 'Delete%')
  )
);

delete from roles where person_id in 
   (select person_id from people where first_names ilike 'Delete%');

update marketing_campaigns set campaign_manager = null where campaign_manager in
	(
		select project_team_member_id from project_team_members where person_id in (
				select person_id from people where first_names ilike 'Delete%'
		)	
	);


delete from project_team_members where person_id in (
		select person_id from people where first_names ilike 'Delete%'
);

delete from people where first_names ilike 'Delete%';

-- Roles
select contactinfo_id into temp_contactinfos from role_contactinfos where role_id in 
  (select role_id from roles where role_title ilike 'Delete%');

--delete from saved_role_contactinfos where role_contactinfo_id in 
-- (select role_contactinfo_id from role_contactinfos where role_id in 
--    (select role_id from roles where role_title ilike 'Delete%')
--  )
--;

delete from mailout_contacts where role_contactinfo_id in 
 (select role_contactinfo_id from role_contactinfos where role_id in
   (select role_id from roles where role_title ilike 'Delete%')
  )
;

delete from role_contactinfos where role_id in
(select role_id from roles where role_title ilike 'Delete%');

delete from default_contactinfos where contactinfo_id in
(select contactinfo_id from temp_contactinfos);

delete from contactinfos where contactinfo_id in 
(select contactinfo_id from temp_contactinfos);

drop table temp_contactinfos;

delete from contributors where role_id in (select role_id from roles where role_title ilike 'Delete%');

delete from roles where role_title ilike 'Delete%';

--WR#53212 - re-check - correct values
update zencartconfiguration set configuration_value = '0,0,20,2.50,200,5.00,500,6.50,1250,7.00,2000,8.00' 
  where configuration_key = 'MODULE_SHIPPING_TABLE_COST';

-- WR#51729 - 'New product' provider form
CREATE SEQUENCE prov_products_prov_product_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE prov_products (
    prov_product_id integer NOT NULL DEFAULT nextval('prov_products_prov_product_id_seq'::regclass),
    status_id integer NOT NULL,
    name text,
    email text,
    product_name text,
    type_cd boolean DEFAULT false NOT NULL,
    type_score_music boolean DEFAULT false NOT NULL,
    type_video boolean DEFAULT false NOT NULL,
    type_dvd boolean DEFAULT false NOT NULL,
    type_book boolean DEFAULT false NOT NULL,
    type_kit boolean DEFAULT false NOT NULL,
    type_other text,
    notes text,
    composers_involved text,
    works_involved text,
    performers_involved text,
    publisher text,
    publisher_email text,
    publisher_phone text,
    distributor text,
    distributor_email text,
    distributor_phone text,
    retail_price text,
    trade_price text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);

-- Settings - recipient of email notifications
insert into settings (setting_name, setting_value) values ('prov_products_recipient', 'info@sounz.org.nz');

-- Privileges
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_PRODUCT_PROV_FORM','User can edit products provider forms (SOUNZ Administrator and TAP Administrator only)');

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM'));
   
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM'));

-- Restriction for /prov_products/ALL, for a status of Pending and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Pending and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Pending and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Approved and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Approved and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Approved and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Masked and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Masked and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Masked and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Withdrawn and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Withdrawn and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Withdrawn and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Published and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Published and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/ALL, for a status of Published and privilege CAN_EDIT_PRODUCT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PRODUCT_PROV_FORM')
);

-- Restriction for /prov_products/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_products/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_products/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_products/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_products/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_products', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /home/email_updates_requested, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('home', 'email_updates_requested', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /home/email_updates_requested, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('home', 'email_updates_requested', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- WR#50274 - note dated 14:46 16-05-2008
delete from saved_searches where search_type = 'selected_results';

-- WR#42492 - replace 'Person' role type by 'Unspecified' role type if a login does not exist for that person
update roles set role_type_id = (select role_type_id from role_types where role_type_desc = 'Unspecified')
  where person_id not in (select person_id from logins where person_id is not null) 
    and role_type_id = (select role_type_id from role_types where role_type_desc='Person')
;

COMMIT;