-- PRIVILEGES and MEMBER TYPES
-- ONLY RUN THIS ONCE!!

-- member types
BEGIN;

INSERT INTO member_types (member_type_desc) VALUES ('Guest');

-- privileges for 'Guest' member type
INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Guest'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_VIEW_PUBLIC'));

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Guest'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'IS_AUTHENTICATED'));

COMMIT;
