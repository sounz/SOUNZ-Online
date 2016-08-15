----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 01/11/2007 14:41:26
--
-- Instructions:
-- apply this script to target database diffsounz, This will then
-- make it identical to the reference database, diffsounz-new.
--
----------------------------------------------------------------------------
BEGIN;
drop table sounz_services cascade;
COMMIT;

BEGIN;
drop table sounz_donations cascade;
COMMIT;

BEGIN;
--Create SOUNZ Services table
CREATE TABLE sounz_services (
sounz_service_id     INT               not null default nextval('manifestations_manifestation_id_seq'),
sounz_service_name   TEXT                 not null,
sounz_service_description TEXT                 null,
sounz_service_price  NUMERIC              not null DEFAULT 0.00,
subscription_duration INTERVAL             null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SOUNZ_SERVICES PRIMARY KEY (sounz_service_id)
);

CREATE INDEX UPDATED_BY_31_FK ON sounz_services (
updated_by
);

ALTER TABLE sounz_services
   ADD CONSTRAINT fk_sounz_services_updated_by FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

GRANT SELECT ON sounz_services TO SOUNZ_REPORTS;

COMMIT;


BEGIN;

-- CREATING NEW TABLE sounz_donations
create table sounz_donations (
  "sounz_donation_id" int not null default nextval('manifestations_manifestation_id_seq') ,
  "sounz_donation_price" numeric not null default 0.00,
  "sounz_donation_description" text,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "updated_by" int4 not null
);
create index donation_updated_by_fk on sounz_donations using btree (updated_by);

-- CREATING NEW CONSTRAINT fk_sounz_donations_updated_by
alter table sounz_donations
  add constraint fk_sounz_donations_updated_by foreign key (updated_by) references logins (login_id) on update restrict on delete restrict;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_sounz_donations
alter table sounz_donations
  add constraint pk_sounz_donations primary key (sounz_donation_id);

COMMIT;

BEGIN;
-- CREATING NEW INDEX donation_updated_by_fk
create index donation_updated_by_fk on sounz_donations using btree (updated_by);
COMMIT;
