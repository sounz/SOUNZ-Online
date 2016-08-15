-- fix seemingly pointless item type description if it exists
BEGIN;
UPDATE item_types set item_type_desc='No ERP Status' where item_type_desc='Item type';
COMMIT;


--Add new item types required for ERP
BEGIN;
INSERT INTO item_types (item_type_desc) VALUES ('Loan item');
INSERT INTO item_types (item_type_desc) VALUES ('Sale item');
COMMIT;

