----------------------------------------------------------------------------
-- Instructions:
-- apply this script to target database sounz
--
-- This will provide a 'Non-applicable' type for both 'manifestation_types'
-- and 'resource_types'. It also associates ALL formats with this type
-- which will allow SOUNZ to pick 'Non-applicable' as the type, and
-- then pick any of the allowed formats for the format.
--
----------------------------------------------------------------------------

BEGIN;

INSERT into manifestation_types (manifestation_type_desc) values ('Non-applicable');

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) SELECT (SELECT MAX(manifestation_type_id) FROM manifestation_types), format_id FROM formats WHERE manifestation_format=TRUE;

INSERT into resource_types (resource_type_desc) values ('Non-applicable');

INSERT INTO resource_type_formats (resource_type_id, format_id) SELECT (SELECT MAX(resource_type_id) FROM resource_types), format_id FROM formats WHERE resource_format=TRUE;


COMMIT;
