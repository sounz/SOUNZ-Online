----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user liuba at 08/10/2007 17:25:29
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

DROP index mailout_attachment_uix;

COMMIT;

