-- Patch for SOUNZ database upgrade
-- 1.41.0 to 1.42.0
--
begin;

ALTER TABLE regions ALTER COLUMN region_order SET NOT NULL;

commit;
