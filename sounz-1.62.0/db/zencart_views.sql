
-- address book

CREATE OR REPLACE VIEW sounz_zencart_address_book AS
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



--sounz_products_for_sale

create or replace view sounz_products_for_sale as SELECT m.sale_product_id AS product_id, m.manifestation_id, m.manifestation_type_id, m.format_id, m.status_id, m.manifestation_title, m.manifestation_title_alt, m.series_title, m.publication_year, m.isbn, m.ismn, m.isrc, m.issn, m.imprint, m.copyright, m.collation, m.duration, m.dedication_note, m.publisher_note, m.content_note, m.general_note, m.internal_note, m.manifestation_code, m.mw_code, m.clonable, m.available_for_loan, m.available_for_hire, m.available_for_sale, m.item_cost, m.freight_code, m.created_at, m.updated_at, m.updated_by, m.downloadable, (select count(*) from items si where m.manifestation_id = si.manifestation_id) as item_count
   FROM manifestations m left join items i on i.manifestation_id = m.manifestation_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE m.available_for_sale = true;
  

--sounz_products_for_loan

create or replace view sounz_products_for_loan as SELECT m.loan_product_id AS product_id, m.manifestation_id, m.manifestation_type_id, m.format_id, m.status_id, CONCAT('(FOR LOAN) ',m.manifestation_title)as manifestation_title, m.manifestation_title_alt, m.series_title, m.publication_year, m.isbn, m.ismn, m.isrc, m.issn, m.imprint, m.copyright, m.collation, m.duration, m.dedication_note, m.publisher_note, m.content_note, m.general_note, m.internal_note, m.manifestation_code, m.mw_code, m.clonable, m.available_for_loan, m.available_for_hire, m.available_for_sale, m.item_cost, 0::int as freight_code, m.created_at, m.updated_at,m.updated_by, m.downloadable,(select count(*) from items si where m.manifestation_id = si.manifestation_id) as item_count
   FROM manifestations m left join items i on i.manifestation_id = m.manifestation_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE m.available_for_loan = true and it.item_type_desc='Music library item';


--sounz_resources_for_sale

create or replace view sounz_resources_for_sale as SELECT r.sale_product_id AS product_id, r.resource_id, r.resource_type_id, r.format_id, r.status_id, r.resource_title, r.resource_title_alt, r.series_title, r.publication_year, r.isbn, r.ismn, r.isrc, r.issn, r.imprint, r.copyright, r.collation, r.duration, r.dedication_note, r.publisher_note, r.content_note, r.general_note, r.internal_note, r.resource_code, r.mw_code, r.clonable, r.available_for_loan, r.available_for_hire, r.available_for_sale, r.item_cost, r.freight_code, r.created_at, r.updated_at, r.updated_by, r.downloadable, (select count(*) from items si where r.resource_id = si.resource_id) as item_count
   FROM resources r left join items i on i.resource_id = r.resource_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE r.available_for_sale = true;

--sounz_resources_for_loan

create or replace view sounz_resources_for_loan as SELECT r.loan_product_id AS product_id, r.resource_id, r.resource_type_id, r.format_id, r.status_id, CONCAT('(FOR LOAN) ',r.resource_title) AS resource_title, r.resource_title_alt, r.series_title, r.publication_year, r.isbn, r.ismn, r.isrc, r.issn, r.imprint, r.copyright, r.collation, r.duration, r.dedication_note, r.publisher_note, r.content_note, r.general_note, r.internal_note, r.resource_code, r.mw_code, r.clonable, r.available_for_loan, r.available_for_hire, r.available_for_sale, r.item_cost, 0::int as freight_code, r.created_at, r.updated_at, r.updated_by, r.downloadable, (select count(*) from items si where r.resource_id = si.resource_id) as item_count
   FROM resources r left join items i on i.resource_id = r.resource_id left join item_types it on it.item_type_id = i.item_type_id
  WHERE r.available_for_loan = true and it.item_type_desc='Resource library item';




--sounz_zencart_products

CREATE OR REPLACE VIEW sounz_zencart_products AS

SELECT 'SALE_MANIFESTATION' as products_class,m.product_id AS products_id, m.manifestation_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, m.mw_code AS products_model, ''::text AS products_image, m.item_cost AS products_price, 0 AS products_virtual, m.created_at AS products_date_added, m.updated_at AS products_last_modified, m.created_at AS products_date_available, m.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 1 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, CASE WHEN m.downloadable = true THEN 1::integer ELSE 0::integer END as products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_products_for_sale m

UNION

SELECT 'LOAN_MANIFESTATION' as products_class,l.product_id AS products_id, l.manifestation_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, l.mw_code AS products_model, ''::text AS products_image, l.item_cost AS products_price, 1 AS products_virtual, l.created_at AS products_date_added, l.updated_at AS products_last_modified, l.created_at AS products_date_available, l.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 1 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 1 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_products_for_loan l where l.item_count >0

