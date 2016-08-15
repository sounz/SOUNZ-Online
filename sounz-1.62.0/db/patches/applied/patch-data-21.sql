-- Add settings for provider forms submission notification email
-- Please replace setting_value with appropriate recipient
begin;

insert into settings (setting_name, setting_value) values ('SubmissionNotificationSenderEmail', 'NOREPLY@sounz.org.nz');

insert into settings (setting_name, setting_value) values ('prov_composer_bios_recipient', 'liuba@catalyst.net.nz');
insert into settings (setting_name, setting_value) values ('prov_contact_updates_recipient', 'liuba@catalyst.net.nz');
insert into settings (setting_name, setting_value) values ('prov_contributor_profiles_recipient', 'liuba@catalyst.net.nz');
insert into settings (setting_name, setting_value) values ('prov_events_recipient', 'liuba@catalyst.net.nz');
insert into settings (setting_name, setting_value) values ('prov_work_updates_recipient', 'liuba@catalyst.net.nz');
insert into settings (setting_name, setting_value) values ('prov_feedbacks_recipient', 'liuba@catalyst.net.nz');

commit;

-- Add settings for campaign mailout sender email
begin;

insert into settings (setting_name, setting_value) values ('CampaignMailoutSenderEmail', 'sounz@sounz.org.nz');

commit;