-- Patch for SOUNZ database upgrade
-- 1.57.9 to 1.57.10
--
BEGIN;

-- WR200345 - remove memberships_page

DELETE FROM controller_restrictions where controller_action = 'memberships_page';

COMMIT;