UNION

SELECT 'SALE_RESOURCE' as products_class,r.product_id AS products_id, r.resource_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, r.mw_code AS products_model, ''::text AS products_image, r.item_cost AS products_price, 0 AS products_virtual, r.created_at AS products_date_added, r.updated_at AS products_last_modified, r.created_at AS products_date_available, r.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 1 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, CASE WHEN r.downloadable = true THEN 1::integer ELSE 0::integer END as products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_resources_for_sale r

UNION

SELECT 'LOAN_RESOURCE' as products_class,r.product_id AS products_id, r.resource_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, r.mw_code AS products_model, ''::text AS products_image, r.item_cost AS products_price, 1 AS products_virtual, r.created_at AS products_date_added, r.updated_at AS products_last_modified, r.created_at AS products_date_available, r.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 1 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_resources_for_loan r where r.item_count >0

UNION

SELECT 'SERVICE' as products_class,s.sounz_service_id AS products_id, s.sounz_service_id as manifestation_id, 1 AS products_type, 1 AS products_quantity, ''::text AS products_model, ''::text AS products_image, s.sounz_service_price AS products_price, 1 AS products_virtual, s.created_at AS products_date_added, s.updated_at AS products_last_modified, s.created_at AS products_date_available, 0 AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 1 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 1 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_services s

UNION

SELECT 'DONATION' as products_class,d.sounz_donation_id AS products_id, d.sounz_donation_id as manifestation_id, 1 AS products_type, 9999 AS products_quantity, ''::text AS products_model, ''::text AS products_image, d.sounz_donation_price AS products_price, 1 AS products_virtual, d.created_at AS products_date_added, d.updated_at AS products_last_modified, d.created_at AS products_date_available, 0 AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 0 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 1 AS product_is_always_free_shipping, 1 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
   FROM sounz_donations d;
   
--sounz_zencart_products_description

CREATE OR REPLACE VIEW sounz_zencart_products_description AS

SELECT m.product_id AS products_id, 1 AS language_id, m.manifestation_title AS products_name, m.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_products_for_sale m

UNION

SELECT m.product_id AS products_id, 1 AS language_id, m.manifestation_title AS products_name, m.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_products_for_loan m

UNION

SELECT r.product_id AS products_id, 1 AS language_id, r.resource_title AS products_name, r.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_resources_for_sale r

UNION 

SELECT r.product_id AS products_id, 1 AS language_id, r.resource_title AS products_name, r.general_note AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_resources_for_loan r
   
UNION

SELECT s.sounz_service_id AS products_id, 1 AS language_id, s.sounz_service_name AS products_name, s.sounz_service_description AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_services s

UNION

SELECT d.sounz_donation_id AS products_id, 1 AS language_id, d.sounz_donation_description AS products_name, d.sounz_donation_description AS products_description, 'http://sounz.catalyst.net.nz' AS products_url, 0 AS products_viewed
   FROM sounz_donations d;

--sounz_zencart_products_to_categories

CREATE OR REPLACE VIEW sounz_zencart_products_to_categories AS

SELECT m.product_id AS products_id, 2 AS categories_id
   FROM sounz_products_for_sale m

UNION

SELECT l.product_id AS products_id, 4 AS categories_id
   FROM sounz_products_for_loan l

UNION

SELECT sr.product_id AS products_id, 6 AS categories_id
   FROM sounz_resources_for_sale sr

UNION

SELECT lr.product_id AS products_id, 7 AS categories_id
   FROM sounz_resources_for_loan lr

UNION

SELECT s.sounz_service_id AS products_id, 3 AS categories_id
   FROM sounz_services s

UNION

SELECT d.sounz_donation_id AS products_id, 5 AS categories_id
   FROM sounz_donations d;
   

--sounz_zencart_customers

CREATE OR REPLACE VIEW sounz_zencart_customers AS

SELECT l.login_id AS customers_id, p.gender AS customers_gender, p.first_names AS customers_firstname, p.last_name AS customers_lastname, p.year_of_birth AS customers_dob, c.email_1 AS customers_email_address, l.username AS customers_nick, rc.role_contactinfo_id AS customers_default_address_id, c.phone AS customers_telephone, c.phone_fax AS customers_fax, l."password" AS customers_password, 0 AS customers_newsletter, (select case when count(*) > 0 then 1 else 0 end as customers_group_pricing from logins sl left join memberships sm on sl.login_id = sm.login_id left join member_types smt on sm.member_type_id=smt.member_type_id where smt.member_type_desc='Online Member' and sl.login_id=l.login_id) AS customers_group_pricing, 'TEXT' AS customers_email_format, 0 AS customers_authorization, '' AS customers_referral, '' AS customers_paypal_payerid, 0 AS customers_paypal_ec, ( SELECT nomens.nomen
           FROM nomens
          WHERE nomens.nomen_id = p.nomen_id) AS customers_nomen
   FROM logins l
   LEFT JOIN people p ON l.person_id = p.person_id
   LEFT JOIN roles ro ON ro.person_id = p.person_id
   LEFT JOIN role_types rt on ro.role_type_id=rt.role_type_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
  WHERE rc.contactinfo_type='postal' and rt.role_type_desc='Person'AND ro.organisation_id IS NULL 
  
