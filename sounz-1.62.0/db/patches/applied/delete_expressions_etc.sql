--------------------------------------------------------------------------------------
-- CLEANOUT of expressions, manifestations and resources, plus all
-- associated relationships, attachments and general hangers-on.
-- Needless to say, be careful in choosing the database to apply this
-- script to.
--------------------------------------------------------------------------------------

BEGIN;

CREATE TEMPORARY TABLE tmpids (
  id int4 null
);


-- ITEMS
delete from reserved_items;
delete from borrowed_items;
delete from items;

-- SAMPLES
insert into tmpids select media_item_id from sample_attachments;
update media_items set parent_id=NULL where parent_id IN (select id from tmpids);
delete from sample_attachments where media_item_id IN (select id from tmpids);
delete from media_items where media_item_id IN (select id from tmpids);
delete from samples;
delete from tmpids;

-- MANIFESTATIONS
insert into tmpids select media_item_id from manifestation_attachments;
update media_items set parent_id=NULL where parent_id IN (select id from tmpids);
delete from manifestation_attachments where media_item_id IN (select id from tmpids);
delete from media_items where media_item_id IN (select id from tmpids);
delete from samples;
delete from tmpids;

-- role_relationships
insert into tmpids select r1.relationship_id from role_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from role_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- superwork_relationships
insert into tmpids select r1.relationship_id from superwork_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from superwork_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- distinction_relationships
insert into tmpids select r1.relationship_id from distinction_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from distinction_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- work_relationships
insert into tmpids select r1.relationship_id from work_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from work_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- event_relationships
insert into tmpids select r1.relationship_id from event_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from event_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- expression_relationships
insert into tmpids select r1.relationship_id from expression_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- resource_relationships
insert into tmpids select r1.relationship_id from resource_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- concept_relationships
insert into tmpids select r1.relationship_id from concept_relationships r1,relationships r2, manifestation_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from concept_relationships where relationship_id IN (select id from tmpids);
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;

delete from exam_set_works;

delete from manifestation_access_rights;

delete from expression_manifestations;

delete from manifestations;


-- RESOURCES
insert into tmpids select media_item_id from resource_attachments;
update media_items set parent_id=NULL where parent_id IN (select id from tmpids);
delete from resource_attachments where media_item_id IN (select id from tmpids);
delete from media_items where media_item_id IN (select id from tmpids);
delete from resources;
delete from tmpids;

-- role_relationships
insert into tmpids select r1.relationship_id from role_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from role_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- superwork_relationships
insert into tmpids select r1.relationship_id from superwork_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from superwork_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- distinction_relationships
insert into tmpids select r1.relationship_id from distinction_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from distinction_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- work_relationships
insert into tmpids select r1.relationship_id from work_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from work_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- event_relationships
insert into tmpids select r1.relationship_id from event_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from event_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- expression_relationships
insert into tmpids select r1.relationship_id from expression_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- manifestation_relationships
insert into tmpids select r1.relationship_id from manifestation_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- concept_relationships
insert into tmpids select r1.relationship_id from concept_relationships r1,relationships r2, resource_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from concept_relationships where relationship_id IN (select id from tmpids);
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;

delete from resource_access_rights;

delete from resources;

-- EXPRESSIONS

-- role_relationships
insert into tmpids select r1.relationship_id from role_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from role_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- superwork_relationships
insert into tmpids select r1.relationship_id from superwork_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from superwork_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- distinction_relationships
insert into tmpids select r1.relationship_id from distinction_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from distinction_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- work_relationships
insert into tmpids select r1.relationship_id from work_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from work_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- event_relationships
insert into tmpids select r1.relationship_id from event_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from event_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- resource_relationships
insert into tmpids select r1.relationship_id from resource_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from resource_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- manifestation_relationships
insert into tmpids select r1.relationship_id from manifestation_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from manifestation_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;


-- concept_relationships
insert into tmpids select r1.relationship_id from concept_relationships r1,relationships r2, expression_relationships r3 where r1.relationship_id=r2.relationship_id and r2.relationship_id=r3.relationship_id;
delete from concept_relationships where relationship_id IN (select id from tmpids);
delete from expression_relationships where relationship_id IN (select id from tmpids);
delete from relationships where relationship_id IN (select id from tmpids);
delete from tmpids;

delete from event_expression;

delete from expression_languages;

delete from expression_access_rights;

delete from expressions;


DROP table tmpids;

COMMIT;
