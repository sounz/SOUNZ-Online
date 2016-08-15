-- Patch for SOUNZ database upgrade
-- 1.35.0 to 1.36.0
--

BEGIN;

-- WR#62057 - Orders failed to be created as
-- the types of zencartorders columns limited to certain
-- characters long, we don't have any limits in sounz database for address columns,
-- hence, for consistency and to avoid any other problems, change
-- the address column types from 'character varying' to 'text'
ALTER TABLE zencartorders
  ALTER COLUMN customers_name TYPE text,
  ALTER COLUMN customers_company TYPE text,
  ALTER COLUMN customers_street_address TYPE text,
  ALTER COLUMN customers_suburb TYPE text,
  ALTER COLUMN customers_city TYPE text,
  ALTER COLUMN customers_postcode TYPE text,
  ALTER COLUMN customers_state TYPE text,
  ALTER COLUMN customers_country TYPE text,
  ALTER COLUMN customers_telephone TYPE text,
  ALTER COLUMN customers_email_address TYPE text,
  ALTER COLUMN delivery_name TYPE text,
  ALTER COLUMN delivery_company TYPE text,
  ALTER COLUMN delivery_street_address TYPE text,
  ALTER COLUMN delivery_suburb TYPE text,
  ALTER COLUMN delivery_city TYPE text,
  ALTER COLUMN delivery_postcode TYPE text,
  ALTER COLUMN delivery_state TYPE text,
  ALTER COLUMN delivery_country TYPE text,
  ALTER COLUMN billing_name TYPE text,
  ALTER COLUMN billing_company TYPE text,
  ALTER COLUMN billing_street_address TYPE text,
  ALTER COLUMN billing_suburb TYPE text,
  ALTER COLUMN billing_city TYPE text,
  ALTER COLUMN billing_postcode TYPE text,
  ALTER COLUMN billing_state TYPE text,
  ALTER COLUMN billing_country TYPE text
;

-- drop sounz_zencart_address_book view, so that we can alter column types of zencartaddress_book
-- and then recreate it
DROP VIEW sounz_zencart_address_book;

ALTER TABLE zencartaddress_book
  ALTER COLUMN entry_company TYPE text,
  ALTER COLUMN entry_firstname TYPE text,
  ALTER COLUMN entry_lastname TYPE text,
  ALTER COLUMN entry_street_address TYPE text,
  ALTER COLUMN entry_suburb TYPE text,
  ALTER COLUMN entry_postcode TYPE text,
  ALTER COLUMN entry_city TYPE text,
  ALTER COLUMN entry_state TYPE text
;

CREATE OR REPLACE VIEW sounz_zencart_address_book AS
SELECT rc.role_contactinfo_id AS address_book_id, l.login_id AS customers_id, p.gender AS entry_gender, o.organisation_name AS entry_company, p.first_names AS entry_firstname, p.last_name AS entry_lastname, c.street || ' ' || c.po_box AS entry_street_address, c.suburb AS entry_suburb, c.postcode AS entry_postcode, c.locality AS entry_city, r.region_name AS entry_state, c.country_id AS entry_country_id, 0 AS entry_zone_id
   FROM logins l
   LEFT JOIN people p ON l.person_id = p.person_id
   LEFT JOIN roles ro ON ro.person_id = p.person_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
   LEFT JOIN regions r ON r.region_id = c.region_id
   LEFT JOIN countries co ON co.country_id = c.country_id
   LEFT JOIN organisations o ON o.organisation_id = ro.organisation_id
  WHERE rc.contactinfo_id IS NOT NULL AND (c.street <> ''::text OR c.building <> ''::text)

UNION

SELECT rc.role_contactinfo_id AS address_book_id, l.login_id AS customers_id, 'M'::char(1) AS entry_gender, o.organisation_name AS entry_company, ''::text AS entry_firstname, ''::text AS entry_lastname, c.street || ' ' || c.po_box AS entry_street_address, c.suburb AS entry_suburb, c.postcode AS entry_postcode, c.locality AS entry_city, r.region_name AS entry_state, c.country_id AS entry_country_id, 0 AS entry_zone_id
   FROM logins l
   LEFT JOIN organisations o ON l.organisation_id = o.organisation_id
   LEFT JOIN roles ro ON ro.organisation_id = o.organisation_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
   LEFT JOIN regions r ON r.region_id = c.region_id
   LEFT JOIN countries co ON co.country_id = c.country_id
WHERE rc.contactinfo_id IS NOT NULL AND (c.street <> ''::text OR c.building <> ''::text)

UNION

select * from zencartaddress_book;

COMMIT;