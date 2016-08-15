-------------------------------------------------------------------------
-- Fix GRANTs
--
-- In theory having special roles is a good idea, but the shear number
-- of GRANTs which have to be generated for the 'web' access user, make
-- it a PITA to do.
--
-- So, this fixup revokes all of them and removes these users:
--     SOUNZ_WEB and SOUNZ_ADMIN.
--
-- We retain these users: SOUNZ, SOUNZ_REPORTS
--
-- User/role 'sounz' is the de-facto database owner, and is what the
-- application will be connecting as - this is the current state of
-- affairs in development, so no pain there.
--
-- User/role 'sounz_reports' is a readonly user which SOUNZ staff will
-- be connecting as to do reports.
--
-------------------------------------------------------------------------

BEGIN;

-- Assert all table permissions
GRANT SELECT ON access_rights TO SOUNZ_REPORTS;
REVOKE ALL ON access_rights FROM SOUNZ_ADMIN;
REVOKE ALL ON access_rights FROM SOUNZ_WEB;

GRANT SELECT ON allowed_ips TO SOUNZ_REPORTS;
REVOKE ALL ON allowed_ips FROM SOUNZ_ADMIN;
REVOKE ALL ON allowed_ips FROM SOUNZ_WEB;

GRANT SELECT ON app_control TO SOUNZ_REPORTS;
REVOKE ALL ON app_control FROM SOUNZ_ADMIN;
REVOKE ALL ON app_control FROM SOUNZ_WEB;

GRANT SELECT ON attachment_types TO SOUNZ_REPORTS;
REVOKE ALL ON attachment_types FROM SOUNZ_ADMIN;
REVOKE ALL ON attachment_types FROM SOUNZ_WEB;

GRANT SELECT ON backup_works TO SOUNZ_REPORTS;
REVOKE ALL ON backup_works FROM SOUNZ_ADMIN;
REVOKE ALL ON backup_works FROM SOUNZ_WEB;

GRANT SELECT ON borrowed_items TO SOUNZ_REPORTS;
REVOKE ALL ON borrowed_items FROM SOUNZ_ADMIN;
REVOKE ALL ON borrowed_items FROM SOUNZ_WEB;

GRANT SELECT ON campaign_mailouts TO SOUNZ_REPORTS;
REVOKE ALL ON campaign_mailouts FROM SOUNZ_ADMIN;
REVOKE ALL ON campaign_mailouts FROM SOUNZ_WEB;

GRANT SELECT ON cm_content_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON cm_content_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON cm_content_attachments FROM SOUNZ_WEB;

GRANT SELECT ON cm_contents TO SOUNZ_REPORTS;
REVOKE ALL ON cm_contents FROM SOUNZ_ADMIN;
REVOKE ALL ON cm_contents FROM SOUNZ_WEB;

GRANT SELECT ON communication_methods TO SOUNZ_REPORTS;
REVOKE ALL ON communication_methods FROM SOUNZ_ADMIN;
REVOKE ALL ON communication_methods FROM SOUNZ_WEB;

GRANT SELECT ON communication_types TO SOUNZ_REPORTS;
REVOKE ALL ON communication_types FROM SOUNZ_ADMIN;
REVOKE ALL ON communication_types FROM SOUNZ_WEB;

GRANT SELECT ON communications TO SOUNZ_REPORTS;
REVOKE ALL ON communications FROM SOUNZ_ADMIN;
REVOKE ALL ON communications FROM SOUNZ_WEB;

GRANT SELECT ON concept_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON concept_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON concept_relationships FROM SOUNZ_WEB;

GRANT SELECT ON concept_types TO SOUNZ_REPORTS;
REVOKE ALL ON concept_types FROM SOUNZ_ADMIN;
REVOKE ALL ON concept_types FROM SOUNZ_WEB;

