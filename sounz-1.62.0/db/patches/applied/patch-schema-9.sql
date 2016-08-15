----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 13/09/2007 21:26:33
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- COLUMNS to DROP/RECREATE on TABLE manifestations
alter table "manifestations" drop column freight_code;
alter table manifestations
  add column freight_code int4;

-- COLUMNS to DROP/RECREATE on TABLE resources
alter table "resources" drop column freight_code;
alter table resources
  add column freight_code int4;

-- COLUMNS to ALTER on TABLE resources
alter table resources
  alter column author_note drop not null;
