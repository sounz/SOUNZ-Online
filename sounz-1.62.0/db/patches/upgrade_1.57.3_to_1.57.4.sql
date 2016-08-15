-- Patch for SOUNZ database upgrade
-- 1.57.3 to 1.57.4
--
BEGIN;

-- WR85535 adding fields to prov_work_updates

ALTER TABLE prov_work_updates ADD COLUMN suitable_for TEXT;
ALTER TABLE prov_work_updates ADD COLUMN streamable BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE prov_work_updates ADD COLUMN streamable_permission BOOLEAN NOT NULL DEFAULT false;

COMMIT;
