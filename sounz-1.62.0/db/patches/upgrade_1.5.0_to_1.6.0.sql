-- Patch for SOUNZ database upgrade
-- 1.5.0 to 1.6.0
--

begin;
-- set status to 'Withdrawn' for the works marked to 'delete'
update works set status_id=(select status_id from publishing_statuses where status_desc = 'Withdrawn') where work_title ILIKE '%delete%' and status_id=(select status_id from publishing_statuses where status_desc = 'Published');

commit;