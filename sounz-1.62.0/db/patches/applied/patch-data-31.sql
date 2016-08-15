-- Add privilege 'CAN_EDIT_LOGIN' to 'CRM Administrator' member type
begin;

update privileges set privilege_desc = 'User can edit logins (SOUNZ Administrator and CRM Administrator only)' 
 where privilege_name = 'CAN_EDIT_LOGIN';

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_LOGIN'));

commit;

-- new privileges for editing provider forms
begin;

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CONTACT_UPDATE_PROV_FORM','User can edit contact updates provider forms (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_EVENT_PROV_FORM','User can edit events provider forms (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_FEEDBACK_PROV_FORM','User can edit feedbacks provider forms (SOUNZ Administrator and CRM Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_WORK_UPDATE_PROV_FORM','User can edit work updates provider forms (SOUNZ Administrator and TAP Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_COMPOSER_BIO_PROV_FORM','User can edit composer bios provider forms (SOUNZ Administrator and TAP Administrator only)');

INSERT INTO privileges (privilege_name, privilege_desc)
 VALUES ('CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM','User can edit contributor profiles provider forms (SOUNZ Administrator and TAP Administrator only)');

-- 'Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_EVENT_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM'));

-- 'CRM Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTACT_UPDATE_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_EVENT_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'CRM Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_FEEDBACK_PROV_FORM'));

-- 'TAP Administrator' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_WORK_UPDATE_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_COMPOSER_BIO_PROV_FORM'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'TAP Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM'));

commit;
