----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 20/12/2007 16:56:19
--
-- Instructions:
-- apply this script to target database sounz
--
----------------------------------------------------------------------------

BEGIN;

-- DROPPING NON-EXISTENT TABLE allowed_ips
drop table allowed_ips;

-- DROPPING NON-EXISTENT TABLE backup_works
drop table backup_works;

-- COLUMNS to ALTER on TABLE borrowed_items
update borrowed_items set active=true where active is null;
alter table borrowed_items
  alter column active set not null;

-- COLUMNS to DROP/RECREATE on TABLE items
alter table "items" drop column login_id;

-- COLUMNS to DROP/RECREATE on TABLE memberships
alter table "memberships" drop column zencart_order_id;

-- COLUMNS to ALTER on TABLE memberships
update memberships set pending_payment=false where pending_payment is null;
alter table memberships
  alter column pending_payment set not null;

-- CREATING NEW CONSTRAINT service_membertype_fk
alter table sounz_services
  add constraint service_membertype_fk foreign key (member_type_id) references member_types (member_type_id) on update restrict on delete restrict;

-- WR#51296 change 'Taiwan, Province of China' to 'Taiwan'
update countries set country_name='Taiwan' where country_name ilike '%taiwan%';

COMMIT;
