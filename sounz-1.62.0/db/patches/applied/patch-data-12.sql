-- ADD EXTRA PRIVILEGES
-- ONLY RUN THIS ONCE!!

BEGIN;

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CONTENT_PAGES','User who have access to content managed pages (Sounz staff only)');

COMMIT;