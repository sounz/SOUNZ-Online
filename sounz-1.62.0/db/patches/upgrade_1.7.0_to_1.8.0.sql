begin;

-- Fix for WR50956 - CD Roms becoming CDs
update resources set format_id = 
	(select format_id from formats where format_desc = 'CD')
where
	format_id = (select format_id from formats where format_desc='CD Rom');
	
	
	
-- Fixes for 42011
delete from valid_entity_entity_relationships where 
	relationship_type_id = (select relationship_type_id from relationship_types where relationship_type_desc = 'Is presented by')
and
	entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
and
	entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'expression');
	
	
--Role <---> Expression : 'Is broadcast by'
delete from valid_entity_entity_relationships where 
	relationship_type_id = (select relationship_type_id from relationship_types where relationship_type_desc = 'Is broadcast by')
and
	entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
and
	entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'expression');


--Role <---> Event : 'Is performed by'
delete from valid_entity_entity_relationships where 
	relationship_type_id = (select relationship_type_id from relationship_types where relationship_type_desc = 'Is performed by')
and
	entity_type_to_id = (select entity_type_id from entity_types where entity_type = 'role')
and
	entity_type_from_id = (select entity_type_id from entity_types where entity_type = 'event');
	
	
	
	
	
	
	
-- WR50908 - delete things with delete in the title


-- deal with manifestations
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
	

-- Delete works



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
	
delete from works where work_title ilike 'Delete%';
	




	
-- Delete expressions
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
	
	
-- Delete superworks

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

-- adding status to news_articles
ALTER TABLE news_articles ADD COLUMN status_id INT4;

-- set existent articles to 'Published'
UPDATE news_articles SET status_id=(SELECT status_id FROM publishing_statuses 
WHERE status_desc='Published');

ALTER TABLE news_articles ALTER COLUMN status_id SET NOT NULL;

CREATE INDEX NEWS_ARTICLES_PUBSTATUS_FK ON news_articles (
status_id
);

ALTER TABLE news_articles
   ADD CONSTRAINT fk_NEWS_ARTICLE_NEWS_ARTICLE_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

-- controller_restrictions
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

