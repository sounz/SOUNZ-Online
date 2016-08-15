-- Patch for the cleanup of the entries flagged to be deleted from SOUNZ database

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

COMMIT;
