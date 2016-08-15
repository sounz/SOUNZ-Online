
--alter items to contain a reference to the login that borrowed the item, and the due date of return.
BEGIN;
ALTER TABLE items ADD COLUMN borrowed_date timestamp;
ALTER TABLE items ADD COLUMN return_date timestamp;
ALTER TABLE items ADD COLUMN login_id int;
COMMIT;

BEGIN;
--Create SOUNZ Services table
CREATE TABLE sounz_services (
sounz_service_id     SERIAL               not null,
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
