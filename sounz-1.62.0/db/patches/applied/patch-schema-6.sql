----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v9.1
-- connecting as user liuba at 04/09/2007 16:05:16
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- Making phone field of mailout_contacts table not mandatory
alter table mailout_contacts alter column phone drop not null;