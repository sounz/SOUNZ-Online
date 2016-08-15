----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user liuba at 04/10/2007 11:45:34
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

drop table settings;

CREATE TABLE settings (
setting_id           SERIAL               not null,
setting_name         TEXT                 not null,
setting_value        TEXT                 not null,
CONSTRAINT PK_SETTINGS PRIMARY KEY (setting_id)
);

GRANT SELECT ON settings TO SOUNZ_REPORTS;

COMMIT;

