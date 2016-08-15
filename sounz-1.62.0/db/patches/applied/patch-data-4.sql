----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 02/09/2007 09:00:16
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
-- This data update just provides the item_types which can be selected
-- for items in the maintenance screen.
----------------------------------------------------------------------------

BEGIN;

UPDATE item_types SET item_type_desc='Reference library item' WHERE item_type_id=1;
SELECT SETVAL('item_types_item_type_id_seq', 1);
INSERT INTO item_types (item_type_desc) VALUES ('Music library item');
INSERT INTO item_types (item_type_desc) VALUES ('Commercial item');

COMMIT;

