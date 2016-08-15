begin;

-- WR 50264 remove all '(c)' from the beginning of the copyright field of a manifestation
UPDATE manifestations SET copyright = REPLACE(copyright, '(c) ','');
UPDATE manifestations SET copyright = REPLACE(copyright, '(C) ','');

-- WR 67057 allow downloadable items to be added to the shopping cart multiple times
CREATE OR REPLACE VIEW sounz_zencart_products AS

SELECT 'SALE_MANIFESTATION' as products_class,m.product_id AS products_id, m.manifestation_id as manifestation_id, 1 AS products_type, item_count AS products_quantity, m.mw_code AS products_model, ''::text AS products_image, m.item_cost AS products_price, 0 AS products_virtual, m.created_at AS products_date_added, m.updated_at AS products_last_modified, m.created_at AS products_date_available, m.freight_code AS products_weight, 1 AS products_status, 0 AS products_tax_class_id, NULL::integer AS manufacturers_id, 0 AS products_ordered, 0 AS products_quantity_order_min, 1 AS products_quantity_order_units, 1 AS products_priced_by_attribute, 0 AS product_is_free, 0 AS product_is_call, 0 AS products_quantity_mixed, 0 AS product_is_always_free_shipping, 0 AS products_qty_box_status, 0 AS products_quantity_order_max, 0 AS products_sort_order, 0 AS products_discount_type, 0 AS products_discount_type_from, 1 AS products_price_sorter, 0 AS master_categories_id, 0 AS products_mixed_discount_quantity, 0 AS metatags_title_status, 0 AS metatags_products_name_status, 0 AS metatags_model_status, 0 AS metatags_price_status, 0 AS metatags_title_tagline_status
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

-- WR 67106 rename "Related Resources" to "Resources"
UPDATE valid_entity_entity_relationships SET page_title = 'Resources' where ruby_method_name = 'related_resources';

-- WR 67077 adding children to concepts that did not have one
INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Bible',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Bible' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Wedding',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Wedding' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Urban NZ',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Urban NZ' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Spiritual',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Spiritual' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Sea and Water',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Sea and Water' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Religious',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Religious' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('No theme',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'No theme' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Heaven and hell',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Heaven and hell' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Easter',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Easter' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Christmas',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Christmas' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Birth',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Birth' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);


INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Sea and Water',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Sea and Water' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Sea and Water - NZ',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Sea and Water - NZ' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Spectralism',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Genre'),
          (select concept_id from concepts where concept_name = 'Spectralism' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Genre') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('New Complexity',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Genre'),
          (select concept_id from concepts where concept_name = 'New Complexity' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Genre') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Spectralism',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Influence'),
          (select concept_id from concepts where concept_name = 'Spectralism' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('New Complexity',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Influence'),
          (select concept_id from concepts where concept_name = 'New Complexity' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Birds',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Influence'),
          (select concept_id from concepts where concept_name = 'Birds' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence') and  parent_concept_id is null),
          now(),
          now()
);

-- WR 67076 adding new children to concepts
INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Flemish and Dutch',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Culture - other' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Flemish and Dutch',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Influence'),
          (select concept_id from concepts where concept_name = 'Culture - other' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Irish or Celtic',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Theme'),
          (select concept_id from concepts where concept_name = 'Culture - other' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Theme') and  parent_concept_id is null),
          now(),
          now()
);

INSERT INTO concepts (concept_name, updated_by, concept_type_id, parent_concept_id, created_at, updated_at)
   VALUES ('Irish or Celtic',
          (select login_id from logins where username = 'batch'),
          (select concept_type_id from concept_types where concept_type_desc = 'Influence'),
          (select concept_id from concepts where concept_name = 'Culture - other' and concept_type_id = (select concept_type_id from concept_types where concept_type_desc = 'Influence') and  parent_concept_id is null),
          now(),
          now()
);

-- WR 67041 - Advanced search for borrowed items
-- Restriction for /search_borrowed_items/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_borrowed_items', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_borrowed_items/ALL, for a privilege CAN_EDIT_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_borrowed_items', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_CRM')
);

-- Restriction for /search_borrowed_items/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_borrowed_items', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);

-- Restriction for /search_borrowed_items/ALL, for a privilege CAN_PUBLISH_CRM
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('search_borrowed_items', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_PUBLISH_CRM')
);


commit;
