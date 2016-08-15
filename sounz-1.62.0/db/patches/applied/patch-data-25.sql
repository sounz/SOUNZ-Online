-- Allow works/show_more page to be visible
begin;


-- Restriction for /works/show_more, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);


commit;
