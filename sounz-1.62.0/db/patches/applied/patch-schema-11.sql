----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 19/09/2007 11:26:33
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- COLUMNS to DROP on TABLE communications
alter table "communications" drop column communication_agent_class;
