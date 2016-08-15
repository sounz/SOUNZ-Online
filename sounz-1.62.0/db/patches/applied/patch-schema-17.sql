----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 10/10/2007 23:39:08
--
-- Instructions:
-- apply this script to target database sounz_live, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

BEGIN;


-- COLUMNS to DROP/RECREATE on TABLE communications
ALTER TABLE "communications" DROP COLUMN communication_agent_class;

-- DROPPING NON-EXISTENT TABLE mailout_templates
DROP TABLE mailout_templates;


-- DROP/RE_CREATE cm_contents table
DROP TABLE cm_contents;

CREATE TABLE cm_contents (
cm_content_id        SERIAL               not null,
status_id            INT4                 not null,
cm_content_name      TEXT                 not null,
cm_content_title     TEXT                 null,
cm_content           TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_CM_CONTENTS PRIMARY KEY (cm_content_id)
);
CREATE INDEX CM_CONTENTS_UPDATED_BY_FK ON cm_contents (status_id);
CREATE INDEX CM_CONTENTS_UPDATED_BY_FK2 ON cm_contents (updated_by);
CREATE unique INDEX CM_CONTENTS_NAME_UIX ON cm_contents (cm_content_name);
GRANT SELECT ON cm_contents TO SOUNZ_REPORTS;


CREATE TABLE cm_content_attachments (
cm_content_attachment_id SERIAL           not null,
media_item_id        INT4                 not null,
cm_content_id        INT4                 not null,
attachment_type_id   INT4                 not null,
CONSTRAINT PK_CM_CONTENT_ATTACHMENTS PRIMARY KEY (cm_content_attachment_id)
);
CREATE INDEX CM_CONTENT_ATTACHMENT_FK ON cm_content_attachments (cm_content_id);
CREATE INDEX CM_CONTENT_ATT_MEDIA_FK ON cm_content_attachments (media_item_id);
CREATE INDEX CM_CONTENT_ATT_TYPE_FK ON cm_content_attachments (attachment_type_id);
GRANT SELECT ON cm_content_attachments TO SOUNZ_REPORTS;


CREATE TABLE news_article_attachments (
news_article_attachment_id SERIAL         not null,
media_item_id        INT4                 not null,
news_article_id      INT4                 not null,
attachment_type_id   INT4                 not null,
CONSTRAINT PK_NEWS_ARTICLE_ATTACHMENTS PRIMARY KEY (news_article_attachment_id)
);
CREATE INDEX NEWS_ARTICLE_ATTACHMENT_FK ON news_article_attachments (news_article_id);
CREATE INDEX NEWS_ARTICLE_ATT_TYPE_FK ON news_article_attachments (attachment_type_id);
CREATE INDEX NEWS_ARTICLE_ATT_MEDIA_FK ON news_article_attachments (media_item_id);
GRANT SELECT ON news_article_attachments TO SOUNZ_REPORTS;


CREATE TABLE news_articles (
news_article_id      SERIAL               not null,
headline             TEXT                 not null,
content              TEXT                 null,
precis               TEXT                 null,
article_timestamp    TIMESTAMP            null,
article_type         TEXT                 not null DEFAULT 'n' 
      CONSTRAINT CKC_ARTICLE_TYPE_NEWS_ART CHECK (article_type in ('n','p')),
feature              BOOL                 not null DEFAULT false,
archived             BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_NEWS_ARTICLES PRIMARY KEY (news_article_id)
);
CREATE INDEX UPDATED_BY_30_FK ON news_articles (updated_by);
GRANT SELECT ON news_articles TO SOUNZ_REPORTS;


-- RE-CREATING CHANGED CONSTRAINT ckc_mailout_type_campaign
alter table campaign_mailouts
 drop constraint ckc_mailout_type_campaign restrict;
alter table campaign_mailouts
  add constraint ckc_mailout_type_campaign check ((mailout_type = 'e'::bpchar) OR (mailout_type = 'p'::bpchar));

