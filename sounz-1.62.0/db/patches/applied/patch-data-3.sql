----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 02/09/2007 09:00:16
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

--                   !!!!!!  NOTE  !!!!!!!
-- APPLY THIS PATCH ONLY ONCE. APPLYING MORE THAN ONCE WILL
-- PROBABLY STUFF UP YOUR DATA.

-- ALL in one big transaction..
BEGIN;

-- FIX MANIFESTATION TYPES ORDERING

-- Remove links - we will recreate these later on
DELETE FROM manifestation_type_formats;
DELETE FROM resource_type_formats;

-- Fix manifestation_types data..
UPDATE manifestations SET manifestation_type_id=3 WHERE manifestation_type_id=15;
DELETE FROM manifestation_types WHERE manifestation_type_id=15;
UPDATE manifestation_types set manifestation_type_desc='part - recorded' WHERE manifestation_type_id=3;


-- FIX RESOURCE TYPES ORDERING
-- Move resource type 4 --> 3
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (3,'education resource');
UPDATE resources SET resource_type_id=3 WHERE resource_type_id=4;

-- Move resource type 20 --> 4
UPDATE resource_types SET resource_type_desc='industry manual - NZ' WHERE resource_type_id=4;
UPDATE resources SET resource_type_id=4 WHERE resource_type_id=20;
DELETE FROM resource_types WHERE resource_type_id=20;

-- Move resources type 5 thru 22 --> 105 thru 122
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (105,'');
UPDATE resources SET resource_type_id=105 WHERE resource_type_id=5;
DELETE FROM resource_types WHERE resource_type_id=5;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (106,'');
UPDATE resources SET resource_type_id=106 WHERE resource_type_id=6;
DELETE FROM resource_types WHERE resource_type_id=6;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (107,'');
UPDATE resources SET resource_type_id=107 WHERE resource_type_id=7;
DELETE FROM resource_types WHERE resource_type_id=7;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (109,'');
UPDATE resources SET resource_type_id=109 WHERE resource_type_id=9;
DELETE FROM resource_types WHERE resource_type_id=9;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (110,'');
UPDATE resources SET resource_type_id=110 WHERE resource_type_id=10;
DELETE FROM resource_types WHERE resource_type_id=10;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (111,'');
UPDATE resources SET resource_type_id=111 WHERE resource_type_id=11;
DELETE FROM resource_types WHERE resource_type_id=11;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (113,'');
UPDATE resources SET resource_type_id=113 WHERE resource_type_id=13;
DELETE FROM resource_types WHERE resource_type_id=13;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (114,'');
UPDATE resources SET resource_type_id=114 WHERE resource_type_id=14;
DELETE FROM resource_types WHERE resource_type_id=14;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (116,'');
UPDATE resources SET resource_type_id=116 WHERE resource_type_id=16;
DELETE FROM resource_types WHERE resource_type_id=16;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (118,'');
UPDATE resources SET resource_type_id=118 WHERE resource_type_id=18;
DELETE FROM resource_types WHERE resource_type_id=18;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (119,'');
UPDATE resources SET resource_type_id=119 WHERE resource_type_id=19;
DELETE FROM resource_types WHERE resource_type_id=19;

INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (122,'');
UPDATE resources SET resource_type_id=122 WHERE resource_type_id=22;
DELETE FROM resource_types WHERE resource_type_id=22;

-- Re-create resource types in correct order, moving 105 thru 122
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (5,'industry manual - other');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (6,'commentary or analysis');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (7,'documentary');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (8,'bibliography');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (9,'music theory');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (10,'interview');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (11,'programme note');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (12,'review');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (13,'sheet music');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (14,'lyrics / libretti');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (15,'NZ recordings - other genres');
INSERT INTO resource_types (resource_type_id,resource_type_desc) VALUES (16,'NZ recordings - not by SOUNZ composers');

-- industry manual - other (110 --> 5)
UPDATE resources SET resource_type_id=5 WHERE resource_type_id=110;

-- commentary or analysis (118 --> 6) 
UPDATE resources SET resource_type_id=6 WHERE resource_type_id=118;

-- documentary (106 --> 7)
UPDATE resources SET resource_type_id=7 WHERE resource_type_id=106;

-- bibliography (105 --> 8)
UPDATE resources SET resource_type_id=8 WHERE resource_type_id=105;

