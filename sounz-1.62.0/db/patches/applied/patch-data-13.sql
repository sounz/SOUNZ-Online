--Consolidate the names of the attachment types and alter those that exist currently
--create table attachment_types_bak as select * from attachment_types;

begin;

insert into attachment_types (attachment_type_desc, display_order) values ('Main Image', 1);
	
-- update contributor attachments to be main image
update contributor_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 1;
delete from attachment_types where attachment_type_id = 1;		


update contributor_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update event_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update manifestation_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update organisation_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update person_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update resource_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;

update work_attachments set attachment_type_id = 
currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 3;
				
-- update sample attachments to use the sample attachment type
update sample_attachments set attachment_type_id = 5 where attachment_type_id = 3;

-- delete the old contributor photo attachment type

delete from attachment_types where attachment_type_id = 3;
	
	
-- this is the image type that is used in search results if a main image does not exist
insert into attachment_types (attachment_type_desc, display_order) values ('Icon Image', 1);

-- convert the contributor thumbnail to icon image
update contributor_attachments set attachment_type_id = 
	currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 2;

-- convert the contributor thumbnail to icon image
update manifestation_attachments set attachment_type_id = 
	currval('attachment_types_attachment_type_id_seq') where attachment_type_id = 4;
		
delete from attachment_types where attachment_type_id = 2;
delete from attachment_types where attachment_type_id = 4;
	
		
-- these are new so no tweaks required
insert into attachment_types (attachment_type_desc, display_order) values ('Logo', 3);
insert into attachment_types (attachment_type_desc, display_order) values ('Supplementary Image', 4);

-- this is internal only
insert into attachment_types (attachment_type_desc, display_order) values ('Tiny MCE', -1);
	
	
-- now alter the existing attachment types to use Main Image and Icon Image instead of the respective
-- contributor and manifestation attachment types.  This will keep things generic


commit;