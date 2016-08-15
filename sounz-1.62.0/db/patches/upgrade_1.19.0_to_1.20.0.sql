-- Patch for SOUNZ database upgrade
-- 1.19.0 to 1.20.0
--

BEGIN;

--WR#53914 - deleting logins with email type usernames and without person/organisation associated with them
DELETE FROM memberships 
  WHERE login_id IN (
    SELECT login_id FROM logins
      WHERE person_id IS NULL 
        AND organisation_id IS NULL 
        AND username ilike '%@%'  
);

DELETE FROM password_change_requests
  WHERE requested_by_login_id IN (
    SELECT login_id FROM logins
      WHERE person_id IS NULL 
        AND organisation_id IS NULL 
        AND username ilike '%@%'  
);

DELETE FROM logins
  WHERE person_id IS NULL 
    AND organisation_id IS NULL 
    AND username ilike '%@%'
;

COMMIT;