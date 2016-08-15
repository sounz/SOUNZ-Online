----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 21/08/2007 20:30:36
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

-- RE-CREATING CHANGED CONSTRAINT ckc_access_right_sour_expressi
alter table expression_access_rights
 drop constraint ckc_access_right_sour_expressi restrict;
alter table expression_access_rights
  add constraint ckc_access_right_sour_expressi check ((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text));

-- RE-CREATING CHANGED CONSTRAINT ckc_access_right_sour_manifest
alter table manifestation_access_rights
 drop constraint ckc_access_right_sour_manifest restrict;
alter table manifestation_access_rights
  add constraint ckc_access_right_sour_manifest check ((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text));

-- RE-CREATING CHANGED CONSTRAINT ckc_access_right_sour_resource
alter table resource_access_rights
 drop constraint ckc_access_right_sour_resource restrict;
alter table resource_access_rights
  add constraint ckc_access_right_sour_resource check ((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text));

-- RE-CREATING CHANGED CONSTRAINT ckc_access_right_sour_work_acc
alter table work_access_rights
 drop constraint ckc_access_right_sour_work_acc restrict;
alter table work_access_rights
  add constraint ckc_access_right_sour_work_acc check ((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text));

COMMIT;
