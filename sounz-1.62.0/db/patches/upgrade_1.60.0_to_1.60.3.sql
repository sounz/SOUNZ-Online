-- Patch for SOUNZ database upgrade
-- 1.60.0 to 1.60.3 
--

-- WR93152 - Adding new categories for Jazz 
BEGIN;

INSERT INTO work_categories (work_category_desc, work_category_abbrev, additional, display_order) VALUES ('Jazz', '24', FALSE, 15);

COMMIT;

-- adding sub-categories
BEGIN;

INSERT into work_subcategories (work_category_id, work_subcategory_desc, legacy_4d_identity_code, additional, display_order) VALUES (
    (SELECT work_category_id from work_categories where work_category_desc = 'Jazz'), 
    'Small ensemble with vocals', 
    '9999',
    FALSE,
    155);

INSERT into work_subcategories (work_category_id, work_subcategory_desc, legacy_4d_identity_code, additional, display_order) VALUES (
    (SELECT work_category_id from work_categories where work_category_desc = 'Jazz'), 
    'Small ensemble without vocals', 
    '9999',
    FALSE,
    156);

INSERT into work_subcategories (work_category_id, work_subcategory_desc, legacy_4d_identity_code, additional, display_order) VALUES (
    (SELECT work_category_id from work_categories where work_category_desc = 'Jazz'), 
    'Large ensemble with vocals', 
    '9999',
    FALSE,
    157);

INSERT into work_subcategories (work_category_id, work_subcategory_desc, legacy_4d_identity_code, additional, display_order) VALUES (
    (SELECT work_category_id from work_categories where work_category_desc = 'Jazz'), 
    'Large ensemble without vocals', 
    '9999',
    FALSE,
    158);

COMMIT;

-- WR93152 - updating manifestation type description 
BEGIN;

UPDATE  manifestation_types SET manifestation_type_desc = 'chord chart / lead sheet' where manifestation_type_desc = 'chord chart';

COMMIT;

-- WR206637 - Resource type "music theory" to "repertoire lists" 
BEGIN;

UPDATE resource_types SET resource_type_desc = 'repertoire list' where resource_type_id IN (SELECT resource_type_id from resource_types where resource_type_desc = 'music theory');

COMMIT;