-- music theory (111 --> 9)
UPDATE resources SET resource_type_id=9 WHERE resource_type_id=111;

-- interview (107 --> 10)
UPDATE resources SET resource_type_id=10 WHERE resource_type_id=107;

-- prograqmme note (116 --> 11)
UPDATE resources SET resource_type_id=11 WHERE resource_type_id=116;

-- review (109 --> 12)
UPDATE resources SET resource_type_id=12 WHERE resource_type_id=109;

-- sheet music (122 --> 13)
UPDATE resources SET resource_type_id=13 WHERE resource_type_id=122;

-- lyrics / libretti (119 --> 14)
UPDATE resources SET resource_type_id=14 WHERE resource_type_id=119;

-- NZ recordings - other genres (113 --> 15)
UPDATE resources SET resource_type_id=15 WHERE resource_type_id=113;

-- NZ recordings - not by SOUNZ composers (114 --> 16)
UPDATE resources SET resource_type_id=16 WHERE resource_type_id=114;

-- Remove temporaries now..
DELETE FROM resource_types WHERE resource_type_id > 99;



-- CREATE MANIFESTATION FORMATS LISTS (for dropdowns)
SELECT SETVAL('manifestation_type_formats_manifestation_type_format_id_seq', 1);

-- 1 FULL SCORE
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (1, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (1, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (1, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (1, 19);

-- 2 PART/S - WRITTEN
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (2, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (2, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (2, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (2, 19);

-- 3 PART - RECORDED
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 2);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 4);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 18);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 16);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 17);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 14);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 6);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 13);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 10);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 3);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (3, 9);

-- 4 SCORE AND PART/S
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (4, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (4, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (4, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (4, 19);

-- 5 PIANO REDUCTION
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (5, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (5, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (5, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (5, 19);

-- 6 VOCAL SCORE
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (6, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (6, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (6, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (6, 19);

-- 7 GRAPHIC SCORE - FULL SCORE
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (7, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (7, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (7, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (7, 19);

-- 8 GRAPHIC SCORE - PARTS
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (8, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (8, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (8, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (8, 19);

-- 9 MINIATURE SCORE
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (9, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (9, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (9, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (9, 19);

-- 10 CHORD CHART
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (10, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (10, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (10, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (10, 19);

-- 11 REDUCED SCORE
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (11, 25);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (11, 24);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (11, 20);
INSERT INTO manifestation_type_formats (manifestation_type_id, format_id)
  VALUES (11, 19);


-- CREATE RESOURCE FORMATS LISTS (for dropdowns)
SELECT SETVAL('resource_type_formats_resource_type_format_id_seq', 1);

-- These two should appear in resources formats lists
UPDATE formats SET resource_format=TRUE WHERE format_ID IN (30,31);

-- 1 biography
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (1, 28);

-- 2 history
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (2, 28);

-- 3 education resource
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (3, 28);

-- 4 industry manual - NZ
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (4, 28);

-- 5 industry manual - other
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (5, 28);

-- 6 commentary or analysis
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (6, 28);

-- 7 documentary
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (7, 28);

-- 8 bibliography
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (8, 28);

-- 9 music theory
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (9, 28);

-- 10 interview
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (10, 28);

-- 11 programme note
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (11, 28);

-- 12 review
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (12, 28);

-- 13 sheet music
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (13, 28);

-- 14 lyrics / libretti
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 11);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 31);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 23);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 21);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 22);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 26);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 8);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (14, 28);

-- 15 NZ recordings - other genres
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (15, 28);

-- 16 NZ recordings - not by SOUNZ composers
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 2);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 4);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 1);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 9);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 30);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 13);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 3);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 27);
INSERT INTO resource_type_formats (resource_type_id, format_id)
  VALUES (16, 28);


-- Now re-apply patch-3.sql which was blown away with this patch

INSERT into manifestation_types (manifestation_type_desc) values ('Not-applicable');

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) SELECT (SELECT MAX(manifestation_type_id) FROM manifestation_types), format_id FROM formats WHERE manifestation_format=TRUE;

INSERT into resource_types (resource_type_desc) values ('Not-applicable');

INSERT INTO resource_type_formats (resource_type_id, format_id) SELECT (SELECT MAX(resource_type_id) FROM resource_types), format_id FROM formats WHERE resource_format=TRUE;


-- Phew!!
COMMIT;