GRANT SELECT ON concepts TO SOUNZ_REPORTS;
REVOKE ALL ON concepts FROM SOUNZ_ADMIN;
REVOKE ALL ON concepts FROM SOUNZ_WEB;

GRANT SELECT ON contactinfos TO SOUNZ_REPORTS;
REVOKE ALL ON contactinfos FROM SOUNZ_ADMIN;
REVOKE ALL ON contactinfos FROM SOUNZ_WEB;

GRANT SELECT ON contributor_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON contributor_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON contributor_attachments FROM SOUNZ_WEB;

GRANT SELECT ON contributors TO SOUNZ_REPORTS;
REVOKE ALL ON contributors FROM SOUNZ_ADMIN;
REVOKE ALL ON contributors FROM SOUNZ_WEB;

GRANT SELECT ON countries TO SOUNZ_REPORTS;
REVOKE ALL ON countries FROM SOUNZ_ADMIN;
REVOKE ALL ON countries FROM SOUNZ_WEB;

GRANT SELECT ON default_contactinfos TO SOUNZ_REPORTS;
REVOKE ALL ON default_contactinfos FROM SOUNZ_ADMIN;
REVOKE ALL ON default_contactinfos FROM SOUNZ_WEB;

GRANT SELECT ON distinction_instances TO SOUNZ_REPORTS;
REVOKE ALL ON distinction_instances FROM SOUNZ_ADMIN;
REVOKE ALL ON distinction_instances FROM SOUNZ_WEB;

GRANT SELECT ON distinction_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON distinction_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON distinction_relationships FROM SOUNZ_WEB;

GRANT SELECT ON distinctions TO SOUNZ_REPORTS;
REVOKE ALL ON distinctions FROM SOUNZ_ADMIN;
REVOKE ALL ON distinctions FROM SOUNZ_WEB;

GRANT SELECT ON entity_relationship_types TO SOUNZ_REPORTS;
REVOKE ALL ON entity_relationship_types FROM SOUNZ_ADMIN;
REVOKE ALL ON entity_relationship_types FROM SOUNZ_WEB;

GRANT SELECT ON entity_types TO SOUNZ_REPORTS;
REVOKE ALL ON entity_types FROM SOUNZ_ADMIN;
REVOKE ALL ON entity_types FROM SOUNZ_WEB;

GRANT SELECT ON event_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON event_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON event_attachments FROM SOUNZ_WEB;

GRANT SELECT ON event_expression TO SOUNZ_REPORTS;
REVOKE ALL ON event_expression FROM SOUNZ_ADMIN;
REVOKE ALL ON event_expression FROM SOUNZ_WEB;

GRANT SELECT ON event_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON event_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON event_relationships FROM SOUNZ_WEB;

GRANT SELECT ON event_types TO SOUNZ_REPORTS;
REVOKE ALL ON event_types FROM SOUNZ_ADMIN;
REVOKE ALL ON event_types FROM SOUNZ_WEB;

GRANT SELECT ON events TO SOUNZ_REPORTS;
REVOKE ALL ON events FROM SOUNZ_ADMIN;
REVOKE ALL ON events FROM SOUNZ_WEB;

GRANT SELECT ON exam_set_works TO SOUNZ_REPORTS;
REVOKE ALL ON exam_set_works FROM SOUNZ_ADMIN;
REVOKE ALL ON exam_set_works FROM SOUNZ_WEB;

GRANT SELECT ON examboards TO SOUNZ_REPORTS;
REVOKE ALL ON examboards FROM SOUNZ_ADMIN;
REVOKE ALL ON examboards FROM SOUNZ_WEB;

GRANT SELECT ON expression_access_rights TO SOUNZ_REPORTS;
REVOKE ALL ON expression_access_rights FROM SOUNZ_ADMIN;
REVOKE ALL ON expression_access_rights FROM SOUNZ_WEB;

