-- Patch for SOUNZ database upgrade
-- 1.45.0 to 1.46.0
--
BEGIN;

--WR#69808 - Fixing zencart address book that didn't get contact info details if street or building info were empty
--and fixing Building details of contact info not showing in Ecommerce part of the system
DROP VIEW sounz_zencart_address_book;

CREATE VIEW sounz_zencart_address_book AS
SELECT rc.role_contactinfo_id AS address_book_id, l.login_id AS customers_id, p.gender AS entry_gender, o.organisation_name AS entry_company, p.first_names AS entry_firstname, p.last_name AS entry_lastname, c.building || ' ' || c.street || ' ' || c.po_box AS entry_street_address, c.suburb AS entry_suburb, c.postcode AS entry_postcode, c.locality AS entry_city, r.region_name AS entry_state, c.country_id AS entry_country_id, 0 AS entry_zone_id
   FROM logins l
   LEFT JOIN people p ON l.person_id = p.person_id
   LEFT JOIN roles ro ON ro.person_id = p.person_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
   LEFT JOIN regions r ON r.region_id = c.region_id
   LEFT JOIN countries co ON co.country_id = c.country_id
   LEFT JOIN organisations o ON o.organisation_id = ro.organisation_id
  WHERE rc.contactinfo_id IS NOT NULL AND (c.street <> ''::text OR c.building <> ''::text OR c.po_box <> ''::text OR c.suburb <> ''::text OR c.locality <> ''::text)

UNION

SELECT rc.role_contactinfo_id AS address_book_id, l.login_id AS customers_id, 'M'::char(1) AS entry_gender, o.organisation_name AS entry_company, ''::text AS entry_firstname, ''::text AS entry_lastname, c.building || ' ' || c.street || ' ' || c.po_box AS entry_street_address, c.suburb AS entry_suburb, c.postcode AS entry_postcode, c.locality AS entry_city, r.region_name AS entry_state, c.country_id AS entry_country_id, 0 AS entry_zone_id
   FROM logins l
   LEFT JOIN organisations o ON l.organisation_id = o.organisation_id
   LEFT JOIN roles ro ON ro.organisation_id = o.organisation_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
   LEFT JOIN regions r ON r.region_id = c.region_id
   LEFT JOIN countries co ON co.country_id = c.country_id
WHERE rc.contactinfo_id IS NOT NULL AND (c.street <> ''::text OR c.building <> ''::text OR c.po_box <> ''::text OR c.suburb <> ''::text OR c.locality <> ''::text)

UNION

select * from zencartaddress_book;

COMMIT;