-- Restriction for /cm_contents/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /cm_contents/ALL, for a status of Published and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /cm_contents/ALL, for a status of Published and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /cm_contents/ALL, for a status of Pending and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /cm_contents/ALL, for a status of Pending and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('cm_contents', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
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

-- Restriction for /cart/add_product_to_cart, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'add_product_to_cart', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
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

-- Restriction for /cart/memberships_page, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('cart', 'memberships_page', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
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

-- Restriction for /finder/addToSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'addToSelected', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /finder/addToSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'addToSelected', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /finder/removeFromSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'removeFromSelected', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /finder/removeFromSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'removeFromSelected', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /finder/clearSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'clearSelected', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /finder/clearSelected, for a status of Published and privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('finder', 'clearSelected', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
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

-- Restriction for /news_articles/index, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'index', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/index, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'index', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/list, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/show, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /news_articles/ALL, for a status of Published and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /news_articles/ALL, for a status of Published and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /news_articles/ALL, for a status of Pending and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /news_articles/ALL, for a status of Pending and privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('news_articles', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
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

-- Restriction for /advanced_finder/work, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'work', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/work, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'work', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_works, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_works', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_works, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_works', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_work, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_work', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_work, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_work', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/findSubcategories, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'findSubcategories', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/findSubcategories, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'findSubcategories', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/event, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'event', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/event, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'event', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_events, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_events', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_events, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_events', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_event, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_event', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_event, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_event', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/contributor, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'contributor', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/contributor, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'contributor', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_contributors, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_contributors', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_contributors, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_contributors', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_contributors, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_contributors', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_contributors, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_contributors', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/manifestation_resource, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'manifestation_resource', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/manifestation_resource, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'manifestation_resource', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_manifestations_resources, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_manifestations_resources', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/search_manifestations_resources, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'search_manifestations_resources', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_manifestation_resource, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_manifestation_resource', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /advanced_finder/reset_manifestation_resource, for a privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('advanced_finder', 'reset_manifestation_resource', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
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

-- Restriction for /distinctions/related, for a status of Published and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('distinctions', 'related', 'get',
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

-- Restriction for /items/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Published and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Pending and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Approved and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Masked and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Withdrawn and privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /items/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Published and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Pending and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Approved and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Masked and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/ALL, for a status of Withdrawn and privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'ALL', 'post',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /items/show, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/show, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/show, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/show, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/show, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'show', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/list, for a status of Published and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/list, for a status of Pending and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/list, for a status of Approved and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/list, for a status of Masked and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
);

-- Restriction for /items/list, for a status of Withdrawn and privilege CAN_VIEW_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('items', 'list', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_TAP')
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

-- Restriction for /people/web_user_address_details, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'web_user_address_details', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/web_user_address_details, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'web_user_address_details', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/update_web_user_address_details, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'update_web_user_address_details', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /people/update_web_user_address_details, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'update_web_user_address_details', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
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

-- Restriction for /saved_searches/save_search_from_form, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'save_search_from_form', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /saved_searches/save_search_from_form, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'save_search_from_form', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /saved_searches/do_search, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'do_search', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /saved_searches/do_search, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'do_search', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /saved_searches/delete_search_ajax, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'delete_search_ajax', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /saved_searches/delete_search_ajax, for a privilege CAN_SAVE_SEARCH
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('saved_searches', 'delete_search_ajax', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_SAVE_SEARCH')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /attachment/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('attachment', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /image_mce_attachments/ALL, for a privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('image_mce_attachments', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /image_mce_attachments/ALL, for a privilege CAN_EDIT_CONTENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('image_mce_attachments', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CONTENT')
);

-- Restriction for /image_mce_attachments/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('image_mce_attachments', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /image_mce_attachments/ALL, for a privilege CAN_EDIT_PROJECT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('image_mce_attachments', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_PROJECT')
);

-- Restriction for /association/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('association', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /association/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('association', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /association/ALL, for a privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('association', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /association/ALL, for a privilege CAN_EDIT_EVENT
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('association', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_EVENT')
);

-- Restriction for /duration_as_interval/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('duration_as_interval', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /duration_as_interval/ALL, for a privilege CAN_EDIT_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('duration_as_interval', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_TAP')
);

-- Restriction for /duration_as_interval/ALL, for a privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('duration_as_interval', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Restriction for /duration_as_interval/ALL, for a privilege CAN_PUBLISH_TAP
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('duration_as_interval', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_TAP')
);

-- Add Scilla's missing regions
insert into regions(region_name, country_id) values ('Ontario',
(select country_id from countries where country_name = 'Canada')
);

insert into regions(region_name, country_id) values ('Northwest Territories',
(select country_id from countries where country_name = 'Canada')
);

insert into regions(region_name, country_id) values ('Nunavit',
(select country_id from countries where country_name = 'Canada')
);

insert into regions(region_name, country_id) values ('Prince Edward Island',
(select country_id from countries where country_name = 'Canada')
);


-- more deletion, this time organisation and people

-- deal with organisations
delete from saved_role_contactinfos where role_contactinfo_id in (
	select role_contactinfo_id from role_contactinfos where role_id in (
		select role_id from roles where organisation_id in (
			select organisation_id from organisations where organisation_name ilike 'Delete%'
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
	
	
-- deal with people

delete from saved_role_contactinfos where role_contactinfo_id in (
	select role_contactinfo_id from role_contactinfos where role_id in (
		select role_id from roles where person_id in (
			select person_id from people where first_names ilike 'Delete%'
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


select relationship_id into temp_rels 		from role_relationships where role_id in (
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

delete from roles where person_id in (
	select person_id from people where first_names ilike 'Delete%'
);




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

-- WR#51122 - change the name of the 'Requested SOUNZ Newsletter' saved contact list to
-- 'Requested Email Updates'
update saved_contact_lists set list_name = 'Requested Email Updates' where list_name = 'Requested SOUNZ Newsletter';

commit;








