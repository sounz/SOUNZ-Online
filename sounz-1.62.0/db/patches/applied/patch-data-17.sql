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

-- Restriction for /home/index, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('home', 'index', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /home/index, for a status of Published and privilege CAN_EDIT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('home', 'index', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT')
);

commit;
