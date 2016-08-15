-- Patch for SOUNZ database upgrade
-- 1.60.4 to 1.60.5
--
BEGIN;

-- WR209534 media on demand 
-- Splitting embedded Format into embedded - video and embedded - audio for Manifestation and Resources

INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('embedded - video', true, true);
UPDATE formats SET format_desc = 'embedded - audio' WHERE format_desc = 'embedded';

COMMIT;

BEGIN;

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'embedded - video'));
                                                
INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'embedded - video'));

COMMIT;