-- CREATING NEW CONSTRAINT fk_cm_conte_cm_conten_cm_conte
alter table cm_content_attachments
  add constraint fk_cm_conte_cm_conten_cm_conte foreign key (cm_content_id) references cm_contents (cm_content_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_cm_conte_cm_conten_attachme
alter table cm_content_attachments
  add constraint fk_cm_conte_cm_conten_attachme foreign key (attachment_type_id) references attachment_types (attachment_type_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_cm_conte_cm_conten_media_it
alter table cm_content_attachments
  add constraint fk_cm_conte_cm_conten_media_it foreign key (media_item_id) references media_items (media_item_id) on update restrict on delete restrict deferrable initially deferred;

-- RE-CREATING CHANGED CONSTRAINT ckc_status_communic
alter table communications
 drop constraint ckc_status_communic restrict;
alter table communications
  add constraint ckc_status_communic check ((status = 'o'::bpchar) OR (status = 'c'::bpchar));

-- RE-CREATING CHANGED CONSTRAINT ckc_priority_communic
alter table communications
 drop constraint ckc_priority_communic restrict;
alter table communications
  add constraint ckc_priority_communic check (((((priority = 0) OR (priority = 1)) OR (priority = 2)) OR (priority = 3)) OR (priority = 4));

-- RE-CREATING CHANGED CONSTRAINT ckc_composer_status_contribu
alter table contributors
 drop constraint ckc_composer_status_contribu restrict;
alter table contributors
  add constraint ckc_composer_status_contribu check ((composer_status IS NULL) OR (((composer_status = 0) OR (composer_status = 1)) OR (composer_status = 2)));

-- RE-CREATING CHANGED CONSTRAINT ckc_use_restriction_n_expressi
alter table expressions
 drop constraint ckc_use_restriction_n_expressi restrict;
alter table expressions
  add constraint ckc_use_restriction_n_expressi check ((use_restriction_note = 'available'::text) OR (use_restriction_note = 'unavailable'::text));

-- RE-CREATING CHANGED CONSTRAINT ckc_edition_expressi
alter table expressions
 drop constraint ckc_edition_expressi restrict;
alter table expressions
  add constraint ckc_edition_expressi check ((edition IS NULL) OR ((((edition = ''::bpchar) OR (edition = 'ORG'::bpchar)) OR (edition = 'RFP'::bpchar)) OR (edition = 'GEN'::bpchar)));

-- RE-CREATING CHANGED CONSTRAINT ckc_premiere_expressi
alter table expressions
 drop constraint ckc_premiere_expressi restrict;
alter table expressions
  add constraint ckc_premiere_expressi check ((premiere IS NULL) OR (((premiere = 'NA'::bpchar) OR (premiere = 'NZ'::bpchar)) OR (premiere = 'W'::bpchar)));

-- RE-CREATING CHANGED CONSTRAINT ckc_item_category_items
alter table items
 drop constraint ckc_item_category_items restrict;
alter table items
  add constraint ckc_item_category_items check ((item_category = 'R'::bpchar) OR (item_category = 'M'::bpchar));

-- RE-CREATING CHANGED CONSTRAINT ckc_login_agent_class_logins
alter table logins
 drop constraint ckc_login_agent_class_logins restrict;
alter table logins
  add constraint ckc_login_agent_class_logins check ((login_agent_class = 'P'::bpchar) OR (login_agent_class = 'O'::bpchar));

-- RE-CREATING CHANGED CONSTRAINT ckc_manifestation_typ_manifest
alter table manifestation_types
 drop constraint ckc_manifestation_typ_manifest restrict;
alter table manifestation_types
  add constraint ckc_manifestation_typ_manifest check ((manifestation_type_category IS NULL) OR (((manifestation_type_category = 1) OR (manifestation_type_category = 2)) OR (manifestation_type_category = 3)));

-- RE-CREATING CHANGED CONSTRAINT ckc_campaign_status_marketin
alter table marketing_campaigns
 drop constraint ckc_campaign_status_marketin restrict;
alter table marketing_campaigns
  add constraint ckc_campaign_status_marketin check ((campaign_status = 'i'::bpchar) OR (campaign_status = 'f'::bpchar));

-- CREATING NEW CONSTRAINT fk_news_art_news_arti_news_art
alter table news_article_attachments
  add constraint fk_news_art_news_arti_news_art foreign key (news_article_id) references news_articles (news_article_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_news_art_news_arti_attachme
alter table news_article_attachments
  add constraint fk_news_art_news_arti_attachme foreign key (attachment_type_id) references attachment_types (attachment_type_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_news_art_news_arti_media_it
alter table news_article_attachments
  add constraint fk_news_art_news_arti_media_it foreign key (media_item_id) references media_items (media_item_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_news_art_updated_b_logins
alter table news_articles
  add constraint fk_news_art_updated_b_logins foreign key (updated_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- RE-CREATING CHANGED CONSTRAINT ckc_gender_people
alter table people
 drop constraint ckc_gender_people restrict;
alter table people
  add constraint ckc_gender_people check ((gender IS NULL) OR (((gender = 'M'::bpchar) OR (gender = 'F'::bpchar)) OR (gender = 'U'::bpchar)));

-- RE-CREATING CHANGED CONSTRAINT ckc_project_status_projects
alter table projects
 drop constraint ckc_project_status_projects restrict;
alter table projects
  add constraint ckc_project_status_projects check (((project_status = 0) OR (project_status = 1)) OR (project_status = 2));

-- RE-CREATING CHANGED CONSTRAINT ckc_contactinfo_type_role_con
alter table role_contactinfos
 drop constraint ckc_contactinfo_type_role_con restrict;
alter table role_contactinfos
  add constraint ckc_contactinfo_type_role_con check (((contactinfo_type = 'postal'::text) OR (contactinfo_type = 'physical'::text)) OR (contactinfo_type = 'billing'::text));

-- RE-CREATING CHANGED CONSTRAINT ckc_difficulty_works
alter table works
 drop constraint ckc_difficulty_works restrict;
alter table works
  add constraint ckc_difficulty_works check ((difficulty IS NULL) OR ((((difficulty = 0) OR (difficulty = 1)) OR (difficulty = 2)) OR (difficulty = 3)));

-- DROPPING NON-EXISTENT SEQUENCE mailout_templates_mailout_template_id_seq
drop sequence mailout_templates_mailout_template_id_seq;


COMMIT;
