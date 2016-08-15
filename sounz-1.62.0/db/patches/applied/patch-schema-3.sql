----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 30/08/2007 15:06:39
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- ADDING NEW COLUMN programme_note
alter table works
  add column programme_note text;
