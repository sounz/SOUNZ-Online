----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 11/10/2007 09:58:29
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- CREATING NEW TABLE app_control
create table app_control (
  "app_version" text,
  "last_db_patch" text,
  "updated_at" timestamp not null
);