GRANT SELECT ON expression_languages TO SOUNZ_REPORTS;
REVOKE ALL ON expression_languages FROM SOUNZ_ADMIN;
REVOKE ALL ON expression_languages FROM SOUNZ_WEB;

GRANT SELECT ON expression_manifestations TO SOUNZ_REPORTS;
REVOKE ALL ON expression_manifestations FROM SOUNZ_ADMIN;
REVOKE ALL ON expression_manifestations FROM SOUNZ_WEB;

GRANT SELECT ON expression_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON expression_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON expression_relationships FROM SOUNZ_WEB;

GRANT SELECT ON expressions TO SOUNZ_REPORTS;
REVOKE ALL ON expressions FROM SOUNZ_ADMIN;
REVOKE ALL ON expressions FROM SOUNZ_WEB;

GRANT SELECT ON formats TO SOUNZ_REPORTS;
REVOKE ALL ON formats FROM SOUNZ_ADMIN;
REVOKE ALL ON formats FROM SOUNZ_WEB;

GRANT SELECT ON item_types TO SOUNZ_REPORTS;
REVOKE ALL ON item_types FROM SOUNZ_ADMIN;
REVOKE ALL ON item_types FROM SOUNZ_WEB;

GRANT SELECT ON items TO SOUNZ_REPORTS;
REVOKE ALL ON items FROM SOUNZ_ADMIN;
REVOKE ALL ON items FROM SOUNZ_WEB;

GRANT SELECT ON languages TO SOUNZ_REPORTS;
REVOKE ALL ON languages FROM SOUNZ_ADMIN;
REVOKE ALL ON languages FROM SOUNZ_WEB;

GRANT SELECT ON logins TO SOUNZ_REPORTS;
REVOKE ALL ON logins FROM SOUNZ_ADMIN;
REVOKE ALL ON logins FROM SOUNZ_WEB;

GRANT SELECT ON mailout_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON mailout_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON mailout_attachments FROM SOUNZ_WEB;

GRANT SELECT ON mailout_contacts TO SOUNZ_REPORTS;
REVOKE ALL ON mailout_contacts FROM SOUNZ_ADMIN;
REVOKE ALL ON mailout_contacts FROM SOUNZ_WEB;

GRANT SELECT ON manifestation_access_rights TO SOUNZ_REPORTS;
REVOKE ALL ON manifestation_access_rights FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestation_access_rights FROM SOUNZ_WEB;

GRANT SELECT ON manifestation_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON manifestation_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestation_attachments FROM SOUNZ_WEB;

GRANT SELECT ON manifestation_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON manifestation_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestation_relationships FROM SOUNZ_WEB;

GRANT SELECT ON manifestation_type_formats TO SOUNZ_REPORTS;
REVOKE ALL ON manifestation_type_formats FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestation_type_formats FROM SOUNZ_WEB;

GRANT SELECT ON manifestation_types TO SOUNZ_REPORTS;
REVOKE ALL ON manifestation_types FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestation_types FROM SOUNZ_WEB;

GRANT SELECT ON manifestations TO SOUNZ_REPORTS;
REVOKE ALL ON manifestations FROM SOUNZ_ADMIN;
REVOKE ALL ON manifestations FROM SOUNZ_WEB;

GRANT SELECT ON marketing_campaigns TO SOUNZ_REPORTS;
REVOKE ALL ON marketing_campaigns FROM SOUNZ_ADMIN;
REVOKE ALL ON marketing_campaigns FROM SOUNZ_WEB;

GRANT SELECT ON marketing_categories TO SOUNZ_REPORTS;
REVOKE ALL ON marketing_categories FROM SOUNZ_ADMIN;
REVOKE ALL ON marketing_categories FROM SOUNZ_WEB;

GRANT SELECT ON marketing_subcategories TO SOUNZ_REPORTS;
REVOKE ALL ON marketing_subcategories FROM SOUNZ_ADMIN;
REVOKE ALL ON marketing_subcategories FROM SOUNZ_WEB;

