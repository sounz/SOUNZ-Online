-- Patch for SOUNZ database upgrade
-- 1.50.0 to 1.51.0
--
BEGIN;

-- WR70957 media on demand 
-- adding sounzmedia ManifestationType and audio, video, embedded Format

INSERT INTO manifestation_types (manifestation_type_desc, manifestation_type_category) VALUES ('Media on Demand', 3);
INSERT INTO resource_types (resource_type_desc) VALUES ('Media on Demand');
INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('internal - audio', true, true);
INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('external - audio', true, true);
INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('internal - video', true, true);
INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('external - video', true, true);
INSERT INTO formats (format_desc, manifestation_format, resource_format) VALUES ('embedded', true, true);
-- video format already exists format_id 9

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'embedded'));

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'internal - audio'));

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'external - audio'));

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'internal - video'));

INSERT INTO manifestation_type_formats (manifestation_type_id, format_id) 
        VALUES ((SELECT manifestation_type_id from manifestation_types where manifestation_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'external - video'));
                                                
INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'embedded'));

INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'internal - audio'));

INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'external - audio'));         
                                                               
INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'internal - video'));

INSERT INTO resource_type_formats (resource_type_id, format_id) 
        VALUES ((SELECT resource_type_id from resource_types where resource_type_desc = 'Media on Demand'), 
                        (SELECT format_id from formats where format_desc = 'external - video'));                        

--Alter manifestations and resources table to hold sounzmedia info
ALTER TABLE manifestations ADD COLUMN sounzmedia TEXT;
ALTER TABLE resources ADD COLUMN sounzmedia TEXT;

-- Controller Restrictions
INSERT INTO controller_restrictions (privilege_id, status_id, controller_name, controller_action, http_verb) 
        VALUES (1, 3, 'finder', 'reset_sounzmedia_search', 'get');
        
-- Setting for random sounzmedia. Just making sure we got a setting before the first cron run on release day.
INSERT INTO settings (setting_name, setting_value) VALUES ('front_page_sounzmedia', '');        
        
-- WR55028
-- Change configuration for expired membership notification Email 
UPDATE settings SET setting_value = 'admin@sounz.org.nz' where setting_name = 'ExpiringMembershipsNotificationRecipient';

--WR#72223 - shipping cost for NZ Standard zone
update zencartconfiguration set configuration_value = '0,0,100,2.50,200,3.50,500,6.50,1250,7.00,2000,8.00'
  where configuration_key = 'MODULE_SHIPPING_TABLE_COST';
  
-- WR55028
-- Update Email configurations
UPDATE settings set setting_value = 'info@sounz.org.nz' where setting_name = 'CampaignMailoutSenderEmail';
UPDATE settings set setting_value = 'info@sounz.org.nz' where setting_name = 'ReminderNoticeSenderEmail';

COMMIT;



