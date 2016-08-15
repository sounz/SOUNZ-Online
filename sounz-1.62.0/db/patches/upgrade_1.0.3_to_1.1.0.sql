-- Patch for SOUNZ database upgrade
-- 1.0.3 to 1.0.4
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

-- Restriction for /finder/addToSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'addToSelectedSession', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/addToSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'addToSelectedSession', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/removeFromSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'removeFromSelectedSession', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/removeFromSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'removeFromSelectedSession', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/clearSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'clearSelectedSession', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /finder/clearSelectedSession, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'clearSelectedSession', 'get',
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

-- Restriction for /works/availability, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/availability, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/availability, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/availability, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /works/availability, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
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

-- Restriction for /works/availability, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('works', 'availability', 'get',
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

--add additional fields to the sounz_services table

alter table sounz_services add column member_type_id int;
alter table sounz_services add column zencart_tag varchar(64);

--make sure names are consistent

update item_types set item_type_desc='Resource library item' where item_type_desc like 'Resource%';

--we need this to expire memberships

alter table memberships add column expiry_date timestamp;
alter table memberships add column pending_payment boolean default true;

alter table memberships add column purchased_date timestamp;
alter table memberships add column renewed_date timestamp;

alter table memberships add column zencart_order_id int;


--fundamental flaw that needs to be addressed.

-- ADDING NEW COLUMN expression_id
alter table samples
  add column expression_id int4;

-- CREATING NEW CONSTRAINT fk_sample_expression
alter table samples
  add constraint fk_sample_expression foreign key (expression_id) references expressions (expression_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW INDEX sample_expression_fk
create index sample_expression_fk on samples using btree (expression_id);


alter table borrowed_items add column active boolean default true;

-- WR50596 - no caption supplied (GBA)
-- This affected 769 records in my local copy
update media_items set caption = '' where media_item_id in (select media_item_id from media_items where media_item_id in (select media_item_id from
	 manifestation_attachments) and caption='No caption supplied');


-- WR 50622 (GBA)
delete from work_categorizations where work_id = 10940 and work_subcategory_id = 154;
	
	
-- WR forgot to print it out (GBA) - fix names of contributor image captions
update media_items set caption = 'Brent Parker' where caption = 'Brent Parker (Brent Parker)';
update media_items set caption = 'Radha Sahar (Nee Wardrop)' where caption = 'Radha Sahar (Nee Wardrop) (Radha Sahar)';
update media_items set caption = 'Ashley Heenan' where caption = 'Ashley Heenan (Ashley David Joseph Heenan)';
update media_items set caption = 'Cheryl Camm' where caption = 'Cheryl Camm (Cheryl Camm)';
update media_items set caption = 'Natalie Moreno' where caption = 'Natalie Moreno (Natalie Lauren Moreno)';
update media_items set caption = 'Paul Booth' where caption = 'Paul Booth (Paul Booth)';
update media_items set caption = 'Robin Fazakerley' where caption = 'Robin Fazakerley (Robin Dina Fazakerley)';
update media_items set caption = 'Christopher Blake' where caption = 'Christopher Blake (Christopher Blake)';
update media_items set caption = 'Pepe Becker' where caption = 'Pepe Becker (Pepe Becker)';
update media_items set caption = 'Eve de Castro-Robinson' where caption = 'Eve De Castro-Robinson (Eve De Castro-Robinson)';
update media_items set caption = 'Andrew Perkins' where caption = 'Andrew Perkins (Andrew Michael Ellis Perkins)';
update media_items set caption = 'Barry Anderson' where caption = 'Barry Anderson (Barry Anderson)';
update media_items set caption = 'Chris Cree Brown' where caption = 'Chris Cree Brown (Christopher John Cree Brown)';
update media_items set caption = 'Jeremy Mayall' where caption = 'Jeremy Mayall (Jeremy Mayall)';
update media_items set caption = 'Kit Powell' where caption = 'Kit Powell (Christopher Bolland Powell)';
update media_items set caption = 'Chris Archer' where caption = 'Chris Archer (Christopher Paul  Archer)';
update media_items set caption = 'Lyell Cresswell' where caption = 'Lyell Cresswell (Lyell Richard Cresswell)';
update media_items set caption = 'Bronwyn Officer' where caption = 'Bronwyn Officer (Bronwyn Officer)';
update media_items set caption = 'Jonathan Crehan' where caption = 'Jonathan Crehan (Jonathan Crehan)';
update media_items set caption = 'Larry Pruden' where caption = 'Larry Pruden (Larry Carrol Pruden)';
update media_items set caption = 'Gillian Whitehead' where caption = 'Gillian Whitehead (Gillian Whitehead)';
update media_items set caption = 'Patrick Shepherd' where caption = 'Patrick Shepherd (Patrick Shepherd)';
update media_items set caption = 'Peter Crowe' where caption = 'Peter Crowe (Peter Russell Crowe)';
update media_items set caption = 'Helen Fisher' where caption = 'Helen Fisher (Helen Wynfreda Fisher)';
update media_items set caption = 'Jonathan Besser' where caption = 'Jonathan Besser (Jonathan Besser)';
update media_items set caption = 'John Rimmer' where caption = 'John Rimmer (John Francis Rimmer)';
update media_items set caption = 'John Young' where caption = 'John Young (John Young)';
update media_items set caption = 'Alan Cruise-Johnston' where caption = 'Alan Cruise-Johnston (Alan David Cruise-Johnston)';
update media_items set caption = 'Chris Watson' where caption = 'Chris Watson (Christopher David Watson)';
update media_items set caption = 'Daniel Beban' where caption = 'Daniel Beban (Daniel Beban)';
update media_items set caption = 'Philip Dadson' where caption = 'Philip Dadson (Philip Dadson)';
update media_items set caption = 'Dorothy Freed' where caption = 'Dorothy Freed (Dorothy Whitson Freed)';
update media_items set caption = 'Kenneth Young' where caption = 'Kenneth Young (Kenneth William Young)';
update media_items set caption = 'Warwick Blair' where caption = 'Warwick Blair (Warwick Blair)';
update media_items set caption = 'Robin Toan' where caption = 'Robin Toan (Robin Toan)';
update media_items set caption = 'Craig Sengelow' where caption = 'Craig Sengelow (Craig Sengelow)';
update media_items set caption = 'Lachlan  McKenzie' where caption = 'Lachlan  Mckenzie (Lachlan Daniel Mckenzie)';
update media_items set caption = 'William Dart' where caption = 'William Dart (William Dart)';
update media_items set caption = 'Susan Frykberg' where caption = 'Susan Frykberg (Susan Frykberg)';
update media_items set caption = 'Anthony Ritchie' where caption = 'Anthony Ritchie (Anthony Damian Ritchie)';
update media_items set caption = 'Ivan Zagni' where caption = 'Ivan Zagni (Ivan Zagni)';
update media_items set caption = 'Elissa Milne' where caption = 'Elissa Milne (Elissa Milne)';
update media_items set caption = 'Susan Beresford' where caption = 'Susan Beresford (Susan Beresford)';
update media_items set caption = 'Chris Gendall' where caption = 'Chris Gendall (Chris Gendall)';
update media_items set caption = 'Victoria Kelly' where caption = 'Victoria Kelly (Victoria Kelly)';
update media_items set caption = 'Peter Godfrey' where caption = 'Peter Godfrey (Peter David Hensman Godfrey)';
update media_items set caption = 'Dorothy Ker' where caption = 'Dorothy Ker (Dorothy Ker)';
update media_items set caption = 'Victor Galway' where caption = 'Victor Galway (Victor Galway)';
update media_items set caption = 'Richard Bolley' where caption = 'Richard Bolley (Richard Bolley)';
update media_items set caption = 'Jeni Little' where caption = 'Jeni Little (Jenny Michelle Little)';
update media_items set caption = 'Graham Parsons' where caption = 'Graham Parsons (Graham Parsons)';
update media_items set caption = 'Yvette  Audain' where caption = 'Yvette  Audain (Yvette Michelle Audain)';
update media_items set caption = 'Maria Grenfell' where caption = 'Maria Grenfell (Maria Jacqueline Grenfell)';
update media_items set caption = 'Douglas Lilburn' where caption = 'Douglas Lilburn (Douglas Gordon Lilburn)';
update media_items set caption = 'Anthony Young' where caption = 'Anthony Young (Anthony Young)';
update media_items set caption = 'Don Blume' where caption = 'Don Blume (Donald, Glenn Blume)';
update media_items set caption = 'Annea Lockwood' where caption = 'Annea Lockwood (Annea Lockwood)';
update media_items set caption = 'Penny Axtens' where caption = 'Penny Axtens (Penelope Axtens)';
update media_items set caption = 'Alison Grant' where caption = 'Alison Grant (Alison Grant)';
update media_items set caption = 'Martin Lodge' where caption = 'Martin Lodge (Martin Victor Lodge)';
update media_items set caption = 'David Sanders' where caption = 'David Sanders (David Sanders)';
update media_items set caption = 'Jenny McLeod' where caption = 'Jenny McLeod (Jennifer Helen McLeod)';
update media_items set caption = 'Robert Burch' where caption = 'Robert Burch (Robert William Burch)';
update media_items set caption = 'Douglas Mews' where caption = 'Douglas Mews (Douglas Kelson Mews)';
update media_items set caption = 'Hirini Melbourne' where caption = 'Hirini Melbourne (Hirini Melbourne)';
update media_items set caption = 'John Psathas' where caption = 'John Psathas (Ioannis Psathas)';
update media_items set caption = 'Philip Norman' where caption = 'Philip Norman (Philip Thomas Norman)';
update media_items set caption = 'Rachael Morgan' where caption = 'Rachael Morgan (Rachael Morgan)';
update media_items set caption = 'Tecwyn Evans' where caption = 'Tecwyn Evans (Tecwyn Huw Evans)';
update media_items set caption = 'Edwin Carr' where caption = 'Edwin Carr (Edwin James Nairn Carr)';
update media_items set caption = 'John Elmsly' where caption = 'John Elmsly (John Anthony Elmsly)';
update media_items set caption = 'Jack Speirs' where caption = 'Malcolm Speirs (Jack William Malcolm Speirs)';
update media_items set caption = 'Miriama Young' where caption = 'Miriama Young (Miriama Young)';
update media_items set caption = 'Helen Caskie' where caption = 'Helen Caskie (Helen Caskie)';
update media_items set caption = 'John Charles' where caption = 'John Charles (John Joseph Charles)';
update media_items set caption = 'John Emeleus' where caption = 'John Emeleus (John Robert William Emeleus)';
update media_items set caption = 'Christopher Norton' where caption = 'Christopher Norton (Christopher Garth Norton)';
update media_items set caption = 'Ronald Tremain' where caption = 'Ronald Tremain (Ronald Tremain)';
update media_items set caption = 'Michelle Scullion' where caption = 'Michelle Scullion (Michelle Scullion)';
update media_items set caption = 'Rachel Clement' where caption = 'Rachel Clement (Rachel Clement)';
update media_items set caption = 'John Cousins' where caption = 'John Cousins (John Edward Cousins)';
update media_items set caption = 'Judith Exley' where caption = 'Judith Exley (Judith Kathleen Exley)';
update media_items set caption = 'Leonie Holmes' where caption = 'Leonie Holmes (Leonie Holmes)';
update media_items set caption = 'Juliet Palmer' where caption = 'Juliet Palmer (Juliet Kiri Palmer)';
update media_items set caption = 'Craig Utting' where caption = 'Craig Utting (Craig Michael Utting)';
update media_items set caption = 'William Green' where caption = 'William Green (William Green)';
update media_items set caption = 'Vernon Griffiths' where caption = 'Vernon Griffiths (Thomas Vernon Griffiths)';
update media_items set caption = 'Kathryn Lauder' where caption = 'Kathryn Lauder (Kathryn Lauder)';
update media_items set caption = 'Lucy Mulgan' where caption = 'Lucy Mulgan (Lucy Mulgan)';
update media_items set caption = 'David Farquhar' where caption = 'David Farquhar (David Andross Farquhar)';
update media_items set caption = 'Denise Hulford' where caption = 'Denise Hulford (Denise Lovona Hulford)';
update media_items set caption = 'Michael Vinten' where caption = 'Michael Vinten (Michael John Vinten)';
update media_items set caption = 'Ray Twomey' where caption = 'Ray Twomey (Raymond Russell Twomey)';
update media_items set caption = 'Alfred Hill' where caption = 'Alfred Hill (Alfred Hill)';
update media_items set caption = 'Willow Macky' where caption = 'Willow Macky (Katharine Faith Macky)';
update media_items set caption = 'Ian Sinclair' where caption = 'Ian Sinclair (Ian Alexander Sinclair)';
update media_items set caption = 'Michael Williams' where caption = 'Michael Williams (Michael Williams)';
update media_items set caption = 'Gareth Farr' where caption = 'Gareth Farr (Gareth Vincent Farr)';
update media_items set caption = 'Maarire Goodall' where caption = 'Maarire Goodall (Maarire Goodall)';
update media_items set caption = 'James Instone' where caption = 'James Instone (James Instone)';
update media_items set caption = 'Matthew Davidson' where caption = 'Matthew Davidson (Matthew Davidson)';
update media_items set caption = 'Daniel Stabler' where caption = 'Daniel Stabler (Daniel R. Stabler)';
update media_items set caption = 'Fritha Jameson' where caption = 'Fritha Jameson (Fritha Jameson)';
update media_items set caption = 'Bryony Jagger' where caption = 'Bryony Jagger (Bryony Maglona  Jagger)';
update media_items set caption = 'Philip Brownlee' where caption = 'Philip Brownlee (Philip Brownlee)';
update media_items set caption = 'Dan Poynton' where caption = 'Dan Poynton (Daniel Poynton)';
update media_items set caption = 'Dion Workman' where caption = 'Dion Workman (Dion Workman)';
update media_items set caption = 'Glenda Keam' where caption = 'Glenda Keam (Glenda Ruth Keam)';
update media_items set caption = 'John Wells' where caption = 'John Wells (John Wells)';
update media_items set caption = 'Dylan Lardelli' where caption = 'Dylan Lardelli (Dylan Lardelli)';
update media_items set caption = 'Alison Isadora' where caption = 'Alison Isadora (Alison Isadora)';
update media_items set caption = 'Eric  Biddington' where caption = 'Eric  Biddington (Eric Wilhelm Biddington)';
update media_items set caption = 'Brigid Ursula Bisley' where caption = 'Brigid Ursula Bisley (Ursula Brigid Bisley)';
update media_items set caption = 'Michael Smither' where caption = 'Michael Smither (Michael Duncan Smither)';
update media_items set caption = 'John Ritchie' where caption = 'John Ritchie (John Anthony Ritchie)';
update media_items set caption = 'Jack Body' where caption = 'Jack Body (John Stanley Body)';
update media_items set caption = 'Gary Daverne' where caption = 'Gary Daverne (Gary Michael Daverne)';
update media_items set caption = 'Christopher Prosser' where caption = 'Christopher Prosser (Christopher Prosser)';
update media_items set caption = 'Claire Cowan' where caption = 'Claire Cowan (Claire Cowan)';
update media_items set caption = 'Tony Ryan' where caption = 'Tony Ryan (Anthony Wayne Ryan)';
update media_items set caption = 'Jeroen Speak' where caption = 'Jeroen Speak (Jeroen Speak)';
update media_items set caption = 'Helen Bowater' where caption = 'Helen Bowater (Helen Bowater)';
update media_items set caption = 'Ronald Dellow' where caption = 'Ronald Dellow (Ronald Graeme Dellow)';
update media_items set caption = 'Noel Sanders' where caption = 'Noel Sanders (Noel Sanders)';
update media_items set caption = 'Katherine Dienes' where caption = 'Katherine Dienes (Katherine Dienes)';
update media_items set caption = 'Cilla McQueen' where caption = 'Cilla McQueen (Cilla McQueen)';
update media_items set caption = 'Hugh Dixon' where caption = 'Hugh Dixon (Hugh William Dixon)';
update media_items set caption = 'David Griffiths' where caption = 'David Griffiths (David John Griffiths)';
update media_items set caption = 'Peter Scholes' where caption = 'Peter Scholes (Peter Graham Scholes)';
update media_items set caption = 'Mike Nock' where caption = 'Mike Nock (Michael Nock)';
update media_items set caption = 'Dorothy Buchanan' where caption = 'Dorothy Buchanan (Dorothy Buchanan)';
update media_items set caption = 'Aaron Lloydd' where caption = 'Aaron Lloydd (Aaron Lloydd)';
update media_items set caption = 'Mark Smythe' where caption = 'Mark Smythe (Mark Smythe)';
update media_items set caption = 'Neville Hall' where caption = 'Neville Hall (Neville John  Hall)';
update media_items set caption = 'David Downes' where caption = 'David Downes (David Ross John Downes)';
update media_items set caption = 'Nicholas Giles-Palmer' where caption = 'Nicholas Giles-Palmer (Nicholas Giles-Palmer)';
update media_items set caption = 'Frank Wregglesworth' where caption = 'Frank Wregglesworth (Frank Wregglesworth)';
update media_items set caption = 'Laughton Pattrick' where caption = 'Laughton Pattrick (Laughton Pattrick)';
update media_items set caption = 'Christopher Adams' where caption = 'Christopher Adams (Christopher Adams)';
update media_items set caption = 'Michael Norris' where caption = 'Michael Norris (Michael John Stuart Norris)';
update media_items set caption = 'Martin Setchell' where caption = 'Martin Setchell (Martin Philip Setchell)';
update media_items set caption = 'John Drummond' where caption = 'John Drummond (John Drummond)';
update media_items set caption = 'David Hamilton' where caption = 'David Hamilton (David Blair Hamilton)';
update media_items set caption = 'Christopher Marshall' where caption = 'Christopher Marshall (Christopher Marshall)';
update media_items set caption = 'Nigel Williams' where caption = 'Nigel Williams (Nigel Williams)';
update media_items set caption = 'Karlo Margetic' where caption = 'Karlo Margetic (Karlo Margetic)';
update media_items set caption = 'Jordan Reyne' where caption = 'Jordan Reyne (Jordan Reyne)';
update media_items set caption = 'Ross Harris' where caption = 'Ross Harris (Ross Talbot Harris)';
update media_items set caption = 'James Gardner' where caption = 'James Gardner (James Gardner)';
update media_items set caption = 'Lissa Meridan' where caption = 'Lissa Meridan (Lissa Meridan)';
update media_items set caption = 'Hamilton Dickson' where caption = 'Hamilton Dickson (Hamilton Dickson)';
update media_items set caption = 'James Gardner' where caption = 'James Gardner (James Gardner)';
update media_items set caption = 'Lissa Meridan' where caption = 'Lissa Meridan (Lissa Meridan)';
update media_items set caption = 'Hamilton Dickson' where caption = 'Hamilton Dickson (Hamilton Dickson)';
update media_items set caption = 'Brent Parker' where caption = 'Brent Parker (Brent Parker)';
update media_items set caption = 'Radha Sahar (Nee Wardrop)' where caption = 'Radha Sahar (Nee Wardrop) (Radha Sahar)';
update media_items set caption = 'Ashley Heenan' where caption = 'Ashley Heenan (Ashley David Joseph Heenan)';
update media_items set caption = 'Cheryl Camm' where caption = 'Cheryl Camm (Cheryl Camm)';
update media_items set caption = 'Emma Carle' where caption = 'Emma Carl� (Emma Carl�)';
update media_items set caption = 'Natalie Moreno' where caption = 'Natalie Moreno (Natalie Lauren Moreno)';
update media_items set caption = 'Paul Booth' where caption = 'Paul Booth (Paul Booth)';
update media_items set caption = 'Robin Fazakerley' where caption = 'Robin Fazakerley (Robin Dina Fazakerley)';
update media_items set caption = 'Christopher Blake' where caption = 'Christopher Blake (Christopher Blake)';
update media_items set caption = 'Pepe Becker' where caption = 'Pepe Becker (Pepe Becker)';
update media_items set caption = 'Eve de Castro-Robinson' where caption = 'Eve De Castro-Robinson (Eve De Castro-Robinson)';
update media_items set caption = 'Andrew Perkins' where caption = 'Andrew Perkins (Andrew Michael Ellis Perkins)';
update media_items set caption = 'Barry Anderson' where caption = 'Barry Anderson (Barry Anderson)';
update media_items set caption = 'Chris Cree Brown' where caption = 'Chris Cree Brown (Christopher John Cree Brown)';
update media_items set caption = 'Jeremy Mayall' where caption = 'Jeremy Mayall (Jeremy Mayall)';
update media_items set caption = 'Kit Powell' where caption = 'Kit Powell (Christopher Bolland Powell)';
update media_items set caption = 'Lyell Cresswell' where caption = 'Lyell Cresswell (Lyell Richard Cresswell)';
update media_items set caption = 'Bronwyn Officer' where caption = 'Bronwyn Officer (Bronwyn Officer)';
update media_items set caption = 'Jonathan Crehan' where caption = 'Jonathan Crehan (Jonathan Crehan)';
update media_items set caption = 'Chris Archer' where caption = 'Chris Archer (Christopher Paul  Archer)';
update media_items set caption = 'Larry Pruden' where caption = 'Larry Pruden (Larry Carrol Pruden)';
update media_items set caption = 'Gillian Whitehead' where caption = 'Gillian Whitehead (Gillian Whitehead)';
update media_items set caption = 'Patrick Shepherd' where caption = 'Patrick Shepherd (Patrick Shepherd)';
update media_items set caption = 'Peter Crowe' where caption = 'Peter Crowe (Peter Russell Crowe)';
update media_items set caption = 'Helen Fisher' where caption = 'Helen Fisher (Helen Wynfreda Fisher)';
update media_items set caption = 'Jonathan Besser' where caption = 'Jonathan Besser (Jonathan Besser)';
update media_items set caption = 'John Young' where caption = 'John Young (John Young)';
update media_items set caption = 'Alan Cruise-Johnston' where caption = 'Alan Cruise-Johnston (Alan David Cruise-Johnston)';
update media_items set caption = 'Chris Watson' where caption = 'Chris Watson (Christopher David Watson)';
update media_items set caption = 'Daniel Beban' where caption = 'Daniel Beban (Daniel Beban)';
update media_items set caption = 'Philip Dadson' where caption = 'Philip Dadson (Philip Dadson)';
update media_items set caption = 'Dorothy Freed' where caption = 'Dorothy Freed (Dorothy Whitson Freed)';
update media_items set caption = 'John Rimmer' where caption = 'John Rimmer (John Francis Rimmer)';
update media_items set caption = 'Kenneth Young' where caption = 'Kenneth Young (Kenneth William Young)';
update media_items set caption = 'Warwick Blair' where caption = 'Warwick Blair (Warwick Blair)';
update media_items set caption = 'Robin Toan' where caption = 'Robin Toan (Robin Toan)';
update media_items set caption = 'Craig Sengelow' where caption = 'Craig Sengelow (Craig Sengelow)';
update media_items set caption = 'William Dart' where caption = 'William Dart (William Dart)';
update media_items set caption = 'Susan Frykberg' where caption = 'Susan Frykberg (Susan Frykberg)';
update media_items set caption = 'Anthony Ritchie' where caption = 'Anthony Ritchie (Anthony Damian Ritchie)';
update media_items set caption = 'Lachlan  McKenzie' where caption = 'Lachlan  Mckenzie (Lachlan Daniel Mckenzie)';
update media_items set caption = 'Ivan Zagni' where caption = 'Ivan Zagni (Ivan Zagni)';
update media_items set caption = 'Elissa Milne' where caption = 'Elissa Milne (Elissa Milne)';
update media_items set caption = 'Susan Beresford' where caption = 'Susan Beresford (Susan Beresford)';
update media_items set caption = 'Chris Gendall' where caption = 'Chris Gendall (Chris Gendall)';
update media_items set caption = 'Victoria Kelly' where caption = 'Victoria Kelly (Victoria Kelly)';
update media_items set caption = 'Peter Godfrey' where caption = 'Peter Godfrey (Peter David Hensman Godfrey)';
update media_items set caption = 'Dorothy Ker' where caption = 'Dorothy Ker (Dorothy Ker)';
update media_items set caption = 'Victor Galway' where caption = 'Victor Galway (Victor Galway)';
update media_items set caption = 'Richard Bolley' where caption = 'Richard Bolley (Richard Bolley)';
update media_items set caption = 'Jeni Little' where caption = 'Jeni Little (Jenny Michelle Little)';
update media_items set caption = 'Graham Parsons' where caption = 'Graham Parsons (Graham Parsons)';
update media_items set caption = 'Yvette  Audain' where caption = 'Yvette  Audain (Yvette Michelle Audain)';
update media_items set caption = 'Maria Grenfell' where caption = 'Maria Grenfell (Maria Jacqueline Grenfell)';
update media_items set caption = 'Douglas Lilburn' where caption = 'Douglas Lilburn (Douglas Gordon Lilburn)';
update media_items set caption = 'Anthony Young' where caption = 'Anthony Young (Anthony Young)';
update media_items set caption = 'Don Blume' where caption = 'Don Blume (Donald, Glenn Blume)';
update media_items set caption = 'Annea Lockwood' where caption = 'Annea Lockwood (Annea Lockwood)';
update media_items set caption = 'Penny Axtens' where caption = 'Penny Axtens (Penelope Axtens)';
update media_items set caption = 'Alison Grant' where caption = 'Alison Grant (Alison Grant)';
update media_items set caption = 'Martin Lodge' where caption = 'Martin Lodge (Martin Victor Lodge)';
update media_items set caption = 'David Sanders' where caption = 'David Sanders (David Sanders)';
update media_items set caption = 'Jenny McLeod' where caption = 'Jenny McLeod (Jennifer Helen McLeod)';
update media_items set caption = 'Robert Burch' where caption = 'Robert Burch (Robert William Burch)';
update media_items set caption = 'Douglas Mews' where caption = 'Douglas Mews (Douglas Kelson Mews)';
update media_items set caption = 'Hirini Melbourne' where caption = 'Hirini Melbourne (Hirini Melbourne)';
update media_items set caption = 'John Psathas' where caption = 'John Psathas (Ioannis Psathas)';
update media_items set caption = 'Philip Norman' where caption = 'Philip Norman (Philip Thomas Norman)';
update media_items set caption = 'Rachael Morgan' where caption = 'Rachael Morgan (Rachael Morgan)';
update media_items set caption = 'Tecwyn Evans' where caption = 'Tecwyn Evans (Tecwyn Huw Evans)';
update media_items set caption = 'Edwin Carr' where caption = 'Edwin Carr (Edwin James Nairn Carr)';
update media_items set caption = 'John Elmsly' where caption = 'John Elmsly (John Anthony Elmsly)';
update media_items set caption = 'Jack Speirs' where caption = 'Malcolm Speirs (Jack William Malcolm Speirs)';
update media_items set caption = 'Miriama Young' where caption = 'Miriama Young (Miriama Young)';
update media_items set caption = 'John Charles' where caption = 'John Charles (John Joseph Charles)';
update media_items set caption = 'John Emeleus' where caption = 'John Emeleus (John Robert William Emeleus)';
update media_items set caption = 'Christopher Norton' where caption = 'Christopher Norton (Christopher Garth Norton)';
update media_items set caption = 'Helen Caskie' where caption = 'Helen Caskie (Helen Caskie)';
update media_items set caption = 'Ronald Tremain' where caption = 'Ronald Tremain (Ronald Tremain)';
update media_items set caption = 'Michelle Scullion' where caption = 'Michelle Scullion (Michelle Scullion)';
update media_items set caption = 'Rachel Clement' where caption = 'Rachel Clement (Rachel Clement)';
update media_items set caption = 'Judith Exley' where caption = 'Judith Exley (Judith Kathleen Exley)';
update media_items set caption = 'Leonie Holmes' where caption = 'Leonie Holmes (Leonie Holmes)';
update media_items set caption = 'Juliet Palmer' where caption = 'Juliet Palmer (Juliet Kiri Palmer)';
update media_items set caption = 'John Cousins' where caption = 'John Cousins (John Edward Cousins)';
update media_items set caption = 'Craig Utting' where caption = 'Craig Utting (Craig Michael Utting)';
update media_items set caption = 'William Green' where caption = 'William Green (William Green)';
update media_items set caption = 'Vernon Griffiths' where caption = 'Vernon Griffiths (Thomas Vernon Griffiths)';
update media_items set caption = 'Kathryn Lauder' where caption = 'Kathryn Lauder (Kathryn Lauder)';
update media_items set caption = 'Lucy Mulgan' where caption = 'Lucy Mulgan (Lucy Mulgan)';
update media_items set caption = 'David Farquhar' where caption = 'David Farquhar (David Andross Farquhar)';
update media_items set caption = 'Denise Hulford' where caption = 'Denise Hulford (Denise Lovona Hulford)';
update media_items set caption = 'Ray Twomey' where caption = 'Ray Twomey (Raymond Russell Twomey)';
update media_items set caption = 'Alfred Hill' where caption = 'Alfred Hill (Alfred Hill)';
update media_items set caption = 'Willow Macky' where caption = 'Willow Macky (Katharine Faith Macky)';
update media_items set caption = 'Ian Sinclair' where caption = 'Ian Sinclair (Ian Alexander Sinclair)';
update media_items set caption = 'Michael Williams' where caption = 'Michael Williams (Michael Williams)';
update media_items set caption = 'Gareth Farr' where caption = 'Gareth Farr (Gareth Vincent Farr)';
update media_items set caption = 'Michael Vinten' where caption = 'Michael Vinten (Michael John Vinten)';
update media_items set caption = 'James Instone' where caption = 'James Instone (James Instone)';
update media_items set caption = 'Matthew Davidson' where caption = 'Matthew Davidson (Matthew Davidson)';
update media_items set caption = 'Daniel Stabler' where caption = 'Daniel Stabler (Daniel R. Stabler)';
update media_items set caption = 'Bryony Jagger' where caption = 'Bryony Jagger (Bryony Maglona  Jagger)';
update media_items set caption = 'Fritha Jameson' where caption = 'Fritha Jameson (Fritha Jameson)';
update media_items set caption = 'Philip Brownlee' where caption = 'Philip Brownlee (Philip Brownlee)';
update media_items set caption = 'Dan Poynton' where caption = 'Dan Poynton (Daniel Poynton)';
update media_items set caption = 'Dion Workman' where caption = 'Dion Workman (Dion Workman)';
update media_items set caption = 'Glenda Keam' where caption = 'Glenda Keam (Glenda Ruth Keam)';
update media_items set caption = 'John Wells' where caption = 'John Wells (John Wells)';
update media_items set caption = 'Dylan Lardelli' where caption = 'Dylan Lardelli (Dylan Lardelli)';
update media_items set caption = 'Alison Isadora' where caption = 'Alison Isadora (Alison Isadora)';
update media_items set caption = 'Eric  Biddington' where caption = 'Eric  Biddington (Eric Wilhelm Biddington)';
update media_items set caption = 'Brigid Ursula Bisley' where caption = 'Brigid Ursula Bisley (Ursula Brigid Bisley)';
update media_items set caption = 'Michael Smither' where caption = 'Michael Smither (Michael Duncan Smither)';
update media_items set caption = 'John Ritchie' where caption = 'John Ritchie (John Anthony Ritchie)';
update media_items set caption = 'Jack Body' where caption = 'Jack Body (John Stanley Body)';
update media_items set caption = 'Gary Daverne' where caption = 'Gary Daverne (Gary Michael Daverne)';
update media_items set caption = 'Christopher Prosser' where caption = 'Christopher Prosser (Christopher Prosser)';
update media_items set caption = 'Claire Cowan' where caption = 'Claire Cowan (Claire Cowan)';
update media_items set caption = 'Tony Ryan' where caption = 'Tony Ryan (Anthony Wayne Ryan)';
update media_items set caption = 'Jeroen Speak' where caption = 'Jeroen Speak (Jeroen Speak)';
update media_items set caption = 'Helen Bowater' where caption = 'Helen Bowater (Helen Bowater)';
update media_items set caption = 'Ronald Dellow' where caption = 'Ronald Dellow (Ronald Graeme Dellow)';
update media_items set caption = 'Noel Sanders' where caption = 'Noel Sanders (Noel Sanders)';
update media_items set caption = 'Katherine Dienes' where caption = 'Katherine Dienes (Katherine Dienes)';
update media_items set caption = 'Samuel Holloway' where caption = 'Samuel Holloway (Samuel Holloway)';
update media_items set caption = 'Cilla McQueen' where caption = 'Cilla McQueen (Cilla McQueen)';
update media_items set caption = 'Hugh Dixon' where caption = 'Hugh Dixon (Hugh William Dixon)';
update media_items set caption = 'David Griffiths' where caption = 'David Griffiths (David John Griffiths)';
update media_items set caption = 'Peter Scholes' where caption = 'Peter Scholes (Peter Graham Scholes)';
update media_items set caption = 'Mike Nock' where caption = 'Mike Nock (Michael Nock)';
update media_items set caption = 'Dorothy Buchanan' where caption = 'Dorothy Buchanan (Dorothy Buchanan)';
update media_items set caption = 'Aaron Lloydd' where caption = 'Aaron Lloydd (Aaron Lloydd)';
update media_items set caption = 'Mark Smythe' where caption = 'Mark Smythe (Mark Smythe)';
update media_items set caption = 'Neville Hall' where caption = 'Neville Hall (Neville John  Hall)';
update media_items set caption = 'David Downes' where caption = 'David Downes (David Ross John Downes)';
update media_items set caption = 'Nicholas Giles-Palmer' where caption = 'Nicholas Giles-Palmer (Nicholas Giles-Palmer)';
update media_items set caption = 'Frank Wregglesworth' where caption = 'Frank Wregglesworth (Frank Wregglesworth)';
update media_items set caption = 'Laughton Pattrick' where caption = 'Laughton Pattrick (Laughton Pattrick)';
update media_items set caption = 'Christopher Adams' where caption = 'Christopher Adams (Christopher Adams)';
update media_items set caption = 'Michael Norris' where caption = 'Michael Norris (Michael John Stuart Norris)';
update media_items set caption = 'Martin Setchell' where caption = 'Martin Setchell (Martin Philip Setchell)';
update media_items set caption = 'John Drummond' where caption = 'John Drummond (John Drummond)';
update media_items set caption = 'David Hamilton' where caption = 'David Hamilton (David Blair Hamilton)';
update media_items set caption = 'Christopher Marshall' where caption = 'Christopher Marshall (Christopher Marshall)';
update media_items set caption = 'Nigel Williams' where caption = 'Nigel Williams (Nigel Williams)';
update media_items set caption = 'Karlo Margetic' where caption = 'Karlo Margetic (Karlo Margetic)';
update media_items set caption = 'Jordan Reyne' where caption = 'Jordan Reyne (Jordan Reyne)';
update media_items set caption = 'Ross Harris' where caption = 'Ross Harris (Ross Talbot Harris)';
update media_items set caption = 'Bruce Crossman' where caption = 'Bruce Crossman (Bruce Crossman)';
update media_items set caption = 'Bruce Crossman' where caption = 'Bruce Crossman (Bruce Crossman)';
update media_items set caption = 'Maarire Goodall' where caption = 'Maarire Goodall (Maarire Goodall)';

alter table sounz_services add column mw_code text;
alter table sounz_donations add column mw_code text;

-- WR50618 - tweaks to veer naming
update valid_entity_entity_relationships set page_title = 'Awards' where page_title = 'Distinctions' and 
	entity_type_from_id = (select entity_type_id from entity_types where entity_type='role');

--mw codes for donations
update sounz_donations set mw_code='DON_10' where sounz_donation_price=10;
update sounz_donations set mw_code='DON_20' where sounz_donation_price=20;
update sounz_donations set mw_code='DON_50' where sounz_donation_price=50;

insert into sounz_donations (sounz_donation_price,sounz_donation_description,created_at,updated_at,updated_by,mw_code) values (100,'$100 Donation',now(),now(),1000,'DON_100');
insert into sounz_donations (sounz_donation_price,sounz_donation_description,created_at,updated_at,updated_by,mw_code) values (250,'$250 Donation',now(),now(),1000,'DON_250');
insert into sounz_donations (sounz_donation_price,sounz_donation_description,created_at,updated_at,updated_by,mw_code) values (500,'$500 Donation',now(),now(),1000,'DON_500');

insert into sounz_services (sounz_service_name,sounz_service_description,sounz_service_price,subscription_duration,created_at,updated_at,updated_by,member_type_id,zencart_tag,mw_code) values ('Sounz Standard Library Membership','One years access to the SOUNZ Library - this membership entitles you to borrow a maximum of 25 items at a time.',40,'1 year',now(),now(),1000,9,'SOUNZ_LIBRARY','MEM_LIB_ISTD');
insert into sounz_services (sounz_service_name,sounz_service_description,sounz_service_price,subscription_duration,created_at,updated_at,updated_by,member_type_id,zencart_tag,mw_code) values ('Sounz Supersize Library Membership','One years access to the SOUNZ Library - this membership entitles you to borrow an unlimited number of items.',60,'1 year',now(),now(),1000,9,'SOUNZ_LIBRARY','MEM_LIB_ISS');
insert into sounz_services (sounz_service_name,sounz_service_description,sounz_service_price,subscription_duration,created_at,updated_at,updated_by,member_type_id,zencart_tag,mw_code) values ('Sounz Online Library Membership (3 months)','3 months of access to the SOUNZ Online system',20,'3 mon',now(),now(),1000,9,'SOUNZ_ONLINE','MEM_ONLINE_3');
insert into sounz_services (sounz_service_name,sounz_service_description,sounz_service_price,subscription_duration,created_at,updated_at,updated_by,member_type_id,zencart_tag,mw_code) values ('Sounz Online Library Membership (12 months)','A year of access to the SOUNZ Online system',20,'12 mon',now(),now(),1000,9,'SOUNZ_ONLINE','MEM_ONLINE_12');

commit;
