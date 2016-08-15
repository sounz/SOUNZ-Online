----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 21/10/2007 14:13:14
--
-- Instructions:
-- apply this script to target database sounz
--
----------------------------------------------------------------------------

BEGIN;

-- CREATING NEW TABLE controller_restrictions
create table controller_restrictions (
  "controller_restriction_id" serial,
  "privilege_id" int4 not null,
  "status_id" int4 not null,
  "controller_name" text not null,
  "controller_action" text,
  "http_verb" text not null default 'get'::text
);
create index controller_restrict_status_fk on controller_restrictions using btree (status_id);
create index controller_restrict_pivilege_fk on controller_restrictions using btree (privilege_id);

-- CREATING NEW CONSTRAINT fk_controll_controlle_publishi
alter table controller_restrictions
  add constraint fk_controll_controlle_publishi foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict;

-- CREATING NEW CONSTRAINT fk_controll_controlle_privileg
alter table controller_restrictions
  add constraint fk_controll_controlle_privileg foreign key (privilege_id) references privileges (privilege_id) on update restrict on delete restrict;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_controller_restrictions
alter table controller_restrictions
  add constraint pk_controller_restrictions primary key (controller_restriction_id);

-- CREATING NEW CONSTRAINT ckc_http_verb_controll
alter table controller_restrictions
  add constraint ckc_http_verb_controll check ((http_verb = 'get'::text) OR (http_verb = 'post'::text));

COMMIT;
