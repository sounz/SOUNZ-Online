-------------------------------------------------------------------------
-- User/role 'sounz_reports' is a readonly user which SOUNZ staff will
-- be connecting as to do reports.
--
-- Below should list all of the tables in the SOUNZ database which can
-- be used by SOUNZ staff to produce ad-hoc reports. Feel free to keep
-- this up to date.;-)
--
-------------------------------------------------------------------------

BEGIN;

-- Assert all table permissions
GRANT SELECT ON access_rights TO SOUNZ_REPORTS;
GRANT SELECT ON allowed_ips TO SOUNZ_REPORTS;
GRANT SELECT ON app_control TO SOUNZ_REPORTS;
GRANT SELECT ON attachment_types TO SOUNZ_REPORTS;
GRANT SELECT ON backup_works TO SOUNZ_REPORTS;
GRANT SELECT ON borrowed_items TO SOUNZ_REPORTS;
GRANT SELECT ON campaign_mailouts TO SOUNZ_REPORTS;
GRANT SELECT ON cm_content_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON cm_contents TO SOUNZ_REPORTS;
GRANT SELECT ON communication_methods TO SOUNZ_REPORTS;
GRANT SELECT ON communication_types TO SOUNZ_REPORTS;
GRANT SELECT ON communications TO SOUNZ_REPORTS;
GRANT SELECT ON concept_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON concept_types TO SOUNZ_REPORTS;
GRANT SELECT ON concepts TO SOUNZ_REPORTS;
GRANT SELECT ON contactinfos TO SOUNZ_REPORTS;
GRANT SELECT ON contributor_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON contributors TO SOUNZ_REPORTS;
GRANT SELECT ON countries TO SOUNZ_REPORTS;
GRANT SELECT ON default_contactinfos TO SOUNZ_REPORTS;
GRANT SELECT ON distinction_instances TO SOUNZ_REPORTS;
GRANT SELECT ON distinction_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON distinctions TO SOUNZ_REPORTS;
GRANT SELECT ON entity_relationship_types TO SOUNZ_REPORTS;
GRANT SELECT ON entity_types TO SOUNZ_REPORTS;
GRANT SELECT ON event_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON event_expression TO SOUNZ_REPORTS;
GRANT SELECT ON event_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON event_types TO SOUNZ_REPORTS;
GRANT SELECT ON events TO SOUNZ_REPORTS;
GRANT SELECT ON exam_set_works TO SOUNZ_REPORTS;
GRANT SELECT ON examboards TO SOUNZ_REPORTS;
GRANT SELECT ON expression_access_rights TO SOUNZ_REPORTS;
GRANT SELECT ON expression_languages TO SOUNZ_REPORTS;
GRANT SELECT ON expression_manifestations TO SOUNZ_REPORTS;
GRANT SELECT ON expression_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON expressions TO SOUNZ_REPORTS;
GRANT SELECT ON formats TO SOUNZ_REPORTS;
GRANT SELECT ON item_types TO SOUNZ_REPORTS;
GRANT SELECT ON items TO SOUNZ_REPORTS;
GRANT SELECT ON languages TO SOUNZ_REPORTS;
GRANT SELECT ON logins TO SOUNZ_REPORTS;
GRANT SELECT ON mailout_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON mailout_contacts TO SOUNZ_REPORTS;
GRANT SELECT ON manifestation_access_rights TO SOUNZ_REPORTS;
GRANT SELECT ON manifestation_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON manifestation_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON manifestation_type_formats TO SOUNZ_REPORTS;
GRANT SELECT ON manifestation_types TO SOUNZ_REPORTS;
GRANT SELECT ON manifestations TO SOUNZ_REPORTS;
GRANT SELECT ON marketing_campaigns TO SOUNZ_REPORTS;
GRANT SELECT ON marketing_categories TO SOUNZ_REPORTS;
GRANT SELECT ON marketing_subcategories TO SOUNZ_REPORTS;
GRANT SELECT ON media_items TO SOUNZ_REPORTS;
GRANT SELECT ON member_type_privileges TO SOUNZ_REPORTS;
GRANT SELECT ON member_types TO SOUNZ_REPORTS;
GRANT SELECT ON memberships TO SOUNZ_REPORTS;
GRANT SELECT ON mime_categories TO SOUNZ_REPORTS;
GRANT SELECT ON mime_types TO SOUNZ_REPORTS;
GRANT SELECT ON modes TO SOUNZ_REPORTS;
GRANT SELECT ON news_articles TO SOUNZ_REPORTS;
GRANT SELECT ON news_article_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON nomens TO SOUNZ_REPORTS;
GRANT SELECT ON organisation_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON organisations TO SOUNZ_REPORTS;
GRANT SELECT ON people TO SOUNZ_REPORTS;
GRANT SELECT ON person_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON "privileges" TO SOUNZ_REPORTS;
GRANT SELECT ON project_team_members TO SOUNZ_REPORTS;
GRANT SELECT ON projects TO SOUNZ_REPORTS;
GRANT SELECT ON publishing_statuses TO SOUNZ_REPORTS;
GRANT SELECT ON regions TO SOUNZ_REPORTS;
GRANT SELECT ON related_communications TO SOUNZ_REPORTS;
GRANT SELECT ON related_organisations TO SOUNZ_REPORTS;
GRANT SELECT ON relationship_types TO SOUNZ_REPORTS;
GRANT SELECT ON relationships TO SOUNZ_REPORTS;
GRANT SELECT ON reserved_items TO SOUNZ_REPORTS;
GRANT SELECT ON resource_access_rights TO SOUNZ_REPORTS;
GRANT SELECT ON resource_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON resource_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON resource_type_formats TO SOUNZ_REPORTS;
GRANT SELECT ON resource_types TO SOUNZ_REPORTS;
GRANT SELECT ON resources TO SOUNZ_REPORTS;
GRANT SELECT ON role_categorizations TO SOUNZ_REPORTS;
GRANT SELECT ON role_contactinfos TO SOUNZ_REPORTS;
GRANT SELECT ON role_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON role_types TO SOUNZ_REPORTS;
GRANT SELECT ON roles TO SOUNZ_REPORTS;
GRANT SELECT ON sample_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON samples TO SOUNZ_REPORTS;
GRANT SELECT ON saved_contact_lists TO SOUNZ_REPORTS;
GRANT SELECT ON saved_role_contactinfos TO SOUNZ_REPORTS;
GRANT SELECT ON saved_searches TO SOUNZ_REPORTS;
GRANT SELECT ON settings TO SOUNZ_REPORTS;
GRANT SELECT ON sounz_services TO SOUNZ_REPORTS;
GRANT SELECT ON superwork_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON superworks TO SOUNZ_REPORTS;
GRANT SELECT ON valid_entity_entity_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON work_access_rights TO SOUNZ_REPORTS;
GRANT SELECT ON work_attachments TO SOUNZ_REPORTS;
GRANT SELECT ON work_categories TO SOUNZ_REPORTS;
GRANT SELECT ON work_categorizations TO SOUNZ_REPORTS;
GRANT SELECT ON work_composers TO SOUNZ_REPORTS;
GRANT SELECT ON work_relationships TO SOUNZ_REPORTS;
GRANT SELECT ON work_subcategories TO SOUNZ_REPORTS;
GRANT SELECT ON works TO SOUNZ_REPORTS;
GRANT SELECT ON works_advanced_search TO SOUNZ_REPORTS;

COMMIT;
