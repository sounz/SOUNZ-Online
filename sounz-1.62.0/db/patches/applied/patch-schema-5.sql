----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 04/09/2007 08:12:10
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
-- Some minor changes to the distinction_instances table:
-- 1) The field "prize_placing" turns out to be not required, but notes
-- on the award are needed, so this text field is being renamed.
--
-- 2) The "award_date" field is being replaced with an integer field
-- to simply record the year, since SOUNZ never get told the
-- full date of these awards.
----------------------------------------------------------------------------

BEGIN;

-- RENAME "prize_placing" to "instance_info"
alter table "distinction_instances"
  rename column prize_placing to instance_info;

-- REPLACE "award_date" with "award_year"
alter table "distinction_instances"
  drop column award_date;
alter table distinction_instances
  add column award_year int4;

COMMIT;