GRANT SELECT ON media_items TO SOUNZ_REPORTS;
REVOKE ALL ON media_items FROM SOUNZ_ADMIN;
REVOKE ALL ON media_items FROM SOUNZ_WEB;

GRANT SELECT ON member_type_privileges TO SOUNZ_REPORTS;
REVOKE ALL ON member_type_privileges FROM SOUNZ_ADMIN;
REVOKE ALL ON member_type_privileges FROM SOUNZ_WEB;

GRANT SELECT ON member_types TO SOUNZ_REPORTS;
REVOKE ALL ON member_types FROM SOUNZ_ADMIN;
REVOKE ALL ON member_types FROM SOUNZ_WEB;

GRANT SELECT ON memberships TO SOUNZ_REPORTS;
REVOKE ALL ON memberships FROM SOUNZ_ADMIN;
REVOKE ALL ON memberships FROM SOUNZ_WEB;

GRANT SELECT ON mime_categories TO SOUNZ_REPORTS;
REVOKE ALL ON mime_categories FROM SOUNZ_ADMIN;
REVOKE ALL ON mime_categories FROM SOUNZ_WEB;

GRANT SELECT ON mime_types TO SOUNZ_REPORTS;
REVOKE ALL ON mime_types FROM SOUNZ_ADMIN;
REVOKE ALL ON mime_types FROM SOUNZ_WEB;

GRANT SELECT ON modes TO SOUNZ_REPORTS;
REVOKE ALL ON modes FROM SOUNZ_ADMIN;
REVOKE ALL ON modes FROM SOUNZ_WEB;

GRANT SELECT ON news_articles TO SOUNZ_REPORTS;
REVOKE ALL ON news_articles FROM SOUNZ_ADMIN;
REVOKE ALL ON news_articles FROM SOUNZ_WEB;

GRANT SELECT ON news_article_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON news_article_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON news_article_attachments FROM SOUNZ_WEB;

GRANT SELECT ON nomens TO SOUNZ_REPORTS;
REVOKE ALL ON nomens FROM SOUNZ_ADMIN;
REVOKE ALL ON nomens FROM SOUNZ_WEB;

GRANT SELECT ON organisation_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON organisation_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON organisation_attachments FROM SOUNZ_WEB;

GRANT SELECT ON organisations TO SOUNZ_REPORTS;
REVOKE ALL ON organisations FROM SOUNZ_ADMIN;
REVOKE ALL ON organisations FROM SOUNZ_WEB;

GRANT SELECT ON people TO SOUNZ_REPORTS;
REVOKE ALL ON people FROM SOUNZ_ADMIN;
REVOKE ALL ON people FROM SOUNZ_WEB;

GRANT SELECT ON person_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON person_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON person_attachments FROM SOUNZ_WEB;

GRANT SELECT ON "privileges" TO SOUNZ_REPORTS;
REVOKE ALL ON "privileges" FROM SOUNZ_ADMIN;
REVOKE ALL ON "privileges" FROM SOUNZ_WEB;

GRANT SELECT ON project_team_members TO SOUNZ_REPORTS;
REVOKE ALL ON project_team_members FROM SOUNZ_ADMIN;
REVOKE ALL ON project_team_members FROM SOUNZ_WEB;

GRANT SELECT ON projects TO SOUNZ_REPORTS;
REVOKE ALL ON projects FROM SOUNZ_ADMIN;
REVOKE ALL ON projects FROM SOUNZ_WEB;

GRANT SELECT ON publishing_statuses TO SOUNZ_REPORTS;
REVOKE ALL ON publishing_statuses FROM SOUNZ_ADMIN;
REVOKE ALL ON publishing_statuses FROM SOUNZ_WEB;

GRANT SELECT ON regions TO SOUNZ_REPORTS;
REVOKE ALL ON regions FROM SOUNZ_ADMIN;
REVOKE ALL ON regions FROM SOUNZ_WEB;

