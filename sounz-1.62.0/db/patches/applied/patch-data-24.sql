
begin;
-- Delete the existing permissions and regenerate
delete from controller_restrictions;

-- Restriction for /works/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /expressions/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /events/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /resources/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /manifestations/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /concepts/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /contributors/show_appropriate_for_role, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'show_appropriate_for_role', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /cm_contents/show_by_name, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'show_by_name', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /concepts/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/shows, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'shows', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/toggle_facet_block, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'toggle_facet_block', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /home/index, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('home', 'index', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /authentication/unauthorised, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('authentication', 'unauthorised', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);


-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /people/new_web_user, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new_web_user', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/create_web_user, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create_web_user', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /contactinfos/countryChosen, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contactinfos', 'countryChosen', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

commit;
