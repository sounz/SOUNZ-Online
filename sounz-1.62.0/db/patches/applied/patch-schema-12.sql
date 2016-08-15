----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 24/09/2007 12:40:34
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

-- DROPPING NON-EXISTENT TABLE search_settings
drop table search_settings;

-- CREATING NEW TABLE cm_contents
create table cm_contents (
  "cm_content_id" serial not null,
  "status_id" int4 not null,
  "cm_content_desc" text,
  "cm_content" text,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "updated_by" int4 not null
);
create index cm_contents_updated_by_fk2 on cm_contents using btree (updated_by);
create index cm_contents_updated_by_fk on cm_contents using btree (status_id);

-- ADDING NEW COLUMN downloadable
alter table manifestations add column downloadable bool;
alter table manifestations alter column downloadable set default 'false';
update manifestations set downloadable=FALSE;
alter table manifestations alter column downloadable set not null;

-- ADDING NEW COLUMN downloadable
alter table resources add column downloadable bool;
alter table resources alter column downloadable set default 'false';
update resources set downloadable=FALSE;
alter table resources alter column downloadable set not null;

-- CREATING NEW CONSTRAINT fk_cm_conte_updated_b_logins
alter table cm_contents
  add constraint fk_cm_conte_updated_b_logins foreign key (updated_by) references logins (login_id) on update restrict on delete restrict;

-- CREATING NEW CONSTRAINT fk_cm_conte_cm_conten_publishi
alter table cm_contents
  add constraint fk_cm_conte_cm_conten_publishi foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict;


COMMIT;

