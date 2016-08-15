--Replaces 'Campaign mailout' attachment type in mailout_attachments to
--'Tiny MCE' and deletes attachment type 'Campaign mailout' from attachment_types

begin;

update mailout_attachments set attachment_type_id = (select attachment_type_id from attachment_types where attachment_type_desc like '%Tiny MCE%');

delete from attachment_types where attachment_type_desc like '%Campaign mailout%';

commit;