UNION

  SELECT l.login_id AS customers_id, 'M'::char(1) AS customers_gender, '' AS customers_firstname, o.organisation_name AS customers_lastname, o.year_of_establishment AS customers_dob, c.email_1 AS customers_email_address, l.username AS customers_nick, rc.role_contactinfo_id AS customers_default_address_id, c.phone AS customers_telephone, c.phone_fax AS customers_fax, l."password" AS customers_password, 0 AS customers_newsletter, (select case when count(*) > 0 then 1 else 0 end as customers_group_pricing from logins sl left join memberships sm on sl.login_id = sm.login_id left join member_types smt on sm.member_type_id=smt.member_type_id where smt.member_type_desc='Online Member' and sl.login_id=l.login_id) AS customers_group_pricing, 'TEXT' AS customers_email_format, 0 AS customers_authorization, '' AS customers_referral, '' AS customers_paypal_payerid, 0 AS customers_paypal_ec, '' AS customers_nomen
   FROM logins l
   LEFT JOIN organisations o ON l.organisation_id = o.organisation_id
   LEFT JOIN roles ro ON ro.organisation_id = o.organisation_id
   LEFT JOIN role_types rt on ro.role_type_id=rt.role_type_id
   LEFT JOIN role_contactinfos rc ON ro.role_id = rc.role_id
   LEFT JOIN contactinfos c ON rc.contactinfo_id = c.contactinfo_id
  WHERE rc.contactinfo_type='postal' and rt.role_type_desc='Organisation'AND ro.person_id IS NULL;

--sounz_zencart_product_attributes

create or replace view sounz_zencart_product_attributes as select 
m.sale_product_id as products_attributes_id, m.sale_product_id as products_id, 1 as options_id, CASE WHEN m.format_id IN (18) THEN 1::integer ELSE 2::integer END as options_values_id, 
0 as options_values_price,''::text as price_prefix,0 as products_options_sort_order, 0 as product_attribute_is_free, m.freight_code as products_attributes_weight,
'-'::text as products_attributes_weight_prefix, 0  as attributes_display_only, 1 as attributes_default, 0 as attributes_discounted,
''::text as attributes_image, 1 as attributes_price_base_included,0 as attributes_price_onetime, 0 as attributes_price_factor,
0 as attributes_price_factor_offset, 0 as attributes_price_factor_onetime, 0 as attributes_price_factor_onetime_offset,
''::text as attributes_qty_prices, ''::text as attributes_qty_prices_onetime,0 as attributes_price_words, 0 as attributes_price_words_free, 0 as attributes_price_letters, 0 as attributes_price_letters_free,
0 as attributes_required from manifestations m where m.downloadable=true

UNION

select 
r.sale_product_id as products_attributes_id, r.sale_product_id as products_id, 1 as options_id, CASE WHEN r.format_id IN (18) THEN 1::integer ELSE 2::integer END as options_values_id, 
0 as options_values_price,''::text as price_prefix,0 as products_options_sort_order, 0 as product_attribute_is_free, r.freight_code as products_attributes_weight,
'-'::text as products_attributes_weight_prefix, 0  as attributes_display_only, 1 as attributes_default, 0 as attributes_discounted,
''::text as attributes_image, 1 as attributes_price_base_included,0 as attributes_price_onetime, 0 as attributes_price_factor,
0 as attributes_price_factor_offset, 0 as attributes_price_factor_onetime, 0 as attributes_price_factor_onetime_offset,
''::text as attributes_qty_prices, ''::text as attributes_qty_prices_onetime,0 as attributes_price_words, 0 as attributes_price_words_free, 0 as attributes_price_letters, 0 as attributes_price_letters_free,
0 as attributes_required from resources r where r.downloadable=true;




--sounz_zencart_product_attributes_download

create or replace view sounz_zencart_product_attributes_download as select m.sale_product_id as products_attributes_id, m.download_file_name as products_attributes_filename,m.download_file_name_2 as products_attributes_filename_2,3 as products_attributes_maxdays, 3 as products_attributes_maxcount from manifestations m where m.downloadable=true;

--sounz_zencart_countries

create or replace view sounz_zencart_countries as select c.country_id as countries_id, c.country_name as countries_name,c.country_abbrev as countries_iso_code_2,c.country_abbrev as countries_iso_code_3,1 as address_format_id from countries c;
