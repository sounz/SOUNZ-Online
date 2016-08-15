-- Patch for SOUNZ database upgrade
-- 1.0.2 to 1.0.3
--

begin;

-- updated controller_restrictions
--
-- Delete the existing permissions and regenerate
delete from controller_restrictions;

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

-- Restriction for /media_items/show_flash_music, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('media_items', 'show_flash_music', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /media_items/show_flash_video, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('media_items', 'show_flash_video', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /media_items/show_flash_music_for_sample, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('media_items', 'show_flash_music_for_sample', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /media_items/show_flash_video_for_sample, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('media_items', 'show_flash_video_for_sample', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /cart/show_cart_contents, for a status of Published and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'show_cart_contents', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_cart_contents, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'show_cart_contents', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_cart_contents, for a status of Withdrawn and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'show_cart_contents', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_cart_contents, for a status of Masked and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'show_cart_contents', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_cart_contents, for a status of Approved and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'show_cart_contents', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Published and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Masked and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Withdrawn and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Approved and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Published and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Masked and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Withdrawn and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/add_product_to_cart, for a status of Approved and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cart', 'add_product_to_cart', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_memberships, for a privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'show_memberships', 'get',
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /cart/show_donations, for a privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'show_donations', 'get',
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /borrowed_items/ALL, for a privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('borrowed_items', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /borrowed_items/ALL, for a privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('borrowed_items', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /finder/reset_event_search, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'reset_event_search', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/reset_people_search, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'reset_people_search', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/reset_work_search, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'reset_work_search', 'get',
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

-- Restriction for /finder/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'show', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/shows, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'shows', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/toggle_facet_block, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'toggle_facet_block', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /home/index, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('home', 'index', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /authentication/unauthorised, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('authentication', 'unauthorised', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/new_web_user, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'new_web_user', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/create_web_user, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'create_web_user', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /contactinfos/countryChosen, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'countryChosen', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /contactinfos/countryChosen, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'countryChosen', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/index, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('news_articles', 'index', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/list, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('news_articles', 'list', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/show, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('news_articles', 'show', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /media_items/download, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('media_items', 'download', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/sonline_music, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'sonline_music', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/search_works_resources, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_works_resources', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/sonline_music, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'sonline_music', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/search_works_resources, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_works_resources', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/work_subcategories, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'work_subcategories', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/work_subcategories, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'work_subcategories', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/concept_main_categories, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'concept_main_categories', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/concept_main_categories, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'concept_main_categories', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/reset_sonline_music, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_sonline_music', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /advanced_finder/reset_sonline_music, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_sonline_music', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /superworks/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /superworks/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /superworks/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /superworks/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('superworks', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /works/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /works/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /works/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show_more, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show_more, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show_more, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show_more, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show_more, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /works/show_more, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'show_more', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /works/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /expressions/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /expressions/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /expressions/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /expressions/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('expressions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /manifestations/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /manifestations/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /manifestations/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /manifestations/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('manifestations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /resources/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /resources/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /resources/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /resources/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /resources/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('resources', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Pending and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Pending and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Approved and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Approved and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Masked and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Masked and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Withdrawn and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Withdrawn and privilege CAN_EDIT_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Published and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Pending and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Pending and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Approved and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Approved and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Masked and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Masked and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_DISTINCTION
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_DISTINCTION')
);

-- Restriction for /distinctions/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /distinction_instances/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /distinction_instances/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /distinction_instances/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinction_instances', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /concepts/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /concepts/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /concepts/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /concepts/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('concepts', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
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

-- Restriction for /events/ALL, for a status of Published and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Published and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Pending and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Pending and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Approved and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Approved and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Masked and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Masked and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Withdrawn and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Withdrawn and privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /events/ALL, for a status of Published and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Published and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Pending and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Pending and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Approved and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Approved and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Masked and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Masked and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_EVENT')
);

-- Restriction for /events/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/related, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/related, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/related, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/related, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/related, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/news, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/news, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/news, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/news, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/news, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/homepage_news, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/homepage_news, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/homepage_news, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/homepage_news, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/homepage_news, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /events/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /events/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /events/homepage_news, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'homepage_news', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /events/news, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('events', 'news', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /contributors/ALL, for a status of Published and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Published and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Pending and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Pending and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Approved and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Approved and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Masked and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Masked and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Published and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Published and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Pending and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Pending and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Approved and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Approved and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Masked and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Masked and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /contributors/show_appropriate_for_role, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('contributors', 'show_appropriate_for_role', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/new, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/new, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/new, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/create, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/create, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/edit, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/edit, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/update, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/update, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /people/roles, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/roles, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /people/privileges_list, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/privileges_list, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/assignLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/removeLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/createLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /people/extendLoan, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/extendLoan, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'extendLoan', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markDue, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markDue', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/markReturned, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'markReturned', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Pending and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Approved and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Masked and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /people/sendReminder, for a status of Withdrawn and privilege CAN_EDIT_BORROWED_ITEM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('people', 'sendReminder', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BORROWED_ITEM')
);

-- Restriction for /organisations/new, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/new, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/new, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/create, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/create, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/edit, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/edit, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'edit', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/update, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/update, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'update', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/related, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/related, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'related', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/add_relationship, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'add_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/delete_relationship, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'delete_relationship', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Pending and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Approved and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Masked and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Withdrawn and privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /organisations/roles, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Pending and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Approved and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Masked and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/roles, for a status of Withdrawn and privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'roles', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /organisations/privileges_list, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/privileges_list, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'privileges_list', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/assignLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'assignLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/removeLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'removeLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Pending and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Approved and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Masked and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /organisations/createLogin, for a status of Withdrawn and privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('organisations', 'createLogin', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /roles/new, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'new', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/new, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'new', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/create, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'create', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/create, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'create', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/edit, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'edit', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/edit, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'edit', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/update_role, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'update_role', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/update_role, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'update_role', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/show, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'show', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/show, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'show', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /roles/contributor_details, for a privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details, for a privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details_update, for a privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details_update', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details_update, for a privilege CAN_EDIT_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details_update', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details, for a privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details, for a privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details_update, for a privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details_update', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/contributor_details_update, for a privilege CAN_PUBLISH_CONTRIBUTOR_PROFILE
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'contributor_details_update', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE')
);

-- Restriction for /roles/show, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('roles', 'show', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /role_contactinfos/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_contactinfos', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_contactinfos/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_contactinfos', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /role_contactinfos/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_contactinfos', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /role_contactinfos/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('role_contactinfos', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /contactinfos/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /contactinfos/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /contactinfos/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /contactinfos/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('contactinfos', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /communications/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('communications', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /communications/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('communications', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /communications/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('communications', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /communications/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('communications', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /search_contacts/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_contacts', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_contacts/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_contacts', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_contacts/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_contacts', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /search_contacts/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_contacts', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /search_communications/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_communications', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_communications/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_communications', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_communications/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_communications', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /search_communications/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_communications', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /saved_contact_lists/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_contact_lists', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /saved_contact_lists/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_contact_lists', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /saved_contact_lists/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_contact_lists', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /saved_contact_lists/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_contact_lists', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /projects/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('projects', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /projects/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('projects', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /marketing_campaigns/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('marketing_campaigns', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /marketing_campaigns/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('marketing_campaigns', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /campaign_mailouts/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('campaign_mailouts', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /campaign_mailouts/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('campaign_mailouts', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /mailout_contacts/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('mailout_contacts', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /mailout_contacts/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('mailout_contacts', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Pending and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Pending and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Pending and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Approved and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Approved and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Approved and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Masked and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Masked and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Masked and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Withdrawn and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Withdrawn and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Withdrawn and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Published and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Published and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/ALL, for a status of Published and privilege CAN_EDIT_COMPOSER_BIO_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM')
);

-- Restriction for /prov_composer_bios/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_composer_bios/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_composer_bios/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_composer_bios/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_composer_bios/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_composer_bios', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Pending and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Pending and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Pending and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Approved and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Approved and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Approved and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Masked and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Masked and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Masked and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Published and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Published and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/ALL, for a status of Published and privilege CAN_EDIT_CONTACT_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM')
);

-- Restriction for /prov_contact_updates/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contact_updates/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contact_updates/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contact_updates/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contact_updates/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contact_updates', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Pending and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Pending and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Pending and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Approved and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Approved and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Approved and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Masked and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Masked and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Masked and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Withdrawn and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Published and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Published and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/ALL, for a status of Published and privilege CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM')
);

-- Restriction for /prov_contributor_profiles/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contributor_profiles/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contributor_profiles/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contributor_profiles/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_contributor_profiles/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_contributor_profiles', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_events/ALL, for a status of Pending and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Pending and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Pending and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Approved and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Approved and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Approved and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Masked and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Masked and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Masked and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Withdrawn and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Withdrawn and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Withdrawn and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Published and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Published and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/ALL, for a status of Published and privilege CAN_EDIT_EVENT_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT_PROV_FORM')
);

-- Restriction for /prov_events/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_events/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_events/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_events/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_events/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_events', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Pending and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Pending and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Pending and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Approved and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Approved and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Approved and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Masked and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Masked and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Masked and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Withdrawn and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Withdrawn and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Withdrawn and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Published and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Published and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/ALL, for a status of Published and privilege CAN_EDIT_FEEDBACK_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM')
);

-- Restriction for /prov_feedbacks/new, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_feedbacks/new, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_feedbacks/create, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_feedbacks/create, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_feedbacks/show_confirmation, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_feedbacks', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_work_updates/ALL, for a status of Pending and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Pending and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Pending and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Approved and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Approved and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Approved and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Masked and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Masked and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Masked and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Withdrawn and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Published and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Published and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/ALL, for a status of Published and privilege CAN_EDIT_WORK_UPDATE_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM')
);

-- Restriction for /prov_work_updates/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_work_updates/new, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_work_updates/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_work_updates/create, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /prov_work_updates/show_confirmation, for a status of Pending and privilege IS_AUTHENTICATED
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_work_updates', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'IS_AUTHENTICATED')
);

-- Restriction for /logins/ALL, for a privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('logins', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);

-- Restriction for /logins/ALL, for a privilege CAN_EDIT_LOGIN
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('logins', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_LOGIN')
);




--Petes zencart stuff

--
-- PostgreSQL database dump
--

--clean it out

delete from zencartaddress_book;
delete from zencartaddress_format;
delete from zencartadmin;
delete from zencartadmin_activity_log;
delete from zencartauthorizenet;
delete from zencartbanners;
delete from zencartbanners_history;
delete from zencartcategories;
delete from zencartcategories_description;
delete from zencartconfiguration;
delete from zencartconfiguration_group;
delete from zencartcounter;
delete from zencartcounter_history;
delete from zencartcountries;
delete from zencartcoupon_email_track;
delete from zencartcoupon_gv_customer;
delete from zencartcoupon_gv_queue;
delete from zencartcoupon_redeem_track;
delete from zencartcoupon_restrict;
delete from zencartcoupons;
delete from zencartcoupons_description;
delete from zencartcurrencies;
delete from zencartcustomers;
delete from zencartcustomers_basket;
delete from zencartcustomers_basket_attributes;
delete from zencartcustomers_info;
delete from zencartcustomers_wishlist;
delete from zencartdb_cache;
delete from zencartemail_archive;
delete from zencartezpages;
delete from zencartfeatured;
delete from zencartfiles_uploaded;
delete from zencartgeo_zones;
delete from zencartget_terms_to_filter;
delete from zencartgroup_pricing;
delete from zencartlanguages;
delete from zencartlayout_boxes;
delete from zencartmanufacturers;
delete from zencartmanufacturers_info;
delete from zencartmedia_clips;
delete from zencartmedia_manager;
delete from zencartmedia_to_products;
delete from zencartmedia_types;
delete from zencartmeta_tags_categories_description;
delete from zencartmeta_tags_products_description;
delete from zencartmusic_genre;
delete from zencartnewsletters;
delete from zencartorders;
delete from zencartorders_products;
delete from zencartorders_products_attributes;
delete from zencartorders_products_download;
delete from zencartorders_status;
delete from zencartorders_status_history;
delete from zencartorders_total;
delete from zencartpaypal;
delete from zencartpaypal_payment_status;
delete from zencartpaypal_payment_status_history;
delete from zencartpaypal_session;
delete from zencartpaypal_testing;
delete from zencartproduct_music_extra;
delete from zencartproduct_type_layout;
delete from zencartproduct_types;
delete from zencartproduct_types_to_category;
delete from zencartproducts;
delete from zencartproducts_attributes;
delete from zencartproducts_attributes_download;
delete from zencartproducts_description;
delete from zencartproducts_discount_quantity;
delete from zencartproducts_notifications;
delete from zencartproducts_options;
delete from zencartproducts_options_types;
delete from zencartproducts_options_values;
delete from zencartproducts_options_values_to_products_options;
delete from zencartproducts_to_categories;
delete from zencartproject_version;
delete from zencartproject_version_history;
delete from zencartquery_builder;
delete from zencartrecord_artists;
delete from zencartrecord_artists_info;
delete from zencartrecord_company;
delete from zencartrecord_company_info;
delete from zencartreviews;
delete from zencartreviews_description;
delete from zencartsalemaker_sales;
delete from zencartsessions;
delete from zencartspecials;
delete from zencarttax_class;
delete from zencarttax_rates;
delete from zencarttemplate_select;
delete from zencartupgrade_exceptions;
delete from zencartwhos_online;
delete from zencartzones;
delete from zencartzones_to_geo_zones;




--rebuild it


INSERT INTO zencartaddress_book VALUES (1, 1, 'm', 'pete', 'Pete', 'Black', '24 Vancouver St.', 'Kingson', '90210', 'Wellington', 'Wellington', 153, 0);
INSERT INTO zencartaddress_book VALUES (2, 1, 'm', 'kdjshfdksjfh', 'Pete', 'BLack', '123 blah st.', 'blah blah', '90210', 'Auckland', 'dslfjdlj', 153, 0);
INSERT INTO zencartaddress_book VALUES (3, 3, 'm', 'dhgfdj', 'jdjafh', 'jhsdgfj', 'sdhgfsdhg', 'ksdhgfjsg', '746856', 'skdhgsdjkg', 'dshfhg', 205, 0);


