----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 26/09/2007 17:44:04
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;

-- ADDING NEW COLUMN delivery_timestamp
alter table mailout_contacts
  add column delivery_timestamp timestamp;

-- RE-CREATING CHANGED CONSTRAINT ckc_mailout_status_campaign
alter table campaign_mailouts
 drop constraint ckc_mailout_status_campaign restrict;
alter table campaign_mailouts alter column mailout_status drop default;

-- Avoid constraint violations..
update campaign_mailouts set mailout_status='n';

alter table campaign_mailouts
  add constraint ckc_mailout_status_campaign check ((((mailout_status = 'n'::bpchar) OR (mailout_status = 'r'::bpchar)) OR (mailout_status = 'i'::bpchar)) OR (mailout_status = 's'::bpchar));

alter table campaign_mailouts alter column mailout_status set default 'n'; 

COMMIT;
