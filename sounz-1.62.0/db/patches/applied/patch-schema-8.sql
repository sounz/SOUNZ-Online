----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 16/09/2007 21:26:33
--
-- This script adds the following sequences:
--   seq_manifestation_code to the table 'manifestations' 
--   seq_resource_code to the table 'resources' 
-- These automatically populate the 'manifestation_code' and
-- 'resource_code' feilds of the respective tables.
--
-- The script also updates manifestations and resources which
-- have been added by SOUNZ since the data migration from 4D.
-- These will be assigned values from the relevant sequence.
--
-- IMPORTANT NOTE: ONLY APPLY THIS ONCE TO THE LIVE DATABASE
--
----------------------------------------------------------------------------

BEGIN;

-- MANIFESTATIONS
-- This sequence provides 'manifestation_code' values for new manifestations..
CREATE SEQUENCE seq_manifestation_code START 10000;
ALTER TABLE manifestations ALTER COLUMN manifestation_code DROP DEFAULT;
ALTER TABLE manifestations ALTER COLUMN manifestation_code SET DEFAULT nextval('seq_manifestation_code');

-- Temporary field to store our SOUNZ-added manifestation_id's
ALTER TABLE manifestations ADD COLUMN ref_id INT4;

-- Create temporary dupes of the SOUNZ-added manifestations, so that the new sequence gets used..
INSERT INTO manifestations (ref_id,manifestation_type_id,format_id,status_id,manifestation_title,created_at,updated_at,updated_by) SELECT manifestation_id,manifestation_type_id,format_id,status_id,manifestation_title,created_at,updated_at,updated_by FROM manifestations WHERE manifestation_code=0;

-- Now back-update the newly added manifestations with the proper code..
UPDATE manifestations SET manifestation_code=(SELECT m2.manifestation_code FROM manifestations m2 WHERE m2.ref_id=manifestations.manifestation_id AND m2.manifestation_code >= 10000) WHERE manifestation_code=0;

-- Delete temporary recs, and field..
DELETE FROM manifestations WHERE ref_id IS NOT NULL;
ALTER TABLE manifestations DROP COLUMN ref_id;

-- Re-initialise sequences
SELECT SETVAL('seq_manifestation_code', (SELECT MAX(manifestation_code) FROM manifestations));
SELECT SETVAL('manifestations_manifestation_id_seq', (SELECT MAX(manifestation_id) FROM manifestations));

-- Confirmation.. optional (uncomment)
-- SELECT manifestation_id,manifestation_code FROM manifestations WHERE manifestation_code >= 10000;


-------------------------------------------------------------------
-- RESOURCES
-- NB: At the time of writing this script there were no resources
-- present, which simplifies this section considerably..

-- Clean out "test data" (there was one record known to be present
-- with this signature at the time this script was written)
DELETE FROM resources WHERE resource_code >= 1000 AND copyright='Test data';

-- This sequence provides 'resource_code' values for new resources..
CREATE SEQUENCE seq_resource_code START 1000;
ALTER TABLE resources ALTER COLUMN resource_code DROP DEFAULT;
ALTER TABLE resources ALTER COLUMN resource_code SET DEFAULT nextval('seq_resource_code');

-- Re-initialise sequences
SELECT SETVAL('resources_resource_id_seq', (SELECT MAX(resource_id) FROM resources));

-------------------------------------------------------------------
-- All or nothing..
COMMIT;
