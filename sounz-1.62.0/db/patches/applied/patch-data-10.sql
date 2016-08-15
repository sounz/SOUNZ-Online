--update password fields with zencart-compaticle MD5s.
--All passwords set to 'sounz00'

BEGIN;
UPDATE logins set password='0e7333d76a3a0f45925b57a5a77f1f46:f69',salt='f69' where username = 'pete' or username = 'gordon' or username = 'liuba';
COMMIT;