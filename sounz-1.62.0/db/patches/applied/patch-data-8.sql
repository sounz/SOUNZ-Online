-- add sample values for the rotating image on the front page
BEGIN;
insert into settings (setting_name, setting_value) values ('front_page_ctr','0');
insert into settings (setting_name, setting_value) values ('front_page_contributors','1204,1118,1144,1252');
insert into settings (setting_name, setting_value) values ('front_page_manifestations','7712,7392,7087,3255');
COMMIT;