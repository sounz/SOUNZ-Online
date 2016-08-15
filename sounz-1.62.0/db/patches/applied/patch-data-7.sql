-- ADD EXTRA PRIVILEGES
-- ONLY RUN THIS ONCE!!

BEGIN;

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_ADV_SEARCH','User can access public advanced search functionality (SOUNZ Members only)');
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('CAN_SAVE_SEARCH','User can access saved search functionality (SOUNZ Members only)');
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('CAN_ACCESS_CRM','User can access CRM functionality (SOUNZ Administrator and CRM Administrators only)');
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('IS_AUTHENTICATED','User has an account with SOUNZ, needed to add sale items to cart etc.');
INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('CAN_ACCESS_LIBRARY','User has a library account with SOUNZ, needed to add loan items to cart etc.');

COMMIT;