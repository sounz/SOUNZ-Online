----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 24/09/2007 12:40:34
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

ALTER table manifestations ALTER COLUMN manifestation_code DROP DEFAULT;
ALTER table resources ALTER COLUMN resource_code DROP DEFAULT;

COMMIT;