--
-- Data for Name: zencartaddress_format; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartaddress_format VALUES (1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country', '$city / $country');
INSERT INTO zencartaddress_format VALUES (2, '$firstname $lastname$cr$streets$cr$city, $state  $postcode$cr$country', '$city, $state / $country');
INSERT INTO zencartaddress_format VALUES (3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country');
INSERT INTO zencartaddress_format VALUES (4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO zencartaddress_format VALUES (5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');
INSERT INTO zencartaddress_format VALUES (6, '$firstname $lastname$cr$streets$cr$city$cr$state$cr$postcode$cr$country', '$postcode / $country');


--
-- Data for Name: zencartadmin; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartadmin VALUES (1, 'Admin', 'admin@localhost', '0e7333d76a3a0f45925b57a5a77f1f46:f69', 1);


--
-- Data for Name: zencartadmin_activity_log; Type: TABLE DATA; Schema: public; Owner: sounz
--

--
-- Data for Name: zencartauthorizenet; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartbanners; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartbanners VALUES (1, 'Zen Cart', 'http://www.zen-cart.com', 'banners/zencart_468_60_02.gif', 'Wide-Banners', '', 0, NULL, NULL, '2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (2, 'Zen Cart the art of e-commerce', 'http://www.zen-cart.com', 'banners/125zen_logo.gif', 'SideBox-Banners', '', 0, NULL, NULL, '2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (3, 'Zen Cart the art of e-commerce', 'http://www.zen-cart.com', 'banners/125x125_zen_logo.gif', 'SideBox-Banners', '', 0, NULL, NULL, '2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (4, 'if you have to think ... you haven''t been Zenned!', 'http://www.zen-cart.com', 'banners/think_anim.gif', 'Wide-Banners', '', 0, NULL, NULL, '2004-01-12 20:53:18', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (5, 'Sashbox.net - the ultimate e-commerce hosting solution', 'http://www.sashbox.net/zencart/', 'banners/sashbox_125x50.jpg', 'BannersAll', '', 0, NULL, NULL, '2005-05-13 10:53:50', NULL, 1, 1, 1, 20);
INSERT INTO zencartbanners VALUES (6, 'Zen Cart the art of e-commerce', 'http://www.zen-cart.com', 'banners/bw_zen_88wide.gif', 'BannersAll', '', 0, NULL, NULL, '2005-05-13 10:54:38', NULL, 1, 1, 1, 10);
INSERT INTO zencartbanners VALUES (7, 'Sashbox.net - the ultimate e-commerce hosting solution', 'http://www.sashbox.net/zencart/', 'banners/sashbox_468x60.jpg', 'Wide-Banners', '', 0, NULL, NULL, '2005-05-13 10:55:11', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (8, 'Start Accepting Credit Cards For Your Business Today!', 'http://www.zen-cart.com/index.php?main_page=infopages&pages_id=30', 'banners/cardsvcs_468x60.gif', 'Wide-Banners', '', 0, NULL, NULL, '2006-03-13 11:02:43', NULL, 1, 1, 1, 0);
INSERT INTO zencartbanners VALUES (9, 'eStart Your Web Store with Zen Cart(tm)', 'http://www.lulu.com/content/466605', 'banners/big-book-ad.gif', 'Wide-Banners', '', 0, NULL, NULL, '2007-02-10 00:00:00', NULL, 1, 1, 1, 1);
INSERT INTO zencartbanners VALUES (10, 'eStart Your Web Store with Zen Cart(tm)', 'http://www.lulu.com/content/466605', 'banners/tall-book.gif', 'SideBox-Banners', '', 0, NULL, NULL, '2007-02-10 00:00:00', NULL, 1, 1, 1, 1);
INSERT INTO zencartbanners VALUES (11, 'eStart Your Web Store with Zen Cart(tm)', 'http://www.lulu.com/content/466605', 'banners/tall-book.gif', 'BannersAll', '', 0, NULL, NULL, '2007-02-10 00:00:00', NULL, 1, 1, 1, 15);


--
-- Data for Name: zencartbanners_history; Type: TABLE DATA; Schema: public; Owner: sounz
--




--
-- Data for Name: zencartcategories; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcategories VALUES (1, NULL, 0, 0, '2007-09-26 18:41:37.442323', NULL, 1);
INSERT INTO zencartcategories VALUES (2, NULL, 0, 0, '2007-09-27 10:30:55.73498', NULL, 1);
INSERT INTO zencartcategories VALUES (3, '', 0, 0, NULL, NULL, 1);
INSERT INTO zencartcategories VALUES (4, '', 0, 0, NULL, NULL, 1);
INSERT INTO zencartcategories VALUES (5, NULL, 0, NULL, NULL, NULL, 1);


--
-- Data for Name: zencartcategories_description; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcategories_description VALUES (3, 1, 'Subscriptions', 'SOUNZ Memberships');
INSERT INTO zencartcategories_description VALUES (2, 1, 'Items for Sale', 'Items for Sale to SOUNZ Users');
INSERT INTO zencartcategories_description VALUES (4, 1, 'Items for Loan', 'Items for Loan to SOUNZ Library Members');
INSERT INTO zencartcategories_description VALUES (5, 1, 'Donations', 'Donations to SOUNZ');


--
-- Data for Name: zencartconfiguration; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartconfiguration VALUES (5, 'Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', 1, 8, NULL, '2007-09-26 17:05:47.351739', NULL, 'zen_cfg_select_option(array(''asc'', ''desc''), ');
INSERT INTO zencartconfiguration VALUES (6, 'Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', 1, 9, NULL, '2007-09-26 17:05:47.356274', NULL, 'zen_cfg_select_option(array(''products_name'', ''date_expected''), ');
INSERT INTO zencartconfiguration VALUES (8, 'Language Selector', 'LANGUAGE_DEFAULT_SELECTOR', 'Default', 'Should the default language be based on the Store preferences, or the customer''s browser settings?<br /><br />Default: Store''s default settings', 1, 11, NULL, '2007-09-26 17:05:47.366047', NULL, 'zen_cfg_select_option(array(''Default'', ''Browser''), ');
INSERT INTO zencartconfiguration VALUES (9, 'Use Search-Engine Safe URLs (still in development)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', 6, 12, NULL, '2007-09-26 17:05:47.371045', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (10, 'Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', 1, 14, NULL, '2007-09-26 17:05:47.375382', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (11, 'Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', 1, 17, NULL, '2007-09-26 17:05:47.379724', NULL, 'zen_cfg_select_option(array(''and'', ''or''), ');
INSERT INTO zencartconfiguration VALUES (13, 'Show Category Counts', 'SHOW_COUNTS', 'true', 'Count recursively how many products are in each category', 1, 19, NULL, '2007-09-26 17:05:47.38933', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (14, 'Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', 1, 20, NULL, '2007-09-26 17:05:47.393806', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (15, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', 1, 21, NULL, '2007-09-26 17:05:47.397904', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (16, 'Display Prices with Tax in Admin', 'DISPLAY_PRICE_WITH_TAX_ADMIN', 'false', 'Display prices with tax included (true) or add the tax at the end (false) in Admin(Invoices)', 1, 21, NULL, '2007-09-26 17:05:47.402553', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (17, 'Basis of Product Tax', 'STORE_PRODUCT_TAX_BASIS', 'Shipping', 'On what basis is Product Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 1, 21, NULL, '2007-09-26 17:05:47.407722', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');
INSERT INTO zencartconfiguration VALUES (18, 'Basis of Shipping Tax', 'STORE_SHIPPING_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone - Can be overriden by correctly written Shipping Module', 1, 21, NULL, '2007-09-26 17:05:47.412624', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');
INSERT INTO zencartconfiguration VALUES (19, 'Sales Tax Display Status', 'STORE_TAX_DISPLAY_STATUS', '0', 'Always show Sales Tax even when amount is $0.00?<br />0= Off<br />1= On', 1, 21, NULL, '2007-09-26 17:05:47.417165', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (20, 'Admin Session Time Out in Seconds', 'SESSION_TIMEOUT_ADMIN', '3600', 'Enter the time in seconds. Default=3600<br />Example: 3600= 1 hour<br /><br />Note: Too few seconds can result in timeout issues when adding/editing products', 1, 40, NULL, '2007-09-26 17:05:47.421538', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (21, 'Admin Set max_execution_time for processes', 'GLOBAL_SET_TIME_LIMIT', '60', 'Enter the time in seconds for how long the max_execution_time of processes should be. Default=60<br />Example: 60= 1 minute<br /><br />Note: Changing the time limit is only needed if you are having problems with the execution time of a process', 1, 42, NULL, '2007-09-26 17:05:47.426389', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (23, 'Store Status', 'STORE_STATUS', '0', 'What is your Store Status<br />0= Normal Store<br />1= Showcase no prices<br />2= Showcase with prices', 1, 25, NULL, '2007-09-26 17:05:47.435764', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (24, 'Server Uptime', 'DISPLAY_SERVER_UPTIME', 'true', 'Displaying Server uptime can cause entries in error logs on some servers. (true = Display, false = don''t display)', 1, 46, '2003-11-08 20:24:47', '0001-01-01 00:00:00', '', 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (25, 'Missing Page Check', 'MISSING_PAGE_CHECK', 'Page Not Found', 'Zen Cart can check for missing pages in the URL and redirect to Index page. For debugging you may want to turn this off. <br /><br /><strong>Default=On</strong><br />On = Send missing pages to ''index''<br />Off = Don''t check for missing pages<br />Page Not Found = display the Page-Not-Found page', 1, 48, '2003-11-08 20:24:47', '0001-01-01 00:00:00', '', 'zen_cfg_select_option(array(''On'', ''Off'', ''Page Not Found''),');
INSERT INTO zencartconfiguration VALUES (26, 'cURL Proxy Status', 'CURL_PROXY_REQUIRED', 'False', 'Does your host require that you use a proxy for cURL communication?', 1, 50, NULL, '2007-09-26 17:05:47.450961', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (27, 'cURL Proxy Address', 'CURL_PROXY_SERVER_DETAILS', '', 'If you have GoDaddy hosting or other hosting services that require use of a proxy to talk to external sites via cURL, enter their proxy address here.<br />format: address:port<br />ie: for GoDaddy, enter: <strong>proxy.shr.secureserver.net:3128</strong> or possibly 64.202.165.130:3128', 1, 51, NULL, '2007-09-26 17:05:47.455347', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (28, 'HTML Editor', 'HTML_EDITOR_PREFERENCE', 'NONE', 'Please select the HTML/Rich-Text editor you wish to use for composing Admin-related emails, newsletters, and product descriptions', 1, 110, NULL, '2007-09-26 17:05:47.45953', NULL, 'zen_cfg_pull_down_htmleditors(');
INSERT INTO zencartconfiguration VALUES (30, 'Show Category Counts - Admin', 'SHOW_COUNTS_ADMIN', 'true', 'Show Category Counts in Admin?', 1, 19, NULL, '2007-09-26 17:05:47.469204', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (31, 'Currency Conversion Ratio', 'CURRENCY_UPLIFT_RATIO', '1.05', 'When auto-updating currencies, what "uplift" ratio should be used to calculate the exchange rate used by your store?<br />ie: the bank rate is obtained from the currency-exchange servers; how much extra do you want to charge in order to make up the difference between the bank rate and the consumer rate?<br /><br /><strong>Default: 1.05 </strong><br />This will cause the published bank rate to be multiplied by 1.05 to set the currency rates in your store.', 1, 55, NULL, '2007-09-26 17:05:47.473821', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (32, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', 2, 1, NULL, '2007-09-26 17:05:47.477979', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (33, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', 2, 2, NULL, '2007-09-26 17:05:47.482145', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (34, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', 2, 3, NULL, '2007-09-26 17:05:47.486294', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (35, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', 2, 4, NULL, '2007-09-26 17:05:47.491402', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (36, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', 2, 5, NULL, '2007-09-26 17:05:47.495499', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (37, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '0', 'Minimum length of company name', 2, 6, NULL, '2007-09-26 17:05:47.499665', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (38, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', 2, 7, NULL, '2007-09-26 17:05:47.504611', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (39, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', 2, 8, NULL, '2007-09-26 17:05:47.509166', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (40, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', 2, 9, NULL, '2007-09-26 17:05:47.513413', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (41, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', 2, 10, NULL, '2007-09-26 17:05:47.517589', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (42, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', 2, 11, NULL, '2007-09-26 17:05:47.521604', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (43, 'Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', 2, 12, NULL, '2007-09-26 17:05:47.525753', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (44, 'Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', 2, 13, NULL, '2007-09-26 17:05:47.530234', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (45, 'Credit Card CVV Number', 'CC_CVV_MIN_LENGTH', '3', 'Minimum length of credit card CVV number', 2, 13, NULL, '2007-09-26 17:05:47.534952', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (46, 'Product Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of product review text', 2, 14, NULL, '2007-09-26 17:05:47.539069', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (47, 'Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', 2, 15, NULL, '2007-09-26 17:05:47.543124', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (48, 'Also Purchased Products', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the ''This Customer Also Purchased'' box', 2, 16, NULL, '2007-09-26 17:05:47.547189', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (49, 'Nick Name', 'ENTRY_NICK_MIN_LENGTH', '3', 'Minimum length of Nick Name', 2, 1, NULL, '2007-09-26 17:05:47.552066', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (50, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', 3, 1, NULL, '2007-09-26 17:05:47.556815', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (51, 'Search Results Per Page', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Number of products to list on a search result page', 3, 2, NULL, '2007-09-26 17:05:47.561055', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (52, 'Prev/Next Navigation Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of ''number'' links use for page-sets', 3, 3, NULL, '2007-09-26 17:05:47.565368', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (53, 'Products on Special ', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Number of products on special to display', 3, 4, NULL, '2007-09-26 17:05:47.570117', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (54, 'New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Number of new products to display in a category', 3, 5, NULL, '2007-09-26 17:05:47.574828', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (55, 'Upcoming Products ', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Number of ''upcoming'' products to display', 3, 6, NULL, '2007-09-26 17:05:47.578978', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (56, 'Manufacturers List - Scroll Box Size/Style', 'MAX_MANUFACTURERS_LIST', '3', 'Number of manufacturers names to be displayed in the scroll box window. Setting this to 1 or 0 will display a dropdown list.', 3, 7, NULL, '2007-09-26 17:05:47.58346', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (57, 'Manufacturers List - Verify Product Exist', 'PRODUCTS_MANUFACTURERS_STATUS', '1', 'Verify that at least 1 product exists and is active for the manufacturer name to show<br /><br />Note: When this feature is ON it can produce slower results on sites with a large number of products and/or manufacturers<br />0= off 1= on', 3, 7, NULL, '2007-09-26 17:05:47.587616', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (58, 'Music Genre List - Scroll Box Size/Style', 'MAX_MUSIC_GENRES_LIST', '3', 'Number of music genre names to be displayed in the scroll box window. Setting this to 1 or 0 will display a dropdown list.', 3, 7, NULL, '2007-09-26 17:05:47.592443', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (59, 'Record Company List - Scroll Box Size/Style', 'MAX_RECORD_COMPANY_LIST', '3', 'Number of record company names to be displayed in the scroll box window. Setting this to 1 or 0 will display a dropdown list.', 3, 7, NULL, '2007-09-26 17:05:47.597297', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (60, 'Length of Record Company Name', 'MAX_DISPLAY_RECORD_COMPANY_NAME_LEN', '15', 'Used in record companies box; maximum length of record company name to display. Longer names will be truncated.', 3, 8, NULL, '2007-09-26 17:05:47.601509', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (61, 'Length of Music Genre Name', 'MAX_DISPLAY_MUSIC_GENRES_NAME_LEN', '15', 'Used in music genres box; maximum length of music genre name to display. Longer names will be truncated.', 3, 8, NULL, '2007-09-26 17:05:47.605788', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (62, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display. Longer names will be truncated.', 3, 8, NULL, '2007-09-26 17:05:47.610513', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (63, 'New Product Reviews Per Page', 'MAX_DISPLAY_NEW_REVIEWS', '6', 'Number of new reviews to display on each page', 3, 9, NULL, '2007-09-26 17:05:47.614571', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (64, 'Random Product Reviews For Box', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'Number of random product reviews to rotate in the box', 3, 10, NULL, '2007-09-26 17:05:47.619095', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (65, 'Random New Products For Box', 'MAX_RANDOM_SELECT_NEW', '10', 'Number of random new product to display in box', 3, 11, NULL, '2007-09-26 17:05:47.62312', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (66, 'Random Products On Special For Box', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'Number of random products on special to display in box', 3, 12, NULL, '2007-09-26 17:05:47.627213', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (67, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', 3, 13, NULL, '2007-09-26 17:05:47.631783', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (68, 'New Products Listing- Number Per Page', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Number of new products listed per page', 3, 14, NULL, '2007-09-26 17:05:47.636181', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (69, 'Best Sellers For Box', 'MAX_DISPLAY_BESTSELLERS', '10', 'Number of best sellers to display in box', 3, 15, NULL, '2007-09-26 17:05:47.640945', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (70, 'Also Purchased Products', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Number of products to display in the ''This Customer Also Purchased'' box', 3, 16, NULL, '2007-09-26 17:05:47.6481', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (71, 'Recent Purchases Box- NOTE: box is disabled ', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Number of products to display in the recent purchases box', 3, 17, NULL, '2007-09-26 17:05:47.655805', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (72, 'Customer Order History List Per Page', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Number of orders to display in the order history list in ''My Account''', 3, 18, NULL, '2007-09-26 17:05:47.664074', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (73, 'Maximum Display of Customers on Customers Page', 'MAX_DISPLAY_SEARCH_RESULTS_CUSTOMER', '20', '', 3, 19, NULL, '2007-09-26 17:05:47.668931', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (74, 'Maximum Display of Orders on Orders Page', 'MAX_DISPLAY_SEARCH_RESULTS_ORDERS', '20', '', 3, 20, NULL, '2007-09-26 17:05:47.673053', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (75, 'Maximum Display of Products on Reports', 'MAX_DISPLAY_SEARCH_RESULTS_REPORTS', '20', '', 3, 21, NULL, '2007-09-26 17:05:47.67713', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (76, 'Maximum Categories Products Display List', 'MAX_DISPLAY_RESULTS_CATEGORIES', '10', 'Number of products to list per screen', 3, 22, NULL, '2007-09-26 17:05:47.681992', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (77, 'Products Listing- Number Per Page', 'MAX_DISPLAY_PRODUCTS_LISTING', '10', 'Maximum Number of Products to list per page on main page', 3, 30, NULL, '2007-09-26 17:05:47.68663', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (78, 'Products Attributes - Option Names and Values Display', 'MAX_ROW_LISTS_OPTIONS', '10', 'Maximum number of option names and values to display in the products attributes page', 3, 24, NULL, '2007-09-26 17:05:47.691277', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (79, 'Products Attributes - Attributes Controller Display', 'MAX_ROW_LISTS_ATTRIBUTES_CONTROLLER', '30', 'Maximum number of attributes to display in the Attributes Controller page', 3, 25, NULL, '2007-09-26 17:05:47.695356', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (80, 'Products Attributes - Downloads Manager Display', 'MAX_DISPLAY_SEARCH_RESULTS_DOWNLOADS_MANAGER', '30', 'Maximum number of attributes downloads to display in the Downloads Manager page', 3, 26, NULL, '2007-09-26 17:05:47.699644', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (81, 'Featured Products - Number to Display Admin', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED_ADMIN', '10', 'Number of featured products to list per screen - Admin', 3, 27, NULL, '2007-09-26 17:05:47.704531', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (82, 'Maximum Display of Featured Products - Main Page', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED', '9', 'Number of featured products to list on main page', 3, 28, NULL, '2007-09-26 17:05:47.709081', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (83, 'Maximum Display of Featured Products Page', 'MAX_DISPLAY_PRODUCTS_FEATURED_PRODUCTS', '10', 'Number of featured products to list per screen', 3, 29, NULL, '2007-09-26 17:05:47.713345', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (84, 'Random Featured Products For Box', 'MAX_RANDOM_SELECT_FEATURED_PRODUCTS', '10', 'Number of random featured products to display in box', 3, 30, NULL, '2007-09-26 17:05:47.717484', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (85, 'Maximum Display of Specials Products - Main Page', 'MAX_DISPLAY_SPECIAL_PRODUCTS_INDEX', '9', 'Number of special products to list on main page', 3, 31, NULL, '2007-09-26 17:05:47.721537', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (86, 'New Product Listing - Limited to ...', 'SHOW_NEW_PRODUCTS_LIMIT', '0', 'Limit the New Product Listing to<br />0= All Products<br />1= Current Month<br />7= 7 Days<br />14= 14 Days<br />30= 30 Days<br />60= 60 Days<br />90= 90 Days<br />120= 120 Days', 3, 40, NULL, '2007-09-26 17:05:47.726914', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''7'', ''14'', ''30'', ''60'', ''90'', ''120''), ');
INSERT INTO zencartconfiguration VALUES (87, 'Maximum Display of Products All Page', 'MAX_DISPLAY_PRODUCTS_ALL', '10', 'Number of products to list per screen', 3, 45, NULL, '2007-09-26 17:05:47.731754', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (88, 'Maximum Display of Language Flags in Language Side Box', 'MAX_LANGUAGE_FLAGS_COLUMNS', '3', 'Number of Language Flags per Row', 3, 50, NULL, '2007-09-26 17:05:47.735986', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (89, 'Maximum File Upload Size', 'MAX_FILE_UPLOAD_SIZE', '2048000', 'What is the Maximum file size for uploads?<br />Default= 2048000', 3, 60, NULL, '2007-09-26 17:05:47.740088', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (90, 'Allowed Filename Extensions for uploading', 'UPLOAD_FILENAME_EXTENSIONS', 'jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip', 'List the permissible filetypes (filename extensions) to be allowed when files are uploaded to your site by customers. Separate multiple values with commas(,). Do not include the dot(.).<br /><br />Suggested setting: "jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip"', 3, 61, NULL, '2007-09-26 17:05:47.744288', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (91, 'Maximum Orders Detail Display on Admin Orders Listing', 'MAX_DISPLAY_RESULTS_ORDERS_DETAILS_LISTING', '0', 'Maximum number of Order Details<br />0 = Unlimited', 3, 65, NULL, '2007-09-26 17:05:47.749265', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (92, 'Maximum PayPal IPN Display on Admin Listing', 'MAX_DISPLAY_SEARCH_RESULTS_PAYPAL_IPN', '20', 'Maximum number of PayPal IPN Lisings in Admin<br />Default is 20', 3, 66, NULL, '2007-09-26 17:05:47.753422', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (93, 'Maximum Display Columns Products to Multiple Categories Manager', 'MAX_DISPLAY_PRODUCTS_TO_CATEGORIES_COLUMNS', '3', 'Maximum Display Columns Products to Multiple Categories Manager<br />3 = Default', 3, 70, NULL, '2007-09-26 17:05:47.75752', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (94, 'Maximum Display EZ-Pages', 'MAX_DISPLAY_SEARCH_RESULTS_EZPAGE', '20', 'Maximum Display EZ-Pages<br />20 = Default', 3, 71, NULL, '2007-09-26 17:05:47.761604', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (95, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', 4, 1, NULL, '2007-09-26 17:05:47.767042', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (96, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', 4, 2, NULL, '2007-09-26 17:05:47.77166', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (97, 'Heading Image Width - Admin', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images in the Admin<br />NOTE: Presently, this adjusts the spacing on the pages in the Admin Pages or could be used to add images to the heading in the Admin', 4, 3, NULL, '2007-09-26 17:05:47.775836', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (98, 'Heading Image Height - Admin', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images in the Admin<br />NOTE: Presently, this adjusts the spacing on the pages in the Admin Pages or could be used to add images to the heading in the Admin', 4, 4, NULL, '2007-09-26 17:05:47.779883', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (99, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', 4, 5, NULL, '2007-09-26 17:05:47.783993', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (100, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', 4, 6, NULL, '2007-09-26 17:05:47.78913', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (101, 'Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', 4, 7, NULL, '2007-09-26 17:05:47.793262', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (102, 'Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', 4, 8, NULL, '2007-09-26 17:05:47.797627', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (103, 'Image - Shopping Cart Status', 'IMAGE_SHOPPING_CART_STATUS', '1', 'Show product image in the shopping cart?<br />0= off 1= on', 4, 9, NULL, '2007-09-26 17:05:47.802242', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (104, 'Image - Shopping Cart Width', 'IMAGE_SHOPPING_CART_WIDTH', '50', 'Default = 50', 4, 10, NULL, '2007-09-26 17:05:47.807091', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (105, 'Image - Shopping Cart Height', 'IMAGE_SHOPPING_CART_HEIGHT', '40', 'Default = 40', 4, 11, NULL, '2007-09-26 17:05:47.812144', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (106, 'Category Icon Image Width - Product Info Pages', 'CATEGORY_ICON_IMAGE_WIDTH', '57', 'The pixel width of Category Icon heading images for Product Info Pages', 4, 13, NULL, '2007-09-26 17:05:47.816355', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (107, 'Category Icon Image Height - Product Info Pages', 'CATEGORY_ICON_IMAGE_HEIGHT', '40', 'The pixel height of Category Icon heading images for Product Info Pages', 4, 14, NULL, '2007-09-26 17:05:47.820499', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (108, 'Top Subcategory Image Width', 'SUBCATEGORY_IMAGE_TOP_WIDTH', '150', 'The pixel width of Top subcategory images<br />Top subcategory is when the Category contains subcategories', 4, 15, NULL, '2007-09-26 17:05:47.824565', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (109, 'Top Subcategory Image Height', 'SUBCATEGORY_IMAGE_TOP_HEIGHT', '85', 'The pixel height of Top subcategory images<br />Top subcategory is when the Category contains subcategories', 4, 16, NULL, '2007-09-26 17:05:47.829185', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (110, 'Product Info - Image Width', 'MEDIUM_IMAGE_WIDTH', '150', 'The pixel width of Product Info images', 4, 20, NULL, '2007-09-26 17:05:47.833955', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (111, 'Product Info - Image Height', 'MEDIUM_IMAGE_HEIGHT', '120', 'The pixel height of Product Info images', 4, 21, NULL, '2007-09-26 17:05:47.838007', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (112, 'Product Info - Image Medium Suffix', 'IMAGE_SUFFIX_MEDIUM', '_MED', 'Product Info Medium Image Suffix<br />Default = _MED', 4, 22, NULL, '2007-09-26 17:05:47.842095', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (113, 'Product Info - Image Large Suffix', 'IMAGE_SUFFIX_LARGE', '_LRG', 'Product Info Large Image Suffix<br />Default = _LRG', 4, 23, NULL, '2007-09-26 17:05:47.846665', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (114, 'Product Info - Number of Additional Images per Row', 'IMAGES_AUTO_ADDED', '3', 'Product Info - Enter the number of additional images to display per row<br />Default = 3', 4, 30, NULL, '2007-09-26 17:05:47.851494', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (115, 'Image - Product Listing Width', 'IMAGE_PRODUCT_LISTING_WIDTH', '100', 'Default = 100', 4, 40, NULL, '2007-09-26 17:05:47.855579', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (116, 'Image - Product Listing Height', 'IMAGE_PRODUCT_LISTING_HEIGHT', '80', 'Default = 80', 4, 41, NULL, '2007-09-26 17:05:47.859585', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (117, 'Image - Product New Listing Width', 'IMAGE_PRODUCT_NEW_LISTING_WIDTH', '100', 'Default = 100', 4, 42, NULL, '2007-09-26 17:05:47.863636', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (118, 'Image - Product New Listing Height', 'IMAGE_PRODUCT_NEW_LISTING_HEIGHT', '80', 'Default = 80', 4, 43, NULL, '2007-09-26 17:05:47.867763', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (119, 'Image - New Products Width', 'IMAGE_PRODUCT_NEW_WIDTH', '100', 'Default = 100', 4, 44, NULL, '2007-09-26 17:05:47.873104', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (120, 'Image - New Products Height', 'IMAGE_PRODUCT_NEW_HEIGHT', '80', 'Default = 80', 4, 45, NULL, '2007-09-26 17:05:47.877167', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (121, 'Image - Featured Products Width', 'IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH', '100', 'Default = 100', 4, 46, NULL, '2007-09-26 17:05:47.881178', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (122, 'Image - Featured Products Height', 'IMAGE_FEATURED_PRODUCTS_LISTING_HEIGHT', '80', 'Default = 80', 4, 47, NULL, '2007-09-26 17:05:47.886174', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (123, 'Image - Product All Listing Width', 'IMAGE_PRODUCT_ALL_LISTING_WIDTH', '100', 'Default = 100', 4, 48, NULL, '2007-09-26 17:05:47.89072', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (124, 'Image - Product All Listing Height', 'IMAGE_PRODUCT_ALL_LISTING_HEIGHT', '80', 'Default = 80', 4, 49, NULL, '2007-09-26 17:05:47.895386', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (125, 'Product Image - No Image Status', 'PRODUCTS_IMAGE_NO_IMAGE_STATUS', '1', 'Use automatic No Image when none is added to product<br />0= off<br />1= On', 4, 60, NULL, '2007-09-26 17:05:47.899608', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (126, 'Product Image - No Image picture', 'PRODUCTS_IMAGE_NO_IMAGE', 'no_picture.gif', 'Use automatic No Image when none is added to product<br />Default = no_picture.gif', 4, 61, NULL, '2007-09-26 17:05:47.904044', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (127, 'Image - Use Proportional Images on Products and Categories', 'PROPORTIONAL_IMAGES_STATUS', '1', 'Use Proportional Images on Products and Categories?<br /><br />NOTE: Do not use 0 height or width settings for Proportion Images<br />0= off 1= on', 4, 75, NULL, '2007-09-26 17:05:47.914531', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (128, 'Email Salutation', 'ACCOUNT_GENDER', 'true', 'Display salutation choice during account creation and with account information', 5, 1, NULL, '2007-09-26 17:05:47.922872', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (129, 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth field during account creation and with account information<br />NOTE: Set Minimum Value Date of Birth to blank for not required<br />Set Minimum Value Date of Birth > 0 to require', 5, 2, NULL, '2007-09-26 17:05:47.92781', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (130, 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company field during account creation and with account information', 5, 3, NULL, '2007-09-26 17:05:47.932735', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (131, 'Address Line 2', 'ACCOUNT_SUBURB', 'true', 'Display address line 2 field during account creation and with account information', 5, 4, NULL, '2007-09-26 17:05:47.937664', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (132, 'State', 'ACCOUNT_STATE', 'true', 'Display state field during account creation and with account information', 5, 5, NULL, '2007-09-26 17:05:47.941994', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (133, 'State - Always display as pulldown?', 'ACCOUNT_STATE_DRAW_INITIAL_DROPDOWN', 'false', 'When state field is displayed, should it always be a pulldown menu?', 5, 5, NULL, '2007-09-26 17:05:47.946314', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (134, 'Create Account Default Country ID', 'SHOW_CREATE_ACCOUNT_DEFAULT_COUNTRY', '223', 'Set Create Account Default Country ID to:<br />Default is 223', 5, 6, NULL, '2007-09-26 17:05:47.951229', 'zen_get_country_name', 'zen_cfg_pull_down_country_list_none(');
INSERT INTO zencartconfiguration VALUES (135, 'Fax Number', 'ACCOUNT_FAX_NUMBER', 'true', 'Display fax number field during account creation and with account information', 5, 10, NULL, '2007-09-26 17:05:47.955298', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (136, 'Show Newsletter Checkbox', 'ACCOUNT_NEWSLETTER_STATUS', '1', 'Show Newsletter Checkbox<br />0= off<br />1= Display Unchecked<br />2= Display Checked<br /><strong>Note: Defaulting this to accepted may be in violation of certain regulations for your state or country</strong>', 5, 45, NULL, '2007-09-26 17:05:47.960294', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (137, 'Customer Default Email Preference', 'ACCOUNT_EMAIL_PREFERENCE', '0', 'Set the Default Customer Default Email Preference<br />0= Text<br />1= HTML<br />', 5, 46, NULL, '2007-09-26 17:05:47.965386', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (138, 'Customer Product Notification Status', 'CUSTOMERS_PRODUCTS_NOTIFICATION_STATUS', '1', 'Customer should be asked about product notifications after checkout success and in account preferences<br />0= Never ask<br />1= Ask (ignored on checkout if has already selected global notifications)<br /><br />Note: Sidebox must be turned off separately', 5, 50, NULL, '2007-09-26 17:05:47.970391', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (139, 'Customer Shop Status - View Shop and Prices', 'CUSTOMERS_APPROVAL', '0', 'Customer must be approved to shop<br />0= Not required<br />1= Must login to browse<br />2= May browse but no prices unless logged in<br />3= Showroom Only<br /><br />It is recommended that Option 2 be used for the purposes of Spiders if you wish customers to login to see prices.', 5, 55, NULL, '2007-09-26 17:05:47.981505', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (140, 'Customer Approval Status - Authorization Pending', 'CUSTOMERS_APPROVAL_AUTHORIZATION', '0', 'Customer must be Authorized to shop<br />0= Not required<br />1= Must be Authorized to Browse<br />2= May browse but no prices unless Authorized<br />3= Customer May Browse and May see Prices but Must be Authorized to Buy<br /><br />It is recommended that Option 2 or 3 be used for the purposes of Spiders', 5, 65, NULL, '2007-09-26 17:05:47.986089', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (141, 'Customer Authorization: filename', 'CUSTOMERS_AUTHORIZATION_FILENAME', 'customers_authorization', 'Customer Authorization filename<br />Note: Do not include the extension<br />Default=customers_authorization', 5, 66, NULL, '2007-09-26 17:05:47.990909', NULL, '');
INSERT INTO zencartconfiguration VALUES (142, 'Customer Authorization: Hide Header', 'CUSTOMERS_AUTHORIZATION_HEADER_OFF', 'false', 'Customer Authorization: Hide Header <br />(true=hide false=show)', 5, 67, NULL, '2007-09-26 17:05:47.995117', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (143, 'Customer Authorization: Hide Column Left', 'CUSTOMERS_AUTHORIZATION_COLUMN_LEFT_OFF', 'false', 'Customer Authorization: Hide Column Left <br />(true=hide false=show)', 5, 68, NULL, '2007-09-26 17:05:47.999544', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (144, 'Customer Authorization: Hide Column Right', 'CUSTOMERS_AUTHORIZATION_COLUMN_RIGHT_OFF', 'false', 'Customer Authorization: Hide Column Right <br />(true=hide false=show)', 5, 69, NULL, '2007-09-26 17:05:48.005018', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (145, 'Customer Authorization: Hide Footer', 'CUSTOMERS_AUTHORIZATION_FOOTER_OFF', 'false', 'Customer Authorization: Hide Footer <br />(true=hide false=show)', 5, 70, NULL, '2007-09-26 17:05:48.00988', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (146, 'Customer Authorization: Hide Prices', 'CUSTOMERS_AUTHORIZATION_PRICES_OFF', 'false', 'Customer Authorization: Hide Prices <br />(true=hide false=show)', 5, 71, NULL, '2007-09-26 17:05:48.022778', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (147, 'Customers Referral Status', 'CUSTOMERS_REFERRAL_STATUS', '0', 'Customers Referral Code is created from<br />0= Off<br />1= 1st Discount Coupon Code used<br />2= Customer can add during create account or edit if blank<br /><br />NOTE: Once the Customers Referral Code has been set it can only be changed in the Admin Customer', 5, 80, NULL, '2007-09-26 17:05:48.027288', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (149, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_shipping.php;ot_coupon.php;ot_group_pricing.php;ot_tax.php;ot_loworderfee.php;ot_gv.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', 6, 0, NULL, '2007-09-26 17:05:48.036525', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (158, 'Enable Free Shipping', 'MODULE_SHIPPING_FREESHIPPER_STATUS', 'True', 'Do you want to offer Free shipping?', 6, 0, NULL, '2007-09-26 17:05:48.075037', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (159, 'Free Shipping Cost', 'MODULE_SHIPPING_FREESHIPPER_COST', '0.00', 'What is the Shipping cost?', 6, 6, NULL, '2007-09-26 17:05:48.078662', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (160, 'Handling Fee', 'MODULE_SHIPPING_FREESHIPPER_HANDLING', '0', 'Handling fee for this shipping method.', 6, 0, NULL, '2007-09-26 17:05:48.082925', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (161, 'Tax Class', 'MODULE_SHIPPING_FREESHIPPER_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2007-09-26 17:05:48.08758', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (162, 'Shipping Zone', 'MODULE_SHIPPING_FREESHIPPER_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2007-09-26 17:05:48.091767', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (163, 'Sort Order', 'MODULE_SHIPPING_FREESHIPPER_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2007-09-26 17:05:48.095621', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (164, 'Enable Store Pickup Shipping', 'MODULE_SHIPPING_STOREPICKUP_STATUS', 'True', 'Do you want to offer In Store rate shipping?', 6, 0, NULL, '2007-09-26 17:05:48.099229', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (165, 'Shipping Cost', 'MODULE_SHIPPING_STOREPICKUP_COST', '0.00', 'The shipping cost for all orders using this shipping method.', 6, 0, NULL, '2007-09-26 17:05:48.103069', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (166, 'Tax Class', 'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2007-09-26 17:05:48.106692', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (167, 'Tax Basis', 'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, NULL, '2007-09-26 17:05:48.111718', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing''), ');
INSERT INTO zencartconfiguration VALUES (168, 'Shipping Zone', 'MODULE_SHIPPING_STOREPICKUP_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2007-09-26 17:05:48.115775', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (169, 'Sort Order', 'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2007-09-26 17:05:48.11955', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (177, 'Enable Free Charge Module', 'MODULE_PAYMENT_FREECHARGER_STATUS', 'True', 'Do you want to accept Free Charge payments?', 6, 1, NULL, '2007-09-26 17:05:48.153286', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (178, 'Sort order of display.', 'MODULE_PAYMENT_FREECHARGER_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2007-09-26 17:05:48.181482', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (179, 'Payment Zone', 'MODULE_PAYMENT_FREECHARGER_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2007-09-26 17:05:48.185029', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (180, 'Set Order Status', 'MODULE_PAYMENT_FREECHARGER_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2007-09-26 17:05:48.189953', 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');
INSERT INTO zencartconfiguration VALUES (186, 'Include Tax', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_TAX', 'false', 'Include Tax value in amount before discount calculation?', 6, 6, NULL, '2007-09-26 17:05:48.216069', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (187, 'This module is installed', 'MODULE_ORDER_TOTAL_GROUP_PRICING_STATUS', 'true', '', 6, 1, NULL, '2007-09-26 17:05:48.219862', NULL, 'zen_cfg_select_option(array(''true''), ');
INSERT INTO zencartconfiguration VALUES (188, 'Sort Order', 'MODULE_ORDER_TOTAL_GROUP_PRICING_SORT_ORDER', '290', 'Sort order of display.', 6, 2, NULL, '2007-09-26 17:05:48.223517', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (189, 'Include Shipping', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_SHIPPING', 'false', 'Include Shipping value in amount before discount calculation?', 6, 5, NULL, '2007-09-26 17:05:48.227169', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (190, 'Re-calculate Tax', 'MODULE_ORDER_TOTAL_GROUP_PRICING_CALC_TAX', 'Standard', 'Re-Calculate Tax', 6, 7, NULL, '2007-09-26 17:05:48.231499', NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''), ');
INSERT INTO zencartconfiguration VALUES (191, 'Tax Class', 'MODULE_ORDER_TOTAL_GROUP_PRICING_TAX_CLASS', '0', 'Use the following tax class when treating Group Discount as Credit Note.', 6, 0, NULL, '2007-09-26 17:05:48.236126', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (200, 'Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', 6, 0, NULL, '2007-09-26 17:05:48.27537', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (201, 'Admin configuration_key shows', 'ADMIN_CONFIGURATION_KEY_ON', '0', 'Manually switch to value of 1 to see the configuration_key name in configuration displays', 6, 0, NULL, '2007-09-26 17:05:48.279835', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (202, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', 7, 1, NULL, '2007-09-26 17:05:48.283667', 'zen_get_country_name', 'zen_cfg_pull_down_country_list(');
INSERT INTO zencartconfiguration VALUES (203, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes. NOTE: For USA zip codes, only use your 5 digit zip code.', 7, 2, NULL, '2007-09-26 17:05:48.288794', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (204, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', 7, 3, NULL, '2007-09-26 17:05:48.299621', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (206, 'Larger packages - added packaging percentage:weight', 'SHIPPING_BOX_PADDING', '10:0', 'What is the weight of typical packaging for Large packages?<br />Example: 10% + 1lb 10:1<br />10% + 0lbs 10:0<br />0% + 5lbs 0:5<br />0% + 0lbs 0:0', 7, 5, NULL, '2007-09-26 17:05:48.311114', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (207, 'Display Number of Boxes and Weight Status', 'SHIPPING_BOX_WEIGHT_DISPLAY', '3', 'Display Shipping Weight and Number of Boxes?<br /><br />0= off<br />1= Boxes Only<br />2= Weight Only<br />3= Both Boxes and Weight', 7, 15, NULL, '2007-09-26 17:05:48.314893', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (208, 'Shipping Estimator Display Settings for Shopping Cart', 'SHOW_SHIPPING_ESTIMATOR_BUTTON', '1', '<br />0= Off<br />1= Display as Button on Shopping Cart<br />2= Display as Listing on Shopping Cart Page', 7, 20, NULL, '2007-09-26 17:05:48.318848', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (209, 'Order Free Shipping 0 Weight Status', 'ORDER_WEIGHT_ZERO_STATUS', '0', 'If there is no weight to the order, does the order have Free Shipping?<br />0= no<br />1= yes<br /><br />Note: When using Free Shipping, Enable the Free Shipping Module this will only show when shipping is free.', 7, 15, NULL, '2007-09-26 17:05:48.322843', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (210, 'Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', 8, 1, NULL, '2007-09-26 17:05:48.32753', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (211, 'Display Product Manufacturer Name', 'PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', 8, 2, NULL, '2007-09-26 17:05:48.331653', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (212, 'Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', 8, 3, NULL, '2007-09-26 17:05:48.33545', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (213, 'Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', 8, 4, NULL, '2007-09-26 17:05:48.339101', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (214, 'Display Product Price/Add to Cart', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price/Add to Cart', 8, 5, NULL, '2007-09-26 17:05:48.343281', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (215, 'Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', 8, 6, NULL, '2007-09-26 17:05:48.346916', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (216, 'Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', 8, 7, NULL, '2007-09-26 17:05:48.351475', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (217, 'Display Product Price/Add to Cart Column Width', 'PRODUCTS_LIST_PRICE_WIDTH', '125', 'Define the width of the Price/Add to Cart column<br />Default= 125', 8, 8, NULL, '2007-09-26 17:05:48.355177', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (218, 'Display Category/Manufacturer Filter (0=off; 1=on)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', 8, 9, NULL, '2007-09-26 17:05:48.358754', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (219, 'Prev/Next Split Page Navigation (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '3', 'Sets the location of the Prev/Next Split Page Navigation', 8, 10, NULL, '2007-09-26 17:05:48.362484', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (220, 'Display Product Listing Default Sort Order', 'PRODUCT_LISTING_DEFAULT_SORT_ORDER', '', 'Product Listing Default sort order?<br />NOTE: Leave Blank for Product Sort Order. Sort the Product Listing in the order you wish for the default display to start in to get the sort order setting. Example: 2a', 8, 15, NULL, '2007-09-26 17:05:48.36781', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (221, 'Display Product Add to Cart Button (0=off; 1=on; 2=on with Qty Box per Product)', 'PRODUCT_LIST_PRICE_BUY_NOW', '1', 'Do you want to display the Add to Cart Button?<br /><br /><strong>NOTE:</strong> Turn OFF Display Multiple Products Qty Box Status to use Option 2 on with Qty Box per Product', 8, 20, NULL, '2007-09-26 17:05:48.373681', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (222, 'Display Multiple Products Qty Box Status and Set Button Location', 'PRODUCT_LISTING_MULTIPLE_ADD_TO_CART', '3', 'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', 8, 25, NULL, '2007-09-26 17:05:48.377517', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (223, 'Display Product Description', 'PRODUCT_LIST_DESCRIPTION', '150', 'Do you want to display the Product Description?<br /><br />0= OFF<br />150= Suggested Length, or enter the maximum number of characters to display', 8, 30, NULL, '2007-09-26 17:05:48.381312', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (224, 'Product Listing Ascending Sort Order', 'PRODUCT_LIST_SORT_ORDER_ASCENDING', '+', 'What do you want to use to indicate Sort Order Ascending?<br />Default = +', 8, 40, NULL, '2007-09-26 17:05:48.385596', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (225, 'Product Listing Descending Sort Order', 'PRODUCT_LIST_SORT_ORDER_DESCENDING', '-', 'What do you want to use to indicate Sort Order Descending?<br />Default = -', 8, 41, NULL, '2007-09-26 17:05:48.389883', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (226, 'Include Product Listing Alpha Sorter Dropdown', 'PRODUCT_LIST_ALPHA_SORTER', 'true', 'Do you want to include an Alpha Filter dropdown on the Product Listing?', 8, 50, NULL, '2007-09-26 17:05:48.393553', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (227, 'Include Product Listing Sub Categories Image', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS', 'true', 'Do you want to include the Sub Categories Image on the Product Listing?', 8, 52, NULL, '2007-09-26 17:05:48.397321', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (228, 'Include Product Listing Top Categories Image', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS_TOP', 'true', 'Do you want to include the Top Categories Image on the Product Listing?', 8, 53, NULL, '2007-09-26 17:05:48.401129', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (229, 'Show SubCategories on Main Page while navigating', 'PRODUCT_LIST_CATEGORY_ROW_STATUS', '1', 'Show Sub-Categories on Main Page while navigating through Categories<br /><br />0= off<br />1= on', 8, 60, NULL, '2007-09-26 17:05:48.406308', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (230, 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', 9, 1, NULL, '2007-09-26 17:05:48.410908', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (231, 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', 9, 2, NULL, '2007-09-26 17:05:48.414574', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (232, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', 9, 3, NULL, '2007-09-26 17:05:48.418675', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (233, 'Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', 9, 4, NULL, '2007-09-26 17:05:48.422356', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (234, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', 9, 5, NULL, '2007-09-26 17:05:48.425873', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (235, 'Products status in Catalog when out of stock should be set to', 'SHOW_PRODUCTS_SOLD_OUT', '0', 'Show Products when out of stock<br /><br />0= set product status to OFF<br />1= leave product status ON', 9, 10, NULL, '2007-09-26 17:05:48.430365', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (236, 'Show Sold Out Image in place of Add to Cart', 'SHOW_PRODUCTS_SOLD_OUT_IMAGE', '1', 'Show Sold Out Image instead of Add to Cart Button<br /><br />0= off<br />1= on', 9, 11, NULL, '2007-09-26 17:05:48.434211', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (237, 'Product Quantity Decimals', 'QUANTITY_DECIMALS', '0', 'Allow how many decimals on Quantity<br /><br />0= off', 9, 15, NULL, '2007-09-26 17:05:48.438548', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (238, 'Show Shopping Cart - Delete Checkboxes or Delete Button', 'SHOW_SHOPPING_CART_DELETE', '3', 'Show on Shopping Cart Delete Button and/or Checkboxes<br /><br />1= Delete Button Only<br />2= Checkbox Only<br />3= Both Delete Button and Checkbox', 9, 20, NULL, '2007-09-26 17:05:48.442294', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (239, 'Show Shopping Cart - Update Cart Button Location', 'SHOW_SHOPPING_CART_UPDATE', '3', 'Show on Shopping Cart Update Cart Button Location as:<br /><br />1= Next to each Qty Box<br />2= Below all Products<br />3= Both Next to each Qty Box and Below all Products', 9, 22, NULL, '2007-09-26 17:05:48.446779', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (240, 'Show New Products on empty Shopping Cart Page', 'SHOW_SHOPPING_CART_EMPTY_NEW_PRODUCTS', '1', 'Show New Products on empty Shopping Cart Page<br />0= off or set the sort order', 9, 30, NULL, '2007-09-26 17:05:48.451803', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (241, 'Show Featured Products on empty Shopping Cart Page', 'SHOW_SHOPPING_CART_EMPTY_FEATURED_PRODUCTS', '2', 'Show Featured Products on empty Shopping Cart Page<br />0= off or set the sort order', 9, 31, NULL, '2007-09-26 17:05:48.455554', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (242, 'Show Special Products on empty Shopping Cart Page', 'SHOW_SHOPPING_CART_EMPTY_SPECIALS_PRODUCTS', '3', 'Show Special Products on empty Shopping Cart Page<br />0= off or set the sort order', 9, 32, NULL, '2007-09-26 17:05:48.459384', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (243, 'Show Upcoming Products on empty Shopping Cart Page', 'SHOW_SHOPPING_CART_EMPTY_UPCOMING', '4', 'Show Upcoming Products on empty Shopping Cart Page<br />0= off or set the sort order', 9, 33, NULL, '2007-09-26 17:05:48.463264', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (244, 'Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', 10, 1, NULL, '2007-09-26 17:05:48.467333', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (245, 'Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/zen/page_parse_time.log', 'Directory and filename of the page parse time log', 10, 2, NULL, '2007-09-26 17:05:48.472358', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (246, 'Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', 10, 3, NULL, '2007-09-26 17:05:48.475886', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (247, 'Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'false', 'Display the page parse time on the bottom of each page<br />You do not need to store the times to display them in the Catalog', 10, 4, NULL, '2007-09-26 17:05:48.479727', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (248, 'Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log (PHP4 only)', 10, 5, NULL, '2007-09-26 17:05:48.483539', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (250, 'SMTP Email Account Mailbox', 'EMAIL_SMTPAUTH_MAILBOX', 'YourEmailAccountNameHere', 'Enter the mailbox account name (me@mydomain.com) supplied by your host. This is the account name that your host requires for SMTP authentication.<br />Only required if using SMTP Authentication for email.', 12, 101, NULL, '2007-09-26 17:05:48.493346', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (251, 'SMTP Email Account Password', 'EMAIL_SMTPAUTH_PASSWORD', 'YourPasswordHere', 'Enter the password for your SMTP mailbox. <br />Only required if using SMTP Authentication for email.', 12, 101, NULL, '2007-09-26 17:05:48.496876', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (252, 'SMTP Email Mail Host', 'EMAIL_SMTPAUTH_MAIL_SERVER', 'mail.EnterYourDomain.com', 'Enter the DNS name of your SMTP mail server.<br />ie: mail.mydomain.com<br />or 55.66.77.88<br />Only required if using SMTP Authentication for email.', 12, 101, NULL, '2007-09-26 17:05:48.500887', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (253, 'SMTP Email Mail Server Port', 'EMAIL_SMTPAUTH_MAIL_SERVER_PORT', '25', 'Enter the IP port number that your SMTP mailserver operates on.<br />Only required if using SMTP Authentication for email.', 12, 101, NULL, '2007-09-26 17:05:48.504777', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (254, 'Convert currencies for Text emails', 'CURRENCIES_TRANSLATIONS', '&pound;,�:&euro;,�', 'What currency conversions do you need for Text emails?<br />Default = &amp;pound;,�:&amp;euro;,�', 12, 120, NULL, '2003-11-21 00:00:00', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (255, 'E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', 12, 2, NULL, '2007-09-26 17:05:48.513518', NULL, 'zen_cfg_select_option(array(''LF'', ''CRLF''),');
INSERT INTO zencartconfiguration VALUES (256, 'Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', 12, 3, NULL, '2007-09-26 17:05:48.51786', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (257, 'Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', 12, 6, NULL, '2007-09-26 17:05:48.521681', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (258, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', 12, 5, NULL, '2007-09-26 17:05:48.526087', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (259, 'Email Archiving Active?', 'EMAIL_ARCHIVE', 'false', 'If you wish to have email messages archived/stored when sent, set this to "true".', 12, 6, NULL, '2007-09-26 17:05:48.53037', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (260, 'E-Mail Friendly-Errors', 'EMAIL_FRIENDLY_ERRORS', 'false', 'Do you want to display friendly errors if emails fail?  Setting this to false will display PHP errors and likely cause the script to fail. Only set to false while troubleshooting, and true for a live shop.', 12, 7, NULL, '2007-09-26 17:05:48.534968', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (263, 'Emails must send from known domain?', 'EMAIL_SEND_MUST_BE_STORE', 'No', 'Does your mailserver require that all outgoing emails have their "from" address match a known domain that exists on your webserver?<br /><br />This is often set in order to prevent spoofing and spam broadcasts.  If set to Yes, this will cause the email address (sent FROM) to be used as the "from" address on all outgoing mail.', 12, 11, NULL, '0001-01-01 00:00:00', NULL, 'zen_cfg_select_option(array(''No'', ''Yes''), ');
INSERT INTO zencartconfiguration VALUES (264, 'Email Admin Format?', 'ADMIN_EXTRA_EMAIL_FORMAT', 'TEXT', 'Please select the Admin extra email format', 12, 12, NULL, '0001-01-01 00:00:00', NULL, 'zen_cfg_select_option(array(''TEXT'', ''HTML''), ');
INSERT INTO zencartconfiguration VALUES (266, 'Send Copy of Create Account Emails To - Status', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO_STATUS', '0', 'Send copy of Create Account Status<br />0= off 1= on', 12, 13, NULL, '2007-09-26 17:05:48.558764', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (268, 'Send Copy of Tell a Friend Emails To - Status', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO_STATUS', '0', 'Send copy of Tell a Friend Status<br />0= off 1= on', 12, 15, NULL, '2007-09-26 17:05:48.567473', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (270, 'Send Copy of Customer GV Send Emails To - Status', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO_STATUS', '0', 'Send copy of Customer GV Send Status<br />0= off 1= on', 12, 17, NULL, '2007-09-26 17:05:48.575469', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (272, 'Send Copy of Admin GV Mail Emails To - Status', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO_STATUS', '0', 'Send copy of Admin GV Mail Status<br />0= off 1= on', 12, 19, NULL, '2007-09-26 17:05:48.583493', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (274, 'Send Copy of Admin Discount Coupon Mail Emails To - Status', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO_STATUS', '0', 'Send copy of Admin Discount Coupon Mail Status<br />0= off 1= on', 12, 21, NULL, '2007-09-26 17:05:48.591477', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (276, 'Send Copy of Admin Orders Status Emails To - Status', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS', '0', 'Send copy of Admin Orders Status Status<br />0= off 1= on', 12, 23, NULL, '2007-09-26 17:05:48.599588', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (278, 'Send Notice of Pending Reviews Emails To - Status', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO_STATUS', '0', 'Send copy of Pending Reviews Status<br />0= off 1= on', 12, 25, NULL, '2007-09-26 17:05:48.607738', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (280, 'Set "Contact Us" Email Dropdown List', 'CONTACT_US_LIST', '', 'On the "Contact Us" Page, set the list of email addresses , in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 40, NULL, '2007-09-26 17:05:48.616025', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (281, 'Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product. <br />If set to [false], then tell-a-friend will prompt for login if user is not already logged in.', 12, 50, NULL, '2007-09-26 17:05:48.620298', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (282, 'Contact Us - Show Store Name and Address', 'CONTACT_US_STORE_NAME_ADDRESS', '1', 'Include Store Name and Address<br />0= off 1= on', 12, 50, NULL, '2007-09-26 17:05:48.624521', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (283, 'Send Low Stock Emails', 'SEND_LOWSTOCK_EMAIL', '0', 'When stock level is at or below low stock level send an email<br />0= off<br />1= on', 12, 60, '2007-09-26 17:05:48.62878', '2007-09-26 17:05:48.62878', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (285, 'Display "Newsletter Unsubscribe" Link?', 'SHOW_NEWSLETTER_UNSUBSCRIBE_LINK', 'true', 'Show "Newsletter Unsubscribe" link in the "Information" side-box?', 12, 70, NULL, '2007-09-26 17:05:48.636304', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (286, 'Audience-Select Count Display', 'AUDIENCE_SELECT_DISPLAY_COUNTS', 'true', 'When displaying lists of available audiences/recipients, should the recipients-count be included? <br /><em>(This may make things slower if you have a lot of customers or complex audience queries)</em>', 12, 90, NULL, '2007-09-26 17:05:48.640054', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (287, 'Enable Downloads', 'DOWNLOAD_ENABLED', 'true', 'Enable the products download functions.', 13, 1, NULL, '2007-09-26 17:05:48.645491', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (288, 'Download by Redirect', 'DOWNLOAD_BY_REDIRECT', 'true', 'Use browser redirection for download. Disable on non-Unix systems.<br /><br />Note: Set /pub to 777 when redirect is true', 13, 2, NULL, '2007-09-26 17:05:48.649666', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (289, 'Download by streaming', 'DOWNLOAD_IN_CHUNKS', 'false', 'If download-by-redirect is disabled, and your PHP memory_limit setting is under 8 MB, you might need to enable this setting so that files are streamed in smaller segments to the browser.<br /><br />Has no effect if Download By Redirect is enabled.', 13, 2, NULL, '2007-09-26 17:05:48.653531', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (290, 'Download Expiration (Number of Days)', 'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', 13, 3, NULL, '2007-09-26 17:05:48.657482', NULL, '');
INSERT INTO zencartconfiguration VALUES (291, 'Number of Downloads Allowed - Per Product', 'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', 13, 4, NULL, '2007-09-26 17:05:48.660985', NULL, '');
INSERT INTO zencartconfiguration VALUES (292, 'Downloads Controller Update Status Value', 'DOWNLOADS_ORDERS_STATUS_UPDATED_VALUE', '4', 'What orders_status resets the Download days and Max Downloads - Default is 4', 13, 10, '2007-09-26 17:05:48.665376', '2007-09-26 17:05:48.665376', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (293, 'Downloads Controller Order Status Value >= lower value', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS', '2', 'Downloads Controller Order Status Value - Default >= 2<br /><br />Downloads are available for checkout based on the orders status. Orders with orders status greater than this value will be available for download. The orders status is set for an order by the Payment Modules. Set the lower range for this range.', 13, 12, '2007-09-26 17:05:48.670362', '2007-09-26 17:05:48.670362', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (294, 'Downloads Controller Order Status Value <= upper value', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS_END', '4', 'Downloads Controller Order Status Value - Default <= 4<br /><br />Downloads are available for checkout based on the orders status. Orders with orders status less than this value will be available for download. The orders status is set for an order by the Payment Modules.  Set the upper range for this range.', 13, 13, '2007-09-26 17:05:48.674182', '2007-09-26 17:05:48.674182', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (295, 'Enable Price Factor', 'ATTRIBUTES_ENABLED_PRICE_FACTOR', 'true', 'Enable the Attributes Price Factor.', 13, 25, NULL, '2007-09-26 17:05:48.678842', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (296, 'Enable Qty Price Discount', 'ATTRIBUTES_ENABLED_QTY_PRICES', 'true', 'Enable the Attributes Quantity Price Discounts.', 13, 26, NULL, '2007-09-26 17:05:48.682629', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (297, 'Enable Attribute Images', 'ATTRIBUTES_ENABLED_IMAGES', 'true', 'Enable the Attributes Images.', 13, 28, NULL, '2007-09-26 17:05:48.68787', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (298, 'Enable Text Pricing by word or letter', 'ATTRIBUTES_ENABLED_TEXT_PRICES', 'true', 'Enable the Attributes Text Pricing by word or letter.', 13, 35, NULL, '2007-09-26 17:05:48.692619', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (299, 'Text Pricing - Spaces are Free', 'TEXT_SPACES_FREE', '1', 'On Text pricing Spaces are Free<br /><br />0= off 1= on', 13, 36, NULL, '2007-09-26 17:05:48.69631', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (300, 'Read Only option type - Ignore for Add to Cart', 'PRODUCTS_OPTIONS_TYPE_READONLY_IGNORED', '1', 'When a Product only uses READONLY attributes, should the Add to Cart button be On or Off?<br />0= OFF<br />1= ON', 13, 37, NULL, '2007-09-26 17:05:48.700196', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (301, 'Enable GZip Compression', 'GZIP_LEVEL', '0', '0= off 1= on', 14, 1, NULL, '2007-09-26 17:05:48.705795', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (303, 'Cookie Domain', 'SESSION_USE_FQDN', 'True', 'If True the full domain name will be used to store the cookie, e.g. www.mydomain.com. If False only a partial domain name will be used, e.g. mydomain.com. If you are unsure about this, always leave set to true.', 15, 2, NULL, '2007-09-26 17:05:48.715383', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (304, 'Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', 15, 2, NULL, '2007-09-26 17:05:48.719173', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (305, 'Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', 15, 3, NULL, '2007-09-26 17:05:48.722862', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (306, 'Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', 15, 4, NULL, '2007-09-26 17:05:48.727364', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (307, 'Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', 15, 5, NULL, '2007-09-26 17:05:48.731855', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (308, 'Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'True', 'Prevent known spiders from starting a session.', 15, 6, NULL, '2007-09-26 17:05:48.741317', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (309, 'Recreate Session', 'SESSION_RECREATE', 'True', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', 15, 7, NULL, '2007-09-26 17:05:48.74507', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (310, 'IP to Host Conversion Status', 'SESSION_IP_TO_HOST_ADDRESS', 'true', 'Convert IP Address to Host Address<br /><br />Note: on some servers this can slow down the initial start of a session or execution of Emails', 15, 10, NULL, '2007-09-26 17:05:48.750459', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (311, 'Length of the redeem code', 'SECURITY_CODE_LENGTH', '10', 'Enter the length of the redeem code<br />The longer the more secure', 16, 1, NULL, '2007-09-26 17:05:48.755265', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (312, 'Default Order Status For Zero Balance Orders', 'DEFAULT_ZERO_BALANCE_ORDERS_STATUS_ID', '2', 'When an order''s balance is zero, this order status will be assigned to it.', 16, 0, NULL, '2007-09-26 17:05:48.758923', 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');
INSERT INTO zencartconfiguration VALUES (313, 'New Signup Discount Coupon ID#', 'NEW_SIGNUP_DISCOUNT_COUPON', '', 'Select the coupon<br />', 16, 75, NULL, '2007-09-26 17:05:48.76294', NULL, 'zen_cfg_select_coupon_id(');
INSERT INTO zencartconfiguration VALUES (314, 'New Signup Gift Voucher Amount', 'NEW_SIGNUP_GIFT_VOUCHER_AMOUNT', '', 'Leave blank for none<br />Or enter an amount ie. 10 for $10.00', 16, 76, NULL, '2007-09-26 17:05:48.766996', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (315, 'Maximum Discount Coupons Per Page', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS', '20', 'Number of Discount Coupons to list per Page', 16, 81, NULL, '2007-09-26 17:05:48.771814', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (316, 'Maximum Discount Coupon Report Results Per Page', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS_REPORTS', '20', 'Number of Discount Coupons to list on Reports Page', 16, 81, NULL, '2007-09-26 17:05:48.775372', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (317, 'Credit Card Enable Status - VISA', 'CC_ENABLED_VISA', '1', 'Accept VISA 0= off 1= on', 17, 1, NULL, '2007-09-26 17:05:48.778944', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (318, 'Credit Card Enable Status - MasterCard', 'CC_ENABLED_MC', '1', 'Accept MasterCard 0= off 1= on', 17, 2, NULL, '2007-09-26 17:05:48.782731', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (319, 'Credit Card Enable Status - AmericanExpress', 'CC_ENABLED_AMEX', '0', 'Accept AmericanExpress 0= off 1= on', 17, 3, NULL, '2007-09-26 17:05:48.786867', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (320, 'Credit Card Enable Status - Diners Club', 'CC_ENABLED_DINERS_CLUB', '0', 'Accept Diners Club 0= off 1= on', 17, 4, NULL, '2007-09-26 17:05:48.791489', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (321, 'Credit Card Enable Status - Discover Card', 'CC_ENABLED_DISCOVER', '0', 'Accept Discover Card 0= off 1= on', 17, 5, NULL, '2007-09-26 17:05:48.795231', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (322, 'Credit Card Enable Status - JCB', 'CC_ENABLED_JCB', '0', 'Accept JCB 0= off 1= on', 17, 6, NULL, '2007-09-26 17:05:48.798986', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (323, 'Credit Card Enable Status - AUSTRALIAN BANKCARD', 'CC_ENABLED_AUSTRALIAN_BANKCARD', '0', 'Accept AUSTRALIAN BANKCARD 0= off 1= on', 17, 7, NULL, '2007-09-26 17:05:48.802957', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (324, 'Credit Card Enable Status - SOLO', 'CC_ENABLED_SOLO', '0', 'Accept SOLO Card 0= off 1= on', 17, 8, NULL, '2007-09-26 17:05:48.806778', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (325, 'Credit Card Enable Status - Switch', 'CC_ENABLED_SWITCH', '0', 'Accept SWITCH Card 0= off 1= on', 17, 9, NULL, '2007-09-26 17:05:48.811573', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (326, 'Credit Card Enable Status - Maestro', 'CC_ENABLED_MAESTRO', '0', 'Accept MAESTRO Card 0= off 1= on', 17, 10, NULL, '2007-09-26 17:05:48.815404', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (327, 'Credit Card Enabled - Show on Payment', 'SHOW_ACCEPTED_CREDIT_CARDS', '0', 'Show accepted credit cards on Payment page?<br />0= off<br />1= As Text<br />2= As Images<br /><br />Note: images and text must be defined in both the database and language file for specific credit card types.', 17, 50, NULL, '2007-09-26 17:05:48.819258', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (328, 'This module is installed', 'MODULE_ORDER_TOTAL_GV_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (329, 'Sort Order', 'MODULE_ORDER_TOTAL_GV_SORT_ORDER', '840', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:40', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (330, 'Queue Purchases', 'MODULE_ORDER_TOTAL_GV_QUEUE', 'true', 'Do you want to queue purchases of the Gift Voucher?', 6, 3, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (331, 'Include Shipping', 'MODULE_ORDER_TOTAL_GV_INC_SHIPPING', 'true', 'Include Shipping in calculation', 6, 5, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (333, 'Re-calculate Tax', 'MODULE_ORDER_TOTAL_GV_CALC_TAX', 'None', 'Re-Calculate Tax', 6, 7, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''),');
INSERT INTO zencartconfiguration VALUES (334, 'Tax Class', 'MODULE_ORDER_TOTAL_GV_TAX_CLASS', '0', 'Use the following tax class when treating Gift Voucher as Credit Note.', 6, 0, NULL, '2003-10-30 22:16:40', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (335, 'Credit including Tax', 'MODULE_ORDER_TOTAL_GV_CREDIT_TAX', 'false', 'Add tax to purchased Gift Voucher when crediting to Account', 6, 8, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (336, 'Set Order Status', 'MODULE_ORDER_TOTAL_GV_ORDER_STATUS_ID', '0', 'Set the status of orders made where GV covers full payment', 6, 0, NULL, '2007-09-26 17:05:48.855948', 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');
INSERT INTO zencartconfiguration VALUES (337, 'This module is installed', 'MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:43', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (338, 'Sort Order', 'MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER', '400', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:43', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (339, 'Allow Low Order Fee', 'MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE', 'false', 'Do you want to allow low order fees?', 6, 3, NULL, '2003-10-30 22:16:43', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (340, 'Order Fee For Orders Under', 'MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER', '50', 'Add the low order fee to orders under this amount.', 6, 4, NULL, '2003-10-30 22:16:43', 'currencies->format', NULL);
INSERT INTO zencartconfiguration VALUES (341, 'Order Fee', 'MODULE_ORDER_TOTAL_LOWORDERFEE_FEE', '5', 'For Percentage Calculation - include a % Example: 10%<br />For a flat amount just enter the amount - Example: 5 for $5.00', 6, 5, NULL, '2003-10-30 22:16:43', '', NULL);
INSERT INTO zencartconfiguration VALUES (342, 'Attach Low Order Fee On Orders Made', 'MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION', 'both', 'Attach low order fee for orders sent to the set destination.', 6, 6, NULL, '2003-10-30 22:16:43', NULL, 'zen_cfg_select_option(array(''national'', ''international'', ''both''),');
INSERT INTO zencartconfiguration VALUES (343, 'Tax Class', 'MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS', '0', 'Use the following tax class on the low order fee.', 6, 7, NULL, '2003-10-30 22:16:43', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (344, 'No Low Order Fee on Virtual Products', 'MODULE_ORDER_TOTAL_LOWORDERFEE_VIRTUAL', 'false', 'Do not charge Low Order Fee when cart is Virtual Products Only', 6, 8, NULL, '2004-04-20 22:16:43', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (345, 'No Low Order Fee on Gift Vouchers', 'MODULE_ORDER_TOTAL_LOWORDERFEE_GV', 'false', 'Do not charge Low Order Fee when cart is Gift Vouchers Only', 6, 9, NULL, '2004-04-20 22:16:43', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (346, 'This module is installed', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:46', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (351, 'This module is installed', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:49', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (352, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '100', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:49', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (353, 'This module is installed', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:52', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (354, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '300', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:52', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (355, 'This module is installed', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:55', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (356, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '999', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:55', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (357, 'Tax Class', 'MODULE_ORDER_TOTAL_COUPON_TAX_CLASS', '0', 'Use the following tax class when treating Discount Coupon as Credit Note.', 6, 0, NULL, '2003-10-30 22:16:36', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (358, 'Include Tax', 'MODULE_ORDER_TOTAL_COUPON_INC_TAX', 'false', 'Include Tax in calculation.', 6, 6, NULL, '2003-10-30 22:16:36', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (359, 'Sort Order', 'MODULE_ORDER_TOTAL_COUPON_SORT_ORDER', '280', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (360, 'Include Shipping', 'MODULE_ORDER_TOTAL_COUPON_INC_SHIPPING', 'false', 'Include Shipping in calculation', 6, 5, NULL, '2003-10-30 22:16:36', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (361, 'This module is installed', 'MODULE_ORDER_TOTAL_COUPON_STATUS', 'true', '', 6, 1, NULL, '2003-10-30 22:16:36', NULL, 'zen_cfg_select_option(array(''true''),');
INSERT INTO zencartconfiguration VALUES (362, 'Re-calculate Tax', 'MODULE_ORDER_TOTAL_COUPON_CALC_TAX', 'Standard', 'Re-Calculate Tax', 6, 7, NULL, '2003-10-30 22:16:36', NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''),');
INSERT INTO zencartconfiguration VALUES (363, 'Admin Demo Status', 'ADMIN_DEMO', '0', 'Admin Demo should be on?<br />0= off 1= on', 6, 0, NULL, '2007-09-26 17:05:48.968801', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (364, 'Product option type Select', 'PRODUCTS_OPTIONS_TYPE_SELECT', '0', 'The number representing the Select type of product option.', 0, NULL, '2007-09-26 17:05:48.972724', '2007-09-26 17:05:48.972724', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (365, 'Text product option type', 'PRODUCTS_OPTIONS_TYPE_TEXT', '1', 'Numeric value of the text product option type', 6, NULL, '2007-09-26 17:05:48.97631', '2007-09-26 17:05:48.97631', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (366, 'Radio button product option type', 'PRODUCTS_OPTIONS_TYPE_RADIO', '2', 'Numeric value of the radio button product option type', 6, NULL, '2007-09-26 17:05:48.97981', '2007-09-26 17:05:48.97981', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (367, 'Check box product option type', 'PRODUCTS_OPTIONS_TYPE_CHECKBOX', '3', 'Numeric value of the check box product option type', 6, NULL, '2007-09-26 17:05:48.984221', '2007-09-26 17:05:48.984221', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (368, 'File product option type', 'PRODUCTS_OPTIONS_TYPE_FILE', '4', 'Numeric value of the file product option type', 6, NULL, '2007-09-26 17:05:48.988211', '2007-09-26 17:05:48.988211', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (369, 'ID for text and file products options values', 'PRODUCTS_OPTIONS_VALUES_TEXT_ID', '0', 'Numeric value of the products_options_values_id used by the text and file attributes.', 6, NULL, '2007-09-26 17:05:48.992412', '2007-09-26 17:05:48.992412', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (370, 'Upload prefix', 'UPLOAD_PREFIX', 'upload_', 'Prefix used to differentiate between upload options and other options', 0, NULL, '2007-09-26 17:05:48.996053', '2007-09-26 17:05:48.996053', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (371, 'Text prefix', 'TEXT_PREFIX', 'txt_', 'Prefix used to differentiate between text option values and other option values', 0, NULL, '2007-09-26 17:05:48.999725', '2007-09-26 17:05:48.999725', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (372, 'Read Only option type', 'PRODUCTS_OPTIONS_TYPE_READONLY', '5', 'Numeric value of the file product option type', 6, NULL, '2007-09-26 17:05:49.004181', '2007-09-26 17:05:49.004181', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (373, 'Products Info - Products Option Name Sort Order', 'PRODUCTS_OPTIONS_SORT_ORDER', '0', 'Sort order of Option Names for Products Info<br />0= Sort Order, Option Name<br />1= Option Name', 18, 35, '2007-09-26 17:05:49.008246', '2007-09-26 17:05:49.008246', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (374, 'Products Info - Product Option Value of Attributes Sort Order', 'PRODUCTS_OPTIONS_SORT_BY_PRICE', '1', 'Sort order of Product Option Values of Attributes for Products Info<br />0= Sort Order, Price<br />1= Sort Order, Option Value Name', 18, 36, '2007-09-26 17:05:49.017551', '2007-09-26 17:05:49.017551', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (375, 'Product Info - Show Option Values Name Below Attributes Image', 'PRODUCT_IMAGES_ATTRIBUTES_NAMES', '1', 'Product Info - Show the name of the Option Value beneath the Attribute Image?<br />0= off 1= on', 18, 41, NULL, '2007-09-26 17:05:49.021375', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (376, 'Product Info - Show Sales Discount Savings Status', 'SHOW_SALE_DISCOUNT_STATUS', '1', 'Product Info - Show the amount of discount savings?<br />0= off 1= on', 18, 45, NULL, '2007-09-26 17:05:49.025616', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (377, 'Product Info - Show Sales Discount Savings Dollars or Percentage', 'SHOW_SALE_DISCOUNT', '1', 'Product Info - Show the amount of discount savings display as:<br />1= % off 2= $amount off', 18, 46, NULL, '2007-09-26 17:05:49.030294', NULL, 'zen_cfg_select_option(array(''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (378, 'Product Info - Show Sales Discount Savings Percentage Decimals', 'SHOW_SALE_DISCOUNT_DECIMALS', '0', 'Product Info - Show discount savings display as a Percentage with how many decimals?:<br />Default= 0', 18, 47, NULL, '2007-09-26 17:05:49.034242', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (379, 'Product Info - Price is Free Image or Text Status', 'OTHER_IMAGE_PRICE_IS_FREE_ON', '1', 'Product Info - Show the Price is Free Image or Text on Displayed Price<br />0= Text<br />1= Image', 18, 50, NULL, '2007-09-26 17:05:49.037948', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (380, 'Product Info - Price is Call for Price Image or Text Status', 'PRODUCTS_PRICE_IS_CALL_IMAGE_ON', '1', 'Product Info - Show the Price is Call for Price Image or Text on Displayed Price<br />0= Text<br />1= Image', 18, 51, NULL, '2007-09-26 17:05:49.041675', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (381, 'Product Quantity Box Status - Adding New Products', 'PRODUCTS_QTY_BOX_STATUS', '1', 'What should the Default Quantity Box Status be set to when adding New Products?<br /><br />0= off<br />1= on<br />NOTE: This will show a Qty Box when ON and default the Add to Cart to 1', 18, 55, NULL, '2007-09-26 17:05:49.045631', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (382, 'Product Reviews Require Approval', 'REVIEWS_APPROVAL', '1', 'Do product reviews require approval?<br /><br />Note: When Review Status is off, it will also not show<br /><br />0= off 1= on', 18, 62, NULL, '2007-09-26 17:05:49.050855', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (383, 'Meta Tags - Include Product Model in Title', 'META_TAG_INCLUDE_MODEL', '1', 'Do you want to include the Product Model in the Meta Tag Title?<br /><br />0= off 1= on', 18, 69, NULL, '2007-09-26 17:05:49.05531', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (384, 'Meta Tags - Include Product Price in Title', 'META_TAG_INCLUDE_PRICE', '1', 'Do you want to include the Product Price in the Meta Tag Title?<br /><br />0= off 1= on', 18, 70, NULL, '2007-09-26 17:05:49.059021', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (385, 'Meta Tags Generated Description Maximum Length?', 'MAX_META_TAG_DESCRIPTION_LENGTH', '50', 'Set Generated Meta Tag Description Maximum Length to (words) Default 50:', 18, 71, NULL, '2007-09-26 17:05:49.062716', '', '');
INSERT INTO zencartconfiguration VALUES (386, 'Also Purchased Products Columns per Row', 'SHOW_PRODUCT_INFO_COLUMNS_ALSO_PURCHASED_PRODUCTS', '3', 'Also Purchased Products Columns per Row<br />0= off or set the sort order', 18, 72, NULL, '2007-09-26 17:05:49.066574', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');
INSERT INTO zencartconfiguration VALUES (387, 'Previous Next - Navigation Bar Position', 'PRODUCT_INFO_PREVIOUS_NEXT', '1', 'Location of Previous/Next Navigation Bar<br />0= off<br />1= Top of Page<br />2= Bottom of Page<br />3= Both Top and Bottom of Page', 18, 21, '2007-09-26 17:05:49.071684', '2007-09-26 17:05:49.071684', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''Top of Page''), array(''id''=>''2'', ''text''=>''Bottom of Page''), array(''id''=>''3'', ''text''=>''Both Top & Bottom of Page'')),');
INSERT INTO zencartconfiguration VALUES (388, 'Previous Next - Sort Order', 'PRODUCT_INFO_PREVIOUS_NEXT_SORT', '1', 'Products Display Order by<br />0= Product ID<br />1= Product Name<br />2= Model<br />3= Price, Product Name<br />4= Price, Model<br />5= Product Name, Model<br />6= Product Sort Order', 18, 22, '2007-09-26 17:05:49.075959', '2007-09-26 17:05:49.075959', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Product ID''), array(''id''=>''1'', ''text''=>''Name''), array(''id''=>''2'', ''text''=>''Product Model''), array(''id''=>''3'', ''text''=>''Product Price - Name''), array(''id''=>''4'', ''text''=>''Product Price - Model''), array(''id''=>''5'', ''text''=>''Product Name - Model''), array(''id''=>''6'', ''text''=>''Product Sort Order'')),');
INSERT INTO zencartconfiguration VALUES (389, 'Previous Next - Button and Image Status', 'SHOW_PREVIOUS_NEXT_STATUS', '0', 'Button and Product Image status settings are:<br />0= Off<br />1= On', 18, 20, '2007-09-26 17:05:49.079827', '2007-09-26 17:05:49.079827', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''On'')),');
INSERT INTO zencartconfiguration VALUES (390, 'Previous Next - Button and Image Settings', 'SHOW_PREVIOUS_NEXT_IMAGES', '0', 'Show Previous/Next Button and Product Image Settings<br />0= Button Only<br />1= Button and Product Image<br />2= Product Image Only', 18, 21, '2007-09-26 17:05:49.083638', '2007-09-26 17:05:49.083638', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Button Only''), array(''id''=>''1'', ''text''=>''Button and Product Image''), array(''id''=>''2'', ''text''=>''Product Image Only'')),');
INSERT INTO zencartconfiguration VALUES (391, 'Previous Next - Image Width?', 'PREVIOUS_NEXT_IMAGE_WIDTH', '50', 'Previous/Next Image Width?', 18, 22, NULL, '2007-09-26 17:05:49.087816', '', '');
INSERT INTO zencartconfiguration VALUES (392, 'Previous Next - Image Height?', 'PREVIOUS_NEXT_IMAGE_HEIGHT', '40', 'Previous/Next Image Height?', 18, 23, NULL, '2007-09-26 17:05:49.092691', '', '');
INSERT INTO zencartconfiguration VALUES (393, 'Previous Next - Navigation Includes Category Position', 'PRODUCT_INFO_CATEGORIES', '1', 'Product''s Category Image and Name Alignment Above Previous/Next Navigation Bar<br />0= off<br />1= Align Left<br />2= Align Center<br />3= Align Right', 18, 20, '2007-09-26 17:05:49.096503', '2007-09-26 17:05:49.096503', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''Align Left''), array(''id''=>''2'', ''text''=>''Align Center''), array(''id''=>''3'', ''text''=>''Align Right'')),');
INSERT INTO zencartconfiguration VALUES (394, 'Previous Next - Navigation Includes Category Name and Image Status', 'PRODUCT_INFO_CATEGORIES_IMAGE_STATUS', '2', 'Product''s Category Image and Name Status<br />0= Category Name and Image always shows<br />1= Category Name only<br />2= Category Name and Image when not blank', 18, 20, '2007-09-26 17:05:49.100538', '2007-09-26 17:05:49.100538', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Category Name and Image Always''), array(''id''=>''1'', ''text''=>''Category Name only''), array(''id''=>''2'', ''text''=>''Category Name and Image when not blank'')),');
INSERT INTO zencartconfiguration VALUES (395, 'Column Width - Left Boxes', 'BOX_WIDTH_LEFT', '150px', 'Width of the Left Column Boxes<br />px may be included<br />Default = 150px', 19, 1, NULL, '2003-11-21 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (396, 'Column Width - Right Boxes', 'BOX_WIDTH_RIGHT', '150px', 'Width of the Right Column Boxes<br />px may be included<br />Default = 150px', 19, 2, NULL, '2003-11-21 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (397, 'Bread Crumbs Navigation Separator', 'BREAD_CRUMBS_SEPARATOR', '&nbsp;::&nbsp;', 'Enter the separator symbol to appear between the Navigation Bread Crumb trail<br />Note: Include spaces with the &amp;nbsp; symbol if you want them part of the separator.<br />Default = &amp;nbsp;::&amp;nbsp;', 19, 3, NULL, '2003-11-21 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (398, 'Define Breadcrumb Status', 'DEFINE_BREADCRUMB_STATUS', '1', 'Enable the Breadcrumb Trail Links?<br />0= OFF<br />1= ON<br />2= Off for Home Page Only', 19, 4, NULL, '2007-09-26 17:05:49.117235', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (399, 'Bestsellers - Number Padding', 'BEST_SELLERS_FILLER', '&nbsp;', 'What do you want to Pad the numbers with?<br />Default = &amp;nbsp;', 19, 5, NULL, '2003-11-21 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (400, 'Bestsellers - Truncate Product Names', 'BEST_SELLERS_TRUNCATE', '35', 'What size do you want to truncate the Product Names?<br />Default = 35', 19, 6, NULL, '2003-11-21 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (401, 'Bestsellers - Truncate Product Names followed by ...', 'BEST_SELLERS_TRUNCATE_MORE', 'true', 'When truncated Product Names follow with ...<br />Default = true', 19, 7, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (402, 'Categories Box - Show Specials Link', 'SHOW_CATEGORIES_BOX_SPECIALS', 'true', 'Show Specials Link in the Categories Box', 19, 8, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (403, 'Categories Box - Show Products New Link', 'SHOW_CATEGORIES_BOX_PRODUCTS_NEW', 'true', 'Show Products New Link in the Categories Box', 19, 9, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (404, 'Shopping Cart Box Status', 'SHOW_SHOPPING_CART_BOX_STATUS', '1', 'Shopping Cart Shows<br />0= Always<br />1= Only when full<br />2= Only when full but not when viewing the Shopping Cart', 19, 10, NULL, '2007-09-26 17:05:49.141389', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (405, 'Categories Box - Show Featured Products Link', 'SHOW_CATEGORIES_BOX_FEATURED_PRODUCTS', 'true', 'Show Featured Products Link in the Categories Box', 19, 11, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (406, 'Categories Box - Show Products All Link', 'SHOW_CATEGORIES_BOX_PRODUCTS_ALL', 'true', 'Show Products All Link in the Categories Box', 19, 12, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (407, 'Column Left Status - Global', 'COLUMN_LEFT_STATUS', '1', 'Show Column Left, unless page override exists?<br />0= Column Left is always off<br />1= Column Left is on, unless page override', 19, 15, NULL, '2007-09-26 17:05:49.154095', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (408, 'Column Right Status - Global', 'COLUMN_RIGHT_STATUS', '1', 'Show Column Right, unless page override exists?<br />0= Column Right is always off<br />1= Column Right is on, unless page override', 19, 16, NULL, '2007-09-26 17:05:49.159009', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (409, 'Column Width - Left', 'COLUMN_WIDTH_LEFT', '150px', 'Width of the Left Column<br />px may be included<br />Default = 150px', 19, 20, NULL, '2003-11-21 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (410, 'Column Width - Right', 'COLUMN_WIDTH_RIGHT', '150px', 'Width of the Right Column<br />px may be included<br />Default = 150px', 19, 21, NULL, '2003-11-21 22:16:36', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (411, 'Categories Separator between links Status', 'SHOW_CATEGORIES_SEPARATOR_LINK', '1', 'Show Category Separator between Category Names and Links?<br />0= off<br />1= on', 19, 24, NULL, '2007-09-26 17:05:49.170708', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (412, 'Categories Separator between the Category Name and Count', 'CATEGORIES_SEPARATOR', '-&gt;', 'What separator do you want between the Category name and the count?<br />Default = -&amp;gt;', 19, 25, NULL, '2003-11-21 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (413, 'Categories Separator between the Category Name and Sub Categories', 'CATEGORIES_SEPARATOR_SUBS', '|_&nbsp;', 'What separator do you want between the Category name and Sub Category Name?<br />Default = |_&amp;nbsp;', 19, 26, NULL, '2004-03-25 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (414, 'Categories Count Prefix', 'CATEGORIES_COUNT_PREFIX', '&nbsp;(', 'What do you want to Prefix the count with?<br />Default= (', 19, 27, NULL, '2003-01-21 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (415, 'Categories Count Suffix', 'CATEGORIES_COUNT_SUFFIX', ')', 'What do you want as a Suffix to the count?<br />Default= )', 19, 28, NULL, '2003-01-21 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (416, 'Categories SubCategories Indent', 'CATEGORIES_SUBCATEGORIES_INDENT', '&nbsp;&nbsp;', 'What do you want to use as the subcategories indent?<br />Default= &nbsp;&nbsp;', 19, 29, NULL, '2004-06-24 22:16:36', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (417, 'Categories with 0 Products Status', 'CATEGORIES_COUNT_ZERO', '0', 'Show Category Count for 0 Products?<br />0= off<br />1= on', 19, 30, NULL, '2007-09-26 17:05:49.193886', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (418, 'Split Categories Box', 'CATEGORIES_SPLIT_DISPLAY', 'True', 'Split the categories box display by product type', 19, 31, NULL, '2007-09-26 17:05:49.198606', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (419, 'Shopping Cart - Show Totals', 'SHOW_TOTALS_IN_CART', '1', 'Show Totals Above Shopping Cart?<br />0= off<br />1= on: Items Weight Amount<br />2= on: Items Weight Amount, but no weight when 0<br />3= on: Items Amount', 19, 31, NULL, '2007-09-26 17:05:49.202482', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (420, 'Customer Greeting - Show on Index Page', 'SHOW_CUSTOMER_GREETING', '1', 'Always Show Customer Greeting on Index?<br />0= off<br />1= on', 19, 40, NULL, '2007-09-26 17:05:49.206312', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (421, 'Categories - Always Show on Main Page', 'SHOW_CATEGORIES_ALWAYS', '0', 'Always Show Categories on Main Page<br />0= off<br />1= on<br />Default category can be set to Top Level or a Specific Top Level', 19, 45, NULL, '2007-09-26 17:05:49.211388', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (422, 'Main Page - Opens with Category', 'CATEGORIES_START_MAIN', '0', '0= Top Level Categories<br />Or enter the Category ID#<br />Note: Sub Categories can also be used Example: 3_10', 19, 46, NULL, '2007-09-26 17:05:49.215221', '', '');
INSERT INTO zencartconfiguration VALUES (423, 'Categories - Always Open to Show SubCategories', 'SHOW_CATEGORIES_SUBCATEGORIES_ALWAYS', '1', 'Always Show Categories and SubCategories<br />0= off, just show Top Categories<br />1= on, Always show Categories and SubCategories when selected', 19, 47, NULL, '2007-09-26 17:05:49.219734', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (424, 'Banner Display Groups - Header Position 1', 'SHOW_BANNERS_GROUP_SET1', '', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 1?<br />Leave blank for none', 19, 55, NULL, '2007-09-26 17:05:49.223795', '', '');
INSERT INTO zencartconfiguration VALUES (425, 'Banner Display Groups - Header Position 2', 'SHOW_BANNERS_GROUP_SET2', '', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 2?<br />Leave blank for none', 19, 56, NULL, '2007-09-26 17:05:49.227473', '', '');
INSERT INTO zencartconfiguration VALUES (426, 'Banner Display Groups - Header Position 3', 'SHOW_BANNERS_GROUP_SET3', '', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 3?<br />Leave blank for none', 19, 57, NULL, '2007-09-26 17:05:49.23186', '', '');
INSERT INTO zencartconfiguration VALUES (427, 'Banner Display Groups - Footer Position 1', 'SHOW_BANNERS_GROUP_SET4', '', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 1?<br />Leave blank for none', 19, 65, NULL, '2007-09-26 17:05:49.235629', '', '');
INSERT INTO zencartconfiguration VALUES (428, 'Banner Display Groups - Footer Position 2', 'SHOW_BANNERS_GROUP_SET5', '', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 2?<br />Leave blank for none', 19, 66, NULL, '2007-09-26 17:05:49.24068', '', '');
INSERT INTO zencartconfiguration VALUES (429, 'Banner Display Groups - Footer Position 3', 'SHOW_BANNERS_GROUP_SET6', 'Wide-Banners', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />Default Group is Wide-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 3?<br />Leave blank for none', 19, 67, NULL, '2007-09-26 17:05:49.251282', '', '');
INSERT INTO zencartconfiguration VALUES (430, 'Banner Display Groups - Side Box banner_box', 'SHOW_BANNERS_GROUP_SET7', 'SideBox-Banners', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br />Default Group is SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Side Box - banner_box?<br />Leave blank for none', 19, 70, NULL, '2007-09-26 17:05:49.254941', '', '');
INSERT INTO zencartconfiguration VALUES (431, 'Banner Display Groups - Side Box banner_box2', 'SHOW_BANNERS_GROUP_SET8', 'SideBox-Banners', 'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br />Default Group is SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Side Box - banner_box2?<br />Leave blank for none', 19, 71, NULL, '2007-09-26 17:05:49.25854', '', '');
INSERT INTO zencartconfiguration VALUES (432, 'Banner Display Group - Side Box banner_box_all', 'SHOW_BANNERS_GROUP_SET_ALL', 'BannersAll', 'The Banner Display Group may only be from one (1) Banner Group for the Banner All sidebox<br /><br />Default Group is BannersAll<br /><br />What Banner Group do you want to use in the Side Box - banner_box_all?<br />Leave blank for none', 19, 72, NULL, '2007-09-26 17:05:49.262937', '', '');
INSERT INTO zencartconfiguration VALUES (433, 'Footer - Show IP Address status', 'SHOW_FOOTER_IP', '1', 'Show Customer IP Address in the Footer<br />0= off<br />1= on<br />Should the Customer IP Address show in the footer?', 19, 80, NULL, '2007-09-26 17:05:49.266984', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (434, 'Product Discount Quantities - Add how many blank discounts?', 'DISCOUNT_QTY_ADD', '5', 'How many blank discount quantities should be added for Product Pricing?', 19, 90, NULL, '2007-09-26 17:05:49.271312', '', '');
INSERT INTO zencartconfiguration VALUES (435, 'Product Discount Quantities - Display how many per row?', 'DISCOUNT_QUANTITY_PRICES_COLUMN', '5', 'How many discount quantities should show per row on Product Info Pages?', 19, 95, NULL, '2007-09-26 17:05:49.274924', '', '');
INSERT INTO zencartconfiguration VALUES (436, 'Categories/Products Display Sort Order', 'CATEGORIES_PRODUCTS_SORT_ORDER', '0', 'Categories/Products Display Sort Order<br />0= Categories/Products Sort Order/Name<br />1= Categories/Products Name<br />2= Products Model<br />3= Products Qty+, Products Name<br />4= Products Qty-, Products Name<br />5= Products Price+, Products Name<br />6= Products Price+, Products Name', 19, 100, NULL, '2007-09-26 17:05:49.278841', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4'', ''5'', ''6''), ');
INSERT INTO zencartconfiguration VALUES (437, 'Option Names and Values Global Add, Copy and Delete Features Status', 'OPTION_NAMES_VALUES_GLOBAL_STATUS', '1', 'Option Names and Values Global Add, Copy and Delete Features Status<br />0= Hide Features<br />1= Show Features<br />2= Products Model', 19, 110, NULL, '2007-09-26 17:05:49.284127', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (438, 'Categories-Tabs Menu ON/OFF', 'CATEGORIES_TABS_STATUS', '1', 'Categories-Tabs<br />This enables the display of your store''s categories as a menu across the top of your header. There are many potential creative uses for this.<br />0= Hide Categories Tabs<br />1= Show Categories Tabs', 19, 112, NULL, '2007-09-26 17:05:49.288809', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (439, 'Site Map - include My Account Links?', 'SHOW_ACCOUNT_LINKS_ON_SITE_MAP', 'No', 'Should the links to My Account show up on the site-map?<br />Note: Spiders will try to index this page, and likely should not be sent to secure pages, since there is no benefit in indexing a login page.<br /><br />Default: false', 19, 115, NULL, '2007-09-26 17:05:49.29348', NULL, 'zen_cfg_select_option(array(''Yes'', ''No''), ');
INSERT INTO zencartconfiguration VALUES (440, 'Skip 1-prod Categories', 'SKIP_SINGLE_PRODUCT_CATEGORIES', 'True', 'Skip single-product categories<br />If this option is set to True, then if the customer clicks on a link to a category which only contains a single item, then Zen Cart will take them directly to that product-page, rather than present them with another link to click in order to see the product.<br />Default: True', 19, 120, NULL, '2007-09-26 17:05:49.297922', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (441, 'Use split-login page', 'USE_SPLIT_LOGIN_MODE', 'False', 'The login page can be displayed in two modes: Split or Vertical.<br />In Split mode, the create-account options are accessed by clicking a button to get to the create-account page.  In Vertical mode, the create-account input fields are all displayed inline, below the login field, making one less click for the customer to create their account.<br />Default: False', 19, 121, NULL, '2007-09-26 17:05:49.303382', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (442, 'CSS Buttons', 'IMAGE_USE_CSS_BUTTONS', 'No', 'CSS Buttons<br />Use CSS buttons instead of images (GIF/JPG)?<br />Button styles must be configured in the stylesheet if you enable this option.', 19, 147, NULL, '2007-09-26 17:05:49.307878', NULL, 'zen_cfg_select_option(array(''No'', ''Yes''), ');
INSERT INTO zencartconfiguration VALUES (443, '<strong>Down for Maintenance: ON/OFF</strong>', 'DOWN_FOR_MAINTENANCE', 'false', 'Down for Maintenance <br />(true=on false=off)', 20, 1, NULL, '2007-09-26 17:05:49.312845', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (444, 'Down for Maintenance: filename', 'DOWN_FOR_MAINTENANCE_FILENAME', 'down_for_maintenance', 'Down for Maintenance filename<br />Note: Do not include the extension<br />Default=down_for_maintenance', 20, 2, NULL, '2007-09-26 17:05:49.317412', NULL, '');
INSERT INTO zencartconfiguration VALUES (445, 'Down for Maintenance: Hide Header', 'DOWN_FOR_MAINTENANCE_HEADER_OFF', 'false', 'Down for Maintenance: Hide Header <br />(true=hide false=show)', 20, 3, NULL, '2007-09-26 17:05:49.321558', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (446, 'Down for Maintenance: Hide Column Left', 'DOWN_FOR_MAINTENANCE_COLUMN_LEFT_OFF', 'false', 'Down for Maintenance: Hide Column Left <br />(true=hide false=show)', 20, 4, NULL, '2007-09-26 17:05:49.326535', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (447, 'Down for Maintenance: Hide Column Right', 'DOWN_FOR_MAINTENANCE_COLUMN_RIGHT_OFF', 'false', 'Down for Maintenance: Hide Column Right <br />(true=hide false=show)', 20, 5, NULL, '2007-09-26 17:05:49.331454', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (448, 'Down for Maintenance: Hide Footer', 'DOWN_FOR_MAINTENANCE_FOOTER_OFF', 'false', 'Down for Maintenance: Hide Footer <br />(true=hide false=show)', 20, 6, NULL, '2007-09-26 17:05:49.342872', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (449, 'Down for Maintenance: Hide Prices', 'DOWN_FOR_MAINTENANCE_PRICES_OFF', 'false', 'Down for Maintenance: Hide Prices <br />(true=hide false=show)', 20, 7, NULL, '2007-09-26 17:05:49.347696', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (450, 'Down For Maintenance (exclude this IP-Address)', 'EXCLUDE_ADMIN_IP_FOR_MAINTENANCE', 'your IP (ADMIN)', 'This IP Address is able to access the website while it is Down For Maintenance (like webmaster)<br />To enter multiple IP Addresses, separate with a comma. If you do not know your IP Address, check in the Footer of your Shop.', 20, 8, '2003-03-21 13:43:22', '2003-03-21 21:20:07', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (451, 'NOTICE PUBLIC Before going Down for Maintenance: ON/OFF', 'WARN_BEFORE_DOWN_FOR_MAINTENANCE', 'false', 'Give a WARNING some time before you put your website Down for Maintenance<br />(true=on false=off)<br />If you set the ''Down For Maintenance: ON/OFF'' to true this will automaticly be updated to false', 20, 9, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (452, 'Date and hours for notice before maintenance', 'PERIOD_BEFORE_DOWN_FOR_MAINTENANCE', '15/05/2003  2-3 PM', 'Date and hours for notice before maintenance website, enter date and hours for maintenance website', 20, 10, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (453, 'Display when webmaster has enabled maintenance', 'DISPLAY_MAINTENANCE_TIME', 'false', 'Display when Webmaster has enabled maintenance <br />(true=on false=off)<br />', 20, 11, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (454, 'Display website maintenance period', 'DISPLAY_MAINTENANCE_PERIOD', 'false', 'Display Website maintenance period <br />(true=on false=off)<br />', 20, 12, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (455, 'Website maintenance period', 'TEXT_MAINTENANCE_PERIOD_TIME', '2h00', 'Enter Website Maintenance period (hh:mm)', 20, 13, '2003-03-21 13:08:25', '2003-03-21 11:42:47', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (456, 'Confirm Terms and Conditions During Checkout Procedure', 'DISPLAY_CONDITIONS_ON_CHECKOUT', 'false', 'Show the Terms and Conditions during the checkout procedure which the customer must agree to.', 11, 1, NULL, '2007-09-26 17:05:49.380471', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (457, 'Confirm Privacy Notice During Account Creation Procedure', 'DISPLAY_PRIVACY_CONDITIONS', 'false', 'Show the Privacy Notice during the account creation procedure which the customer must agree to.', 11, 2, NULL, '2007-09-26 17:05:49.384946', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (458, 'Display Product Image', 'PRODUCT_NEW_LIST_IMAGE', '1102', 'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 1, NULL, '2007-09-26 17:05:49.390771', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (459, 'Display Product Quantity', 'PRODUCT_NEW_LIST_QUANTITY', '1202', 'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 2, NULL, '2007-09-26 17:05:49.401379', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (460, 'Display Product Buy Now Button', 'PRODUCT_NEW_BUY_NOW', '1300', 'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 3, NULL, '2007-09-26 17:05:49.405712', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (461, 'Display Product Name', 'PRODUCT_NEW_LIST_NAME', '2101', 'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 4, NULL, '2007-09-26 17:05:49.418317', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (462, 'Display Product Model', 'PRODUCT_NEW_LIST_MODEL', '2201', 'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 5, NULL, '2007-09-26 17:05:49.422436', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (463, 'Display Product Manufacturer Name', 'PRODUCT_NEW_LIST_MANUFACTURER', '2302', 'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 6, NULL, '2007-09-26 17:05:49.426633', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (464, 'Display Product Price', 'PRODUCT_NEW_LIST_PRICE', '2402', 'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 7, NULL, '2007-09-26 17:05:49.431876', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (465, 'Display Product Weight', 'PRODUCT_NEW_LIST_WEIGHT', '2502', 'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 8, NULL, '2007-09-26 17:05:49.436115', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (466, 'Display Product Date Added', 'PRODUCT_NEW_LIST_DATE_ADDED', '2601', 'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 21, 9, NULL, '2007-09-26 17:05:49.440279', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (467, 'Display Product Description', 'PRODUCT_NEW_LIST_DESCRIPTION', '1', 'Do you want to display the Product Description - First 150 characters?<br />0= off<br />1= on', 21, 10, NULL, '2007-09-26 17:05:49.444631', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (468, 'Display Product Display - Default Sort Order', 'PRODUCT_NEW_LIST_SORT_DEFAULT', '6', 'What Sort Order Default should be used for New Products Display?<br />Default= 6 for Date New to Old<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', 21, 11, NULL, '2007-09-26 17:05:49.449805', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');
INSERT INTO zencartconfiguration VALUES (469, 'Default Products New Group ID', 'PRODUCT_NEW_LIST_GROUP_ID', '21', 'Warning: Only change this if your Products New Group ID has changed from the default of 21<br />What is the configuration_group_id for New Products Listings?', 21, 12, NULL, '2007-09-26 17:05:49.455869', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (470, 'Display Multiple Products Qty Box Status and Set Button Location', 'PRODUCT_NEW_LISTING_MULTIPLE_ADD_TO_CART', '3', 'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', 21, 25, NULL, '2007-09-26 17:05:49.460304', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (471, 'Mask Upcoming Products from being include as New Products', 'SHOW_NEW_PRODUCTS_UPCOMING_MASKED', '0', 'Do you want to mask Upcoming Products from being included as New Products in Listing, Sideboxes and Centerbox?<br />0= off<br />1= on', 21, 30, NULL, '2007-09-26 17:05:49.464758', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (472, 'Display Product Image', 'PRODUCT_FEATURED_LIST_IMAGE', '1102', 'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 1, NULL, '2007-09-26 17:05:49.469871', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (473, 'Display Product Quantity', 'PRODUCT_FEATURED_LIST_QUANTITY', '1202', 'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 2, NULL, '2007-09-26 17:05:49.476541', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (474, 'Display Product Buy Now Button', 'PRODUCT_FEATURED_BUY_NOW', '1300', 'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 3, NULL, '2007-09-26 17:05:49.480653', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (475, 'Display Product Name', 'PRODUCT_FEATURED_LIST_NAME', '2101', 'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 4, NULL, '2007-09-26 17:05:49.485023', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (476, 'Display Product Model', 'PRODUCT_FEATURED_LIST_MODEL', '2201', 'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 5, NULL, '2007-09-26 17:05:49.489639', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (477, 'Display Product Manufacturer Name', 'PRODUCT_FEATURED_LIST_MANUFACTURER', '2302', 'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 6, NULL, '2007-09-26 17:05:49.494318', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (478, 'Display Product Price', 'PRODUCT_FEATURED_LIST_PRICE', '2402', 'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 7, NULL, '2007-09-26 17:05:49.498532', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (479, 'Display Product Weight', 'PRODUCT_FEATURED_LIST_WEIGHT', '2502', 'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 8, NULL, '2007-09-26 17:05:49.502906', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (480, 'Display Product Date Added', 'PRODUCT_FEATURED_LIST_DATE_ADDED', '2601', 'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 22, 9, NULL, '2007-09-26 17:05:49.507028', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (481, 'Display Product Description', 'PRODUCT_FEATURED_LIST_DESCRIPTION', '1', 'Do you want to display the Product Description - First 150 characters?', 22, 10, NULL, '2007-09-26 17:05:49.511615', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (482, 'Display Product Display - Default Sort Order', 'PRODUCT_FEATURED_LIST_SORT_DEFAULT', '1', 'What Sort Order Default should be used for Featured Product Display?<br />Default= 1 for Product Name<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', 22, 11, NULL, '2007-09-26 17:05:49.516778', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');
INSERT INTO zencartconfiguration VALUES (483, 'Default Featured Products Group ID', 'PRODUCT_FEATURED_LIST_GROUP_ID', '22', 'Warning: Only change this if your Featured Products Group ID has changed from the default of 22<br />What is the configuration_group_id for Featured Products Listings?', 22, 12, NULL, '2007-09-26 17:05:49.521335', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (484, 'Display Multiple Products Qty Box Status and Set Button Location', 'PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART', '3', 'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', 22, 25, NULL, '2007-09-26 17:05:49.525671', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (485, 'Display Product Image', 'PRODUCT_ALL_LIST_IMAGE', '1102', 'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 1, NULL, '2007-09-26 17:05:49.530413', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (486, 'Display Product Quantity', 'PRODUCT_ALL_LIST_QUANTITY', '1202', 'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 2, NULL, '2007-09-26 17:05:49.53461', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (487, 'Display Product Buy Now Button', 'PRODUCT_ALL_BUY_NOW', '1300', 'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 3, NULL, '2007-09-26 17:05:49.539306', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (488, 'Display Product Name', 'PRODUCT_ALL_LIST_NAME', '2101', 'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 4, NULL, '2007-09-26 17:05:49.543428', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (489, 'Display Product Model', 'PRODUCT_ALL_LIST_MODEL', '2201', 'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 5, NULL, '2007-09-26 17:05:49.547505', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (490, 'Display Product Manufacturer Name', 'PRODUCT_ALL_LIST_MANUFACTURER', '2302', 'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 6, NULL, '2007-09-26 17:05:49.552169', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (491, 'Display Product Price', 'PRODUCT_ALL_LIST_PRICE', '2402', 'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 7, NULL, '2007-09-26 17:05:49.556289', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (492, 'Display Product Weight', 'PRODUCT_ALL_LIST_WEIGHT', '2502', 'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 8, NULL, '2007-09-26 17:05:49.561108', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (493, 'Display Product Date Added', 'PRODUCT_ALL_LIST_DATE_ADDED', '2601', 'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', 23, 9, NULL, '2007-09-26 17:05:49.565451', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (494, 'Display Product Description', 'PRODUCT_ALL_LIST_DESCRIPTION', '1', 'Do you want to display the Product Description - First 150 characters?', 23, 10, NULL, '2007-09-26 17:05:49.570091', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (495, 'Display Product Display - Default Sort Order', 'PRODUCT_ALL_LIST_SORT_DEFAULT', '1', 'What Sort Order Default should be used for All Products Display?<br />Default= 1 for Product Name<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', 23, 11, NULL, '2007-09-26 17:05:49.574495', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');
INSERT INTO zencartconfiguration VALUES (496, 'Default Products All Group ID', 'PRODUCT_ALL_LIST_GROUP_ID', '23', 'Warning: Only change this if your Products All Group ID has changed from the default of 23<br />What is the configuration_group_id for Products All Listings?', 23, 12, NULL, '2007-09-26 17:05:49.579996', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (497, 'Display Multiple Products Qty Box Status and Set Button Location', 'PRODUCT_ALL_LISTING_MULTIPLE_ADD_TO_CART', '3', 'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', 23, 25, NULL, '2007-09-26 17:05:49.585166', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');
INSERT INTO zencartconfiguration VALUES (502, 'Show New Products on Main Page - Category with SubCategories', 'SHOW_PRODUCT_INFO_CATEGORY_NEW_PRODUCTS', '1', 'Show New Products on Main Page - Category with SubCategories<br />0= off or set the sort order', 24, 70, NULL, '2007-09-26 17:05:49.608128', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (503, 'Show Featured Products on Main Page - Category with SubCategories', 'SHOW_PRODUCT_INFO_CATEGORY_FEATURED_PRODUCTS', '2', 'Show Featured Products on Main Page - Category with SubCategories<br />0= off or set the sort order', 24, 71, NULL, '2007-09-26 17:05:49.613032', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (504, 'Show Special Products on Main Page - Category with SubCategories', 'SHOW_PRODUCT_INFO_CATEGORY_SPECIALS_PRODUCTS', '3', 'Show Special Products on Main Page - Category with SubCategories<br />0= off or set the sort order', 24, 72, NULL, '2007-09-26 17:05:49.617571', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (505, 'Show Upcoming Products on Main Page - Category with SubCategories', 'SHOW_PRODUCT_INFO_CATEGORY_UPCOMING', '4', 'Show Upcoming Products on Main Page - Category with SubCategories<br />0= off or set the sort order', 24, 73, NULL, '2007-09-26 17:05:49.622427', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (498, 'Show New Products on Main Page', 'SHOW_PRODUCT_INFO_MAIN_NEW_PRODUCTS', '0', 'Show New Products on Main Page<br />0= off or set the sort order', 24, 65, NULL, '2007-09-26 17:05:49.59014', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (506, 'Show New Products on Main Page - Errors and Missing Products Page', 'SHOW_PRODUCT_INFO_MISSING_NEW_PRODUCTS', '1', 'Show New Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', 24, 75, NULL, '2007-09-26 17:05:49.626895', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (507, 'Show Featured Products on Main Page - Errors and Missing Products Page', 'SHOW_PRODUCT_INFO_MISSING_FEATURED_PRODUCTS', '2', 'Show Featured Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', 24, 76, NULL, '2007-09-26 17:05:49.631801', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (508, 'Show Special Products on Main Page - Errors and Missing Products Page', 'SHOW_PRODUCT_INFO_MISSING_SPECIALS_PRODUCTS', '3', 'Show Special Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', 24, 77, NULL, '2007-09-26 17:05:49.644138', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (509, 'Show Upcoming Products on Main Page - Errors and Missing Products Page', 'SHOW_PRODUCT_INFO_MISSING_UPCOMING', '4', 'Show Upcoming Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', 24, 78, NULL, '2007-09-26 17:05:49.652418', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (510, 'Show New Products - below Product Listing', 'SHOW_PRODUCT_INFO_LISTING_BELOW_NEW_PRODUCTS', '1', 'Show New Products below Product Listing<br />0= off or set the sort order', 24, 85, NULL, '2007-09-26 17:05:49.660155', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (511, 'Show Featured Products - below Product Listing', 'SHOW_PRODUCT_INFO_LISTING_BELOW_FEATURED_PRODUCTS', '2', 'Show Featured Products below Product Listing<br />0= off or set the sort order', 24, 86, NULL, '2007-09-26 17:05:49.666211', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (512, 'Show Special Products - below Product Listing', 'SHOW_PRODUCT_INFO_LISTING_BELOW_SPECIALS_PRODUCTS', '3', 'Show Special Products below Product Listing<br />0= off or set the sort order', 24, 87, NULL, '2007-09-26 17:05:49.676886', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (513, 'Show Upcoming Products - below Product Listing', 'SHOW_PRODUCT_INFO_LISTING_BELOW_UPCOMING', '4', 'Show Upcoming Products below Product Listing<br />0= off or set the sort order', 24, 88, NULL, '2007-09-26 17:05:49.685622', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (514, 'New Products Columns per Row', 'SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS', '3', 'New Products Columns per Row', 24, 95, NULL, '2007-09-26 17:05:49.694031', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');
INSERT INTO zencartconfiguration VALUES (515, 'Featured Products Columns per Row', 'SHOW_PRODUCT_INFO_COLUMNS_FEATURED_PRODUCTS', '3', 'Featured Products Columns per Row', 24, 96, NULL, '2007-09-26 17:05:49.702259', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');
INSERT INTO zencartconfiguration VALUES (516, 'Special Products Columns per Row', 'SHOW_PRODUCT_INFO_COLUMNS_SPECIALS_PRODUCTS', '3', 'Special Products Columns per Row', 24, 97, NULL, '2007-09-26 17:05:49.706537', NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');
INSERT INTO zencartconfiguration VALUES (517, 'Filter Product Listing for Current Top Level Category When Enabled', 'SHOW_PRODUCT_INFO_ALL_PRODUCTS', '1', 'Filter the products when Product Listing is enabled for current Main Category or show products from all categories?<br />0= Filter Off 1=Filter On ', 24, 100, NULL, '2007-09-26 17:05:49.711798', NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');
INSERT INTO zencartconfiguration VALUES (518, 'Define Main Page Status', 'DEFINE_MAIN_PAGE_STATUS', '1', 'Enable the Defined Main Page Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 60, '2007-09-26 17:05:49.71667', '2007-09-26 17:05:49.71667', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (519, 'Define Contact Us Status', 'DEFINE_CONTACT_US_STATUS', '1', 'Enable the Defined Contact Us Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 61, '2007-09-26 17:05:49.721144', '2007-09-26 17:05:49.721144', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (520, 'Define Privacy Status', 'DEFINE_PRIVACY_STATUS', '1', 'Enable the Defined Privacy Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 62, '2007-09-26 17:05:49.725673', '2007-09-26 17:05:49.725673', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (521, 'Define Shipping & Returns', 'DEFINE_SHIPPINGINFO_STATUS', '1', 'Enable the Defined Shipping & Returns Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 63, '2007-09-26 17:05:49.731094', '2007-09-26 17:05:49.731094', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (522, 'Define Conditions of Use', 'DEFINE_CONDITIONS_STATUS', '1', 'Enable the Defined Conditions of Use Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 64, '2007-09-26 17:05:49.735601', '2007-09-26 17:05:49.735601', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (523, 'Define Checkout Success', 'DEFINE_CHECKOUT_SUCCESS_STATUS', '1', 'Enable the Defined Checkout Success Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 65, '2007-09-26 17:05:49.740068', '2007-09-26 17:05:49.740068', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (524, 'Define Discount Coupon', 'DEFINE_DISCOUNT_COUPON_STATUS', '1', 'Enable the Defined Discount Coupon Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 66, '2007-09-26 17:05:49.744658', '2007-09-26 17:05:49.744658', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (525, 'Define Site Map Status', 'DEFINE_SITE_MAP_STATUS', '1', 'Enable the Defined Site Map Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 67, '2007-09-26 17:05:49.750313', '2007-09-26 17:05:49.750313', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (526, 'Define Page-Not-Found Status', 'DEFINE_PAGE_NOT_FOUND_STATUS', '1', 'Enable the Defined Page-Not-Found Text from define-pages?<br />0= Define Text OFF<br />1= Define Text ON', 25, 67, '2007-09-26 17:05:49.754796', '2007-09-26 17:05:49.754796', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (527, 'Define Page 2', 'DEFINE_PAGE_2_STATUS', '1', 'Enable the Defined Page 2 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 82, '2007-09-26 17:05:49.759198', '2007-09-26 17:05:49.759198', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (528, 'Define Page 3', 'DEFINE_PAGE_3_STATUS', '1', 'Enable the Defined Page 3 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 83, '2007-09-26 17:05:49.763477', '2007-09-26 17:05:49.763477', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (529, 'Define Page 4', 'DEFINE_PAGE_4_STATUS', '1', 'Enable the Defined Page 4 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', 25, 84, '2007-09-26 17:05:49.768077', '2007-09-26 17:05:49.768077', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');
INSERT INTO zencartconfiguration VALUES (530, 'EZ-Pages Display Status - HeaderBar', 'EZPAGES_STATUS_HEADER', '1', 'Display of EZ-Pages content can be Globally enabled/disabled for the Header Bar<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 10, NULL, '2007-09-26 17:05:49.773571', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (531, 'EZ-Pages Display Status - FooterBar', 'EZPAGES_STATUS_FOOTER', '1', 'Display of EZ-Pages content can be Globally enabled/disabled for the Footer Bar<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 11, NULL, '2007-09-26 17:05:49.777356', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (532, 'EZ-Pages Display Status - Sidebox', 'EZPAGES_STATUS_SIDEBOX', '1', 'Display of EZ-Pages content can be Globally enabled/disabled for the Sidebox<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 12, NULL, '2007-09-26 17:05:49.781141', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (533, 'EZ-Pages Header Link Separator', 'EZPAGES_SEPARATOR_HEADER', '&nbsp;::&nbsp;', 'EZ-Pages Header Link Separator<br />Default = &amp;nbsp;::&amp;nbsp;', 30, 20, NULL, '2007-09-26 17:05:49.785355', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (534, 'EZ-Pages Footer Link Separator', 'EZPAGES_SEPARATOR_FOOTER', '&nbsp;::&nbsp;', 'EZ-Pages Footer Link Separator<br />Default = &amp;nbsp;::&amp;nbsp;', 30, 21, NULL, '2007-09-26 17:05:49.789516', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (535, 'EZ-Pages Prev/Next Buttons', 'EZPAGES_SHOW_PREV_NEXT_BUTTONS', '2', 'Display Prev/Continue/Next buttons on EZ-Pages pages?<br />0=OFF (no buttons)<br />1="Continue"<br />2="Prev/Continue/Next"<br /><br />Default setting: 2.', 30, 30, NULL, '2007-09-26 17:05:49.794892', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');
INSERT INTO zencartconfiguration VALUES (536, 'EZ-Pages Table of Contents for Chapters Status', 'EZPAGES_SHOW_TABLE_CONTENTS', '1', 'Enable EZ-Pages Table of Contents for Chapters?<br />0= OFF<br />1= ON', 30, 35, '2007-09-26 17:05:49.818801', '2007-09-26 17:05:49.818801', NULL, 'zen_cfg_select_option(array(''0'', ''1''),');
INSERT INTO zencartconfiguration VALUES (537, 'EZ-Pages Pages to disable headers', 'EZPAGES_DISABLE_HEADER_DISPLAY_LIST', '', 'EZ-Pages "pages" on which to NOT display the normal "header" for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 1,5,2<br />or leave blank.', 30, 40, NULL, '2007-09-26 17:05:49.822716', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (538, 'EZ-Pages Pages to disable footers', 'EZPAGES_DISABLE_FOOTER_DISPLAY_LIST', '', 'EZ-Pages "pages" on which to NOT display the normal "footer" for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 3,7<br />or leave blank.', 30, 41, NULL, '2007-09-26 17:05:49.826574', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (539, 'EZ-Pages Pages to disable left-column', 'EZPAGES_DISABLE_LEFTCOLUMN_DISPLAY_LIST', '', 'EZ-Pages "pages" on which to NOT display the normal "left" column (of sideboxes) for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 21<br />or leave blank.', 30, 42, NULL, '2007-09-26 17:05:49.830919', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (540, 'EZ-Pages Pages to disable right-column', 'EZPAGES_DISABLE_RIGHTCOLUMN_DISPLAY_LIST', '', 'EZ-Pages "pages" on which to NOT display the normal "right" column (of sideboxes) for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 3,82,13<br />or leave blank.', 30, 43, NULL, '2007-09-26 17:05:49.834821', NULL, 'zen_cfg_textarea_small(');
INSERT INTO zencartconfiguration VALUES (29, 'Enable phpBB linkage?', 'PHPBB_LINKS_ENABLED', 'false', 'Should Zen Cart synchronize new account information to your (already-installed) phpBB forum?', 1, 120, NULL, '2007-09-26 17:05:47.463651', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (1, 'Store Name', 'STORE_NAME', 'Test store', 'The name of my store', 1, 1, NULL, '2007-09-26 17:05:47.332935', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (2, 'Store Owner', 'STORE_OWNER', 'Pete', 'The name of my store owner', 1, 2, NULL, '2007-09-26 17:05:47.338174', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (261, 'Email Address (Displayed to Contact you)', 'STORE_OWNER_EMAIL_ADDRESS', 'pete@catalyst.net.nz', 'Email address of Store Owner.  Used as "display only" when informing customers of how to contact you.', 12, 10, NULL, '2007-09-26 17:05:48.538881', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (262, 'Email Address (sent FROM)', 'EMAIL_FROM', 'pete@catalyst.net.nz', 'Address from which email messages will be "sent" by default. Can be over-ridden at compose-time in admin modules.', 12, 11, NULL, '2007-09-26 17:05:48.54278', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (265, 'Send Copy of Order Confirmation Emails To', 'SEND_EXTRA_ORDER_EMAILS_TO', 'pete@catalyst.net.nz', 'Send COPIES of order confirmation emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 12, NULL, '2007-09-26 17:05:48.554699', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (267, 'Send Copy of Create Account Emails To', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Create Account emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 14, NULL, '2007-09-26 17:05:48.563087', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (269, 'Send Copy of Tell a Friend Emails To', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Tell a Friend emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 16, NULL, '2007-09-26 17:05:48.571854', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (271, 'Send Copy of Customer GV Send Emails To', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Customer GV Send emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 18, NULL, '2007-09-26 17:05:48.579736', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (273, 'Send Copy of Customer Admin GV Mail Emails To', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Admin GV Mail emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 20, NULL, '2007-09-26 17:05:48.587353', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (275, 'Send Copy of Customer Admin Discount Coupon Mail Emails To', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Admin Discount Coupon Mail emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 22, NULL, '2007-09-26 17:05:48.595274', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (277, 'Send Copy of Admin Orders Status Emails To', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Admin Orders Status emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 24, NULL, '2007-09-26 17:05:48.603406', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (279, 'Send Notice of Pending Reviews Emails To', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO', 'pete@catalyst.net.nz', 'Send copy of Pending Reviews emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 26, NULL, '2007-09-26 17:05:48.612453', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (284, 'Send Low Stock Emails To', 'SEND_EXTRA_LOW_STOCK_EMAILS_TO', 'pete@catalyst.net.nz', 'When stock level is at or below low stock level send an email to this address, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 61, NULL, '2007-09-26 17:05:48.632739', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (3, 'Country', 'STORE_COUNTRY', '153', 'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', 1, 6, NULL, '2007-09-26 17:05:47.343012', 'zen_get_country_name', 'zen_cfg_pull_down_country_list(');
INSERT INTO zencartconfiguration VALUES (4, 'Zone', 'STORE_ZONE', '201', 'The zone my store is located in', 1, 7, NULL, '2007-09-26 17:05:47.347064', 'zen_cfg_get_zone_name', 'zen_cfg_pull_down_zone_list(');
INSERT INTO zencartconfiguration VALUES (12, 'Store Address and Phone', 'STORE_NAME_ADDRESS', 'Test Store
 Catalyst IT Ltd.
 New Zealand
 123-45678', 'This is the Store Name, Address and Phone used on printable documents and displayed online', 1, 18, NULL, '2007-09-26 17:05:47.384313', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (199, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', 6, 0, NULL, '2007-09-26 17:05:48.271606', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (22, 'Show if version update available', 'SHOW_VERSION_UPDATE_IN_HEADER', 'false', 'Automatically check to see if a new version of Zen Cart is available. Enabling this can sometimes slow down the loading of Admin pages. (Displayed on main Index page after login, and Server Info page.)', 1, 44, NULL, '2007-09-26 17:05:47.431284', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (302, 'Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp/', 'If sessions are file based, store them in this directory.', 15, 1, NULL, '2007-09-26 17:05:48.711545', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (198, 'Default Currency', 'DEFAULT_CURRENCY', 'NZD', 'Default Currency', 6, 0, NULL, '2007-09-26 17:05:48.267024', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (7, 'Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'true', 'Automatically switch to the language''s currency when it is changed', 1, 10, NULL, '2007-09-26 17:05:47.361245', NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');
INSERT INTO zencartconfiguration VALUES (332, 'Include Tax', 'MODULE_ORDER_TOTAL_GV_INC_TAX', 'false', 'Include Tax in calculation.', 6, 6, NULL, '2003-10-30 22:16:40', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (249, 'E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines the method for sending mail.<br /><strong>PHP</strong> is the default, and uses built-in PHP wrappers for processing.<br />Servers running on Windows and MacOS should change this setting to <strong>SMTP</strong>.<br /><br /><strong>SMTPAUTH</strong> should only be used if your server requires SMTP authorization to send messages. You must also configure your SMTPAUTH settings in the appropriate fields in this admin section.<br /><br /><strong>sendmail</strong> is for linux/unix hosts using the sendmail program on the server<br /><strong>"sendmail-f"</strong> is only for servers which require the use of the -f parameter to send mail. This is a security setting often used to prevent spoofing. Will cause errors if your host mailserver is not configured to use it.<br /><br /><strong>Qmail</strong> is used for linux/unix hosts running Qmail as sendmail wrapper at /var/qmail/bin/sendmail.', 12, 1, NULL, '2007-09-26 17:05:48.488161', NULL, 'zen_cfg_select_option(array(''PHP'', ''sendmail'', ''sendmail-f'', ''smtp'', ''smtpauth'', ''Qmail''),');
INSERT INTO zencartconfiguration VALUES (499, 'Show Featured Products on Main Page', 'SHOW_PRODUCT_INFO_MAIN_FEATURED_PRODUCTS', '0', 'Show Featured Products on Main Page<br />0= off or set the sort order', 24, 66, NULL, '2007-09-26 17:05:49.594486', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (500, 'Show Special Products on Main Page', 'SHOW_PRODUCT_INFO_MAIN_SPECIALS_PRODUCTS', '0', 'Show Special Products on Main Page<br />0= off or set the sort order', 24, 67, NULL, '2007-09-26 17:05:49.598986', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (501, 'Show Upcoming Products on Main Page', 'SHOW_PRODUCT_INFO_MAIN_UPCOMING', '0', 'Show Upcoming Products on Main Page<br />0= off or set the sort order', 24, 68, NULL, '2007-09-26 17:05:49.603607', NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');
INSERT INTO zencartconfiguration VALUES (347, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '200', 'Sort order of display.', 6, 2, NULL, '2003-10-30 22:16:46', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (348, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3, NULL, '2003-10-30 22:16:46', NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO zencartconfiguration VALUES (349, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '', 'Provide free shipping for orders over the set amount.', 6, 4, NULL, '2003-10-30 22:16:46', 'currencies->format', NULL);
INSERT INTO zencartconfiguration VALUES (350, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, NULL, '2003-10-30 22:16:46', NULL, 'zen_cfg_select_option(array(''national'', ''international'', ''both''),');
INSERT INTO zencartconfiguration VALUES (572, 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delivery payments?', 6, 1, NULL, '2007-10-29 15:53:54.867555', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (573, 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2007-10-29 15:53:54.869117', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (574, 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2007-10-29 15:53:54.870185', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (575, 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2007-10-29 15:53:54.87179', 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');
INSERT INTO zencartconfiguration VALUES (205, 'Package Tare Small to Medium - added percentage:weight', 'SHIPPING_BOX_WEIGHT', '0:0', 'What is the weight of typical packaging of small to medium packages?<br />Example: 10% + 1lb 10:1<br />10% + 0lbs 10:0<br />0% + 5lbs 0:5<br />0% + 0lbs 0:0', 7, 4, NULL, '2007-09-26 17:05:48.306843', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (148, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php;dpsaccess.php;freecharger.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', 6, 0, '2007-10-31 14:01:00.280349', '2007-09-26 17:05:48.032408', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (150, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'freeshipper.php;storepickup.php;table.php;table2.php;zones.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', 6, 0, '2007-11-12 15:48:14.577554', '2007-09-26 17:05:48.040741', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (608, 'Enable Zones Method', 'MODULE_SHIPPING_ZONES_STATUS', 'True', 'Do you want to offer zone rate shipping?', 6, 0, NULL, '2007-11-12 15:48:14.315756', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (609, 'Calculation Method', 'MODULE_SHIPPING_ZONES_METHOD', 'Weight', 'Calculate cost based on Weight, Price or Item?', 6, 0, NULL, '2007-11-12 15:48:14.318678', NULL, 'zen_cfg_select_option(array(''Weight'', ''Price'', ''Item''), ');
INSERT INTO zencartconfiguration VALUES (610, 'Tax Class', 'MODULE_SHIPPING_ZONES_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2007-11-12 15:48:14.31974', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (611, 'Tax Basis', 'MODULE_SHIPPING_ZONES_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, NULL, '2007-11-12 15:48:14.320489', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');
INSERT INTO zencartconfiguration VALUES (612, 'Sort Order', 'MODULE_SHIPPING_ZONES_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2007-11-12 15:48:14.321327', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (613, 'Skip Countries, use a comma separated list of the two character ISO country codes', 'MODULE_SHIPPING_ZONES_SKIPPED', 'NZ', 'Disable for the following Countries:', 6, 0, NULL, '2007-11-12 15:48:14.322022', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (614, 'Zone 1 Countries', 'MODULE_SHIPPING_ZONES_COUNTRIES_1', 'AU', 'Comma separated list of two character ISO country codes that are part of Zone 1.<br />Set as 00 to indicate all two character ISO country codes that are not specifically defined.', 6, 0, NULL, '2007-11-12 15:48:14.322837', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (615, 'Zone 1 Shipping Table', 'MODULE_SHIPPING_ZONES_COST_1', '20,4.00,100,6.00,200,8.00,300,9.00,400,10.00,500,12.00,750,14.00,1000,15.00,1250,17.00,1500,19.00,1750,22.00,2000,24.00', 'Shipping rates to Zone 1 destinations based on a group of maximum order weights/prices. Example: 3:8.50,7:10.50,... Weight/Price less than or equal to 3 would cost 8.50 for Zone 1 destinations.', 6, 0, NULL, '2007-11-12 15:48:14.323759', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (616, 'Zone 1 Handling Fee', 'MODULE_SHIPPING_ZONES_HANDLING_1', '0', 'Handling Fee for this shipping zone', 6, 0, NULL, '2007-11-12 15:48:14.324491', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (617, 'Zone 2 Countries', 'MODULE_SHIPPING_ZONES_COUNTRIES_2', 'AS,AQ,CX,CK,FJ,PF,GU,ID,KI,MP,FM,NR,NC,NU,NF,PW,PG,WS,SB,TK,TO,TV,VU,WF', 'Comma separated list of two character ISO country codes that are part of Zone 2.<br />Set as 00 to indicate all two character ISO country codes that are not specifically defined.', 6, 0, NULL, '2007-11-12 15:48:14.325153', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (618, 'Zone 2 Shipping Table', 'MODULE_SHIPPING_ZONES_COST_2', '20,5.00,100,7.50,200,9.00,300,11.00,400,13.00,500,15.00,750,18.00,1000,23.00,1250,27.50,1500,32.50,1750,35.00,2000,40.0', 'Shipping rates to Zone 2 destinations based on a group of maximum order weights/prices. Example: 3:8.50,7:10.50,... Weight/Price less than or equal to 3 would cost 8.50 for Zone 2 destinations.', 6, 0, NULL, '2007-11-12 15:48:14.325814', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (619, 'Zone 2 Handling Fee', 'MODULE_SHIPPING_ZONES_HANDLING_2', '0', 'Handling Fee for this shipping zone', 6, 0, NULL, '2007-11-12 15:48:14.326573', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (620, 'Zone 3 Countries', 'MODULE_SHIPPING_ZONES_COUNTRIES_3', 'CN,HK,MO,TW,JP,KP,KR,MN,US,CA', 'Comma separated list of two character ISO country codes that are part of Zone 3.<br />Set as 00 to indicate all two character ISO country codes that are not specifically defined.', 6, 0, NULL, '2007-11-12 15:48:14.327256', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (621, 'Zone 3 Shipping Table', 'MODULE_SHIPPING_ZONES_COST_3', '20,5.00,100,7.50,200,12.00,300,14.00,400,16.00,500,19.00,750,24.00,1000,30.00,1250,35.00,1500,40.00,1750,45.00,2000,55.00', 'Shipping rates to Zone 3 destinations based on a group of maximum order weights/prices. Example: 3:8.50,7:10.50,... Weight/Price less than or equal to 3 would cost 8.50 for Zone 3 destinations.', 6, 0, NULL, '2007-11-12 15:48:14.327953', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (622, 'Zone 3 Handling Fee', 'MODULE_SHIPPING_ZONES_HANDLING_3', '0', 'Handling Fee for this shipping zone', 6, 0, NULL, '2007-11-12 15:48:14.328628', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (623, 'Zone 4 Countries', 'MODULE_SHIPPING_ZONES_COUNTRIES_4', 'GB,FI,DK,EE,FO,GG,IS,IE,IM,JE,LV,LT,NO,SJ,SE,AT,BE,FR,DE,LI,LU,MC,', 'Comma separated list of two character ISO country codes that are part of Zone 4.<br />Set as 00 to indicate all two character ISO country codes that are not specifically defined.', 6, 0, NULL, '2007-11-12 15:48:14.32928', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (624, 'Zone 4 Shipping Table', 'MODULE_SHIPPING_ZONES_COST_4', '20,5.00,100,9.00,200,13.00,300,15.00,400,17.00,500,20.00,750,26.00,1000,30.00,1250,38.00,1500,45.00,1750,50.00,2000,58.00', 'Shipping rates to Zone 4 destinations based on a group of maximum order weights/prices. Example: 3:8.50,7:10.50,... Weight/Price less than or equal to 3 would cost 8.50 for Zone 4 destinations.', 6, 0, NULL, '2007-11-12 15:48:14.329896', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (625, 'Zone 4 Handling Fee', 'MODULE_SHIPPING_ZONES_HANDLING_4', '0', 'Handling Fee for this shipping zone', 6, 0, NULL, '2007-11-12 15:48:14.330519', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (626, 'Zone 5 Countries', 'MODULE_SHIPPING_ZONES_COUNTRIES_5', '00', 'Comma separated list of two character ISO country codes that are part of Zone 5.<br />Set as 00 to indicate all two character ISO country codes that are not specifically defined.', 6, 0, NULL, '2007-11-12 15:48:14.331133', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (627, 'Zone 5 Shipping Table', 'MODULE_SHIPPING_ZONES_COST_5', '20,5.00,100,10.00,200,15.00,300,17.00,400,19.00,500,23.00,750,28.00,1000,35.00,1250,40.00,1500,47.50,1750,53.00,2000,60.00', 'Shipping rates to Zone 5 destinations based on a group of maximum order weights/prices. Example: 3:8.50,7:10.50,... Weight/Price less than or equal to 3 would cost 8.50 for Zone 5 destinations.', 6, 0, NULL, '2007-11-12 15:48:14.331763', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (628, 'Zone 5 Handling Fee', 'MODULE_SHIPPING_ZONES_HANDLING_5', '0', 'Handling Fee for this shipping zone', 6, 0, NULL, '2007-11-12 15:48:14.332384', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (584, 'Enable DPS ACCESS Module', 'MODULE_PAYMENT_DPSACCESS_STATUS', 'True', 'Do you want to accept DPS ACCESS payments?', 6, 3, NULL, '2007-10-31 14:00:36.254465', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (585, 'DPS Access URL', 'MODULE_PAYMENT_DPSACCESS_URL', 'https://www.paymentexpress.com/pxpay/pxpay.aspx', 'The URL for the PxAccess service', 6, 4, NULL, '2007-10-31 14:00:36.281956', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (586, 'DPS Access UserID', 'MODULE_PAYMENT_DPSACCESS_USERID', 'SOUNZ_dev', 'The User ID for your online store', 6, 4, NULL, '2007-10-31 14:00:36.282878', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (587, 'DPS Access DES Key', 'MODULE_PAYMENT_DPSACCESS_DESKEY', '0e33b0f5bc5cd948ced947f37b5c0d8a9a021d9b26989dfb', 'The DES Key for your online store', 6, 4, NULL, '2007-10-31 14:00:36.284624', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (588, 'DPS Access MAC Key', 'MODULE_PAYMENT_DPSACCESS_MACKEY', 'fa6b4bb6cf092d8b', 'The MAC Key for your online store', 6, 4, NULL, '2007-10-31 14:00:36.285502', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (590, 'Payment Zone', 'MODULE_PAYMENT_DPSACCESS_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, NULL, '2007-10-31 14:00:36.287305', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (591, 'Set Order Status', 'MODULE_PAYMENT_DPSACCESS_ORDER_STATUS_ID', '2', 'Set the status of orders made with this payment module to this value', 6, 0, NULL, '2007-10-31 14:00:36.28824', 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');
INSERT INTO zencartconfiguration VALUES (589, 'Sort order of display.', 'MODULE_PAYMENT_DPSACCESS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, NULL, '2007-10-31 14:00:36.286386', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (592, 'Enable Table Method', 'MODULE_SHIPPING_TABLE_STATUS', 'True', 'Do you want to offer table rate shipping?', 6, 0, NULL, '2007-11-12 11:17:18.188452', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (593, 'Shipping Table', 'MODULE_SHIPPING_TABLE_COST', '0,0,20,2.50,1250,5.00,2000,7.50', 'The shipping cost is based on the total cost or weight of items or count of the items. Example: 25:8.50,50:5.50,etc.. Up to 25 charge 8.50, from there to 50 charge 5.50, etc', 6, 0, NULL, '2007-11-12 11:17:18.240175', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (594, 'Table Method', 'MODULE_SHIPPING_TABLE_MODE', 'weight', 'The shipping cost is based on the order total or the total weight of the items ordered or the total number of items orderd.', 6, 0, NULL, '2007-11-12 11:17:18.240951', NULL, 'zen_cfg_select_option(array(''weight'', ''price'', ''item''), ');
INSERT INTO zencartconfiguration VALUES (595, 'Handling Fee', 'MODULE_SHIPPING_TABLE_HANDLING', '0', 'Handling fee for this shipping method.', 6, 0, NULL, '2007-11-12 11:17:18.241784', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (596, 'Tax Class', 'MODULE_SHIPPING_TABLE_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2007-11-12 11:17:18.2425', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (597, 'Tax Basis', 'MODULE_SHIPPING_TABLE_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, NULL, '2007-11-12 11:17:18.243222', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');
INSERT INTO zencartconfiguration VALUES (598, 'Shipping Zone', 'MODULE_SHIPPING_TABLE_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2007-11-12 11:17:18.244047', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (599, 'Sort Order', 'MODULE_SHIPPING_TABLE_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2007-11-12 11:17:18.244816', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (600, 'Enable Table Method', 'MODULE_SHIPPING_TABLE2_STATUS', 'True', 'Do you want to offer table rate shipping?', 6, 0, NULL, '2007-11-12 11:34:45.817063', NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');
INSERT INTO zencartconfiguration VALUES (601, 'Shipping Table', 'MODULE_SHIPPING_TABLE2_COST', '0,0,20,6.00,300,8.00,1000,10.00,2000,10.00', 'The shipping cost is based on the total cost or weight of items or count of the items. Example: 25:8.50,50:5.50,etc.. Up to 25 charge 8.50, from there to 50 charge 5.50, etc', 6, 0, NULL, '2007-11-12 11:34:45.843127', NULL, 'zen_cfg_textarea(');
INSERT INTO zencartconfiguration VALUES (602, 'Table Method', 'MODULE_SHIPPING_TABLE2_MODE', 'weight', 'The shipping cost is based on the order total or the total weight of the items ordered or the total number of items orderd.', 6, 0, NULL, '2007-11-12 11:34:45.844353', NULL, 'zen_cfg_select_option(array(''weight'', ''price'', ''item''), ');
INSERT INTO zencartconfiguration VALUES (603, 'Handling Fee', 'MODULE_SHIPPING_TABLE2_HANDLING', '0', 'Handling fee for this shipping method.', 6, 0, NULL, '2007-11-12 11:34:45.845204', NULL, NULL);
INSERT INTO zencartconfiguration VALUES (604, 'Tax Class', 'MODULE_SHIPPING_TABLE2_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, NULL, '2007-11-12 11:34:45.845861', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');
INSERT INTO zencartconfiguration VALUES (605, 'Tax Basis', 'MODULE_SHIPPING_TABLE2_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, NULL, '2007-11-12 11:34:45.846641', NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');
INSERT INTO zencartconfiguration VALUES (606, 'Shipping Zone', 'MODULE_SHIPPING_TABLE2_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, NULL, '2007-11-12 11:34:45.847533', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');
INSERT INTO zencartconfiguration VALUES (607, 'Sort Order', 'MODULE_SHIPPING_TABLE2_SORT_ORDER', '0', 'Sort order of display.', 6, 0, NULL, '2007-11-12 11:34:45.848252', NULL, NULL);


--
-- Data for Name: zencartconfiguration_group; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartconfiguration_group VALUES (1, 'My Store', 'General information about my store', 1, 1);
INSERT INTO zencartconfiguration_group VALUES (2, 'Minimum Values', 'The minimum values for functions / data', 2, 1);
INSERT INTO zencartconfiguration_group VALUES (3, 'Maximum Values', 'The maximum values for functions / data', 3, 1);
INSERT INTO zencartconfiguration_group VALUES (4, 'Images', 'Image parameters', 4, 1);
INSERT INTO zencartconfiguration_group VALUES (5, 'Customer Details', 'Customer account configuration', 5, 1);
INSERT INTO zencartconfiguration_group VALUES (6, 'Module Options', 'Hidden from configuration', 6, 0);
INSERT INTO zencartconfiguration_group VALUES (7, 'Shipping/Packaging', 'Shipping options available at my store', 7, 1);
INSERT INTO zencartconfiguration_group VALUES (8, 'Product Listing', 'Product Listing configuration options', 8, 1);
INSERT INTO zencartconfiguration_group VALUES (9, 'Stock', 'Stock configuration options', 9, 1);
INSERT INTO zencartconfiguration_group VALUES (10, 'Logging', 'Logging configuration options', 10, 1);
INSERT INTO zencartconfiguration_group VALUES (11, 'Regulations', 'Regulation options', 16, 1);
INSERT INTO zencartconfiguration_group VALUES (12, 'E-Mail Options', 'General settings for E-Mail transport and HTML E-Mails', 12, 1);
INSERT INTO zencartconfiguration_group VALUES (13, 'Attribute Settings', 'Configure products attributes settings', 13, 1);
INSERT INTO zencartconfiguration_group VALUES (14, 'GZip Compression', 'GZip compression options', 14, 1);
INSERT INTO zencartconfiguration_group VALUES (15, 'Sessions', 'Session options', 15, 1);
INSERT INTO zencartconfiguration_group VALUES (16, 'GV Coupons', 'Gift Vouchers and Coupons', 16, 1);
INSERT INTO zencartconfiguration_group VALUES (17, 'Credit Cards', 'Credit Cards Accepted', 17, 1);
INSERT INTO zencartconfiguration_group VALUES (18, 'Product Info', 'Product Info Display Options', 18, 1);
INSERT INTO zencartconfiguration_group VALUES (19, 'Layout Settings', 'Layout Options', 19, 1);
INSERT INTO zencartconfiguration_group VALUES (20, 'Website Maintenance', 'Website Maintenance Options', 20, 1);
INSERT INTO zencartconfiguration_group VALUES (21, 'New Listing', 'New Products Listing', 21, 1);
INSERT INTO zencartconfiguration_group VALUES (22, 'Featured Listing', 'Featured Products Listing', 22, 1);
INSERT INTO zencartconfiguration_group VALUES (23, 'All Listing', 'All Products Listing', 23, 1);
INSERT INTO zencartconfiguration_group VALUES (24, 'Index Listing', 'Index Products Listing', 24, 1);
INSERT INTO zencartconfiguration_group VALUES (25, 'Define Page Status', 'Define Main Pages and HTMLArea Options', 25, 1);
INSERT INTO zencartconfiguration_group VALUES (30, 'EZ-Pages Settings', 'EZ-Pages Settings', 30, 1);


--
-- Data for Name: zencartcounter; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcounter VALUES ('20070926', 7486);


--
-- Data for Name: zencartcounter_history; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcounter_history VALUES ('20070926', 3, 2);
INSERT INTO zencartcounter_history VALUES ('20070927', 81, 10);
INSERT INTO zencartcounter_history VALUES ('20071001', 109, 57);
INSERT INTO zencartcounter_history VALUES ('20071002', 202, 165);
INSERT INTO zencartcounter_history VALUES ('20071012', 329, 7);
INSERT INTO zencartcounter_history VALUES ('20071101', 59, 4);
INSERT INTO zencartcounter_history VALUES ('20071016', 437, 8);
INSERT INTO zencartcounter_history VALUES ('20071023', 212, 6);
INSERT INTO zencartcounter_history VALUES ('20071025', 376, 10);
INSERT INTO zencartcounter_history VALUES ('20071106', 146, 5);
INSERT INTO zencartcounter_history VALUES ('20071011', 219, 5);
INSERT INTO zencartcounter_history VALUES ('20071018', 169, 3);
INSERT INTO zencartcounter_history VALUES ('20071026', 21, 2);
INSERT INTO zencartcounter_history VALUES ('20071029', 194, 9);
INSERT INTO zencartcounter_history VALUES ('20071010', 192, 5);
INSERT INTO zencartcounter_history VALUES ('20071015', 457, 12);
INSERT INTO zencartcounter_history VALUES ('20071008', 298, 13);
INSERT INTO zencartcounter_history VALUES ('20071030', 234, 5);
INSERT INTO zencartcounter_history VALUES ('20071003', 390, 38);
INSERT INTO zencartcounter_history VALUES ('20071114', 373, 10);
INSERT INTO zencartcounter_history VALUES ('20071102', 22, 5);
INSERT INTO zencartcounter_history VALUES ('20071024', 314, 9);
INSERT INTO zencartcounter_history VALUES ('20071105', 362, 11);
INSERT INTO zencartcounter_history VALUES ('20071005', 39, 4);
INSERT INTO zencartcounter_history VALUES ('20071004', 108, 10);
INSERT INTO zencartcounter_history VALUES ('20071031', 45, 4);
INSERT INTO zencartcounter_history VALUES ('20071019', 435, 6);
INSERT INTO zencartcounter_history VALUES ('20071009', 334, 4);
INSERT INTO zencartcounter_history VALUES ('20071107', 340, 4);
INSERT INTO zencartcounter_history VALUES ('20071017', 598, 5);
INSERT INTO zencartcounter_history VALUES ('20071108', 103, 5);
INSERT INTO zencartcounter_history VALUES ('20071109', 24, 1);
INSERT INTO zencartcounter_history VALUES ('20071111', 97, 11);
INSERT INTO zencartcounter_history VALUES ('20071112', 62, 9);
INSERT INTO zencartcounter_history VALUES ('20071113', 102, 6);


--
-- Data for Name: zencartcountries; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcountries VALUES (240, 'Aaland Islands', 'AX', 'ALA', 1);
INSERT INTO zencartcountries VALUES (1, 'Afghanistan', 'AF', 'AFG', 1);
INSERT INTO zencartcountries VALUES (2, 'Albania', 'AL', 'ALB', 1);
INSERT INTO zencartcountries VALUES (3, 'Algeria', 'DZ', 'DZA', 1);
INSERT INTO zencartcountries VALUES (4, 'American Samoa', 'AS', 'ASM', 1);
INSERT INTO zencartcountries VALUES (5, 'Andorra', 'AD', 'AND', 1);
INSERT INTO zencartcountries VALUES (6, 'Angola', 'AO', 'AGO', 1);
INSERT INTO zencartcountries VALUES (7, 'Anguilla', 'AI', 'AIA', 1);
INSERT INTO zencartcountries VALUES (8, 'Antarctica', 'AQ', 'ATA', 1);
INSERT INTO zencartcountries VALUES (9, 'Antigua and Barbuda', 'AG', 'ATG', 1);
INSERT INTO zencartcountries VALUES (10, 'Argentina', 'AR', 'ARG', 1);
INSERT INTO zencartcountries VALUES (11, 'Armenia', 'AM', 'ARM', 1);
INSERT INTO zencartcountries VALUES (12, 'Aruba', 'AW', 'ABW', 1);
INSERT INTO zencartcountries VALUES (13, 'Australia', 'AU', 'AUS', 1);
INSERT INTO zencartcountries VALUES (14, 'Austria', 'AT', 'AUT', 5);
INSERT INTO zencartcountries VALUES (15, 'Azerbaijan', 'AZ', 'AZE', 1);
INSERT INTO zencartcountries VALUES (16, 'Bahamas', 'BS', 'BHS', 1);
INSERT INTO zencartcountries VALUES (17, 'Bahrain', 'BH', 'BHR', 1);
INSERT INTO zencartcountries VALUES (18, 'Bangladesh', 'BD', 'BGD', 1);
INSERT INTO zencartcountries VALUES (19, 'Barbados', 'BB', 'BRB', 1);
INSERT INTO zencartcountries VALUES (20, 'Belarus', 'BY', 'BLR', 1);
INSERT INTO zencartcountries VALUES (21, 'Belgium', 'BE', 'BEL', 1);
INSERT INTO zencartcountries VALUES (22, 'Belize', 'BZ', 'BLZ', 1);
INSERT INTO zencartcountries VALUES (23, 'Benin', 'BJ', 'BEN', 1);
INSERT INTO zencartcountries VALUES (24, 'Bermuda', 'BM', 'BMU', 1);
INSERT INTO zencartcountries VALUES (25, 'Bhutan', 'BT', 'BTN', 1);
INSERT INTO zencartcountries VALUES (26, 'Bolivia', 'BO', 'BOL', 1);
INSERT INTO zencartcountries VALUES (27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1);
INSERT INTO zencartcountries VALUES (28, 'Botswana', 'BW', 'BWA', 1);
INSERT INTO zencartcountries VALUES (29, 'Bouvet Island', 'BV', 'BVT', 1);
INSERT INTO zencartcountries VALUES (30, 'Brazil', 'BR', 'BRA', 1);
INSERT INTO zencartcountries VALUES (31, 'British Indian Ocean Territory', 'IO', 'IOT', 1);
INSERT INTO zencartcountries VALUES (32, 'Brunei Darussalam', 'BN', 'BRN', 1);
INSERT INTO zencartcountries VALUES (33, 'Bulgaria', 'BG', 'BGR', 1);
INSERT INTO zencartcountries VALUES (34, 'Burkina Faso', 'BF', 'BFA', 1);
INSERT INTO zencartcountries VALUES (35, 'Burundi', 'BI', 'BDI', 1);
INSERT INTO zencartcountries VALUES (36, 'Cambodia', 'KH', 'KHM', 1);
INSERT INTO zencartcountries VALUES (37, 'Cameroon', 'CM', 'CMR', 1);
INSERT INTO zencartcountries VALUES (38, 'Canada', 'CA', 'CAN', 1);
INSERT INTO zencartcountries VALUES (39, 'Cape Verde', 'CV', 'CPV', 1);
INSERT INTO zencartcountries VALUES (40, 'Cayman Islands', 'KY', 'CYM', 1);
INSERT INTO zencartcountries VALUES (41, 'Central African Republic', 'CF', 'CAF', 1);
INSERT INTO zencartcountries VALUES (42, 'Chad', 'TD', 'TCD', 1);
INSERT INTO zencartcountries VALUES (43, 'Chile', 'CL', 'CHL', 1);
INSERT INTO zencartcountries VALUES (44, 'China', 'CN', 'CHN', 1);
INSERT INTO zencartcountries VALUES (45, 'Christmas Island', 'CX', 'CXR', 1);
INSERT INTO zencartcountries VALUES (46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1);
INSERT INTO zencartcountries VALUES (47, 'Colombia', 'CO', 'COL', 1);
INSERT INTO zencartcountries VALUES (48, 'Comoros', 'KM', 'COM', 1);
INSERT INTO zencartcountries VALUES (49, 'Congo', 'CG', 'COG', 1);
INSERT INTO zencartcountries VALUES (50, 'Cook Islands', 'CK', 'COK', 1);
INSERT INTO zencartcountries VALUES (51, 'Costa Rica', 'CR', 'CRI', 1);
INSERT INTO zencartcountries VALUES (52, 'Cote D''Ivoire', 'CI', 'CIV', 1);
INSERT INTO zencartcountries VALUES (53, 'Croatia', 'HR', 'HRV', 1);
INSERT INTO zencartcountries VALUES (54, 'Cuba', 'CU', 'CUB', 1);
INSERT INTO zencartcountries VALUES (55, 'Cyprus', 'CY', 'CYP', 1);
INSERT INTO zencartcountries VALUES (56, 'Czech Republic', 'CZ', 'CZE', 1);
INSERT INTO zencartcountries VALUES (57, 'Denmark', 'DK', 'DNK', 1);
INSERT INTO zencartcountries VALUES (58, 'Djibouti', 'DJ', 'DJI', 1);
INSERT INTO zencartcountries VALUES (59, 'Dominica', 'DM', 'DMA', 1);
INSERT INTO zencartcountries VALUES (60, 'Dominican Republic', 'DO', 'DOM', 1);
INSERT INTO zencartcountries VALUES (61, 'East Timor', 'TP', 'TMP', 1);
INSERT INTO zencartcountries VALUES (62, 'Ecuador', 'EC', 'ECU', 1);
INSERT INTO zencartcountries VALUES (63, 'Egypt', 'EG', 'EGY', 1);
INSERT INTO zencartcountries VALUES (64, 'El Salvador', 'SV', 'SLV', 1);
INSERT INTO zencartcountries VALUES (65, 'Equatorial Guinea', 'GQ', 'GNQ', 1);
INSERT INTO zencartcountries VALUES (66, 'Eritrea', 'ER', 'ERI', 1);
INSERT INTO zencartcountries VALUES (67, 'Estonia', 'EE', 'EST', 1);
INSERT INTO zencartcountries VALUES (68, 'Ethiopia', 'ET', 'ETH', 1);
INSERT INTO zencartcountries VALUES (69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1);
INSERT INTO zencartcountries VALUES (70, 'Faroe Islands', 'FO', 'FRO', 1);
INSERT INTO zencartcountries VALUES (71, 'Fiji', 'FJ', 'FJI', 1);
INSERT INTO zencartcountries VALUES (72, 'Finland', 'FI', 'FIN', 1);
INSERT INTO zencartcountries VALUES (73, 'France', 'FR', 'FRA', 1);
INSERT INTO zencartcountries VALUES (74, 'France, Metropolitan', 'FX', 'FXX', 1);
INSERT INTO zencartcountries VALUES (75, 'French Guiana', 'GF', 'GUF', 1);
INSERT INTO zencartcountries VALUES (76, 'French Polynesia', 'PF', 'PYF', 1);
INSERT INTO zencartcountries VALUES (77, 'French Southern Territories', 'TF', 'ATF', 1);
INSERT INTO zencartcountries VALUES (78, 'Gabon', 'GA', 'GAB', 1);
INSERT INTO zencartcountries VALUES (79, 'Gambia', 'GM', 'GMB', 1);
INSERT INTO zencartcountries VALUES (80, 'Georgia', 'GE', 'GEO', 1);
INSERT INTO zencartcountries VALUES (81, 'Germany', 'DE', 'DEU', 5);
INSERT INTO zencartcountries VALUES (82, 'Ghana', 'GH', 'GHA', 1);
INSERT INTO zencartcountries VALUES (83, 'Gibraltar', 'GI', 'GIB', 1);
INSERT INTO zencartcountries VALUES (84, 'Greece', 'GR', 'GRC', 1);
INSERT INTO zencartcountries VALUES (85, 'Greenland', 'GL', 'GRL', 1);
INSERT INTO zencartcountries VALUES (86, 'Grenada', 'GD', 'GRD', 1);
INSERT INTO zencartcountries VALUES (87, 'Guadeloupe', 'GP', 'GLP', 1);
INSERT INTO zencartcountries VALUES (88, 'Guam', 'GU', 'GUM', 1);
INSERT INTO zencartcountries VALUES (89, 'Guatemala', 'GT', 'GTM', 1);
INSERT INTO zencartcountries VALUES (90, 'Guinea', 'GN', 'GIN', 1);
INSERT INTO zencartcountries VALUES (91, 'Guinea-bissau', 'GW', 'GNB', 1);
INSERT INTO zencartcountries VALUES (92, 'Guyana', 'GY', 'GUY', 1);
INSERT INTO zencartcountries VALUES (93, 'Haiti', 'HT', 'HTI', 1);
INSERT INTO zencartcountries VALUES (94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1);
INSERT INTO zencartcountries VALUES (95, 'Honduras', 'HN', 'HND', 1);
INSERT INTO zencartcountries VALUES (96, 'Hong Kong', 'HK', 'HKG', 1);
INSERT INTO zencartcountries VALUES (97, 'Hungary', 'HU', 'HUN', 1);
INSERT INTO zencartcountries VALUES (98, 'Iceland', 'IS', 'ISL', 1);
INSERT INTO zencartcountries VALUES (99, 'India', 'IN', 'IND', 1);
INSERT INTO zencartcountries VALUES (100, 'Indonesia', 'ID', 'IDN', 1);
INSERT INTO zencartcountries VALUES (101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1);
INSERT INTO zencartcountries VALUES (102, 'Iraq', 'IQ', 'IRQ', 1);
INSERT INTO zencartcountries VALUES (103, 'Ireland', 'IE', 'IRL', 1);
INSERT INTO zencartcountries VALUES (104, 'Israel', 'IL', 'ISR', 1);
INSERT INTO zencartcountries VALUES (105, 'Italy', 'IT', 'ITA', 1);
INSERT INTO zencartcountries VALUES (106, 'Jamaica', 'JM', 'JAM', 1);
INSERT INTO zencartcountries VALUES (107, 'Japan', 'JP', 'JPN', 1);
INSERT INTO zencartcountries VALUES (108, 'Jordan', 'JO', 'JOR', 1);
INSERT INTO zencartcountries VALUES (109, 'Kazakhstan', 'KZ', 'KAZ', 1);
INSERT INTO zencartcountries VALUES (110, 'Kenya', 'KE', 'KEN', 1);
INSERT INTO zencartcountries VALUES (111, 'Kiribati', 'KI', 'KIR', 1);
INSERT INTO zencartcountries VALUES (112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1);
INSERT INTO zencartcountries VALUES (113, 'Korea, Republic of', 'KR', 'KOR', 1);
INSERT INTO zencartcountries VALUES (114, 'Kuwait', 'KW', 'KWT', 1);
INSERT INTO zencartcountries VALUES (115, 'Kyrgyzstan', 'KG', 'KGZ', 1);
INSERT INTO zencartcountries VALUES (116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1);
INSERT INTO zencartcountries VALUES (117, 'Latvia', 'LV', 'LVA', 1);
INSERT INTO zencartcountries VALUES (118, 'Lebanon', 'LB', 'LBN', 1);
INSERT INTO zencartcountries VALUES (119, 'Lesotho', 'LS', 'LSO', 1);
INSERT INTO zencartcountries VALUES (120, 'Liberia', 'LR', 'LBR', 1);
INSERT INTO zencartcountries VALUES (121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1);
INSERT INTO zencartcountries VALUES (122, 'Liechtenstein', 'LI', 'LIE', 1);
INSERT INTO zencartcountries VALUES (123, 'Lithuania', 'LT', 'LTU', 1);
INSERT INTO zencartcountries VALUES (124, 'Luxembourg', 'LU', 'LUX', 1);
INSERT INTO zencartcountries VALUES (125, 'Macau', 'MO', 'MAC', 1);
INSERT INTO zencartcountries VALUES (126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1);
INSERT INTO zencartcountries VALUES (127, 'Madagascar', 'MG', 'MDG', 1);
INSERT INTO zencartcountries VALUES (128, 'Malawi', 'MW', 'MWI', 1);
INSERT INTO zencartcountries VALUES (129, 'Malaysia', 'MY', 'MYS', 1);
INSERT INTO zencartcountries VALUES (130, 'Maldives', 'MV', 'MDV', 1);
INSERT INTO zencartcountries VALUES (131, 'Mali', 'ML', 'MLI', 1);
INSERT INTO zencartcountries VALUES (132, 'Malta', 'MT', 'MLT', 1);
INSERT INTO zencartcountries VALUES (133, 'Marshall Islands', 'MH', 'MHL', 1);
INSERT INTO zencartcountries VALUES (134, 'Martinique', 'MQ', 'MTQ', 1);
INSERT INTO zencartcountries VALUES (135, 'Mauritania', 'MR', 'MRT', 1);
INSERT INTO zencartcountries VALUES (136, 'Mauritius', 'MU', 'MUS', 1);
INSERT INTO zencartcountries VALUES (137, 'Mayotte', 'YT', 'MYT', 1);
INSERT INTO zencartcountries VALUES (138, 'Mexico', 'MX', 'MEX', 1);
INSERT INTO zencartcountries VALUES (139, 'Micronesia, Federated States of', 'FM', 'FSM', 1);
INSERT INTO zencartcountries VALUES (140, 'Moldova, Republic of', 'MD', 'MDA', 1);
INSERT INTO zencartcountries VALUES (141, 'Monaco', 'MC', 'MCO', 1);
INSERT INTO zencartcountries VALUES (142, 'Mongolia', 'MN', 'MNG', 1);
INSERT INTO zencartcountries VALUES (143, 'Montserrat', 'MS', 'MSR', 1);
INSERT INTO zencartcountries VALUES (144, 'Morocco', 'MA', 'MAR', 1);
INSERT INTO zencartcountries VALUES (145, 'Mozambique', 'MZ', 'MOZ', 1);
INSERT INTO zencartcountries VALUES (146, 'Myanmar', 'MM', 'MMR', 1);
INSERT INTO zencartcountries VALUES (147, 'Namibia', 'NA', 'NAM', 1);
INSERT INTO zencartcountries VALUES (148, 'Nauru', 'NR', 'NRU', 1);
INSERT INTO zencartcountries VALUES (149, 'Nepal', 'NP', 'NPL', 1);
INSERT INTO zencartcountries VALUES (150, 'Netherlands', 'NL', 'NLD', 1);
INSERT INTO zencartcountries VALUES (151, 'Netherlands Antilles', 'AN', 'ANT', 1);
INSERT INTO zencartcountries VALUES (152, 'New Caledonia', 'NC', 'NCL', 1);
INSERT INTO zencartcountries VALUES (153, 'New Zealand', 'NZ', 'NZL', 1);
INSERT INTO zencartcountries VALUES (154, 'Nicaragua', 'NI', 'NIC', 1);
INSERT INTO zencartcountries VALUES (155, 'Niger', 'NE', 'NER', 1);
INSERT INTO zencartcountries VALUES (156, 'Nigeria', 'NG', 'NGA', 1);
INSERT INTO zencartcountries VALUES (157, 'Niue', 'NU', 'NIU', 1);
INSERT INTO zencartcountries VALUES (158, 'Norfolk Island', 'NF', 'NFK', 1);
INSERT INTO zencartcountries VALUES (159, 'Northern Mariana Islands', 'MP', 'MNP', 1);
INSERT INTO zencartcountries VALUES (160, 'Norway', 'NO', 'NOR', 1);
INSERT INTO zencartcountries VALUES (161, 'Oman', 'OM', 'OMN', 1);
INSERT INTO zencartcountries VALUES (162, 'Pakistan', 'PK', 'PAK', 1);
INSERT INTO zencartcountries VALUES (163, 'Palau', 'PW', 'PLW', 1);
INSERT INTO zencartcountries VALUES (164, 'Panama', 'PA', 'PAN', 1);
INSERT INTO zencartcountries VALUES (165, 'Papua New Guinea', 'PG', 'PNG', 1);
INSERT INTO zencartcountries VALUES (166, 'Paraguay', 'PY', 'PRY', 1);
INSERT INTO zencartcountries VALUES (167, 'Peru', 'PE', 'PER', 1);
INSERT INTO zencartcountries VALUES (168, 'Philippines', 'PH', 'PHL', 1);
INSERT INTO zencartcountries VALUES (169, 'Pitcairn', 'PN', 'PCN', 1);
INSERT INTO zencartcountries VALUES (170, 'Poland', 'PL', 'POL', 1);
INSERT INTO zencartcountries VALUES (171, 'Portugal', 'PT', 'PRT', 1);
INSERT INTO zencartcountries VALUES (172, 'Puerto Rico', 'PR', 'PRI', 1);
INSERT INTO zencartcountries VALUES (173, 'Qatar', 'QA', 'QAT', 1);
INSERT INTO zencartcountries VALUES (174, 'Reunion', 'RE', 'REU', 1);
INSERT INTO zencartcountries VALUES (175, 'Romania', 'RO', 'ROM', 1);
INSERT INTO zencartcountries VALUES (176, 'Russian Federation', 'RU', 'RUS', 1);
INSERT INTO zencartcountries VALUES (177, 'Rwanda', 'RW', 'RWA', 1);
INSERT INTO zencartcountries VALUES (178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1);
INSERT INTO zencartcountries VALUES (179, 'Saint Lucia', 'LC', 'LCA', 1);
INSERT INTO zencartcountries VALUES (180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1);
INSERT INTO zencartcountries VALUES (181, 'Samoa', 'WS', 'WSM', 1);
INSERT INTO zencartcountries VALUES (182, 'San Marino', 'SM', 'SMR', 1);
INSERT INTO zencartcountries VALUES (183, 'Sao Tome and Principe', 'ST', 'STP', 1);
INSERT INTO zencartcountries VALUES (184, 'Saudi Arabia', 'SA', 'SAU', 1);
INSERT INTO zencartcountries VALUES (185, 'Senegal', 'SN', 'SEN', 1);
INSERT INTO zencartcountries VALUES (186, 'Seychelles', 'SC', 'SYC', 1);
INSERT INTO zencartcountries VALUES (187, 'Sierra Leone', 'SL', 'SLE', 1);
INSERT INTO zencartcountries VALUES (188, 'Singapore', 'SG', 'SGP', 4);
INSERT INTO zencartcountries VALUES (189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1);
INSERT INTO zencartcountries VALUES (190, 'Slovenia', 'SI', 'SVN', 1);
INSERT INTO zencartcountries VALUES (191, 'Solomon Islands', 'SB', 'SLB', 1);
INSERT INTO zencartcountries VALUES (192, 'Somalia', 'SO', 'SOM', 1);
INSERT INTO zencartcountries VALUES (193, 'South Africa', 'ZA', 'ZAF', 1);
INSERT INTO zencartcountries VALUES (194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1);
INSERT INTO zencartcountries VALUES (195, 'Spain', 'ES', 'ESP', 3);
INSERT INTO zencartcountries VALUES (196, 'Sri Lanka', 'LK', 'LKA', 1);
INSERT INTO zencartcountries VALUES (197, 'St. Helena', 'SH', 'SHN', 1);
INSERT INTO zencartcountries VALUES (198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1);
INSERT INTO zencartcountries VALUES (199, 'Sudan', 'SD', 'SDN', 1);
INSERT INTO zencartcountries VALUES (200, 'Suriname', 'SR', 'SUR', 1);
INSERT INTO zencartcountries VALUES (201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1);
INSERT INTO zencartcountries VALUES (202, 'Swaziland', 'SZ', 'SWZ', 1);
INSERT INTO zencartcountries VALUES (203, 'Sweden', 'SE', 'SWE', 1);
INSERT INTO zencartcountries VALUES (204, 'Switzerland', 'CH', 'CHE', 1);
INSERT INTO zencartcountries VALUES (205, 'Syrian Arab Republic', 'SY', 'SYR', 1);
INSERT INTO zencartcountries VALUES (206, 'Taiwan', 'TW', 'TWN', 1);
INSERT INTO zencartcountries VALUES (207, 'Tajikistan', 'TJ', 'TJK', 1);
INSERT INTO zencartcountries VALUES (208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1);
INSERT INTO zencartcountries VALUES (209, 'Thailand', 'TH', 'THA', 1);
INSERT INTO zencartcountries VALUES (210, 'Togo', 'TG', 'TGO', 1);
INSERT INTO zencartcountries VALUES (211, 'Tokelau', 'TK', 'TKL', 1);
INSERT INTO zencartcountries VALUES (212, 'Tonga', 'TO', 'TON', 1);
INSERT INTO zencartcountries VALUES (213, 'Trinidad and Tobago', 'TT', 'TTO', 1);
INSERT INTO zencartcountries VALUES (214, 'Tunisia', 'TN', 'TUN', 1);
INSERT INTO zencartcountries VALUES (215, 'Turkey', 'TR', 'TUR', 1);
INSERT INTO zencartcountries VALUES (216, 'Turkmenistan', 'TM', 'TKM', 1);
INSERT INTO zencartcountries VALUES (217, 'Turks and Caicos Islands', 'TC', 'TCA', 1);
INSERT INTO zencartcountries VALUES (218, 'Tuvalu', 'TV', 'TUV', 1);
INSERT INTO zencartcountries VALUES (219, 'Uganda', 'UG', 'UGA', 1);
INSERT INTO zencartcountries VALUES (220, 'Ukraine', 'UA', 'UKR', 1);
INSERT INTO zencartcountries VALUES (221, 'United Arab Emirates', 'AE', 'ARE', 1);
INSERT INTO zencartcountries VALUES (222, 'United Kingdom', 'GB', 'GBR', 6);
INSERT INTO zencartcountries VALUES (223, 'United States', 'US', 'USA', 2);
INSERT INTO zencartcountries VALUES (224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1);
INSERT INTO zencartcountries VALUES (225, 'Uruguay', 'UY', 'URY', 1);
INSERT INTO zencartcountries VALUES (226, 'Uzbekistan', 'UZ', 'UZB', 1);
INSERT INTO zencartcountries VALUES (227, 'Vanuatu', 'VU', 'VUT', 1);
INSERT INTO zencartcountries VALUES (228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1);
INSERT INTO zencartcountries VALUES (229, 'Venezuela', 'VE', 'VEN', 1);
INSERT INTO zencartcountries VALUES (230, 'Viet Nam', 'VN', 'VNM', 1);
INSERT INTO zencartcountries VALUES (231, 'Virgin Islands (British)', 'VG', 'VGB', 1);
INSERT INTO zencartcountries VALUES (232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1);
INSERT INTO zencartcountries VALUES (233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1);
INSERT INTO zencartcountries VALUES (234, 'Western Sahara', 'EH', 'ESH', 1);
INSERT INTO zencartcountries VALUES (235, 'Yemen', 'YE', 'YEM', 1);
INSERT INTO zencartcountries VALUES (236, 'Yugoslavia', 'YU', 'YUG', 1);
INSERT INTO zencartcountries VALUES (237, 'Zaire', 'ZR', 'ZAR', 1);
INSERT INTO zencartcountries VALUES (238, 'Zambia', 'ZM', 'ZMB', 1);
INSERT INTO zencartcountries VALUES (239, 'Zimbabwe', 'ZW', 'ZWE', 1);


--
-- Data for Name: zencartcoupon_email_track; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupon_gv_customer; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupon_gv_queue; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupon_redeem_track; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupon_restrict; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupons; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcoupons_description; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcurrencies; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcurrencies VALUES (6, 'NZ Dollar', 'NZD', '$', '', '.', ',', '2', 1, '2007-10-31 15:27:25.597022');


--
-- Data for Name: zencartcustomers; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcustomers VALUES (1, 'm', 'Pete', 'Black', '1975-06-13 00:00:00', 'pete@catalyst.net.nz', '', 1, '04 972 7859', '', 'c1a60ae52fa4c2e767c88ef9fda8f3a3:04', '0', 0, 'TEXT', 0, '', '', 0);


--
-- Data for Name: zencartcustomers_basket; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcustomers_basket_attributes; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartcustomers_info; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartcustomers_info VALUES (1, '2007-10-03 15:25:37.993515', 2, '2007-10-03 13:14:14.707242', '2007-10-03 15:25:53.717727', 0);


--
-- Data for Name: zencartcustomers_wishlist; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartdb_cache; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartemail_archive; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartezpages; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartfeatured; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartfiles_uploaded; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartgeo_zones; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartget_terms_to_filter; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartget_terms_to_filter VALUES ('manufacturers_id', 'TABLE_MANUFACTURERS', 'manufacturers_name');
INSERT INTO zencartget_terms_to_filter VALUES ('music_genre_id', 'TABLE_MUSIC_GENRE', 'music_genre_name');
INSERT INTO zencartget_terms_to_filter VALUES ('record_company_id', 'TABLE_RECORD_COMPANY', 'record_company_name');


--
-- Data for Name: zencartgroup_pricing; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartlanguages; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartlanguages VALUES (1, 'English', 'en', 'icon.gif', 'english', 1);


--
-- Data for Name: zencartlayout_boxes; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartlayout_boxes VALUES (1, 'default_template_settings', 'banner_box_all.php', 1, 1, 5, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (2, 'default_template_settings', 'banner_box.php', 1, 0, 300, 1, 127);
INSERT INTO zencartlayout_boxes VALUES (3, 'default_template_settings', 'banner_box2.php', 1, 1, 15, 1, 15);
INSERT INTO zencartlayout_boxes VALUES (4, 'default_template_settings', 'best_sellers.php', 1, 1, 30, 70, 1);
INSERT INTO zencartlayout_boxes VALUES (5, 'default_template_settings', 'categories.php', 1, 0, 10, 10, 1);
INSERT INTO zencartlayout_boxes VALUES (6, 'default_template_settings', 'currencies.php', 1, 1, 80, 60, 1);
INSERT INTO zencartlayout_boxes VALUES (7, 'default_template_settings', 'document_categories.php', 1, 0, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (8, 'default_template_settings', 'ezpages.php', 1, 1, -1, 2, 1);
INSERT INTO zencartlayout_boxes VALUES (9, 'default_template_settings', 'featured.php', 1, 0, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (10, 'default_template_settings', 'information.php', 1, 0, 50, 40, 1);
INSERT INTO zencartlayout_boxes VALUES (11, 'default_template_settings', 'languages.php', 1, 1, 70, 50, 1);
INSERT INTO zencartlayout_boxes VALUES (12, 'default_template_settings', 'manufacturers.php', 1, 0, 30, 20, 1);
INSERT INTO zencartlayout_boxes VALUES (13, 'default_template_settings', 'manufacturer_info.php', 1, 1, 35, 95, 1);
INSERT INTO zencartlayout_boxes VALUES (14, 'default_template_settings', 'more_information.php', 1, 0, 200, 200, 1);
INSERT INTO zencartlayout_boxes VALUES (15, 'default_template_settings', 'music_genres.php', 1, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (16, 'default_template_settings', 'order_history.php', 1, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (17, 'default_template_settings', 'product_notifications.php', 1, 1, 55, 85, 1);
INSERT INTO zencartlayout_boxes VALUES (18, 'default_template_settings', 'record_companies.php', 1, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (19, 'default_template_settings', 'reviews.php', 1, 0, 40, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (20, 'default_template_settings', 'search.php', 1, 1, 10, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (21, 'default_template_settings', 'search_header.php', 0, 0, 0, 0, 1);
INSERT INTO zencartlayout_boxes VALUES (22, 'default_template_settings', 'shopping_cart.php', 1, 1, 20, 30, 1);
INSERT INTO zencartlayout_boxes VALUES (23, 'default_template_settings', 'specials.php', 1, 1, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (24, 'default_template_settings', 'tell_a_friend.php', 1, 1, 65, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (25, 'default_template_settings', 'whats_new.php', 1, 0, 20, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (26, 'default_template_settings', 'whos_online.php', 1, 1, 200, 200, 1);
INSERT INTO zencartlayout_boxes VALUES (27, 'template_default', 'banner_box_all.php', 1, 1, 5, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (28, 'template_default', 'banner_box.php', 1, 0, 300, 1, 127);
INSERT INTO zencartlayout_boxes VALUES (29, 'template_default', 'banner_box2.php', 1, 1, 15, 1, 15);
INSERT INTO zencartlayout_boxes VALUES (30, 'template_default', 'best_sellers.php', 1, 1, 30, 70, 1);
INSERT INTO zencartlayout_boxes VALUES (31, 'template_default', 'categories.php', 1, 0, 10, 10, 1);
INSERT INTO zencartlayout_boxes VALUES (32, 'template_default', 'currencies.php', 1, 1, 80, 60, 1);
INSERT INTO zencartlayout_boxes VALUES (33, 'template_default', 'ezpages.php', 1, 1, -1, 2, 1);
INSERT INTO zencartlayout_boxes VALUES (34, 'template_default', 'featured.php', 1, 0, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (35, 'template_default', 'information.php', 1, 0, 50, 40, 1);
INSERT INTO zencartlayout_boxes VALUES (36, 'template_default', 'languages.php', 1, 1, 70, 50, 1);
INSERT INTO zencartlayout_boxes VALUES (37, 'template_default', 'manufacturers.php', 1, 0, 30, 20, 1);
INSERT INTO zencartlayout_boxes VALUES (38, 'template_default', 'manufacturer_info.php', 1, 1, 35, 95, 1);
INSERT INTO zencartlayout_boxes VALUES (39, 'template_default', 'more_information.php', 1, 0, 200, 200, 1);
INSERT INTO zencartlayout_boxes VALUES (40, 'template_default', 'my_broken_box.php', 1, 0, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (41, 'template_default', 'order_history.php', 1, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (42, 'template_default', 'product_notifications.php', 1, 1, 55, 85, 1);
INSERT INTO zencartlayout_boxes VALUES (43, 'template_default', 'reviews.php', 1, 0, 40, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (44, 'template_default', 'search.php', 1, 1, 10, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (45, 'template_default', 'search_header.php', 0, 0, 0, 0, 1);
INSERT INTO zencartlayout_boxes VALUES (46, 'template_default', 'shopping_cart.php', 1, 1, 20, 30, 1);
INSERT INTO zencartlayout_boxes VALUES (47, 'template_default', 'specials.php', 1, 1, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (48, 'template_default', 'tell_a_friend.php', 1, 1, 65, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (49, 'template_default', 'whats_new.php', 1, 0, 20, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (50, 'template_default', 'whos_online.php', 1, 1, 200, 200, 1);
INSERT INTO zencartlayout_boxes VALUES (57, 'classic', 'document_categories.php', 0, 0, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (71, 'classic', 'search_header.php', 0, 0, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (55, 'classic', 'categories.php', 0, 0, 10, 10, 0);
INSERT INTO zencartlayout_boxes VALUES (62, 'classic', 'manufacturers.php', 0, 0, 30, 20, 0);
INSERT INTO zencartlayout_boxes VALUES (75, 'classic', 'whats_new.php', 0, 0, 20, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (69, 'classic', 'reviews.php', 0, 0, 40, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (59, 'classic', 'featured.php', 0, 0, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (60, 'classic', 'information.php', 0, 0, 50, 40, 0);
INSERT INTO zencartlayout_boxes VALUES (64, 'classic', 'more_information.php', 0, 0, 200, 200, 0);
INSERT INTO zencartlayout_boxes VALUES (51, 'classic', 'banner_box.php', 0, 0, 300, 1, 0);
INSERT INTO zencartlayout_boxes VALUES (58, 'classic', 'ezpages.php', 0, 1, -1, 2, 0);
INSERT INTO zencartlayout_boxes VALUES (68, 'classic', 'record_companies.php', 0, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (66, 'classic', 'order_history.php', 0, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (65, 'classic', 'music_genres.php', 0, 1, 0, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (53, 'classic', 'banner_box_all.php', 0, 1, 5, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (70, 'classic', 'search.php', 0, 1, 10, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (52, 'classic', 'banner_box2.php', 0, 1, 15, 1, 0);
INSERT INTO zencartlayout_boxes VALUES (72, 'classic', 'shopping_cart.php', 0, 1, 20, 30, 0);
INSERT INTO zencartlayout_boxes VALUES (54, 'classic', 'best_sellers.php', 0, 1, 30, 70, 0);
INSERT INTO zencartlayout_boxes VALUES (63, 'classic', 'manufacturer_info.php', 0, 1, 35, 95, 0);
INSERT INTO zencartlayout_boxes VALUES (67, 'classic', 'product_notifications.php', 0, 1, 55, 85, 0);
INSERT INTO zencartlayout_boxes VALUES (73, 'classic', 'specials.php', 0, 1, 45, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (74, 'classic', 'tell_a_friend.php', 0, 1, 65, 0, 0);
INSERT INTO zencartlayout_boxes VALUES (61, 'classic', 'languages.php', 0, 1, 70, 50, 0);
INSERT INTO zencartlayout_boxes VALUES (56, 'classic', 'currencies.php', 0, 1, 80, 60, 0);
INSERT INTO zencartlayout_boxes VALUES (76, 'classic', 'whos_online.php', 0, 1, 200, 200, 0);


--
-- Data for Name: zencartmanufacturers; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmanufacturers_info; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmedia_clips; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmedia_manager; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmedia_to_products; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmedia_types; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartmedia_types VALUES (1, 'MP3', '.mp3');


--
-- Data for Name: zencartmeta_tags_categories_description; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmeta_tags_products_description; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartmusic_genre; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartnewsletters; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartorders; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartorders_products; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartorders_products_attributes; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartorders_products_download; Type: TABLE DATA; Schema: public; Owner: sounz
--




--
-- Data for Name: zencartorders_status; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartorders_status VALUES (1, 1, 'Pending');
INSERT INTO zencartorders_status VALUES (2, 1, 'Processing');
INSERT INTO zencartorders_status VALUES (3, 1, 'Delivered');
INSERT INTO zencartorders_status VALUES (4, 1, 'Update');


--
-- Data for Name: zencartorders_status_history; Type: TABLE DATA; Schema: public; Owner: sounz
--




--
-- Data for Name: zencartorders_total; Type: TABLE DATA; Schema: public; Owner: sounz
--




--
-- Data for Name: zencartpaypal; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartpaypal_payment_status; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartpaypal_payment_status VALUES (1, 'Completed');
INSERT INTO zencartpaypal_payment_status VALUES (2, 'Pending');
INSERT INTO zencartpaypal_payment_status VALUES (3, 'Failed');
INSERT INTO zencartpaypal_payment_status VALUES (4, 'Denied');
INSERT INTO zencartpaypal_payment_status VALUES (5, 'Refunded');
INSERT INTO zencartpaypal_payment_status VALUES (6, 'Canceled_Reversal');
INSERT INTO zencartpaypal_payment_status VALUES (7, 'Reversed');


--
-- Data for Name: zencartpaypal_payment_status_history; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartpaypal_session; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartpaypal_testing; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartproduct_music_extra; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartproduct_type_layout; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproduct_type_layout VALUES (1, 'Show Model Number', 'SHOW_PRODUCT_INFO_MODEL', '1', 'Display Model Number on Product Info 0= off 1= on', 1, 1, NULL, '2007-09-26 17:05:51.784078', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (2, 'Show Weight', 'SHOW_PRODUCT_INFO_WEIGHT', '1', 'Display Weight on Product Info 0= off 1= on', 1, 2, NULL, '2007-09-26 17:05:51.789714', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (3, 'Show Attribute Weight', 'SHOW_PRODUCT_INFO_WEIGHT_ATTRIBUTES', '1', 'Display Attribute Weight on Product Info 0= off 1= on', 1, 3, NULL, '2007-09-26 17:05:51.793539', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (4, 'Show Manufacturer', 'SHOW_PRODUCT_INFO_MANUFACTURER', '1', 'Display Manufacturer Name on Product Info 0= off 1= on', 1, 4, NULL, '2007-09-26 17:05:51.797417', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (5, 'Show Quantity in Shopping Cart', 'SHOW_PRODUCT_INFO_IN_CART_QTY', '1', 'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', 1, 5, NULL, '2007-09-26 17:05:51.801704', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (6, 'Show Quantity in Stock', 'SHOW_PRODUCT_INFO_QUANTITY', '1', 'Display Quantity in Stock on Product Info 0= off 1= on', 1, 6, NULL, '2007-09-26 17:05:51.806521', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (7, 'Show Product Reviews Count', 'SHOW_PRODUCT_INFO_REVIEWS_COUNT', '1', 'Display Product Reviews Count on Product Info 0= off 1= on', 1, 7, NULL, '2007-09-26 17:05:51.810687', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (8, 'Show Product Reviews Button', 'SHOW_PRODUCT_INFO_REVIEWS', '1', 'Display Product Reviews Button on Product Info 0= off 1= on', 1, 8, NULL, '2007-09-26 17:05:51.814456', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (9, 'Show Date Available', 'SHOW_PRODUCT_INFO_DATE_AVAILABLE', '1', 'Display Date Available on Product Info 0= off 1= on', 1, 9, NULL, '2007-09-26 17:05:51.818486', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (10, 'Show Date Added', 'SHOW_PRODUCT_INFO_DATE_ADDED', '1', 'Display Date Added on Product Info 0= off 1= on', 1, 10, NULL, '2007-09-26 17:05:51.822435', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (11, 'Show Product URL', 'SHOW_PRODUCT_INFO_URL', '1', 'Display URL on Product Info 0= off 1= on', 1, 11, NULL, '2007-09-26 17:05:51.826201', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (12, 'Show Product Additional Images', 'SHOW_PRODUCT_INFO_ADDITIONAL_IMAGES', '1', 'Display Additional Images on Product Info 0= off 1= on', 1, 13, NULL, '2007-09-26 17:05:51.8305', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (13, 'Show Starting At text on Price', 'SHOW_PRODUCT_INFO_STARTING_AT', '1', 'Display Starting At text on products with attributes Product Info 0= off 1= on', 1, 12, NULL, '2007-09-26 17:05:51.834394', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (14, 'Show Product Tell a Friend button', 'SHOW_PRODUCT_INFO_TELL_A_FRIEND', '1', 'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', 1, 15, NULL, '2007-09-26 17:05:51.838889', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (15, 'Product Free Shipping Image Status - Catalog', 'SHOW_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '0', 'Show the Free Shipping image/text in the catalog?', 1, 16, NULL, '2007-09-26 17:05:51.843317', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (16, 'Product Price Tax Class Default - When adding new products?', 'DEFAULT_PRODUCT_TAX_CLASS_ID', '0', 'What should the Product Price Tax Class Default ID be when adding new products?', 1, 100, NULL, '2007-09-26 17:05:51.847294', '', '');
INSERT INTO zencartproduct_type_layout VALUES (17, 'Product Virtual Default Status - Skip Shipping Address - When adding new products?', 'DEFAULT_PRODUCT_PRODUCTS_VIRTUAL', '0', 'Default Virtual Product status to be ON when adding new products?', 1, 101, NULL, '2007-09-26 17:05:51.851558', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (18, 'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', 'DEFAULT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', 'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', 1, 102, NULL, '2007-09-26 17:05:51.855445', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');
INSERT INTO zencartproduct_type_layout VALUES (19, 'Show Model Number', 'SHOW_PRODUCT_MUSIC_INFO_MODEL', '1', 'Display Model Number on Product Info 0= off 1= on', 2, 1, NULL, '2007-09-26 17:05:51.859301', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (20, 'Show Weight', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT', '0', 'Display Weight on Product Info 0= off 1= on', 2, 2, NULL, '2007-09-26 17:05:51.863852', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (21, 'Show Attribute Weight', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT_ATTRIBUTES', '1', 'Display Attribute Weight on Product Info 0= off 1= on', 2, 3, NULL, '2007-09-26 17:05:51.868015', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (22, 'Show Artist', 'SHOW_PRODUCT_MUSIC_INFO_ARTIST', '1', 'Display Artists Name on Product Info 0= off 1= on', 2, 4, NULL, '2007-09-26 17:05:51.872513', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (23, 'Show Music Genre', 'SHOW_PRODUCT_MUSIC_INFO_GENRE', '1', 'Display Music Genre on Product Info 0= off 1= on', 2, 4, NULL, '2007-09-26 17:05:51.876205', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (24, 'Show Record Company', 'SHOW_PRODUCT_MUSIC_INFO_RECORD_COMPANY', '1', 'Display Record Company on Product Info 0= off 1= on', 2, 4, NULL, '2007-09-26 17:05:51.880191', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (25, 'Show Quantity in Shopping Cart', 'SHOW_PRODUCT_MUSIC_INFO_IN_CART_QTY', '1', 'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', 2, 5, NULL, '2007-09-26 17:05:51.884936', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (26, 'Show Quantity in Stock', 'SHOW_PRODUCT_MUSIC_INFO_QUANTITY', '0', 'Display Quantity in Stock on Product Info 0= off 1= on', 2, 6, NULL, '2007-09-26 17:05:51.88961', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (27, 'Show Product Reviews Count', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS_COUNT', '1', 'Display Product Reviews Count on Product Info 0= off 1= on', 2, 7, NULL, '2007-09-26 17:05:51.89341', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (28, 'Show Product Reviews Button', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS', '1', 'Display Product Reviews Button on Product Info 0= off 1= on', 2, 8, NULL, '2007-09-26 17:05:51.897275', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (29, 'Show Date Available', 'SHOW_PRODUCT_MUSIC_INFO_DATE_AVAILABLE', '1', 'Display Date Available on Product Info 0= off 1= on', 2, 9, NULL, '2007-09-26 17:05:51.901525', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (30, 'Show Date Added', 'SHOW_PRODUCT_MUSIC_INFO_DATE_ADDED', '1', 'Display Date Added on Product Info 0= off 1= on', 2, 10, NULL, '2007-09-26 17:05:51.906164', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (31, 'Show Starting At text on Price', 'SHOW_PRODUCT_MUSIC_INFO_STARTING_AT', '1', 'Display Starting At text on products with attributes Product Info 0= off 1= on', 2, 12, NULL, '2007-09-26 17:05:51.910482', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (32, 'Show Product Additional Images', 'SHOW_PRODUCT_MUSIC_INFO_ADDITIONAL_IMAGES', '1', 'Display Additional Images on Product Info 0= off 1= on', 2, 13, NULL, '2007-09-26 17:05:51.914857', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (33, 'Show Product Tell a Friend button', 'SHOW_PRODUCT_MUSIC_INFO_TELL_A_FRIEND', '1', 'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', 2, 15, NULL, '2007-09-26 17:05:51.918655', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (34, 'Product Free Shipping Image Status - Catalog', 'SHOW_PRODUCT_MUSIC_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '0', 'Show the Free Shipping image/text in the catalog?', 2, 16, NULL, '2007-09-26 17:05:51.922501', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (35, 'Product Price Tax Class Default - When adding new products?', 'DEFAULT_PRODUCT_MUSIC_TAX_CLASS_ID', '0', 'What should the Product Price Tax Class Default ID be when adding new products?', 2, 100, NULL, '2007-09-26 17:05:51.926502', '', '');
INSERT INTO zencartproduct_type_layout VALUES (36, 'Product Virtual Default Status - Skip Shipping Address - When adding new products?', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_VIRTUAL', '0', 'Default Virtual Product status to be ON when adding new products?', 2, 101, NULL, '2007-09-26 17:05:51.930666', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (37, 'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', 'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', 2, 102, NULL, '2007-09-26 17:05:51.934558', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');
INSERT INTO zencartproduct_type_layout VALUES (38, 'Show Product Reviews Count', 'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS_COUNT', '1', 'Display Product Reviews Count on Product Info 0= off 1= on', 3, 7, NULL, '2007-09-26 17:05:51.938631', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (39, 'Show Product Reviews Button', 'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS', '1', 'Display Product Reviews Button on Product Info 0= off 1= on', 3, 8, NULL, '2007-09-26 17:05:51.942441', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (40, 'Show Date Available', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_AVAILABLE', '1', 'Display Date Available on Product Info 0= off 1= on', 3, 9, NULL, '2007-09-26 17:05:51.9462', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (41, 'Show Date Added', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_ADDED', '1', 'Display Date Added on Product Info 0= off 1= on', 3, 10, NULL, '2007-09-26 17:05:51.951133', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (42, 'Show Product Tell a Friend button', 'SHOW_DOCUMENT_GENERAL_INFO_TELL_A_FRIEND', '1', 'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', 3, 15, NULL, '2007-09-26 17:05:51.954955', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (43, 'Show Product URL', 'SHOW_DOCUMENT_GENERAL_INFO_URL', '1', 'Display URL on Product Info 0= off 1= on', 3, 11, NULL, '2007-09-26 17:05:51.958665', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (44, 'Show Product Additional Images', 'SHOW_DOCUMENT_GENERAL_INFO_ADDITIONAL_IMAGES', '1', 'Display Additional Images on Product Info 0= off 1= on', 3, 13, NULL, '2007-09-26 17:05:51.962501', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (45, 'Show Model Number', 'SHOW_DOCUMENT_PRODUCT_INFO_MODEL', '1', 'Display Model Number on Product Info 0= off 1= on', 4, 1, NULL, '2007-09-26 17:05:51.966459', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (46, 'Show Weight', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT', '0', 'Display Weight on Product Info 0= off 1= on', 4, 2, NULL, '2007-09-26 17:05:51.971747', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (47, 'Show Attribute Weight', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT_ATTRIBUTES', '1', 'Display Attribute Weight on Product Info 0= off 1= on', 4, 3, NULL, '2007-09-26 17:05:51.975607', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (48, 'Show Manufacturer', 'SHOW_DOCUMENT_PRODUCT_INFO_MANUFACTURER', '1', 'Display Manufacturer Name on Product Info 0= off 1= on', 4, 4, NULL, '2007-09-26 17:05:51.979301', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (49, 'Show Quantity in Shopping Cart', 'SHOW_DOCUMENT_PRODUCT_INFO_IN_CART_QTY', '1', 'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', 4, 5, NULL, '2007-09-26 17:05:51.983124', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (50, 'Show Quantity in Stock', 'SHOW_DOCUMENT_PRODUCT_INFO_QUANTITY', '0', 'Display Quantity in Stock on Product Info 0= off 1= on', 4, 6, NULL, '2007-09-26 17:05:51.987286', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (51, 'Show Product Reviews Count', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS_COUNT', '1', 'Display Product Reviews Count on Product Info 0= off 1= on', 4, 7, NULL, '2007-09-26 17:05:51.991432', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (52, 'Show Product Reviews Button', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS', '1', 'Display Product Reviews Button on Product Info 0= off 1= on', 4, 8, NULL, '2007-09-26 17:05:51.995385', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (53, 'Show Date Available', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_AVAILABLE', '1', 'Display Date Available on Product Info 0= off 1= on', 4, 9, NULL, '2007-09-26 17:05:51.999318', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (54, 'Show Date Added', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_ADDED', '1', 'Display Date Added on Product Info 0= off 1= on', 4, 10, NULL, '2007-09-26 17:05:52.003428', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (55, 'Show Product URL', 'SHOW_DOCUMENT_PRODUCT_INFO_URL', '1', 'Display URL on Product Info 0= off 1= on', 4, 11, NULL, '2007-09-26 17:05:52.007346', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (56, 'Show Product Additional Images', 'SHOW_DOCUMENT_PRODUCT_INFO_ADDITIONAL_IMAGES', '1', 'Display Additional Images on Product Info 0= off 1= on', 4, 13, NULL, '2007-09-26 17:05:52.01867', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (57, 'Show Starting At text on Price', 'SHOW_DOCUMENT_PRODUCT_INFO_STARTING_AT', '1', 'Display Starting At text on products with attributes Product Info 0= off 1= on', 4, 12, NULL, '2007-09-26 17:05:52.022402', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (58, 'Show Product Tell a Friend button', 'SHOW_DOCUMENT_PRODUCT_INFO_TELL_A_FRIEND', '1', 'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', 4, 15, NULL, '2007-09-26 17:05:52.026943', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (59, 'Product Free Shipping Image Status - Catalog', 'SHOW_DOCUMENT_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '0', 'Show the Free Shipping image/text in the catalog?', 4, 16, NULL, '2007-09-26 17:05:52.031329', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (60, 'Product Price Tax Class Default - When adding new products?', 'DEFAULT_DOCUMENT_PRODUCT_TAX_CLASS_ID', '0', 'What should the Product Price Tax Class Default ID be when adding new products?', 4, 100, NULL, '2007-09-26 17:05:52.035592', '', '');
INSERT INTO zencartproduct_type_layout VALUES (61, 'Product Virtual Default Status - Skip Shipping Address - When adding new products?', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_VIRTUAL', '0', 'Default Virtual Product status to be ON when adding new products?', 4, 101, NULL, '2007-09-26 17:05:52.039305', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (62, 'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', 'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', 4, 102, NULL, '2007-09-26 17:05:52.043083', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');
INSERT INTO zencartproduct_type_layout VALUES (63, 'Show Model Number', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MODEL', '1', 'Display Model Number on Product Info 0= off 1= on', 5, 1, NULL, '2007-09-26 17:05:52.047522', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (64, 'Show Weight', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT', '0', 'Display Weight on Product Info 0= off 1= on', 5, 2, NULL, '2007-09-26 17:05:52.051548', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (65, 'Show Attribute Weight', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT_ATTRIBUTES', '1', 'Display Attribute Weight on Product Info 0= off 1= on', 5, 3, NULL, '2007-09-26 17:05:52.056011', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (66, 'Show Manufacturer', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MANUFACTURER', '1', 'Display Manufacturer Name on Product Info 0= off 1= on', 5, 4, NULL, '2007-09-26 17:05:52.059905', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (67, 'Show Quantity in Shopping Cart', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_IN_CART_QTY', '1', 'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', 5, 5, NULL, '2007-09-26 17:05:52.063601', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (68, 'Show Quantity in Stock', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_QUANTITY', '1', 'Display Quantity in Stock on Product Info 0= off 1= on', 5, 6, NULL, '2007-09-26 17:05:52.067482', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (69, 'Show Product Reviews Count', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS_COUNT', '1', 'Display Product Reviews Count on Product Info 0= off 1= on', 5, 7, NULL, '2007-09-26 17:05:52.071887', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (70, 'Show Product Reviews Button', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS', '1', 'Display Product Reviews Button on Product Info 0= off 1= on', 5, 8, NULL, '2007-09-26 17:05:52.077994', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (71, 'Show Date Available', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_AVAILABLE', '0', 'Display Date Available on Product Info 0= off 1= on', 5, 9, NULL, '2007-09-26 17:05:52.082134', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (72, 'Show Date Added', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_ADDED', '1', 'Display Date Added on Product Info 0= off 1= on', 5, 10, NULL, '2007-09-26 17:05:52.086438', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (73, 'Show Product URL', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_URL', '1', 'Display URL on Product Info 0= off 1= on', 5, 11, NULL, '2007-09-26 17:05:52.090815', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (74, 'Show Product Additional Images', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ADDITIONAL_IMAGES', '1', 'Display Additional Images on Product Info 0= off 1= on', 5, 13, NULL, '2007-09-26 17:05:52.094704', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (75, 'Show Starting At text on Price', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_STARTING_AT', '1', 'Display Starting At text on products with attributes Product Info 0= off 1= on', 5, 12, NULL, '2007-09-26 17:05:52.099457', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (76, 'Show Product Tell a Friend button', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_TELL_A_FRIEND', '1', 'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', 5, 15, NULL, '2007-09-26 17:05:52.10339', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (77, 'Product Free Shipping Image Status - Catalog', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '1', 'Show the Free Shipping image/text in the catalog?', 5, 16, NULL, '2007-09-26 17:05:52.107224', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (78, 'Product Price Tax Class Default - When adding new products?', 'DEFAULT_PRODUCT_FREE_SHIPPING_TAX_CLASS_ID', '0', 'What should the Product Price Tax Class Default ID be when adding new products?', 5, 100, NULL, '2007-09-26 17:05:52.111499', '', '');
INSERT INTO zencartproduct_type_layout VALUES (79, 'Product Virtual Default Status - Skip Shipping Address - When adding new products?', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_VIRTUAL', '0', 'Default Virtual Product status to be ON when adding new products?', 5, 101, NULL, '2007-09-26 17:05:52.11528', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (80, 'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '1', 'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', 5, 102, NULL, '2007-09-26 17:05:52.119947', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');
INSERT INTO zencartproduct_type_layout VALUES (81, 'Show Metatags Title Default - Product Title', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_STATUS', '1', 'Display Product Title in Meta Tags Title 0= off 1= on', 1, 50, NULL, '2007-09-26 17:05:52.123784', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (82, 'Show Metatags Title Default - Product Name', 'SHOW_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', 'Display Product Name in Meta Tags Title 0= off 1= on', 1, 51, NULL, '2007-09-26 17:05:52.127674', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (83, 'Show Metatags Title Default - Product Model', 'SHOW_PRODUCT_INFO_METATAGS_MODEL_STATUS', '1', 'Display Product Model in Meta Tags Title 0= off 1= on', 1, 52, NULL, '2007-09-26 17:05:52.131807', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (84, 'Show Metatags Title Default - Product Price', 'SHOW_PRODUCT_INFO_METATAGS_PRICE_STATUS', '1', 'Display Product Price in Meta Tags Title 0= off 1= on', 1, 53, NULL, '2007-09-26 17:05:52.136009', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (85, 'Show Metatags Title Default - Product Tagline', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', 'Display Product Tagline in Meta Tags Title 0= off 1= on', 1, 54, NULL, '2007-09-26 17:05:52.140264', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (86, 'Show Metatags Title Default - Product Title', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_STATUS', '1', 'Display Product Title in Meta Tags Title 0= off 1= on', 2, 50, NULL, '2007-09-26 17:05:52.144165', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (87, 'Show Metatags Title Default - Product Name', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', 'Display Product Name in Meta Tags Title 0= off 1= on', 2, 51, NULL, '2007-09-26 17:05:52.147914', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (88, 'Show Metatags Title Default - Product Model', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_MODEL_STATUS', '1', 'Display Product Model in Meta Tags Title 0= off 1= on', 2, 52, NULL, '2007-09-26 17:05:52.152554', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (89, 'Show Metatags Title Default - Product Price', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRICE_STATUS', '1', 'Display Product Price in Meta Tags Title 0= off 1= on', 2, 53, NULL, '2007-09-26 17:05:52.156457', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (90, 'Show Metatags Title Default - Product Tagline', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', 'Display Product Tagline in Meta Tags Title 0= off 1= on', 2, 54, NULL, '2007-09-26 17:05:52.16019', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (91, 'Show Metatags Title Default - Document Title', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_STATUS', '1', 'Display Document Title in Meta Tags Title 0= off 1= on', 3, 50, NULL, '2007-09-26 17:05:52.164215', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (92, 'Show Metatags Title Default - Document Name', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', 'Display Document Name in Meta Tags Title 0= off 1= on', 3, 51, NULL, '2007-09-26 17:05:52.168182', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (93, 'Show Metatags Title Default - Document Tagline', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', 'Display Document Tagline in Meta Tags Title 0= off 1= on', 3, 54, NULL, '2007-09-26 17:05:52.172542', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (94, 'Show Metatags Title Default - Document Title', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_STATUS', '1', 'Display Document Title in Meta Tags Title 0= off 1= on', 4, 50, NULL, '2007-09-26 17:05:52.176416', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (95, 'Show Metatags Title Default - Document Name', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', 'Display Document Name in Meta Tags Title 0= off 1= on', 4, 51, NULL, '2007-09-26 17:05:52.180293', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (96, 'Show Metatags Title Default - Document Model', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_MODEL_STATUS', '1', 'Display Document Model in Meta Tags Title 0= off 1= on', 4, 52, NULL, '2007-09-26 17:05:52.185416', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (97, 'Show Metatags Title Default - Document Price', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRICE_STATUS', '1', 'Display Document Price in Meta Tags Title 0= off 1= on', 4, 53, NULL, '2007-09-26 17:05:52.190361', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (98, 'Show Metatags Title Default - Document Tagline', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', 'Display Document Tagline in Meta Tags Title 0= off 1= on', 4, 54, NULL, '2007-09-26 17:05:52.194262', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (99, 'Show Metatags Title Default - Product Title', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_STATUS', '1', 'Display Product Title in Meta Tags Title 0= off 1= on', 5, 50, NULL, '2007-09-26 17:05:52.198729', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (100, 'Show Metatags Title Default - Product Name', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', 'Display Product Name in Meta Tags Title 0= off 1= on', 5, 51, NULL, '2007-09-26 17:05:52.202843', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (101, 'Show Metatags Title Default - Product Model', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_MODEL_STATUS', '1', 'Display Product Model in Meta Tags Title 0= off 1= on', 5, 52, NULL, '2007-09-26 17:05:52.207401', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (102, 'Show Metatags Title Default - Product Price', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRICE_STATUS', '1', 'Display Product Price in Meta Tags Title 0= off 1= on', 5, 53, NULL, '2007-09-26 17:05:52.211742', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (103, 'Show Metatags Title Default - Product Tagline', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', 'Display Product Tagline in Meta Tags Title 0= off 1= on', 5, 54, NULL, '2007-09-26 17:05:52.215717', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');
INSERT INTO zencartproduct_type_layout VALUES (104, 'PRODUCT Attribute is Display Only - Default', 'DEFAULT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', '0', 'PRODUCT Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', 1, 200, NULL, '2007-09-26 17:05:52.219695', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (105, 'PRODUCT Attribute is Free - Default', 'DEFAULT_PRODUCT_ATTRIBUTE_IS_FREE', '1', 'PRODUCT Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', 1, 201, NULL, '2007-09-26 17:05:52.223481', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (106, 'PRODUCT Attribute is Default - Default', 'DEFAULT_PRODUCT_ATTRIBUTES_DEFAULT', '0', 'PRODUCT Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', 1, 202, NULL, '2007-09-26 17:05:52.227887', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (107, 'PRODUCT Attribute is Discounted - Default', 'DEFAULT_PRODUCT_ATTRIBUTES_DISCOUNTED', '1', 'PRODUCT Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', 1, 203, NULL, '2007-09-26 17:05:52.23272', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (108, 'PRODUCT Attribute is Included in Base Price - Default', 'DEFAULT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', 'PRODUCT Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', 1, 204, NULL, '2007-09-26 17:05:52.236545', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (109, 'PRODUCT Attribute is Required - Default', 'DEFAULT_PRODUCT_ATTRIBUTES_REQUIRED', '0', 'PRODUCT Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', 1, 205, NULL, '2007-09-26 17:05:52.241181', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (110, 'PRODUCT Attribute Price Prefix - Default', 'DEFAULT_PRODUCT_PRICE_PREFIX', '1', 'PRODUCT Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', 1, 206, NULL, '2007-09-26 17:05:52.246296', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (111, 'PRODUCT Attribute Weight Prefix - Default', 'DEFAULT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', 'PRODUCT Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', 1, 207, NULL, '2007-09-26 17:05:52.2563', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (112, 'MUSIC Attribute is Display Only - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISPLAY_ONLY', '0', 'MUSIC Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', 2, 200, NULL, '2007-09-26 17:05:52.260072', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (113, 'MUSIC Attribute is Free - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTE_IS_FREE', '1', 'MUSIC Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', 2, 201, NULL, '2007-09-26 17:05:52.264044', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (114, 'MUSIC Attribute is Default - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DEFAULT', '0', 'MUSIC Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', 2, 202, NULL, '2007-09-26 17:05:52.268341', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (115, 'MUSIC Attribute is Discounted - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISCOUNTED', '1', 'MUSIC Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', 2, 203, NULL, '2007-09-26 17:05:52.275359', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (116, 'MUSIC Attribute is Included in Base Price - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', 'MUSIC Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', 2, 204, NULL, '2007-09-26 17:05:52.279183', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (117, 'MUSIC Attribute is Required - Default', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_REQUIRED', '0', 'MUSIC Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', 2, 205, NULL, '2007-09-26 17:05:52.282992', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (118, 'MUSIC Attribute Price Prefix - Default', 'DEFAULT_PRODUCT_MUSIC_PRICE_PREFIX', '1', 'MUSIC Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', 2, 206, NULL, '2007-09-26 17:05:52.287016', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (119, 'MUSIC Attribute Weight Prefix - Default', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', 'MUSIC Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', 2, 207, NULL, '2007-09-26 17:05:52.291147', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (120, 'DOCUMENT GENERAL Attribute is Display Only - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISPLAY_ONLY', '0', 'DOCUMENT GENERAL Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', 3, 200, NULL, '2007-09-26 17:05:52.295108', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (121, 'DOCUMENT GENERAL Attribute is Free - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTE_IS_FREE', '1', 'DOCUMENT GENERAL Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', 3, 201, NULL, '2007-09-26 17:05:52.299223', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (122, 'DOCUMENT GENERAL Attribute is Default - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DEFAULT', '0', 'DOCUMENT GENERAL Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', 3, 202, NULL, '2007-09-26 17:05:52.30303', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (123, 'DOCUMENT GENERAL Attribute is Discounted - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISCOUNTED', '1', 'DOCUMENT GENERAL Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', 3, 203, NULL, '2007-09-26 17:05:52.307128', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (124, 'DOCUMENT GENERAL Attribute is Included in Base Price - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', 'DOCUMENT GENERAL Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', 3, 204, NULL, '2007-09-26 17:05:52.311905', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (125, 'DOCUMENT GENERAL Attribute is Required - Default', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_REQUIRED', '0', 'DOCUMENT GENERAL Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', 3, 205, NULL, '2007-09-26 17:05:52.322991', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (126, 'DOCUMENT GENERAL Attribute Price Prefix - Default', 'DEFAULT_DOCUMENT_GENERAL_PRICE_PREFIX', '1', 'DOCUMENT GENERAL Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', 3, 206, NULL, '2007-09-26 17:05:52.32701', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (127, 'DOCUMENT GENERAL Attribute Weight Prefix - Default', 'DEFAULT_DOCUMENT_GENERAL_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', 'DOCUMENT GENERAL Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', 3, 207, NULL, '2007-09-26 17:05:52.330812', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (128, 'DOCUMENT PRODUCT Attribute is Display Only - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', '0', 'DOCUMENT PRODUCT Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', 4, 200, NULL, '2007-09-26 17:05:52.335342', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (129, 'DOCUMENT PRODUCT Attribute is Free - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTE_IS_FREE', '1', 'DOCUMENT PRODUCT Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', 4, 201, NULL, '2007-09-26 17:05:52.340226', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (130, 'DOCUMENT PRODUCT Attribute is Default - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DEFAULT', '0', 'DOCUMENT PRODUCT Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', 4, 202, NULL, '2007-09-26 17:05:52.3442', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (131, 'DOCUMENT PRODUCT Attribute is Discounted - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISCOUNTED', '1', 'DOCUMENT PRODUCT Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', 4, 203, NULL, '2007-09-26 17:05:52.348836', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (132, 'DOCUMENT PRODUCT Attribute is Included in Base Price - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', 'DOCUMENT PRODUCT Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', 4, 204, NULL, '2007-09-26 17:05:52.354081', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (133, 'DOCUMENT PRODUCT Attribute is Required - Default', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_REQUIRED', '0', 'DOCUMENT PRODUCT Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', 4, 205, NULL, '2007-09-26 17:05:52.358641', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (134, 'DOCUMENT PRODUCT Attribute Price Prefix - Default', 'DEFAULT_DOCUMENT_PRODUCT_PRICE_PREFIX', '1', 'DOCUMENT PRODUCT Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', 4, 206, NULL, '2007-09-26 17:05:52.365405', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (135, 'DOCUMENT PRODUCT Attribute Weight Prefix - Default', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', 'DOCUMENT PRODUCT Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', 4, 207, NULL, '2007-09-26 17:05:52.373626', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (136, 'PRODUCT FREE SHIPPING Attribute is Display Only - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISPLAY_ONLY', '0', 'PRODUCT FREE SHIPPING Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', 5, 201, NULL, '2007-09-26 17:05:52.381971', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (137, 'PRODUCT FREE SHIPPING Attribute is Free - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTE_IS_FREE', '1', 'PRODUCT FREE SHIPPING Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', 5, 201, NULL, '2007-09-26 17:05:52.386545', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (138, 'PRODUCT FREE SHIPPING Attribute is Default - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DEFAULT', '0', 'PRODUCT FREE SHIPPING Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', 5, 202, NULL, '2007-09-26 17:05:52.391363', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (139, 'PRODUCT FREE SHIPPING Attribute is Discounted - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISCOUNTED', '1', 'PRODUCT FREE SHIPPING Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', 5, 203, NULL, '2007-09-26 17:05:52.39803', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (140, 'PRODUCT FREE SHIPPING Attribute is Included in Base Price - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', 'PRODUCT FREE SHIPPING Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', 5, 204, NULL, '2007-09-26 17:05:52.406884', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (141, 'PRODUCT FREE SHIPPING Attribute is Required - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_REQUIRED', '0', 'PRODUCT FREE SHIPPING Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', 5, 205, NULL, '2007-09-26 17:05:52.41105', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO zencartproduct_type_layout VALUES (142, 'PRODUCT FREE SHIPPING Attribute Price Prefix - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRICE_PREFIX', '1', 'PRODUCT FREE SHIPPING Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', 5, 206, NULL, '2007-09-26 17:05:52.41487', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');
INSERT INTO zencartproduct_type_layout VALUES (143, 'PRODUCT FREE SHIPPING Attribute Weight Prefix - Default', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', 'PRODUCT FREE SHIPPING Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', 5, 207, NULL, '2007-09-26 17:05:52.419025', NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');


--
-- Data for Name: zencartproduct_types; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproduct_types VALUES (1, 'Product - General', 'product', 1, 'Y', '', '2007-09-26 17:05:51.062351', '2007-09-26 17:05:51.062351');
INSERT INTO zencartproduct_types VALUES (2, 'Product - Music', 'product_music', 1, 'Y', '', '2007-09-26 17:05:51.066212', '2007-09-26 17:05:51.066212');
INSERT INTO zencartproduct_types VALUES (3, 'Document - General', 'document_general', 3, 'N', '', '2007-09-26 17:05:51.070957', '2007-09-26 17:05:51.070957');
INSERT INTO zencartproduct_types VALUES (4, 'Document - Product', 'document_product', 3, 'Y', '', '2007-09-26 17:05:51.07443', '2007-09-26 17:05:51.07443');
INSERT INTO zencartproduct_types VALUES (5, 'Product - Free Shipping', 'product_free_shipping', 1, 'Y', '', '2007-09-26 17:05:51.077669', '2007-09-26 17:05:51.077669');


--
-- Data for Name: zencartproduct_types_to_category; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartproducts; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts VALUES (2, 1, 50, '', '', 50.0000, 0, '2007-09-27 11:54:48.008063', '2007-09-27 13:18:59.242028', NULL, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 50.0000, 2, 1, 0, 0, 0, 0, 0);


--
-- Data for Name: zencartproducts_attributes; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_attributes VALUES (1, 1, 1, 0, 0.0000, ' ', 0, 0, 0, ' ', 0, 0, 1, NULL, 1, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, 0.0000, 0, 0.0000, 0, 0);
INSERT INTO zencartproducts_attributes VALUES (2, 7702, 1, 1, 0.0000, '+', 0, 0, 0, '+', 0, 1, 1, '', 1, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, '', '', 0.0000, 0, 0.0000, 0, 0);


--
-- Data for Name: zencartproducts_attributes_download; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_attributes_download VALUES (2, 'test.mp3', 3, 3);


--
-- Data for Name: zencartproducts_description; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_description VALUES (2, 1, 'A test product', 'This is a test product', '', 33);


--
-- Data for Name: zencartproducts_discount_quantity; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartproducts_notifications; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartproducts_options; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_options VALUES (1, 1, 'Downloadable', 10, 2, 32, '', 32, 0, 0, 0);


--
-- Data for Name: zencartproducts_options_types; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_options_types VALUES (0, 'Dropdown');
INSERT INTO zencartproducts_options_types VALUES (1, 'Text');
INSERT INTO zencartproducts_options_types VALUES (2, 'Radio');
INSERT INTO zencartproducts_options_types VALUES (3, 'Checkbox');
INSERT INTO zencartproducts_options_types VALUES (4, 'File');
INSERT INTO zencartproducts_options_types VALUES (5, 'Read Only');


--
-- Data for Name: zencartproducts_options_values; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_options_values VALUES (0, 1, 'TEXT', 0);
INSERT INTO zencartproducts_options_values VALUES (1, 1, 'MP3', 0);


--
-- Data for Name: zencartproducts_options_values_to_products_options; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_options_values_to_products_options VALUES (1, 1, 1);


--
-- Data for Name: zencartproducts_to_categories; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproducts_to_categories VALUES (2, 2);


--
-- Data for Name: zencartproject_version; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproject_version VALUES (1, 'Zen-Cart Main', '1', '3.7.1', '', '', '', '', 'Fresh Installation', '2007-09-26 17:05:52.457393');
INSERT INTO zencartproject_version VALUES (2, 'Zen-Cart Database', '1', '3.7.1', '', '', '', '', 'Fresh Installation', '2007-09-26 17:05:52.461496');


--
-- Data for Name: zencartproject_version_history; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartproject_version_history VALUES (1, 'Zen-Cart Main', '1', '3.7.1', '', 'Fresh Installation', '2007-09-26 17:05:52.465299');
INSERT INTO zencartproject_version_history VALUES (2, 'Zen-Cart Database', '1', '3.7.1', '', 'Fresh Installation', '2007-09-26 17:05:52.469949');


--
-- Data for Name: zencartquery_builder; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartquery_builder VALUES (1, 'email', 'All Customers', 'Returns all customers name and email address for sending mass emails (ie: for newsletters, coupons, GV''s, messages, etc).', 'select customers_email_address, customers_firstname, customers_lastname from TABLE_CUSTOMERS order by customers_lastname, customers_firstname, customers_email_address', '');
INSERT INTO zencartquery_builder VALUES (2, 'email,newsletters', 'All Newsletter Subscribers', 'Returns name and email address of newsletter subscribers', 'select customers_firstname, customers_lastname, customers_email_address from TABLE_CUSTOMERS where customers_newsletter = ''1''', '');
INSERT INTO zencartquery_builder VALUES (3, 'email,newsletters', 'Dormant Customers (>3months) (Subscribers)', 'Subscribers who HAVE purchased something, but have NOT purchased for at least three months.', 'select o.date_purchased, c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id AND c.customers_newsletter = 1 GROUP BY c.customers_email_address HAVING max(o.date_purchased) <= subdate(now(),INTERVAL 3 MONTH) ORDER BY c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO zencartquery_builder VALUES (4, 'email,newsletters', 'Active customers in past 3 months (Subscribers)', 'Newsletter subscribers who are also active customers (purchased something) in last 3 months.', 'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o where c.customers_newsletter = ''1'' AND c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO zencartquery_builder VALUES (5, 'email,newsletters', 'Active customers in past 3 months (Regardless of subscription status)', 'All active customers (purchased something) in last 3 months, ignoring newsletter-subscription status.', 'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO zencartquery_builder VALUES (6, 'email,newsletters', 'Administrator', 'Just the email account of the current administrator', 'select ''ADMIN'' as customers_firstname, admin_name as customers_lastname, admin_email as customers_email_address from TABLE_ADMIN where admin_id = $SESSION:admin_id', '');


--
-- Data for Name: zencartrecord_artists; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartrecord_artists_info; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartrecord_company; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartrecord_company_info; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartreviews; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartreviews_description; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartsalemaker_sales; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartsessions; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartsessions VALUES ('7b5271a1148e8eff6a66b6cc6cc8f48e', 1195016289, 'customers_host_address|s:9:"localhost";cartID|s:0:"";cart|O:12:"shoppingCart":9:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;s:18:"free_shipping_item";i:0;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";i:0;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";s:0:"";s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";customer_id|s:4:"1058";customer_default_address_id|s:5:"20349";customers_authorization|s:1:"0";customer_first_name|s:5:"testy";customer_country_id|s:3:"158";customer_zone_id|s:1:"0";new_products_id_in_cart|s:0:"";valid_to_checkout|b:1;cart_errors|s:0:"";cot_gv|b:0;cc_id|s:0:"";order_number_created|s:2:"77";|s:7:"c_ot_gv";');
INSERT INTO zencartsessions VALUES ('3120d0de3f82ef6fc9ca2128ad113769', 1195016516, 'customers_host_address|s:9:"localhost";cartID|s:0:"";cart|O:12:"shoppingCart":9:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;s:18:"free_shipping_item";i:0;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";i:0;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:5:"login";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"action";s:7:"process";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";s:0:"";s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";customer_id|s:4:"1058";customer_default_address_id|s:5:"20349";customers_authorization|s:1:"0";customer_first_name|s:5:"testy";customer_country_id|s:3:"158";customer_zone_id|s:1:"0";');
INSERT INTO zencartsessions VALUES ('b96ea7aae47a32c423cc655971c0d66a', 1195017027, 'customers_host_address|s:9:"localhost";cartID|s:0:"";cart|O:12:"shoppingCart":9:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;s:18:"free_shipping_item";i:0;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";i:0;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:5:"login";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"action";s:7:"process";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";s:0:"";s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";customer_id|s:1:"3";customer_default_address_id|s:5:"19937";customers_authorization|s:1:"0";customer_first_name|s:4:"Pete";customer_country_id|s:3:"158";customer_zone_id|s:1:"0";new_products_id_in_cart|s:0:"";valid_to_checkout|b:1;cart_errors|s:0:"";cot_gv|b:0;cc_id|s:0:"";order_number_created|s:2:"78";|s:7:"c_ot_gv";');
INSERT INTO zencartsessions VALUES ('3512230177c6d251d10ebf8b33ef2cb4', 1195017185, 'customers_host_address|s:9:"localhost";cartID|s:0:"";cart|O:12:"shoppingCart":9:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:6:"cartID";N;s:12:"content_type";b:0;s:18:"free_shipping_item";i:0;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";i:0;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:5:"login";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"action";s:7:"process";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";s:0:"";s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";customer_id|s:4:"1058";customer_default_address_id|s:5:"20349";customers_authorization|s:1:"0";customer_first_name|s:5:"testy";customer_country_id|s:3:"158";customer_zone_id|s:1:"0";');
INSERT INTO zencartsessions VALUES ('ae9c1e26ab87e1420dc0d024e3c5befe', 1195016184, 'customers_host_address|s:9:"localhost";cartID|s:0:"";cart|O:12:"shoppingCart":8:{s:8:"contents";a:0:{}s:5:"total";i:0;s:6:"weight";i:0;s:12:"content_type";b:0;s:18:"free_shipping_item";i:0;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";i:0;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:1:{i:0;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";s:0:"";s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";');
INSERT INTO zencartsessions VALUES ('', 1195016921, 'customers_host_address|s:9:"localhost";cartID|s:5:"50028";cart|O:12:"shoppingCart":9:{s:8:"contents";a:1:{s:37:"6762:81f5b4b332435d9f0ecd5be023dc687d";a:2:{s:3:"qty";d:2;s:10:"attributes";a:1:{i:1;s:1:"1";}}}s:5:"total";d:30;s:6:"weight";d:0;s:6:"cartID";s:5:"50028";s:12:"content_type";s:7:"virtual";s:18:"free_shipping_item";d:2;s:20:"free_shipping_weight";i:0;s:19:"free_shipping_price";d:30;s:9:"observers";a:0:{}}navigation|O:17:"navigationHistory":3:{s:4:"path";a:2:{i:0;a:4:{s:4:"page";s:5:"login";s:4:"mode";s:6:"NONSSL";s:3:"get";a:1:{s:6:"action";s:7:"process";}s:4:"post";a:0:{}}i:1;a:4:{s:4:"page";s:5:"index";s:4:"mode";s:6:"NONSSL";s:3:"get";a:2:{s:6:"result";s:1680:"044d98011b373548cd232f98c74f674dda09ced73ded6f1578d93e739d4f0819cda93000f8166b93e2db7cc086dadca11bc31ed7abc955b49b18d9566477e8e7bc667b4760e0a5cd7058eb4ba6b51996906d51af8efcd085e91e19ae45fbe1fa30b172659f7b334f34697235e7d80ad14b250e15a6a7681531c45ebf744e66214158a995c2aa3b97983d119aae4778ac6b30fa802ce4c357a0a26423f5e2a1dc4fab3b8b3c1009426b30fa802ce4c3577d80e16ca32d6a899f923cdf55c2150a28b9e8f1697c5681990eeb2ce7d16d90db7793d5356b080e28b9e8f1697c5681c4b282c027a1b52c9f13fdf1564d6cb69720ca5df5a08f5038bef1e1c0ec4370cad77219dfc29c4b74dfd69634fa38f57a099c351499ea0a69070fb97d2ee0650e266efbcdc948c6960219f5b2cb13f378134b24660b52892c5f2243067414e7c3b3f0d57efc4e818fbe7d7146dbd83b86fcaf01595444e89584ba4a0ae246dca90fce0f5057e4b4655555947b0feb223d1d664ab0e8ddb39f6c3a29c31a2a8ad7b0d12d0b268a4242c05fada6bd18ed693ac95268b2bc2e5950918b00fea386130f97abcff47b397da0cad2a8d1a6a777c7b9ac867dd3e719bc97dec9cd62382b0effc8fcea012b3c9d7a7cf930a640310e6a97163544702652e88af0853e7bd9dcd023d6879ba58fbefd1a0cdaba077afb79c5dfb19a5b576d7a51cd9126894da77e9899739c69bf1661a58acec657e9ab3af0c0c35cb849a92122578f67b1e5902e54ea002d48138de4048b45437f5e71fc21146da4c574823dc86da67c6ee8247a71de3f15eec64752f6ef5d20de7ec4a742b93ccd99b0d2b3a0dc2ffa965d768bd2596c012b1be3a17d78b3b75a798a8650b67762badde87f39bdaee38d7fd113f3b6680085d94fe4cad2f6c72a1079e1ea1b7265fb19d42b5785077970a005b210e3555ee7c18cdd282e283226ca309430d7b887804ca177e41e1df1b0b2cd5966dcbaa770b1b345d1d1250f01e442a662382d56d17026842638bb84195a189e82c10ab29bd8763e55225c16cb9f13fdf1564d6cb661921328dd39adb71177b3e2ee3c0156d8113725df537c5c5fc4352d986ca3b7639bbddce296880080b3bf1fae7bf4a4bed51f73bdddfeb28053306bb6786a7af75b84f17fad1fc2625f09305157e0fa";s:6:"userid";s:9:"SOUNZ_dev";}s:4:"post";a:0:{}}}s:8:"snapshot";a:0:{}s:9:"observers";a:0:{}}check_valid|s:4:"true";language|s:7:"english";languages_id|s:1:"1";languages_code|s:2:"en";currency|s:3:"NZD";updateExpirations|b:1;session_counter|b:1;customers_ip_address|s:9:"127.0.0.1";customer_id|s:1:"3";customer_default_address_id|s:5:"19937";customers_authorization|s:1:"0";customer_first_name|s:4:"Pete";customer_country_id|s:3:"158";customer_zone_id|s:1:"0";new_products_id_in_cart|s:0:"";valid_to_checkout|b:1;cart_errors|s:0:"";sendto|b:0;payment|s:9:"dpsaccess";shipping|s:9:"free_free";billto|s:5:"19937";cot_gv|i:0;comments|s:0:"";');


--
-- Data for Name: zencartspecials; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencarttax_class; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencarttax_class VALUES (1, 'Taxable Goods', 'The following types of products are included: non-food, services, etc', NULL, '2007-09-26 17:05:51.150777');


--
-- Data for Name: zencarttax_rates; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencarttemplate_select; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencarttemplate_select VALUES (1, 'classic', '0');


--
-- Data for Name: zencartupgrade_exceptions; Type: TABLE DATA; Schema: public; Owner: sounz
--



--
-- Data for Name: zencartwhos_online; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartwhos_online VALUES (1058, 'testerman, testy', '3512230177c6d251d10ebf8b33ef2cb4', '127.0.0.1', '1195015738', '1195015745', 'localhost', '', '/zencart/cartbox.php');
INSERT INTO zencartwhos_online VALUES (1058, 'testerman, testy', '7b5271a1148e8eff6a66b6cc6cc8f48e', '127.0.0.1', '1195014744', '1195014849', 'localhost', '', '/zencart/cartbox.php');
INSERT INTO zencartwhos_online VALUES (1058, 'testerman, testy', '3120d0de3f82ef6fc9ca2128ad113769', '127.0.0.1', '1195015017', '1195015076', 'localhost', '', '/zencart/cartbox.php');
INSERT INTO zencartwhos_online VALUES (3, 'Black, Pete', 'b96ea7aae47a32c423cc655971c0d66a', '127.0.0.1', '1195015235', '1195015587', 'localhost', '', '/zencart/cartbox.php');


--
-- Data for Name: zencartzones; Type: TABLE DATA; Schema: public; Owner: sounz
--

INSERT INTO zencartzones VALUES (212, 158, 'NI', 'North Island');
INSERT INTO zencartzones VALUES (213, 158, 'SI', 'South Island');
INSERT INTO zencartzones VALUES (214, 158, 'WGTN', 'Wellington');


--
-- Data for Name: zencartzones_to_geo_zones; Type: TABLE DATA; Schema: public; Owner: sounz
--












--reset all sequences

select setval('address_book_address_book_id_seq',(select max(address_book_id) from zencartaddress_book)+1);
select setval('address_format_address_format_id_seq',(select max(address_format_id) from zencartaddress_format)+1);
select setval('admin_admin_id_seq',(select max(admin_id) from zencartadmin)+1);
select setval('admin_activity_log_log_id_seq',(select max(log_id) from zencartadmin_activity_log)+1);
select setval('authorizenet_id_seq',(select max(id) from zencartauthorizenet)+1);
select setval('banners_banners_id_seq',(select max(banners_id) from zencartbanners)+1);
select setval('banners_history_banners_history_id_seq',(select max(banners_history_id) from zencartbanners_history)+1);
select setval('categories_categories_id_seq',(select max(categories_id) from zencartcategories)+1);
select setval('configuration_configuration_id_seq',(select max(configuration_id) from zencartconfiguration)+1);
select setval('configuration_group_configuration_group_id_seq',(select max(configuration_group_id) from zencartconfiguration_group)+1);
select setval('countries_countries_id_seq',(select max(countries_id) from zencartcountries)+1);
select setval('coupon_email_track_unique_id_seq',(select max(unique_id) from zencartcoupon_email_track)+1);
select setval('coupon_gv_queue_unique_id_seq',(select max(unique_id) from zencartcoupon_gv_queue)+1);
select setval('coupon_redeem_track_unique_id_seq',(select max(unique_id) from zencartcoupon_redeem_track)+1);
select setval('coupon_restrict_restrict_id_seq',(select max(restrict_id) from zencartcoupon_restrict)+1);
select setval('coupons_coupon_id_seq',(select max(coupon_id) from zencartcoupons)+1);
select setval('currencies_currencies_id_seq',(select max(currencies_id) from zencartcurrencies)+1);
select setval('customers_customers_id_seq',(select max(customers_id) from zencartcustomers)+1);
select setval('customers_basket_customers_basket_id_seq',(select max(customers_basket_id) from zencartcustomers_basket)+1);
select setval('customers_basket_attributes_customers_basket_attributes_id_seq',(select max(customers_basket_attributes_id) from zencartcustomers_basket_attributes)+1);

select setval('email_archive_archive_id_seq',(select max(archive_id) from zencartemail_archive)+1);
select setval('ezpages_pages_id_seq',(select max(pages_id) from zencartezpages)+1);
select setval('featured_featured_id_seq',(select max(featured_id) from zencartfeatured)+1);
select setval('files_uploaded_files_uploaded_id_seq',(select max(files_uploaded_id) from zencartfiles_uploaded)+1);
select setval('geo_zones_geo_zone_id_seq',(select max(geo_zone_id) from zencartgeo_zones)+1);
--MANUAL FIX: group_pricing_group_id_seq
select setval('languages_languages_id_seq',(select max(languages_id) from zencartlanguages)+1);
--MANUAL FIX: layout_boxes_layout_id_seq
select setval('manufacturers_manufacturers_id_seq',(select max(manufacturers_id) from zencartmanufacturers)+1);
--MANUAL FIX: media_clips_clip_id_seq
--MANUAL FIX: media_manager_media_id_seq
--MANUAL FIX: media_types_type_id_seq
select setval('music_genre_music_genre_id_seq',(select max(music_genre_id) from zencartmusic_genre)+1);
select setval('newsletters_newsletters_id_seq',(select max(newsletters_id) from zencartnewsletters)+1);
select setval('orders_orders_id_seq',(select max(orders_id) from zencartorders)+1);
select setval('orders_products_orders_products_id_seq',(select max(orders_products_id) from zencartorders_products)+1);
select setval('orders_products_attributes_orders_products_attributes_id_seq',(select max(orders_products_attributes_id) from zencartorders_products_attributes)+1);
select setval('orders_products_download_orders_products_download_id_seq',(select max(orders_products_download_id) from zencartorders_products_download)+1);
select setval('orders_status_history_orders_status_history_id_seq',(select max(orders_status_history_id) from zencartorders_status_history)+1);
select setval('orders_total_orders_total_id_seq',(select max(orders_total_id) from zencartorders_total)+1);
--MANUAL FIX: paypal_paypal_ipn_id_seq
--MANUAL FIX: paypal_payment_status_payment_status_id_seq
--MANUAL FIX: paypal_payment_status_history_payment_status_history_id_seq
--MANUAL FIX: paypal_session_unique_id_seq
select setval('paypal_testing_paypal_ipn_id_seq',(select max(paypal_ipn_id) from zencartpaypal_testing)+1);
select setval('product_type_layout_configuration_id_seq',(select max(configuration_id) from zencartproduct_type_layout)+1);
--MANUAL FIX: product_types_type_id_seq
select setval('products_products_id_seq',(select max(products_id) from zencartproducts)+1);
select setval('products_attributes_products_attributes_id_seq',(select max(products_attributes_id) from zencartproducts_attributes)+1);
--MANUAL FIX: products_description_products_id_seq
select setval('ucts_options_products_options_values_to_products_options_id_seq',(select max(products_options_values_to_products_options_id) from zencartproducts_options_values_to_products_options)+1);
select setval('project_version_project_version_id_seq',(select max(project_version_id) from zencartproject_version)+1);
--MANUAL FIX: project_version_history_project_version_id_seq
--MANUAL FIX: query_builder_query_id_seq
--MANUAL FIX: record_artists_artists_id_seq
select setval('record_company_record_company_id_seq',(select max(record_company_id) from zencartrecord_company)+1);
select setval('reviews_reviews_id_seq',(select max(reviews_id) from zencartreviews)+1);
--MANUAL FIX: salemaker_sales_sale_id_seq
select setval('specials_specials_id_seq',(select max(specials_id) from zencartspecials)+1);
select setval('tax_class_tax_class_id_seq',(select max(tax_class_id) from zencarttax_class)+1);
select setval('tax_rates_tax_rates_id_seq',(select max(tax_rates_id) from zencarttax_rates)+1);
--MANUAL FIX: template_select_template_id_seq
select setval('upgrade_exceptions_upgrade_exception_id_seq',(select max(upgrade_exception_id) from zencartupgrade_exceptions)+1);
select setval('zones_zone_id_seq',(select max(zone_id) from zencartzones)+1);
--MANUAL FIX: zones_to_geo_zones_association_id_seq

-- couple of extra bits

alter table zencartwhos_online drop column last_page_url;
alter table zencartwhos_online add column last_page_url text;
alter table zencartorders_products drop column products_name;
alter table zencartorders_products add column products_name text;





--latest view definitions



-- address book

CREATE OR REPLACE VIEW sounz_zencart_address_book AS
SELECT rc.role_contactinfo_id AS address_book_id, l.login_id AS customers_id, p.gender AS entry_gender, o.organisation_name AS entry_company, p.first_names AS entry_firstname, p.last_name AS entry_lastname, c.street AS entry_street_address, c.suburb AS entry_suburb, c.postcode AS entry_postcode, c.locality AS entry_city, r.region_name AS entry_state, c.country_id AS entry_country_id, 0 AS entry_zone_id
   FROM logins l
   LEFT JOIN people p ON l.person_id = p.person_id
   LEFT JOIN roles ro ON ro.person_id = p.person_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
   LEFT JOIN regions r ON r.region_id = c.region_id
   LEFT JOIN countries co ON co.country_id = c.country_id
   LEFT JOIN organisations o ON o.organisation_id = ro.organisation_id
  WHERE rc.contactinfo_id IS NOT NULL AND (c.street <> ''::text OR c.building <> ''::text)

UNION

select * from zencartaddress_book;



--sounz_products_for_sale

create or replace view sounz_products_for_sale as SELECT m.sale_product_id AS product_id, m.manifestation_id, m.manifestation_type_id, m.format_id, m.status_id, m.manifestation_title, m.manifestation_title_alt, m.series_title, m.publication_year, m.isbn, m.ismn, m.isrc, m.issn, m.imprint, m.copyright, m.collation, m.duration, m.dedication_note, m.publisher_note, m.content_note, m.general_note, m.internal_note, m.manifestation_code, m.mw_code, m.clonable, m.available_for_loan, m.available_for_hire, m.available_for_sale, m.item_cost, m.freight_code, m.created_at, m.updated_at, m.updated_by, m.downloadable, (select count(*) from items si where m.manifestation_id = si.manifestation_id) as item_count
   FROM manifestations m left join items i on i.manifestation_id = m.manifestation_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE m.available_for_sale = true and it.item_type_desc='Sale item';
  

--sounz_products_for_loan

create or replace view sounz_products_for_loan as SELECT m.loan_product_id AS product_id, m.manifestation_id, m.manifestation_type_id, m.format_id, m.status_id, CONCAT('(FOR LOAN) ',m.manifestation_title)as manifestation_title, m.manifestation_title_alt, m.series_title, m.publication_year, m.isbn, m.ismn, m.isrc, m.issn, m.imprint, m.copyright, m.collation, m.duration, m.dedication_note, m.publisher_note, m.content_note, m.general_note, m.internal_note, m.manifestation_code, m.mw_code, m.clonable, m.available_for_loan, m.available_for_hire, m.available_for_sale, m.item_cost, m.freight_code, m.created_at, m.updated_at,m.updated_by, m.downloadable,(select count(*) from items si where m.manifestation_id = si.manifestation_id) as item_count
   FROM manifestations m left join items i on i.manifestation_id = m.manifestation_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE m.available_for_loan = true and it.item_type_desc='Music library item';


--sounz_resources_for_sale

create or replace view sounz_resources_for_sale as SELECT r.sale_product_id AS product_id, r.resource_id, r.resource_type_id, r.format_id, r.status_id, r.resource_title, r.resource_title_alt, r.series_title, r.publication_year, r.isbn, r.ismn, r.isrc, r.issn, r.imprint, r.copyright, r.collation, r.duration, r.dedication_note, r.publisher_note, r.content_note, r.general_note, r.internal_note, r.resource_code, r.mw_code, r.clonable, r.available_for_loan, r.available_for_hire, r.available_for_sale, r.item_cost, r.freight_code, r.created_at, r.updated_at, r.updated_by, r.downloadable, (select count(*) from items si where r.resource_id = si.resource_id) as item_count
   FROM resources r left join items i on i.resource_id = r.resource_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE r.available_for_sale = true and it.item_type_desc='Sale item';

--sounz_resources_for_loan

create or replace view sounz_resources_for_loan as SELECT r.loan_product_id AS product_id, r.resource_id, r.resource_type_id, r.format_id, r.status_id, r.resource_title, r.resource_title_alt, r.series_title, r.publication_year, r.isbn, r.ismn, r.isrc, r.issn, r.imprint, r.copyright, r.collation, r.duration, r.dedication_note, r.publisher_note, r.content_note, r.general_note, r.internal_note, r.resource_code, r.mw_code, r.clonable, r.available_for_loan, r.available_for_hire, r.available_for_sale, r.item_cost, r.freight_code, r.created_at, r.updated_at, r.updated_by, r.downloadable, (select count(*) from items si where r.resource_id = si.resource_id) as item_count
   FROM resources r left join items i on i.resource_id = r.resource_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE r.available_for_loan = true and it.item_type_desc='Music library item';




--sounz_zencart_products

CREATE OR REPLACE VIEW sounz_zencart_products AS

SELECT 'SALE_MANIFESTATION' as products_class,m.product_id AS products_id, m.manifestation_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, ''::text AS products_model, ''::text AS products_image, m.item_cost AS products_price, 0 AS products_virtual, m.created_at AS products_date_added, m.updated_at AS products_last_modified, m.created_at AS products_date_available, m.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 1 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_products_for_sale m where m.item_count >0

UNION

SELECT 'LOAN_MANIFESTATION' as products_class,l.product_id AS products_id, l.manifestation_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, ''::text AS products_model, ''::text AS products_image, l.item_cost AS products_price, 0 AS products_virtual, l.created_at AS products_date_added, l.updated_at AS products_last_modified, l.created_at AS products_date_available, l.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 1 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 1 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_products_for_loan l where l.item_count >0

UNION

SELECT 'SALE_RESOURCE' as products_class,r.product_id AS products_id, r.resource_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, ''::text AS products_model, ''::text AS products_image, r.item_cost AS products_price, 0 AS products_virtual, r.created_at AS products_date_added, r.updated_at AS products_last_modified, r.created_at AS products_date_available, r.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 1 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_resources_for_sale r where r.item_count >0

UNION

SELECT 'LOAN_RESOURCE' as products_class,r.product_id AS products_id, r.resource_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, ''::text AS products_model, ''::text AS products_image, r.item_cost AS products_price, 0 AS products_virtual, r.created_at AS products_date_added, r.updated_at AS products_last_modified, r.created_at AS products_date_available, r.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_resources_for_sale r where r.item_count >0

UNION

SELECT 'SERVICE' as products_class,s.sounz_service_id AS products_id, s.sounz_service_id as manifestation_id, 1 AS products_type, 1 AS products_quantity, ''::text AS products_model, ''::text AS products_image, s.sounz_service_price AS products_price, 0 AS products_virtual, s.created_at AS products_date_added, s.updated_at AS products_last_modified, s.created_at AS products_date_available, 0 AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 1 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_services s

UNION

SELECT 'DONATION' as products_class,d.sounz_donation_id AS products_id, d.sounz_donation_id as manifestation_id, 1 AS products_type, 9999 AS products_quantity, ''::text AS products_model, ''::text AS products_image, d.sounz_donation_price AS products_price, 0 AS products_virtual, d.created_at AS products_date_added, d.updated_at AS products_last_modified, d.created_at AS products_date_available, 0 AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 1 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_donations d;
   
--sounz_zencart_products_description

CREATE OR REPLACE VIEW sounz_zencart_products_description AS

SELECT m.product_id AS products_id, 1 AS language_id, m.manifestation_title AS products_name, m.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_products_for_sale m

UNION

SELECT m.product_id AS products_id, 1 AS language_id, m.manifestation_title AS products_name, m.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_products_for_loan m

UNION

SELECT s.sounz_service_id AS products_id, 1 AS language_id, s.sounz_service_name AS products_name, s.sounz_service_description AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_services s

UNION

SELECT d.sounz_donation_id AS products_id, 1 AS language_id, d.sounz_donation_description AS products_name, d.sounz_donation_description AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_donations d;

--sounz_zencart_products_to_categories

CREATE OR REPLACE VIEW sounz_zencart_products_to_categories AS

SELECT m.product_id AS products_id, 2 AS categories_id
   FROM sounz_products_for_sale m

UNION

SELECT l.product_id AS products_id, 4 AS categories_id
   FROM sounz_products_for_loan l

UNION

SELECT sr.product_id AS products_id, 6 AS categories_id
   FROM sounz_resources_for_sale sr

UNION

SELECT lr.product_id AS products_id, 7 AS categories_id
   FROM sounz_resources_for_loan lr

UNION

SELECT s.sounz_service_id AS products_id, 3 AS categories_id
   FROM sounz_services s

UNION

SELECT d.sounz_donation_id AS products_id, 5 AS categories_id
   FROM sounz_donations d;
   

--sounz_zencart_customers

CREATE OR REPLACE VIEW sounz_zencart_customers AS

SELECT l.login_id AS customers_id, p.gender AS customers_gender, p.first_names AS customers_firstname, p.last_name AS customers_lastname, p.year_of_birth AS customers_dob, c.email_1 AS customers_email_address, l.username AS customers_nick, rc.role_contactinfo_id AS customers_default_address_id, c.phone AS customers_telephone, c.phone_fax AS customers_fax, l."password" AS customers_password, 0 AS customers_newsletter, 0 AS customers_group_pricing, 'TEXT' AS customers_email_format, 0 AS customers_authorization, '' AS customers_referral, '' AS customers_paypal_payerid, 0 AS customers_paypal_ec, ( SELECT nomens.nomen
           FROM nomens
          WHERE nomens.nomen_id = p.nomen_id) AS customers_nomen
   FROM logins l
   LEFT JOIN people p ON l.person_id = p.person_id
   LEFT JOIN roles ro ON ro.person_id = p.person_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
  WHERE rc.preferred = true AND ro.organisation_id IS NULL
  
UNION

  SELECT l.login_id AS customers_id, 'M'::char(1) AS customers_gender, '' AS customers_firstname, o.organisation_name AS customers_lastname, o.year_of_establishment AS customers_dob, c.email_1 AS customers_email_address, l.username AS customers_nick, rc.role_contactinfo_id AS customers_default_address_id, c.phone AS customers_telephone, c.phone_fax AS customers_fax, l."password" AS customers_password, 0 AS customers_newsletter, 0 AS customers_group_pricing, 'TEXT' AS customers_email_format, 0 AS customers_authorization, '' AS customers_referral, '' AS customers_paypal_payerid, 0 AS customers_paypal_ec, '' AS customers_nomen
   FROM logins l
   LEFT JOIN organisations o ON l.organisation_id = o.organisation_id
   LEFT JOIN roles ro ON ro.organisation_id = o.organisation_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
  WHERE rc.preferred = true AND ro.person_id IS NULL;

--sounz_zencart_product_attributes

create or replace view sounz_zencart_product_attributes as select 
m.sale_product_id as products_attributes_id, m.sale_product_id as products_id, 1 as options_id, 1 as options_values_id, 
0 as options_values_price,''::text as price_prefix,0 as products_options_sort_order, 0 as product_attribute_is_free, m.freight_code as products_attributes_weight,
'-'::text as products_attributes_weight_prefix, 0  as attributes_display_only, 1 as attributes_default, 0 as attributes_discounted,
''::text as attributes_image, 1 as attributes_price_base_included,0 as attributes_price_onetime, 0 as attributes_price_factor,
0 as attributes_price_factor_offset, 0 as attributes_price_factor_onetime, 0 as attributes_price_factor_onetime_offset,
''::text as attributes_qty_prices, ''::text as attributes_qty_prices_onetime,0 as attributes_price_words, 0 as attributes_price_words_free, 0 as attributes_price_letters, 0 as attributes_price_letters_free,
0 as attributes_required from manifestations m where m.downloadable=true

UNION

select 
r.sale_product_id as products_attributes_id, r.sale_product_id as products_id, 1 as options_id, 1 as options_values_id, 
0 as options_values_price,''::text as price_prefix,0 as products_options_sort_order, 0 as product_attribute_is_free, r.freight_code as products_attributes_weight,
'-'::text as products_attributes_weight_prefix, 0  as attributes_display_only, 1 as attributes_default, 0 as attributes_discounted,
''::text as attributes_image, 1 as attributes_price_base_included,0 as attributes_price_onetime, 0 as attributes_price_factor,
0 as attributes_price_factor_offset, 0 as attributes_price_factor_onetime, 0 as attributes_price_factor_onetime_offset,
''::text as attributes_qty_prices, ''::text as attributes_qty_prices_onetime,0 as attributes_price_words, 0 as attributes_price_words_free, 0 as attributes_price_letters, 0 as attributes_price_letters_free,
0 as attributes_required from resources r where r.downloadable=true;




--sounz_zencart_product_attributes_download

create or replace view sounz_zencart_product_attributes_download as select m.sale_product_id as products_attributes_id, m.download_file_name as products_attributes_filename,3 as products_attributes_maxdays, 3 as products_attributes_maxcount from manifestations m where m.downloadable=true;

--sounz_zencart_countries

create or replace view sounz_zencart_countries as select c.country_id as countries_id, c.country_name as countries_name,c.country_abbrev as countries_iso_code_2,c.country_abbrev as countries_iso_code_3,1 as address_format_id from countries c;


commit;