GRANT SELECT ON related_communications TO SOUNZ_REPORTS;
REVOKE ALL ON related_communications FROM SOUNZ_ADMIN;
REVOKE ALL ON related_communications FROM SOUNZ_WEB;

GRANT SELECT ON related_organisations TO SOUNZ_REPORTS;
REVOKE ALL ON related_organisations FROM SOUNZ_ADMIN;
REVOKE ALL ON related_organisations FROM SOUNZ_WEB;

GRANT SELECT ON relationship_types TO SOUNZ_REPORTS;
REVOKE ALL ON relationship_types FROM SOUNZ_ADMIN;
REVOKE ALL ON relationship_types FROM SOUNZ_WEB;

GRANT SELECT ON relationships TO SOUNZ_REPORTS;
REVOKE ALL ON relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON relationships FROM SOUNZ_WEB;

GRANT SELECT ON reserved_items TO SOUNZ_REPORTS;
REVOKE ALL ON reserved_items FROM SOUNZ_ADMIN;
REVOKE ALL ON reserved_items FROM SOUNZ_WEB;

GRANT SELECT ON resource_access_rights TO SOUNZ_REPORTS;
REVOKE ALL ON resource_access_rights FROM SOUNZ_ADMIN;
REVOKE ALL ON resource_access_rights FROM SOUNZ_WEB;

GRANT SELECT ON resource_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON resource_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON resource_attachments FROM SOUNZ_WEB;

GRANT SELECT ON resource_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON resource_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON resource_relationships FROM SOUNZ_WEB;

GRANT SELECT ON resource_type_formats TO SOUNZ_REPORTS;
REVOKE ALL ON resource_type_formats FROM SOUNZ_ADMIN;
REVOKE ALL ON resource_type_formats FROM SOUNZ_WEB;

GRANT SELECT ON resource_types TO SOUNZ_REPORTS;
REVOKE ALL ON resource_types FROM SOUNZ_ADMIN;
REVOKE ALL ON resource_types FROM SOUNZ_WEB;

GRANT SELECT ON resources TO SOUNZ_REPORTS;
REVOKE ALL ON resources FROM SOUNZ_ADMIN;
REVOKE ALL ON resources FROM SOUNZ_WEB;

GRANT SELECT ON role_categorizations TO SOUNZ_REPORTS;
REVOKE ALL ON role_categorizations FROM SOUNZ_ADMIN;
REVOKE ALL ON role_categorizations FROM SOUNZ_WEB;

GRANT SELECT ON role_contactinfos TO SOUNZ_REPORTS;
REVOKE ALL ON role_contactinfos FROM SOUNZ_ADMIN;
REVOKE ALL ON role_contactinfos FROM SOUNZ_WEB;

GRANT SELECT ON role_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON role_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON role_relationships FROM SOUNZ_WEB;

GRANT SELECT ON role_types TO SOUNZ_REPORTS;
REVOKE ALL ON role_types FROM SOUNZ_ADMIN;
REVOKE ALL ON role_types FROM SOUNZ_WEB;

GRANT SELECT ON roles TO SOUNZ_REPORTS;
REVOKE ALL ON roles FROM SOUNZ_ADMIN;
REVOKE ALL ON roles FROM SOUNZ_WEB;

GRANT SELECT ON sample_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON sample_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON sample_attachments FROM SOUNZ_WEB;

GRANT SELECT ON samples TO SOUNZ_REPORTS;
REVOKE ALL ON samples FROM SOUNZ_ADMIN;
REVOKE ALL ON samples FROM SOUNZ_WEB;

GRANT SELECT ON saved_contact_lists TO SOUNZ_REPORTS;
REVOKE ALL ON saved_contact_lists FROM SOUNZ_ADMIN;
REVOKE ALL ON saved_contact_lists FROM SOUNZ_WEB;

