-- PRIVILEGES and MEMBER TYPES
-- ONLY RUN THIS ONCE!!

-- privileges
BEGIN;

DELETE FROM member_type_privileges;

DELETE FROM controller_restrictions WHERE privilege_id = (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT');

DELETE FROM privileges WHERE privilege_name NOT LIKE '%CAN_VIEW_PUBLIC%';

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('IS_AUTHENTICATED','User has an account with SOUNZ, needed to add sale items to cart etc');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('CAN_ACCESS_LIBRARY','User has a library account with SOUNZ, needed to add loan items to cart etc.');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES('CAN_SAVE_SEARCH','User can access saved search functionality (SOUNZ Administrators and SOUNZ Online Members only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_VIEW_TAP','User can view TAP administration part (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_TAP','User can edit TAP entities (SOUNZ Administrator and TAP Administrator only');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_PUBLISH_TAP','User can publish TAP entities (SOUNZ Administrator and TAP Administrator only');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_DISTINCTION','User can edit distinctions (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_PUBLISH_DISTINCTION','User can publish distinctions (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CONTRIBUTOR_PROFILE','User can edit contributor profiles (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_PUBLISH_CONTRIBUTOR_PROFILE','User can publish contributor profiles (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CRM','User can edit CRM (SOUNZ Administrators only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_PUBLISH_CRM','User can publish CRM (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_EVENT','User can edit events (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_PUBLISH_EVENT','User can edit events (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CONTENT','User can edit events (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_LOGIN','User can edit logins (SOUNZ Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_PRIVILEGE','User can edit privileges (SOUNZ Superuser only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_PROJECT','User can edit projects and all related entities - marketing campaigns, campaign mailouts, etc (SOUNZ Administrator and CRM Administrator only)');
 
COMMIT;

-- member types
BEGIN;

UPDATE member_types SET member_type_desc = 'TAP Administrator' WHERE member_type_desc = 'FRBR Administrator';

UPDATE member_types SET member_type_desc = 'Online Member' WHERE member_type_desc = 'Member';

DELETE FROM member_types WHERE member_type_desc = 'Editor';

DELETE FROM member_types WHERE member_type_desc = 'Guest';

INSERT INTO member_types (member_type_desc) VALUES ('Contributor Member');

INSERT INTO member_types (member_type_desc) VALUES ('Library Member');

COMMIT;

-- member type privileges
BEGIN;

DELETE FROM member_type_privileges;

-- privileges for 'Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_SAVE_SEARCH'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_EVENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_EVENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CRM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_CRM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_ACCESS_LIBRARY'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_LOGIN'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_PROJECT'));

-- privileges for 'TAP Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_SAVE_SEARCH'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CRM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_ACCESS_LIBRARY'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

-- privileges for 'CRM Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_SAVE_SEARCH'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_TAP'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_DISTINCTION'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_CONTRIBUTOR_PROFILE'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_EVENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_EVENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CRM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_PUBLISH_CRM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTENT'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_PROJECT'));

-- privileges for 'Online Member' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Online Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Online Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_SAVE_SEARCH'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Online Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

-- privileges for 'Contributor Member' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Contributor Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Contributor Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

-- privileges for 'Library Member' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Library Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Library Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_ACCESS_LIBRARY'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Library Member'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

COMMIT;