GRANT SELECT ON saved_role_contactinfos TO SOUNZ_REPORTS;
REVOKE ALL ON saved_role_contactinfos FROM SOUNZ_ADMIN;
REVOKE ALL ON saved_role_contactinfos FROM SOUNZ_WEB;

GRANT SELECT ON saved_searches TO SOUNZ_REPORTS;
REVOKE ALL ON saved_searches FROM SOUNZ_ADMIN;
REVOKE ALL ON saved_searches FROM SOUNZ_WEB;

GRANT SELECT ON settings TO SOUNZ_REPORTS;
REVOKE ALL ON settings FROM SOUNZ_ADMIN;
REVOKE ALL ON settings FROM SOUNZ_WEB;

GRANT SELECT ON sounz_services TO SOUNZ_REPORTS;
REVOKE ALL ON sounz_services FROM SOUNZ_ADMIN;
REVOKE ALL ON sounz_services FROM SOUNZ_WEB;

GRANT SELECT ON superwork_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON superwork_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON superwork_relationships FROM SOUNZ_WEB;

GRANT SELECT ON superworks TO SOUNZ_REPORTS;
REVOKE ALL ON superworks FROM SOUNZ_ADMIN;
REVOKE ALL ON superworks FROM SOUNZ_WEB;

GRANT SELECT ON valid_entity_entity_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON valid_entity_entity_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON valid_entity_entity_relationships FROM SOUNZ_WEB;

GRANT SELECT ON work_access_rights TO SOUNZ_REPORTS;
REVOKE ALL ON work_access_rights FROM SOUNZ_ADMIN;
REVOKE ALL ON work_access_rights FROM SOUNZ_WEB;

GRANT SELECT ON work_attachments TO SOUNZ_REPORTS;
REVOKE ALL ON work_attachments FROM SOUNZ_ADMIN;
REVOKE ALL ON work_attachments FROM SOUNZ_WEB;

GRANT SELECT ON work_categories TO SOUNZ_REPORTS;
REVOKE ALL ON work_categories FROM SOUNZ_ADMIN;
REVOKE ALL ON work_categories FROM SOUNZ_WEB;

GRANT SELECT ON work_categorizations TO SOUNZ_REPORTS;
REVOKE ALL ON work_categorizations FROM SOUNZ_ADMIN;
REVOKE ALL ON work_categorizations FROM SOUNZ_WEB;

GRANT SELECT ON work_composers TO SOUNZ_REPORTS;
REVOKE ALL ON work_composers FROM SOUNZ_ADMIN;
REVOKE ALL ON work_composers FROM SOUNZ_WEB;

GRANT SELECT ON work_relationships TO SOUNZ_REPORTS;
REVOKE ALL ON work_relationships FROM SOUNZ_ADMIN;
REVOKE ALL ON work_relationships FROM SOUNZ_WEB;

GRANT SELECT ON work_subcategories TO SOUNZ_REPORTS;
REVOKE ALL ON work_subcategories FROM SOUNZ_ADMIN;
REVOKE ALL ON work_subcategories FROM SOUNZ_WEB;

GRANT SELECT ON works TO SOUNZ_REPORTS;
REVOKE ALL ON works FROM SOUNZ_ADMIN;
REVOKE ALL ON works FROM SOUNZ_WEB;

GRANT SELECT ON works_advanced_search TO SOUNZ_REPORTS;
REVOKE ALL ON works_advanced_search FROM SOUNZ_ADMIN;
REVOKE ALL ON works_advanced_search FROM SOUNZ_WEB;

-- Ok, these should be droppable now. If not then fix accordingly
-- by removing statements above for non-existent tables, or by dropping
-- and 'temp' databases you might have hanging around in your Postgres
-- cluster, which depend on them.
DROP ROLE SOUNZ_ADMIN;
DROP ROLE SOUNZ_WEB;

COMMIT;
