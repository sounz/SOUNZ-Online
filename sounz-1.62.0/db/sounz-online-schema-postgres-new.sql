CREATE TABLE access_rights (
access_right_id      SERIAL               not null,
access_right_name    TEXT                 not null,
access_right_desc    TEXT                 null,
CONSTRAINT PK_ACCESS_RIGHTS PRIMARY KEY (access_right_id)
);

GRANT SELECT ON access_rights TO SOUNZ_REPORTS;

CREATE TABLE app_control (
app_version          TEXT                 null,
last_db_patch        TEXT                 null,
updated_at           TIMESTAMP            not null
);

CREATE TABLE attachment_types (
attachment_type_id   SERIAL               not null,
attachment_type_desc TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_ATTACHMENT_TYPES PRIMARY KEY (attachment_type_id)
);

GRANT SELECT ON attachment_types TO SOUNZ_REPORTS;

CREATE TABLE borrowed_items (
borrowed_item_id     SERIAL               not null,
item_id              INT4                 not null,
login_id             INT4                 not null,
date_borrowed        DATE                 not null,
date_renewed         DATE                 null,
date_due             DATE                 null,
date_returned        DATE                 null,
hired_out            BOOL                 not null DEFAULT false,
borrowing_note       TEXT                 null,
reserved             BOOL                 not null DEFAULT false,
active               BOOL                 not null DEFAULT true,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
CONSTRAINT PK_BORROWED_ITEMS PRIMARY KEY (borrowed_item_id)
);

CREATE INDEX BORROWED_ITEM_ITEM_FK ON borrowed_items (
item_id
);

CREATE INDEX BORROWED_ITEM_LOGIN_FK ON borrowed_items (
login_id
);

GRANT SELECT ON borrowed_items TO SOUNZ_REPORTS;

CREATE TABLE campaign_mailouts (
campaign_mailout_id  SERIAL               not null,
marketing_campaign_id INT4                 not null,
mailout_type         CHAR(1)              not null DEFAULT 'e' 
      CONSTRAINT CKC_MAILOUT_TYPE_CAMPAIGN CHECK (mailout_type in ('e','p')),
mailout_description  TEXT                 not null,
mailout_status       CHAR(1)              not null DEFAULT 'n' 
      CONSTRAINT CKC_MAILOUT_STATUS_CAMPAIGN CHECK (mailout_status in ('n','r','i','s')),
main_content         TEXT                 null,
secondary_content    TEXT                 null,
general_note         TEXT                 null,
blind_send           BOOL                 not null DEFAULT true,
mail_merge           BOOL                 not null DEFAULT false,
sent_timestamp       TIMESTAMP            null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_CAMPAIGN_MAILOUTS PRIMARY KEY (campaign_mailout_id)
);

CREATE INDEX CAMPAIGN_MAILOUT_FK ON campaign_mailouts (
marketing_campaign_id
);

CREATE INDEX UPDATED_BY_2_FK ON campaign_mailouts (
updated_by
);

GRANT SELECT ON campaign_mailouts TO SOUNZ_REPORTS;

CREATE TABLE cm_content_attachments (
cm_content_attachment_id SERIAL               not null,
media_item_id        INT4                 not null,
cm_content_id        INT4                 not null,
attachment_type_id   INT4                 not null,
CONSTRAINT PK_CM_CONTENT_ATTACHMENTS PRIMARY KEY (cm_content_attachment_id)
);

CREATE INDEX CM_CONTENT_ATTACHMENT_FK ON cm_content_attachments (
cm_content_id
);

CREATE INDEX CM_CONTENT_ATT_MEDIA_FK ON cm_content_attachments (
media_item_id
);

CREATE INDEX CM_CONTENT_ATT_TYPE_FK ON cm_content_attachments (
attachment_type_id
);

GRANT SELECT ON cm_content_attachments TO SOUNZ_REPORTS;

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

CREATE INDEX CM_CONTENTS_UPDATED_BY_FK ON cm_contents (
status_id
);

CREATE INDEX CM_CONTENTS_UPDATED_BY_FK2 ON cm_contents (
updated_by
);

CREATE unique INDEX CM_CONTENTS_NAME_UIX ON cm_contents (
cm_content_name
);

GRANT SELECT ON cm_contents TO SOUNZ_REPORTS;

CREATE TABLE communication_methods (
communication_method_id SERIAL               not null,
communication_method_desc TEXT                 not null,
CONSTRAINT PK_COMMUNICATION_METHODS PRIMARY KEY (communication_method_id)
);

GRANT SELECT ON communication_methods TO SOUNZ_REPORTS;

CREATE TABLE communication_types (
communication_type_id SERIAL               not null,
communication_type_desc TEXT                 not null,
CONSTRAINT PK_COMMUNICATION_TYPES PRIMARY KEY (communication_type_id)
);

GRANT SELECT ON communication_types TO SOUNZ_REPORTS;

CREATE TABLE communications (
communication_id     SERIAL               not null,
communication_type_id INT4                 not null,
role_id              INT4                 not null,
communication_method_id INT4                 not null,
communication_subject TEXT                 null,
communication_note   TEXT                 null,
priority             INT4                 not null DEFAULT 0 
      CONSTRAINT CKC_PRIORITY_COMMUNIC CHECK (priority in (0,1,2,3,4,5)),
status               CHAR(1)              not null DEFAULT 'o' 
      CONSTRAINT CKC_STATUS_COMMUNIC CHECK (status in ('o','c')),
closed_at            TIMESTAMP            null,
internally_initiated BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_COMMUNICATIONS PRIMARY KEY (communication_id)
);

CREATE INDEX COMMUNICATION_TYPE_FK ON communications (
communication_type_id
);

CREATE INDEX COMMUNICATION_METHOD_FK ON communications (
communication_method_id
);

CREATE INDEX UPDATED_BY_22_FK ON communications (
updated_by
);

CREATE INDEX COMMUNICATION_ROLE_FK ON communications (
role_id
);

GRANT SELECT ON communications TO SOUNZ_REPORTS;

CREATE TABLE concept_relationships (
concept_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
concept_id           INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_CONCEPT_RELATIONSHIPS PRIMARY KEY (concept_relationship_id)
);

CREATE INDEX CONCEPT_ENTITY_FK ON concept_relationships (
concept_id
);

CREATE INDEX CONCEPT_RELTYPE_FK ON concept_relationships (
relationship_type_id
);

CREATE INDEX CONCEPT_RELATIONSHIP_FK ON concept_relationships (
relationship_id
);

CREATE unique INDEX CONCEPT_RELATIONSHIP_UIX ON concept_relationships (
relationship_id,
relationship_type_id,
concept_id
);

GRANT SELECT ON concept_relationships TO SOUNZ_REPORTS;

CREATE TABLE concept_types (
concept_type_id      SERIAL               not null,
concept_type_desc    TEXT                 not null,
CONSTRAINT PK_CONCEPT_TYPES PRIMARY KEY (concept_type_id)
);

GRANT SELECT ON concept_types TO SOUNZ_REPORTS;

CREATE TABLE concepts (
concept_id           SERIAL               not null,
concept_type_id      INT4                 not null,
parent_concept_id    INT4                 null,
concept_name         TEXT                 not null,
concept_description  TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_CONCEPTS PRIMARY KEY (concept_id)
);

CREATE INDEX CONCEPT_TYPE_FK ON concepts (
concept_type_id
);

CREATE INDEX UPDATED_BY_13_FK ON concepts (
updated_by
);

CREATE INDEX PARENT_CONCEPT_FK ON concepts (
parent_concept_id
);

GRANT SELECT ON concepts TO SOUNZ_REPORTS;

CREATE TABLE contactinfos (
contactinfo_id       SERIAL               not null,
preferred_comm_method INT4                 null,
region_id            INT4                 null,
country_id           INT4                 null,
building             TEXT                 null,
street               TEXT                 null,
po_box               TEXT                 null,
suburb               TEXT                 null,
locality             TEXT                 null,
postcode             TEXT                 null,
email_1              TEXT                 null,
email_2              TEXT                 null,
email_3              TEXT                 null,
website_urls         TEXT                 null,
phone                TEXT                 null,
phone_prefix         TEXT                 null,
phone_extension      TEXT                 null,
phone_alt            TEXT                 null,
phone_alt_prefix     TEXT                 null,
phone_alt_extension  TEXT                 null,
phone_fax            TEXT                 null,
phone_fax_prefix     TEXT                 null,
phone_fax_extension  TEXT                 null,
phone_mobile         TEXT                 null,
phone_mobile_prefix  TEXT                 null,
phone_mobile_extension TEXT                 null,
internal_note        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_CONTACTINFOS PRIMARY KEY (contactinfo_id)
);

CREATE INDEX CONTACTINFO_REGION_FK ON contactinfos (
region_id
);

CREATE INDEX UPDATED_BY_20_FK ON contactinfos (
updated_by
);

CREATE INDEX PREFERRED_COMM_METHOD_FK ON contactinfos (
preferred_comm_method
);

CREATE INDEX CONTACTINFO_COUNTRY_FK ON contactinfos (
country_id
);

GRANT SELECT ON contactinfos TO SOUNZ_REPORTS;

CREATE TABLE contributor_attachments (
contributor_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
contributor_id       INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_CONTRIBUTOR_ATTACHMENTS PRIMARY KEY (contributor_attachment_id)
);

CREATE INDEX CONTRIBUTOR_ATTACHMENT_FK ON contributor_attachments (
contributor_id
);

CREATE INDEX CONTRIBUTOR_ATT_MEDIA_FK ON contributor_attachments (
media_item_id
);

CREATE INDEX CONTRIB_ATT_TYPE_FK ON contributor_attachments (
attachment_type_id
);

CREATE unique INDEX CONTRIBUTOR_ATTACHMENT_UIX ON contributor_attachments (
contributor_id,
media_item_id
);

GRANT SELECT ON contributor_attachments TO SOUNZ_REPORTS;

CREATE TABLE contributors (
contributor_id       SERIAL               not null,
status_id            INT4                 not null,
role_id              INT4                 not null,
known_as             TEXT                 null,
photo_credit         TEXT                 null,
apra_member          BOOL                 not null DEFAULT false,
canz_member          BOOL                 not null DEFAULT false,
profile              TEXT                 null,
profile_other        TEXT                 null,
profile_source       TEXT                 null,
composer_status      INT4                 null 
      CONSTRAINT CKC_COMPOSER_STATUS_CONTRIBU CHECK (composer_status is null or ( composer_status in (0,1,2) )),
pull_quote           TEXT                 null,
permission_note      TEXT                 null,
internal_note        TEXT                 null,
legacy4d_identity_code TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_CONTRIBUTORS PRIMARY KEY (contributor_id)
);

CREATE INDEX UPDATED_BY_7_FK ON contributors (
updated_by
);

CREATE INDEX CONTRIBUTORS_PUBSTATUS_FK ON contributors (
status_id
);

CREATE INDEX CONTRIBUTOR_ROLE_FK ON contributors (
role_id
);

GRANT SELECT ON contributors TO SOUNZ_REPORTS;

CREATE TABLE controller_restrictions (
controller_restriction_id SERIAL               not null,
privilege_id         INT4                 not null,
status_id            INT4                 null,
controller_name      TEXT                 not null,
controller_action    TEXT                 null,
http_verb            TEXT                 not null DEFAULT 'get' 
      CONSTRAINT CKC_HTTP_VERB_CONTROLL CHECK (http_verb in ('get','post')),
CONSTRAINT PK_CONTROLLER_RESTRICTIONS PRIMARY KEY (controller_restriction_id)
);

CREATE INDEX CONTROLLER_RESTRICT_PIVILEGE_FK ON controller_restrictions (
privilege_id
);

CREATE INDEX CONTROLLER_RESTRICT_STATUS_FK ON controller_restrictions (
status_id
);

CREATE TABLE countries (
country_id           SERIAL               not null,
country_name         TEXT                 not null,
country_abbrev       TEXT                 null,
CONSTRAINT PK_COUNTRIES PRIMARY KEY (country_id)
);

GRANT SELECT ON countries TO SOUNZ_REPORTS;

CREATE TABLE default_contactinfos (
default_contactinfo_id SERIAL               not null,
contactinfo_id       INT4                 not null,
d_contactinfo_id     INT4                 not null,
d_region             BOOL                 not null DEFAULT true,
d_country            BOOL                 not null DEFAULT true,
d_building           BOOL                 not null DEFAULT true,
d_street             BOOL                 not null DEFAULT true,
d_po_box             BOOL                 not null DEFAULT true,
d_suburb             BOOL                 not null DEFAULT true,
d_locality           BOOL                 not null DEFAULT true,
d_postcode           BOOL                 not null DEFAULT true,
d_email_1            BOOL                 not null DEFAULT true,
d_email_2            BOOL                 not null DEFAULT true,
d_email_3            BOOL                 not null DEFAULT true,
d_website_urls       BOOL                 not null DEFAULT true,
d_phone              BOOL                 not null DEFAULT true,
d_phone_alt          BOOL                 not null DEFAULT true,
d_phone_fax          BOOL                 not null DEFAULT true,
d_phone_mobile       BOOL                 not null DEFAULT true,
CONSTRAINT PK_DEFAULT_CONTACTINFOS PRIMARY KEY (default_contactinfo_id)
);

CREATE INDEX DEF_CINFO_MASTER_FK ON default_contactinfos (
contactinfo_id
);

CREATE INDEX DEF_CINFO_DEFAULT_FK ON default_contactinfos (
d_contactinfo_id
);

CREATE unique INDEX DEF_CINFO_UIX ON default_contactinfos (
contactinfo_id,
d_contactinfo_id
);

GRANT SELECT ON default_contactinfos TO SOUNZ_REPORTS;

CREATE TABLE distinction_instances (
distinction_instance_id SERIAL               not null,
distinction_id       INT4                 not null,
role_id              INT4                 null,
event_id             INT4                 null,
status_id            INT4                 not null,
instance_info        TEXT                 null,
award_year           INT4                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_DISTINCTION_INSTANCES PRIMARY KEY (distinction_instance_id)
);

CREATE INDEX DISTINCTION_INSTANCE_FK ON distinction_instances (
distinction_id
);

CREATE INDEX DISTINCTION_EVENT_FK ON distinction_instances (
event_id
);

CREATE INDEX UPDATED_BY_18_FK ON distinction_instances (
updated_by
);

CREATE INDEX DISTINCINST_PUBSTATUS_FK ON distinction_instances (
status_id
);

CREATE INDEX ROLE_DISTINCTION_INSTANCE_FK ON distinction_instances (
role_id
);

GRANT SELECT ON distinction_instances TO SOUNZ_REPORTS;

CREATE TABLE distinction_relationships (
distinction_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
distinction_instance_id INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_DISTINCTION_RELATIONSHIPS PRIMARY KEY (distinction_relationship_id)
);

CREATE INDEX DISTINCTION_ENTITY_FK ON distinction_relationships (
distinction_instance_id
);

CREATE INDEX DISTINCTION_RELTYPE_FK ON distinction_relationships (
relationship_type_id
);

CREATE INDEX DISTINCTION_RELATIONSHIP_FK ON distinction_relationships (
relationship_id
);

CREATE unique INDEX DISTINCTION_RELATIONSHIP_UIX ON distinction_relationships (
relationship_id,
relationship_type_id,
distinction_instance_id
);

GRANT SELECT ON distinction_relationships TO SOUNZ_REPORTS;

CREATE TABLE distinctions (
distinction_id       SERIAL               not null,
contactinfo_id       INT4                 not null,
status_id            INT4                 not null,
award_name           TEXT                 not null,
award_name_alt       TEXT                 null,
award_info           TEXT                 null,
awarded_since_year   INT4                 null 
      CONSTRAINT CKC_AWARDED_SINCE_YEA_DISTINCT CHECK (awarded_since_year is null or (awarded_since_year between 0 and 9999 )),
frequency            TEXT                 null,
currently_awarded    BOOL                 null DEFAULT false,
general_note         TEXT                 null,
internal_note        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_DISTINCTIONS PRIMARY KEY (distinction_id)
);

CREATE INDEX DISTINCTION_CONTACTINFO_FK ON distinctions (
contactinfo_id
);

CREATE INDEX UPDATED_BY_19_FK ON distinctions (
updated_by
);

CREATE INDEX DISTINCTION_PUBSTATUS_FK ON distinctions (
status_id
);

GRANT SELECT ON distinctions TO SOUNZ_REPORTS;

CREATE TABLE entity_relationship_types (
relationship_type_id INT4                 not null,
entity_type_id       INT4                 not null,
CONSTRAINT PK_ENTITY_RELATIONSHIP_TYPES PRIMARY KEY (relationship_type_id, entity_type_id)
);

CREATE INDEX ENTITY_RELATIONSHIP_TYPES_FK ON entity_relationship_types (
relationship_type_id
);

CREATE INDEX ENTITY_RELATIONSHIP_TYPES2_FK ON entity_relationship_types (
entity_type_id
);

GRANT SELECT ON entity_relationship_types TO SOUNZ_REPORTS;

CREATE TABLE entity_types (
entity_type_id       SERIAL               not null,
entity_type          TEXT                 not null,
CONSTRAINT PK_ENTITY_TYPES PRIMARY KEY (entity_type_id)
);

GRANT SELECT ON entity_types TO SOUNZ_REPORTS;

CREATE TABLE event_attachments (
event_attachment_id  SERIAL               not null,
attachment_type_id   INT4                 not null,
event_id             INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_EVENT_ATTACHMENTS PRIMARY KEY (event_attachment_id)
);

CREATE INDEX EVENT_ATTACHMENT_FK ON event_attachments (
event_id
);

CREATE INDEX EVENT_ATT_MEDIA_FK ON event_attachments (
media_item_id
);

CREATE INDEX EVENT_ATT_TYPE_FK ON event_attachments (
attachment_type_id
);

CREATE unique INDEX EVENT_ATTACHMENT_UIX ON event_attachments (
event_id,
media_item_id
);

GRANT SELECT ON event_attachments TO SOUNZ_REPORTS;

CREATE TABLE event_relationships (
event_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 null,
event_id             INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_EVENT_RELATIONSHIPS PRIMARY KEY (event_relationship_id)
);

CREATE INDEX EVENT_ENTITY_FK ON event_relationships (
event_id
);

CREATE INDEX EVENT_RELTYPE_FK ON event_relationships (
relationship_type_id
);

CREATE INDEX EVENT_RELATIONSHIP_FK ON event_relationships (
relationship_id
);

CREATE unique INDEX EVENT_RELATIONSHIP_UIX ON event_relationships (
relationship_id,
relationship_type_id,
event_id
);

GRANT SELECT ON event_relationships TO SOUNZ_REPORTS;

CREATE TABLE event_types (
event_type_id        SERIAL               not null,
event_type_desc      TEXT                 not null,
CONSTRAINT PK_EVENT_TYPES PRIMARY KEY (event_type_id)
);

GRANT SELECT ON event_types TO SOUNZ_REPORTS;

CREATE TABLE events (
event_id             SERIAL               not null,
event_type_id        INT4                 not null,
contactinfo_id       INT4                 not null,
related_event_id     INT4                 null,
status_id            INT4                 not null,
event_title          TEXT                 not null,
event_start          TIMESTAMP            null,
event_finish         TIMESTAMP            null,
supress_times        BOOL                 not null DEFAULT false,
entry_deadline       TIMESTAMP            null,
entry_anonymous      BOOL                 null DEFAULT false,
entry_age_limit      TEXT                 null,
entry_fee_note       TEXT                 null,
prize_info_note      TEXT                 null,
tickets_note         TEXT                 null,
general_note         TEXT                 null,
internal_note        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_EVENTS PRIMARY KEY (event_id)
);

CREATE INDEX EVENT_TYPE_FK ON events (
event_type_id
);

CREATE INDEX EVENT_CONTACTINFO_FK ON events (
contactinfo_id
);

CREATE INDEX PARENT_EVENT_FK ON events (
related_event_id
);

CREATE INDEX UPDATED_BY_16_FK ON events (
updated_by
);

CREATE INDEX EVENTS_PUBSTATUS_FK ON events (
status_id
);

GRANT SELECT ON events TO SOUNZ_REPORTS;

CREATE TABLE exam_set_works (
exam_set_work_id     SERIAL               not null,
manifestation_id     INT4                 not null,
examboard_id         INT4                 not null,
grade_notes          TEXT                 null,
CONSTRAINT PK_EXAM_SET_WORKS PRIMARY KEY (exam_set_work_id)
);

CREATE INDEX SETWORK_EXAMBOARD_FK ON exam_set_works (
examboard_id
);

CREATE INDEX EXAM_SET_WORK_MANIF_FK ON exam_set_works (
manifestation_id
);

GRANT SELECT ON exam_set_works TO SOUNZ_REPORTS;

CREATE TABLE examboards (
examboard_id         SERIAL               not null,
examboard_name       TEXT                 not null,
CONSTRAINT PK_EXAMBOARDS PRIMARY KEY (examboard_id)
);

GRANT SELECT ON examboards TO SOUNZ_REPORTS;

CREATE TABLE expression_access_rights (
expression_access_right_id SERIAL               not null,
expression_id        INT4                 not null,
access_right_id      INT4                 not null,
access_right_source  TEXT                 not null 
      CONSTRAINT CKC_ACCESS_RIGHT_SOUR_EXPRESSI CHECK (access_right_source in ('composer','publisher')),
CONSTRAINT PK_EXPRESSION_ACCESS_RIGHTS PRIMARY KEY (expression_access_right_id)
);

CREATE INDEX EXPR_AR_EXPRESSION_FK ON expression_access_rights (
expression_id
);

CREATE INDEX EXPR_AR_RIGHTS_FK ON expression_access_rights (
access_right_id
);

CREATE unique INDEX EXPR_AR_UIX ON expression_access_rights (
expression_id,
access_right_id,
access_right_source
);

GRANT SELECT ON expression_access_rights TO SOUNZ_REPORTS;

CREATE TABLE expression_languages (
expression_language_id SERIAL               not null,
expression_id        INT4                 not null,
language_id          INT4                 not null,
CONSTRAINT PK_EXPRESSION_LANGUAGES PRIMARY KEY (expression_language_id)
);

CREATE INDEX EXPR_LANG_LANGUAGE_FK ON expression_languages (
language_id
);

CREATE INDEX EXPR_LANG_EXPRESSION_FK ON expression_languages (
expression_id
);

GRANT SELECT ON expression_languages TO SOUNZ_REPORTS;

CREATE TABLE expression_manifestations (
expression_manifestation_id SERIAL               not null,
manifestation_id     INT4                 not null,
expression_id        INT4                 not null,
expression_order     INT4                 null,
CONSTRAINT PK_EXPRESSION_MANIFESTATIONS PRIMARY KEY (expression_manifestation_id)
);

CREATE INDEX EXPRESSION_MANIFESTATION_FK ON expression_manifestations (
expression_id
);

CREATE INDEX MANIFESTATION_EXPRESSION_FK ON expression_manifestations (
manifestation_id
);

GRANT SELECT ON expression_manifestations TO SOUNZ_REPORTS;

CREATE TABLE expression_relationships (
expression_relationship_id SERIAL               not null,
relationship_type_id INT4                 not null,
relationship_id      INT4                 not null,
expression_id        INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_EXPRESSION_RELATIONSHIPS PRIMARY KEY (expression_relationship_id)
);

CREATE INDEX EXPRESSION_ENTITY_FK ON expression_relationships (
expression_id
);

CREATE INDEX EXPRESSION_RELTYPE_FK ON expression_relationships (
relationship_type_id
);

CREATE INDEX EXPRESSION_RELATIONSHIP_FK ON expression_relationships (
relationship_id
);

CREATE unique INDEX EXPRESSION_RELATIONSHIP_UIX ON expression_relationships (
relationship_id,
relationship_type_id,
expression_id
);

GRANT SELECT ON expression_relationships TO SOUNZ_REPORTS;

CREATE TABLE expressions (
expression_id        SERIAL               not null,
work_id              INT4                 not null,
mode_id              INT4                 not null,
expression_title     TEXT                 null,
status_id            INT4                 not null,
expression_start     TIMESTAMP            null,
expression_finish    TIMESTAMP            null,
supress_times        BOOL                 not null DEFAULT false,
partial_expression   BOOL                 null DEFAULT false,
partial_expression_note TEXT                 null,
premiere             CHAR(3)              null 
      CONSTRAINT CKC_PREMIERE_EXPRESSI CHECK (premiere is null or ( premiere in ('NA','NZ','W') )),
edition              CHAR(3)              null DEFAULT '' 
      CONSTRAINT CKC_EDITION_EXPRESSI CHECK (edition is null or ( edition in ('','ORG','RFP','GEN') )),
players_count        INT4                 null,
use_restriction_note TEXT                 not null DEFAULT 'available' 
      CONSTRAINT CKC_USE_RESTRICTION_N_EXPRESSI CHECK (use_restriction_note in ('available','unavailable')),
general_note         TEXT                 null,
internal_note        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_EXPRESSIONS PRIMARY KEY (expression_id)
);

CREATE INDEX WORK_EXPRESSION_FK ON expressions (
work_id
);

CREATE INDEX MODE_OF_EXPRESSION_FK ON expressions (
mode_id
);

CREATE INDEX UPDATED_BY_10_FK ON expressions (
updated_by
);

CREATE INDEX EXPRESSIONS_PUBSTATUS_FK ON expressions (
status_id
);

GRANT SELECT ON expressions TO SOUNZ_REPORTS;

CREATE TABLE formats (
format_id            SERIAL               not null,
format_desc          TEXT                 not null,
manifestation_format BOOL                 not null DEFAULT false,
resource_format      BOOL                 not null DEFAULT false,
CONSTRAINT PK_FORMATS PRIMARY KEY (format_id)
);

GRANT SELECT ON formats TO SOUNZ_REPORTS;

CREATE TABLE item_types (
item_type_id         SERIAL               not null,
item_type_desc       TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_ITEM_TYPES PRIMARY KEY (item_type_id)
);

GRANT SELECT ON item_types TO SOUNZ_REPORTS;

CREATE TABLE items (
item_id              SERIAL               not null,
resource_id          INT4                 null,
item_type_id         INT4                 not null,
manifestation_id     INT4                 null,
status_id            INT4                 not null,
item_category        CHAR(1)              not null DEFAULT 'M' 
      CONSTRAINT CKC_ITEM_CATEGORY_ITEMS CHECK (item_category in ('R','M')),
item_location        TEXT                 null,
physical_description TEXT                 null,
internal_note        TEXT                 null,
out_on_loan_or_hire  BOOL                 not null DEFAULT false,
borrowed_date        TIMESTAMP            null,
return_date          TIMESTAMP            null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_ITEMS PRIMARY KEY (item_id)
);

CREATE INDEX UPDATED_BY_28_FK ON items (
updated_by
);

CREATE INDEX ITEMS_PUBSTATUS_FK ON items (
status_id
);

CREATE INDEX ITEM_TYPE_FK ON items (
item_type_id
);

CREATE INDEX MANIFESTATION_ITEM_FK ON items (
manifestation_id
);

CREATE INDEX RESOURCE_ITEM_FK ON items (
resource_id
);

GRANT SELECT ON items TO SOUNZ_REPORTS;

CREATE TABLE languages (
language_id          SERIAL               not null,
language_name        TEXT                 not null,
char_encoding        TEXT                 null,
is_default           BOOL                 not null DEFAULT false,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_LANGUAGES PRIMARY KEY (language_id)
);

GRANT SELECT ON languages TO SOUNZ_REPORTS;

CREATE TABLE logins (
login_id             SERIAL               not null,
organisation_id      INT4                 null,
person_id            INT4                 null,
login_agent_class    CHAR(1)              not null DEFAULT 'P' 
      CONSTRAINT CKC_LOGIN_AGENT_CLASS_LOGINS CHECK (login_agent_class in ('P','O','G')),
username             TEXT                 not null,
password             TEXT                 not null,
salt                 TEXT                 not null,
password_valid_until TIMESTAMP            null,
password_forever     BOOL                 not null DEFAULT false,
locked               BOOL                 not null DEFAULT false,
enabled              BOOL                 not null DEFAULT false,
login_fail_count     INT4                 not null DEFAULT 0,
moneyworks_name      TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 null,
CONSTRAINT PK_LOGINS PRIMARY KEY (login_id)
);

CREATE INDEX UPDATED_BY_27_FK ON logins (
updated_by
);

CREATE INDEX PERSON_LOGIN_PERSON_FK ON logins (
person_id
);

CREATE INDEX ORG_LOGIN_ORGANISATION_FK ON logins (
organisation_id
);

GRANT SELECT ON logins TO SOUNZ_REPORTS;

CREATE TABLE mailout_attachments (
mailout_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
campaign_mailout_id  INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_MAILOUT_ATTACHMENTS PRIMARY KEY (mailout_attachment_id)
);

CREATE INDEX MAILOUT_ATTACHMENT_FK ON mailout_attachments (
campaign_mailout_id
);

CREATE INDEX MAILOUT_ATT_MEDIA_FK ON mailout_attachments (
media_item_id
);

CREATE INDEX MAILOUT_ATT_TYPE_FK ON mailout_attachments (
attachment_type_id
);

GRANT SELECT ON mailout_attachments TO SOUNZ_REPORTS;

CREATE TABLE mailout_contacts (
mailout_contact_id   SERIAL               not null,
role_contactinfo_id  INT4                 null,
campaign_mailout_id  INT4                 not null,
address_line1        TEXT                 null,
address_line2        TEXT                 null,
address_line3        TEXT                 null,
address_line4        TEXT                 null,
address_line5        TEXT                 null,
address_line6        TEXT                 null,
address_line7        TEXT                 null,
salutation           TEXT                 null,
nomen                TEXT                 null,
name                 TEXT                 null,
building             TEXT                 null,
street               TEXT                 null,
po_box               TEXT                 null,
suburb               TEXT                 null,
locality             TEXT                 null,
postcode             TEXT                 null,
region               TEXT                 null,
country              TEXT                 null,
role_title           TEXT                 null,
organisation_name    TEXT                 null,
email                TEXT                 null,
phone                TEXT                 null,
fax                  TEXT                 null,
mobile_sms           TEXT                 null,
delivery_failed      BOOL                 not null DEFAULT false,
delivery_timestamp   TIMESTAMP            null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_MAILOUT_CONTACTS PRIMARY KEY (mailout_contact_id)
);

CREATE INDEX MAILOUT_CONTACT_FK ON mailout_contacts (
campaign_mailout_id
);

CREATE INDEX UPDATED_BY_1_FK ON mailout_contacts (
updated_by
);

CREATE INDEX MAILOUT_ROLE_CONTACTINFO_FK ON mailout_contacts (
role_contactinfo_id
);

GRANT SELECT ON mailout_contacts TO SOUNZ_REPORTS;

CREATE TABLE manifestation_access_rights (
manifestation_access_right_id SERIAL               not null,
access_right_id      INT4                 not null,
manifestation_id     INT4                 not null,
access_right_source  TEXT                 not null 
      CONSTRAINT CKC_ACCESS_RIGHT_SOUR_MANIFEST CHECK (access_right_source in ('composer','publisher')),
CONSTRAINT PK_MANIFESTATION_ACCESS_RIGHTS PRIMARY KEY (manifestation_access_right_id)
);

CREATE INDEX MANIF_AR_MANIFESTATION_FK ON manifestation_access_rights (
manifestation_id
);

CREATE INDEX MANIF_AR_RIGHTS_FK ON manifestation_access_rights (
access_right_id
);

CREATE unique INDEX MANIF_AR_UIX ON manifestation_access_rights (
access_right_id,
manifestation_id,
access_right_source
);

GRANT SELECT ON manifestation_access_rights TO SOUNZ_REPORTS;

CREATE TABLE manifestation_attachments (
manifestation_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
manifestation_id     INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_MANIFESTATION_ATTACHMENTS PRIMARY KEY (manifestation_attachment_id)
);

CREATE INDEX MANIFESTATION_ATTACHMENT_FK ON manifestation_attachments (
manifestation_id
);

CREATE INDEX MANIFESTATION_ATT_MEDIA_FK ON manifestation_attachments (
media_item_id
);

CREATE INDEX MANIFESTATION_ATT_TYPE_FK ON manifestation_attachments (
attachment_type_id
);

CREATE INDEX MANIFESTATION_ATTACHMENT_UIX ON manifestation_attachments (
manifestation_id,
media_item_id
);

GRANT SELECT ON manifestation_attachments TO SOUNZ_REPORTS;

CREATE TABLE manifestation_relationships (
manifestation_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
manifestation_id     INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_MANIFESTATION_RELATIONSHIPS PRIMARY KEY (manifestation_relationship_id)
);

CREATE INDEX MANIFESTATION_ENTITY_FK ON manifestation_relationships (
manifestation_id
);

CREATE INDEX MANIFESTATION_RELTYPE_FK ON manifestation_relationships (
relationship_type_id
);

CREATE INDEX MANIFESTATION_RELATIONSHIP_FK ON manifestation_relationships (
relationship_id
);

CREATE unique INDEX MANIFESTATION_RELATIONSHIP_UIX ON manifestation_relationships (
relationship_id,
relationship_type_id,
manifestation_id
);

GRANT SELECT ON manifestation_relationships TO SOUNZ_REPORTS;

CREATE TABLE manifestation_type_formats (
manifestation_type_format_id SERIAL               not null,
manifestation_type_id INT4                 not null,
format_id            INT4                 not null,
CONSTRAINT PK_MANIFESTATION_TYPE_FORMATS PRIMARY KEY (manifestation_type_format_id)
);

CREATE INDEX MANIF_TYPEFORM_FORMAT_FK ON manifestation_type_formats (
format_id
);

CREATE INDEX MANIF_TYPEFORM_TYPE_FK ON manifestation_type_formats (
manifestation_type_id
);

GRANT SELECT ON manifestation_type_formats TO SOUNZ_REPORTS;

CREATE TABLE manifestation_types (
manifestation_type_id SERIAL               not null,
manifestation_type_desc TEXT                 not null,
manifestation_type_category INT4                 null 
      CONSTRAINT CKC_MANIFESTATION_TYP_MANIFEST CHECK (manifestation_type_category is null or ( manifestation_type_category in (1,2,3) )),
CONSTRAINT PK_MANIFESTATION_TYPES PRIMARY KEY (manifestation_type_id)
);

GRANT SELECT ON manifestation_types TO SOUNZ_REPORTS;

CREATE TABLE manifestations (
manifestation_id     SERIAL               not null,
manifestation_type_id INT4                 not null,
format_id            INT4                 not null,
status_id            INT4                 not null,
manifestation_title  TEXT                 not null,
manifestation_title_alt TEXT                 null,
series_title         TEXT                 null,
publication_year     INT4                 null 
      CONSTRAINT CKC_PUBLICATION_YEAR_MANIFEST CHECK (publication_year is null or (publication_year between 0 and 9999 )),
isbn                 TEXT                 null,
ismn                 TEXT                 null,
isrc                 TEXT                 null,
issn                 TEXT                 null,
imprint              TEXT                 null,
copyright            TEXT                 null,
collation            TEXT                 null,
duration             INTERVAL             null,
dedication_note      TEXT                 null,
publisher_note       TEXT                 null,
content_note         TEXT                 null,
general_note         TEXT                 null,
internal_note        TEXT                 null,
manifestation_code   INT4                 not null,
mw_code              TEXT                 null,
clonable             BOOL                 not null DEFAULT false,
downloadable         BOOL                 not null DEFAULT false,
download_file_name   TEXT                 null,
download_file_name_2 TEXT                 null,
available_for_loan   BOOL                 not null DEFAULT false,
available_for_hire   BOOL                 not null DEFAULT false,
available_for_sale   BOOL                 not null DEFAULT false,
sale_product_id      INT4                 not null DEFAULT 0,
loan_product_id      INT4                 not null DEFAULT 0,
item_cost            NUMERIC              null DEFAULT 0.00,
freight_code         INT4                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_MANIFESTATIONS PRIMARY KEY (manifestation_id)
);

CREATE INDEX MANIFESTATION_FORMAT_FK ON manifestations (
format_id
);

CREATE INDEX UPDATED_BY_12_FK ON manifestations (
updated_by
);

CREATE INDEX MANIFESTATIONS_PUBSTATUS_FK ON manifestations (
status_id
);

CREATE INDEX MANIFESTATION_TYPE_FK ON manifestations (
manifestation_type_id
);

GRANT SELECT ON manifestations TO SOUNZ_REPORTS;

CREATE TABLE marketing_campaigns (
marketing_campaign_id SERIAL               not null,
project_id           INT4                 not null,
campaign_manager     INT4                 null,
campaign_name        TEXT                 not null,
campaign_description TEXT                 null,
campaign_status      CHAR(1)              not null DEFAULT 'i' 
      CONSTRAINT CKC_CAMPAIGN_STATUS_MARKETIN CHECK (campaign_status in ('i','f')),
finished_at          TIMESTAMP            null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_MARKETING_CAMPAIGNS PRIMARY KEY (marketing_campaign_id)
);

CREATE INDEX PROJECT_CAMPAIGN_FK ON marketing_campaigns (
project_id
);

CREATE INDEX CAMPAIGN_MANAGER_FK ON marketing_campaigns (
campaign_manager
);

CREATE INDEX UPDATED_BY_24_FK ON marketing_campaigns (
updated_by
);

GRANT SELECT ON marketing_campaigns TO SOUNZ_REPORTS;

CREATE TABLE marketing_categories (
marketing_category_id SERIAL               not null,
description          TEXT                 not null,
abbreviation         TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_MARKETING_CATEGORIES PRIMARY KEY (marketing_category_id)
);

GRANT SELECT ON marketing_categories TO SOUNZ_REPORTS;

CREATE TABLE marketing_subcategories (
marketing_subcategory_id SERIAL               not null,
marketing_category_id INT4                 not null,
description          TEXT                 not null,
abbreviation         TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_MARKETING_SUBCATEGORIES PRIMARY KEY (marketing_subcategory_id)
);

CREATE INDEX MARKETING_CAT_SUBCAT_FK ON marketing_subcategories (
marketing_category_id
);

GRANT SELECT ON marketing_subcategories TO SOUNZ_REPORTS;

CREATE TABLE media_items (
media_item_id        SERIAL               not null,
parent_id            INT4                 null,
mime_type_id         INT4                 null,
media_item_path      TEXT                 null,
media_item_desc      TEXT                 null,
caption              TEXT                 null,
width                INT4                 null,
height               INT4                 null,
size                 INT4                 null,
filename             TEXT                 null,
thumbnail            TEXT                 null,
content_type         TEXT                 null,
copyright            TEXT                 null,
internal_note        TEXT                 null,
available_for_use    BOOL                 not null DEFAULT true,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 null,
CONSTRAINT PK_MEDIA_ITEMS PRIMARY KEY (media_item_id)
);

CREATE INDEX UPDATED_BY_6_FK ON media_items (
updated_by
);

CREATE INDEX MEDIA_ITEM_MIMETYPE_FK ON media_items (
mime_type_id
);

CREATE INDEX PARENT_MEDIA_ITEM_FK ON media_items (
parent_id
);

GRANT SELECT ON media_items TO SOUNZ_REPORTS;

CREATE TABLE member_type_privileges (
member_type_privilege_id SERIAL               not null,
member_type_id       INT4                 not null,
privilege_id         INT4                 not null,
CONSTRAINT PK_MEMBER_TYPE_PRIVILEGES PRIMARY KEY (member_type_privilege_id)
);

CREATE INDEX MEMTYPE_PRIV_TYPE_FK ON member_type_privileges (
member_type_id
);

CREATE INDEX MEMTYPE_PRIV_PRIVILEGE_FK ON member_type_privileges (
privilege_id
);

GRANT SELECT ON member_type_privileges TO SOUNZ_REPORTS;

CREATE TABLE member_types (
member_type_id       SERIAL               not null,
member_type_desc     TEXT                 not null,
CONSTRAINT PK_MEMBER_TYPES PRIMARY KEY (member_type_id)
);

GRANT SELECT ON member_types TO SOUNZ_REPORTS;

CREATE TABLE memberships (
membership_id        SERIAL               not null,
login_id             INT4                 not null,
member_type_id       INT4                 not null,
expiry_date          TIMESTAMP            null,
pending_payment      BOOL                 not null DEFAULT true,
purchased_date       TIMESTAMP            null,
renewed_date         TIMESTAMP            null,
loan_count           INT4                 null,
CONSTRAINT PK_MEMBERSHIPS PRIMARY KEY (membership_id)
);

CREATE INDEX MEMBERSHIP_LOGIN_FK ON memberships (
login_id
);

CREATE INDEX MEMBERSHIP_MEMBER_TYPE_FK ON memberships (
member_type_id
);

GRANT SELECT ON memberships TO SOUNZ_REPORTS;

CREATE TABLE mime_categories (
mime_category_id     SERIAL               not null,
mime_category_desc   TEXT                 not null,
CONSTRAINT PK_MIME_CATEGORIES PRIMARY KEY (mime_category_id)
);

GRANT SELECT ON mime_categories TO SOUNZ_REPORTS;

CREATE TABLE mime_types (
mime_type_id         SERIAL               not null,
mime_category_id     INT4                 not null,
mime_type_desc       TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_MIME_TYPES PRIMARY KEY (mime_type_id)
);

CREATE INDEX MIMETYPE_CATEGORY_FK ON mime_types (
mime_category_id
);

GRANT SELECT ON mime_types TO SOUNZ_REPORTS;

CREATE TABLE modes (
mode_id              SERIAL               not null,
mode_desc            TEXT                 not null,
CONSTRAINT PK_MODES PRIMARY KEY (mode_id)
);

GRANT SELECT ON modes TO SOUNZ_REPORTS;

CREATE TABLE news_article_attachments (
news_article_attachment_id SERIAL               not null,
media_item_id        INT4                 not null,
news_article_id      INT4                 not null,
attachment_type_id   INT4                 not null,
CONSTRAINT PK_NEWS_ARTICLE_ATTACHMENTS PRIMARY KEY (news_article_attachment_id)
);

CREATE INDEX NEWS_ARTICLE_ATTACHMENT_FK ON news_article_attachments (
news_article_id
);

CREATE INDEX NEWS_ARTICLE_ATT_TYPE_FK ON news_article_attachments (
attachment_type_id
);

CREATE INDEX NEWS_ARTICLE_ATT_MEDIA_FK ON news_article_attachments (
media_item_id
);

GRANT SELECT ON news_article_attachments TO SOUNZ_REPORTS;

CREATE TABLE news_articles (
news_article_id      SERIAL               not null,
status_id            INT4                 not null,
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

CREATE INDEX UPDATED_BY_30_FK ON news_articles (
updated_by
);

CREATE INDEX NEWS_ARTICLE_PUBSTATUS_FK ON news_articles (
status_id
);

GRANT SELECT ON news_articles TO SOUNZ_REPORTS;

CREATE TABLE nomens (
nomen_id             SERIAL               not null,
nomen                TEXT                 null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_NOMENS PRIMARY KEY (nomen_id)
);

GRANT SELECT ON nomens TO SOUNZ_REPORTS;

CREATE TABLE organisation_attachments (
organisation_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
organisation_id      INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_ORGANISATION_ATTACHMENTS PRIMARY KEY (organisation_attachment_id)
);

CREATE INDEX ORGANISATION_ATTACHMENT_FK ON organisation_attachments (
organisation_id
);

CREATE INDEX ORGANISATION_ATT_MEDIA_FK ON organisation_attachments (
media_item_id
);

CREATE INDEX ORG_ATT_TYPE_FK ON organisation_attachments (
attachment_type_id
);

CREATE unique INDEX ORGANISATION_ATTACHMENT_UIX ON organisation_attachments (
organisation_id,
media_item_id
);

GRANT SELECT ON organisation_attachments TO SOUNZ_REPORTS;

CREATE TABLE organisations (
organisation_id      SERIAL               not null,
status_id            INT4                 not null,
organisation_name    TEXT                 not null,
organisation_abbrev  TEXT                 null,
year_of_establishment INT4                 null,
internal_note        TEXT                 null,
legacy4d_identity_code TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_ORGANISATIONS PRIMARY KEY (organisation_id)
);

CREATE INDEX UPDATED_BY_5_FK ON organisations (
updated_by
);

CREATE INDEX ORGANISATIONS_PUBSTATUS_FK ON organisations (
status_id
);

GRANT SELECT ON organisations TO SOUNZ_REPORTS;

CREATE TABLE people (
person_id            SERIAL               not null,
status_id            INT4                 not null,
nomen_id             INT4                 null,
last_name            TEXT                 not null,
first_names          TEXT                 null,
known_as             TEXT                 null,
salutation           TEXT                 null,
variant_name         TEXT                 null,
gender               CHAR(1)              null DEFAULT 'U' 
      CONSTRAINT CKC_GENDER_PEOPLE CHECK (gender is null or ( gender in ('M','F','U') )),
year_of_birth        INT4                 null,
year_of_death        INT4                 null,
deceased             BOOL                 not null DEFAULT false,
apra_member          BOOL                 not null DEFAULT false,
canz_member          BOOL                 not null DEFAULT false,
general_note         TEXT                 null,
internal_note        TEXT                 null,
legacy4d_identity_code TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_PEOPLE PRIMARY KEY (person_id)
);

CREATE INDEX UPDATED_BY_25_FK ON people (
updated_by
);

CREATE INDEX PEOPLE_PUBSTATUS_FK ON people (
status_id
);

CREATE INDEX PERSON_NOMEN_FK ON people (
nomen_id
);

GRANT SELECT ON people TO SOUNZ_REPORTS;

CREATE TABLE person_attachments (
person_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
person_id            INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_PERSON_ATTACHMENTS PRIMARY KEY (person_attachment_id)
);

CREATE INDEX PERSON_ATTACHMENT_FK ON person_attachments (
person_id
);

CREATE INDEX PERSON_ATT_MEDIA_FK ON person_attachments (
media_item_id
);

CREATE INDEX PERSON_ATT_TYPE_FK ON person_attachments (
attachment_type_id
);

CREATE unique INDEX PERSON_ATTACHMENT_UIX ON person_attachments (
person_id,
media_item_id
);

GRANT SELECT ON person_attachments TO SOUNZ_REPORTS;

CREATE TABLE "privileges" (
privilege_id         SERIAL               not null,
privilege_name       TEXT                 not null,
privilege_desc       TEXT                 null,
CONSTRAINT PK_PRIVILEGES PRIMARY KEY (privilege_id)
);

GRANT SELECT ON "privileges" TO SOUNZ_REPORTS;

CREATE TABLE project_team_members (
project_team_member_id SERIAL               not null,
project_id           INT4                 not null,
person_id            INT4                 not null,
manager              BOOL                 not null DEFAULT false,
CONSTRAINT PK_PROJECT_TEAM_MEMBERS PRIMARY KEY (project_team_member_id)
);

CREATE INDEX PROJECT_TMBR_PROJ_FK ON project_team_members (
project_id
);

CREATE INDEX PROJECT_TMBR_PERSON_FK ON project_team_members (
person_id
);

GRANT SELECT ON project_team_members TO SOUNZ_REPORTS;

CREATE TABLE projects (
project_id           SERIAL               not null,
project_status       INT4                 not null DEFAULT 0 
      CONSTRAINT CKC_PROJECT_STATUS_PROJECTS CHECK (project_status in (0,1,2)),
project_title        TEXT                 not null,
project_description  TEXT                 null,
start_date           TIMESTAMP            null,
proposed_finish_date TIMESTAMP            null,
actual_finish_date   TIMESTAMP            null,
internal_note        TEXT                 null,
general_note         TEXT                 null,
for_public_display   BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_PROJECTS PRIMARY KEY (project_id)
);

CREATE INDEX UPDATED_BY_23_FK ON projects (
updated_by
);

GRANT SELECT ON projects TO SOUNZ_REPORTS;

CREATE TABLE prov_composer_bios (
prov_composer_bio_id SERIAL               not null,
status_id            INT4                 not null,
name                 TEXT                 null,
email                TEXT                 null,
date_of_birth        TEXT                 null,
replacing_bio        BOOL                 not null DEFAULT false,
amending_bio         BOOL                 not null DEFAULT false,
bio                  TEXT                 null,
author_or_source     TEXT                 null,
pull_quote           TEXT                 null,
attaching_photo      BOOL                 not null DEFAULT false,
photo_credit         TEXT                 null,
website              TEXT                 null,
awards               TEXT                 null,
publisher_info       TEXT                 null,
use_my_current_works BOOL                 not null DEFAULT false,
selected_works_to_delete TEXT                 null,
selected_works_to_add TEXT                 null,
genres_and_influences TEXT                 null,
influence_maori      BOOL                 not null DEFAULT false,
influence_landscape  BOOL                 not null DEFAULT false,
influence_culture_nz BOOL                 not null DEFAULT false,
influence_culture_pacific BOOL                 not null DEFAULT false,
influence_culture_other BOOL                 not null DEFAULT false,
influence_religion_spirit BOOL                 not null DEFAULT false,
influence_lang_lit   BOOL                 not null DEFAULT false,
influence_perf_or_visual BOOL                 not null DEFAULT false,
influence_politics   BOOL                 not null DEFAULT false,
influence_history    BOOL                 not null DEFAULT false,
influence_maths_science BOOL                 not null DEFAULT false,
influence_none_abstract BOOL                 not null DEFAULT false,
pub_licence_already  BOOL                 not null DEFAULT false,
pub_licence_forms_send BOOL                 not null DEFAULT false,
member_canz          BOOL                 not null DEFAULT false,
member_apra          BOOL                 not null DEFAULT false,
other_contact        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 not null,
CONSTRAINT PK_PROV_COMPOSER_BIOS PRIMARY KEY (prov_composer_bio_id)
);

CREATE INDEX PROV_COMPOSER_BIOS_PUBSTATUS_FK ON prov_composer_bios (
status_id
);

CREATE INDEX PROV_COMPOSER_BIOS_UPDATED_BY_FK ON prov_composer_bios (
submitted_by
);

CREATE TABLE prov_contact_updates (
prov_contact_update_id SERIAL               not null,
status_id            INT4                 not null,
name                 TEXT                 null,
email                TEXT                 null,
new_contact          BOOL                 not null DEFAULT false,
existing_contact     BOOL                 not null DEFAULT false,
nomen_none           BOOL                 not null DEFAULT false,
nomen_mr             BOOL                 not null DEFAULT false,
nomen_ms             BOOL                 not null DEFAULT false,
nomen_mrs            BOOL                 not null DEFAULT false,
nomen_mme            BOOL                 not null DEFAULT false,
nomen_dr             BOOL                 not null DEFAULT false,
nomen_prof           BOOL                 not null DEFAULT false,
nomen_lady           BOOL                 not null DEFAULT false,
nomen_sir            BOOL                 not null DEFAULT false,
nomen_dame           BOOL                 not null DEFAULT false,
nomen_miss           BOOL                 not null DEFAULT false,
job_title            TEXT                 null,
organisation         TEXT                 null,
postal_address       TEXT                 null,
postcode             TEXT                 null,
physical_address     TEXT                 null,
phone_home           TEXT                 null,
phone_work           TEXT                 null,
phone_fax            TEXT                 null,
phone_mobile         TEXT                 null,
website              TEXT                 null,
pref_comm_method_email BOOL                 not null DEFAULT false,
pref_comm_method_phone BOOL                 not null DEFAULT false,
pref_comm_method_fax BOOL                 not null DEFAULT false,
pref_comm_method_post BOOL                 not null DEFAULT false,
other_info           TEXT                 null,
send_sounz_news_email BOOL                 not null DEFAULT false,
send_sounz_events_post BOOL                 not null DEFAULT false,
send_sounz_events_email BOOL                 not null DEFAULT false,
send_sounz_updates   BOOL                 not null DEFAULT false,
send_donor_info      BOOL                 not null DEFAULT false,
send_bequest_info    BOOL                 not null DEFAULT false,
send_sounz_news_post BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 not null,
CONSTRAINT PK_PROV_CONTACT_UPDATES PRIMARY KEY (prov_contact_update_id)
);

CREATE INDEX PROV_CONTACT_UPDATES_PUBSTATUS_FK ON prov_contact_updates (
status_id
);

CREATE INDEX PROV_CONTACT_UPDATES_UPDATED_BY_FK ON prov_contact_updates (
submitted_by
);

CREATE TABLE prov_contributor_profiles (
prov_contributor_profile_id SERIAL               not null,
status_id            INT4                 not null,
name                 TEXT                 null,
email                TEXT                 null,
date_of_est_birth    TEXT                 null,
new_profile          BOOL                 not null DEFAULT false,
updated_profile      BOOL                 not null DEFAULT false,
profile              TEXT                 null,
author_or_source     TEXT                 null,
attaching_photo      BOOL                 null DEFAULT false,
photo_credit         TEXT                 null,
attaching_logo       BOOL                 not null DEFAULT false,
website              TEXT                 null,
awards               TEXT                 null,
other_contact        TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 not null,
CONSTRAINT PK_PROV_CONTRIBUTOR_PROFILES PRIMARY KEY (prov_contributor_profile_id)
);

CREATE INDEX PROV_CONTRIBUTOR_PROFILES_PUBSTATUS_FK ON prov_contributor_profiles (
status_id
);

CREATE INDEX PROV_CONTRIBUTOR_PROFILES_UPDATED_BY_FK ON prov_contributor_profiles (
submitted_by
);

CREATE TABLE prov_events (
prov_event_id        SERIAL               not null,
status_id            INT4                 not null,
name                 TEXT                 null,
email                TEXT                 null,
event_name           TEXT                 null,
type_concert         BOOL                 not null DEFAULT false,
type_seminar         BOOL                 not null DEFAULT false,
type_film            BOOL                 not null DEFAULT false,
type_workshop_reading BOOL                 not null DEFAULT false,
type_dance_performance BOOL                 not null DEFAULT false,
type_exhibition_installation BOOL                 not null DEFAULT false,
type_theatre         BOOL                 not null DEFAULT false,
type_broadcast       BOOL                 not null DEFAULT false,
type_launch          BOOL                 not null DEFAULT false,
type_rehearsal       BOOL                 not null DEFAULT false,
type_pre_concert_talk BOOL                 not null DEFAULT false,
type_opera_musical   BOOL                 not null DEFAULT false,
type_ceremony        BOOL                 not null DEFAULT false,
type_opportunity     BOOL                 not null DEFAULT false,
part_of_conference   BOOL                 not null DEFAULT false,
part_of_festival     BOOL                 not null DEFAULT false,
part_of_tour         BOOL                 not null DEFAULT false,
part_of_season       BOOL                 not null DEFAULT false,
umbrella_event       TEXT                 null,
venue                TEXT                 null,
venue_address        TEXT                 null,
event_start_date     TEXT                 null,
event_start_time     TEXT                 null,
event_finish_date    TEXT                 null,
event_finish_time    TEXT                 null,
presenter            TEXT                 null,
event_notes          TEXT                 null,
composers            TEXT                 null,
performers           TEXT                 null,
booking_email        TEXT                 null,
booking_phone        TEXT                 null,
booking_mobile       TEXT                 null,
booking_fax          TEXT                 null,
booking_note         TEXT                 null,
other_info           TEXT                 null,
attachment_info      TEXT                 null,
booking_website      TEXT                 null,
"work"               TEXT                 null,
send_sounz_news_post BOOL                 not null DEFAULT false,
send_sounz_news_email BOOL                 not null DEFAULT false,
send_sounz_events_post BOOL                 not null DEFAULT false,
send_sounz_events_email BOOL                 not null DEFAULT false,
send_sounz_updates   BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 not null,
CONSTRAINT PK_PROV_EVENTS PRIMARY KEY (prov_event_id)
);

CREATE INDEX PROV_EVENTS_PUBSTATUS_FK ON prov_events (
status_id
);

CREATE INDEX PROV_EVENTS_UPDATED_BY_FK ON prov_events (
submitted_by
);

CREATE TABLE prov_feedbacks (
prov_feedback_id     SERIAL               not null,
status_id            INT4                 not null,
visit_daily          BOOL                 not null DEFAULT false,
visit_weekly         BOOL                 not null DEFAULT false,
visit_monthly        BOOL                 not null DEFAULT false,
visit_as_needed      BOOL                 not null DEFAULT false,
use_educator         BOOL                 not null DEFAULT false,
use_student          BOOL                 not null DEFAULT false,
use_performer        BOOL                 not null DEFAULT false,
use_composer         BOOL                 not null DEFAULT false,
use_conductor        BOOL                 not null DEFAULT false,
use_arts_mgr         BOOL                 not null DEFAULT false,
use_customer         BOOL                 not null DEFAULT false,
use_member           BOOL                 not null DEFAULT false,
use_retailer         BOOL                 not null DEFAULT false,
use_other            BOOL                 not null DEFAULT false,
find_what            BOOL                 not null DEFAULT false,
how_improve_website  TEXT                 null,
how_improve_services TEXT                 null,
how_improve_resources TEXT                 null,
comments             TEXT                 null,
respond_contact      TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 null,
CONSTRAINT PK_PROV_FEEDBACKS PRIMARY KEY (prov_feedback_id)
);

CREATE INDEX PROV_FEEDBACKS_PUBSTATUS_FK ON prov_feedbacks (
status_id
);

CREATE INDEX PROV_FEEDBACKS_UPDATED_BY_FK ON prov_feedbacks (
submitted_by
);

CREATE TABLE prov_work_updates (
prov_work_update_id  SERIAL               not null,
status_id            INT4                 not null,
name                 TEXT                 null,
email                TEXT                 null,
work_title           TEXT                 null,
composed_by          TEXT                 null,
description          TEXT                 null,
instrumentation      TEXT                 null,
work_duration        TEXT                 null,
difficulty_beginner  BOOL                 not null DEFAULT false,
difficulty_intermediate BOOL                 not null DEFAULT false,
difficulty_advanced  BOOL                 not null DEFAULT false,
suitable_for_youth   BOOL                 not null DEFAULT false,
sacred               BOOL                 null DEFAULT false,
year_creation        TEXT                 null,
year_revised         TEXT                 null,
revision_note        TEXT                 null,
contents             TEXT                 null,
commissioning_info   TEXT                 null,
text_info            TEXT                 null,
languages            TEXT                 null,
dedication           TEXT                 null,
programme_note       TEXT                 null,
first_perf_day       TEXT                 null,
first_perf_month     TEXT                 null,
first_perf_year      TEXT                 null,
venue                TEXT                 null,
city                 TEXT                 null,
performers           TEXT                 null,
other_performances   TEXT                 null,
will_lodge_score     BOOL                 not null DEFAULT false,
will_lodge_parts     BOOL                 not null DEFAULT false,
format_pdf           BOOL                 not null DEFAULT false,
format_hardcopy      BOOL                 not null DEFAULT false,
score_sample         TEXT                 null,
for_sale_hardcopy    BOOL                 not null DEFAULT false,
for_sale_download    BOOL                 not null DEFAULT false,
for_hire_parts_only  BOOL                 not null DEFAULT false,
commercial_publish_details TEXT                 null,
will_lodge_recording BOOL                 not null DEFAULT false,
recording_performers TEXT                 null,
recording_date       TEXT                 null,
recording_duration   TEXT                 null,
recording_permission BOOL                 not null DEFAULT false,
pref_sample_in_minutes TEXT                 null,
for_sale_download_licence BOOL                 not null DEFAULT false,
commercial_release_details TEXT                 null,
other_materials      TEXT                 null,
genres_and_influences TEXT                 null,
influence_maori      BOOL                 null DEFAULT false,
influence_landscape  BOOL                 null DEFAULT false,
influence_culture_nz BOOL                 null DEFAULT false,
influence_culture_pacific BOOL                 null DEFAULT false,
influence_culture_other BOOL                 null DEFAULT false,
influence_religion_spirit BOOL                 null DEFAULT false,
influence_perf_or_visual BOOL                 null DEFAULT false,
influence_politics   BOOL                 null DEFAULT false,
influence_history    BOOL                 null DEFAULT false,
influence_maths_science BOOL                 null DEFAULT false,
influence_none_abstract BOOL                 null DEFAULT false,
restriction_info     TEXT                 null,
copyright_owner      TEXT                 null,
other_info           TEXT                 null,
influence_lang_lit   BOOL                 null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
submitted_by         INT4                 not null,
CONSTRAINT PK_PROV_WORK_UPDATES PRIMARY KEY (prov_work_update_id)
);

CREATE INDEX PROV_WORK_UPDATES_PUBSTATUS_FK ON prov_work_updates (
status_id
);

CREATE INDEX FK_PROV_WORK_UPDATES_UPDATED_BY_FK ON prov_work_updates (
submitted_by
);

CREATE TABLE publishing_statuses (
status_id            SERIAL               not null,
status_desc          TEXT                 not null,
CONSTRAINT PK_PUBLISHING_STATUSES PRIMARY KEY (status_id)
);

GRANT SELECT ON publishing_statuses TO SOUNZ_REPORTS;

CREATE TABLE regions (
region_id            SERIAL               not null,
country_id           INT4                 not null,
region_name          TEXT                 not null,
CONSTRAINT PK_REGIONS PRIMARY KEY (region_id)
);

CREATE INDEX REGION_COUNTRY_FK ON regions (
country_id
);

GRANT SELECT ON regions TO SOUNZ_REPORTS;

CREATE TABLE related_communications (
communication_id     INT4                 not null,
com_communication_id INT4                 not null,
CONSTRAINT PK_RELATED_COMMUNICATIONS PRIMARY KEY (communication_id, com_communication_id)
);

CREATE INDEX RELATED_COMMUNICATIONS_FK ON related_communications (
communication_id
);

CREATE INDEX RELATED_COMMUNICATIONS2_FK ON related_communications (
com_communication_id
);

GRANT SELECT ON related_communications TO SOUNZ_REPORTS;

CREATE TABLE related_organisations (
organisation_id      INT4                 not null,
org_organisation_id  INT4                 not null,
related_organisation_id SERIAL               not null,
relationship         TEXT                 null,
CONSTRAINT PK_RELATED_ORGANISATIONS PRIMARY KEY (related_organisation_id)
);

CREATE INDEX RELATED_FROM_ORG_FK ON related_organisations (
organisation_id
);

CREATE INDEX RELATED_TO_ORG_FK ON related_organisations (
org_organisation_id
);

CREATE unique INDEX RELATED_ORG_ORG_UIX ON related_organisations (
organisation_id,
org_organisation_id
);

GRANT SELECT ON related_organisations TO SOUNZ_REPORTS;

CREATE TABLE relationship_types (
relationship_type_id SERIAL               not null,
relationship_type_desc TEXT                 not null,
inverse              INT4                 not null DEFAULT 0,
CONSTRAINT PK_RELATIONSHIP_TYPES PRIMARY KEY (relationship_type_id)
);

GRANT SELECT ON relationship_types TO SOUNZ_REPORTS;

CREATE TABLE relationships (
relationship_id      SERIAL               not null,
entity_type_id       INT4                 not null,
ent_entity_type_id   INT4                 not null,
relationship_notes   TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_RELATIONSHIPS PRIMARY KEY (relationship_id)
);

CREATE INDEX ENTITY_TYPE_A_FK ON relationships (
ent_entity_type_id
);

CREATE INDEX ENTITY_TYPE_B_FK ON relationships (
entity_type_id
);

CREATE INDEX UPDATED_BY_11_FK ON relationships (
updated_by
);

GRANT SELECT ON relationships TO SOUNZ_REPORTS;

CREATE TABLE reserved_items (
reserved_item_id     SERIAL               not null,
item_id              INT4                 not null,
login_id             INT4                 not null,
date_reserved        DATE                 not null,
cancelled            BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
CONSTRAINT PK_RESERVED_ITEMS PRIMARY KEY (reserved_item_id)
);

CREATE INDEX RESERVED_ITEM_ITEM_FK ON reserved_items (
item_id
);

CREATE INDEX RESERVED_ITEM_LOGIN_FK ON reserved_items (
login_id
);

CREATE TABLE resource_access_rights (
resource_access_right_id SERIAL               not null,
access_right_id      INT4                 not null,
resource_id          INT4                 not null,
access_right_source  TEXT                 not null 
      CONSTRAINT CKC_ACCESS_RIGHT_SOUR_RESOURCE CHECK (access_right_source in ('composer','publisher')),
CONSTRAINT PK_RESOURCE_ACCESS_RIGHTS PRIMARY KEY (resource_access_right_id)
);

CREATE INDEX RES_AR_RIGHTS_FK ON resource_access_rights (
access_right_id
);

CREATE INDEX RES_AR_RESOURCE_FK ON resource_access_rights (
resource_id
);

CREATE unique INDEX RES_AR_UIX ON resource_access_rights (
access_right_id,
resource_id,
access_right_source
);

GRANT SELECT ON resource_access_rights TO SOUNZ_REPORTS;

CREATE TABLE resource_attachments (
resource_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
resource_id          INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_RESOURCE_ATTACHMENTS PRIMARY KEY (resource_attachment_id)
);

CREATE INDEX RESOURCE_ATTACHMENT_FK ON resource_attachments (
resource_id
);

CREATE INDEX RESOURCE_ATT_MEDIA_FK ON resource_attachments (
media_item_id
);

CREATE INDEX RESOURCE_ATT_TYPE_FK ON resource_attachments (
attachment_type_id
);

CREATE unique INDEX RESOURCE_ATTACHMENT_UIX ON resource_attachments (
resource_id,
media_item_id
);

GRANT SELECT ON resource_attachments TO SOUNZ_REPORTS;

CREATE TABLE resource_relationships (
resource_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
resource_id          INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_RESOURCE_RELATIONSHIPS PRIMARY KEY (resource_relationship_id)
);

CREATE INDEX RESOURCE_ENTITY_FK ON resource_relationships (
resource_id
);

CREATE INDEX RESOURCE_RELTYPE_FK ON resource_relationships (
relationship_type_id
);

CREATE INDEX RESOURCE_RELATIONSHIP_FK ON resource_relationships (
relationship_id
);

CREATE unique INDEX RESOURCE_RELATIONSHIP_UIX ON resource_relationships (
relationship_id,
relationship_type_id,
resource_id
);

GRANT SELECT ON resource_relationships TO SOUNZ_REPORTS;

CREATE TABLE resource_type_formats (
resource_type_format_id SERIAL               not null,
resource_type_id     INT4                 not null,
format_id            INT4                 not null,
CONSTRAINT PK_RESOURCE_TYPE_FORMATS PRIMARY KEY (resource_type_format_id)
);

CREATE INDEX RES_TYPEFORM_RESOURCE_FK ON resource_type_formats (
resource_type_id
);

CREATE INDEX RES_TYPEFORM_FORRMAT_FK ON resource_type_formats (
format_id
);

GRANT SELECT ON resource_type_formats TO SOUNZ_REPORTS;

CREATE TABLE resource_types (
resource_type_id     SERIAL               not null,
resource_type_desc   TEXT                 not null,
CONSTRAINT PK_RESOURCE_TYPES PRIMARY KEY (resource_type_id)
);

GRANT SELECT ON resource_types TO SOUNZ_REPORTS;

CREATE TABLE resources (
resource_id          SERIAL               not null,
resource_type_id     INT4                 not null,
format_id            INT4                 not null,
status_id            INT4                 not null,
author_note          TEXT                 null,
resource_title       TEXT                 not null,
resource_title_alt   TEXT                 null,
series_title         TEXT                 null,
publication_year     INT4                 null 
      CONSTRAINT CKC_PUBLICATION_YEAR_RESOURCE CHECK (publication_year is null or (publication_year between 0 and 9999 )),
isbn                 TEXT                 null,
ismn                 TEXT                 null,
isrc                 TEXT                 null,
issn                 TEXT                 null,
imprint              TEXT                 null,
copyright            TEXT                 null,
collation            TEXT                 null,
duration             INTERVAL             null,
dedication_note      TEXT                 null,
publisher_note       TEXT                 null,
content_note         TEXT                 null,
general_note         TEXT                 null,
internal_note        TEXT                 null,
resource_code        INT4                 not null,
mw_code              TEXT                 null,
clonable             BOOL                 not null DEFAULT false,
downloadable         BOOL                 not null DEFAULT false,
download_file_name   TEXT                 null,
download_file_name_2 TEXT                 null,
available_for_loan   BOOL                 not null DEFAULT false,
available_for_hire   BOOL                 not null DEFAULT false,
available_for_sale   BOOL                 not null DEFAULT false,
sale_product_id      INT4                 not null DEFAULT 0,
loan_product_id      INT4                 not null DEFAULT 0,
item_cost            NUMERIC              null DEFAULT 0.00,
freight_code         INT4                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_RESOURCES PRIMARY KEY (resource_id)
);

CREATE INDEX RESOURCE_TYPE_FK ON resources (
resource_type_id
);

CREATE INDEX RESOURCE_FORMAT_FK ON resources (
format_id
);

CREATE INDEX UPDATED_BY_17_FK ON resources (
updated_by
);

CREATE INDEX RESOURCES_PUBSTATUS_FK ON resources (
status_id
);

GRANT SELECT ON resources TO SOUNZ_REPORTS;

CREATE TABLE role_categorizations (
role_categorization_id SERIAL               not null,
role_id              INT4                 not null,
marketing_subcategory_id INT4                 not null,
CONSTRAINT PK_ROLE_CATEGORIZATIONS PRIMARY KEY (role_categorization_id)
);

CREATE INDEX ROLE_CATEG_SUBCAT_FK ON role_categorizations (
marketing_subcategory_id
);

CREATE INDEX ROLE_CATEG_ROLE_FK ON role_categorizations (
role_id
);

GRANT SELECT ON role_categorizations TO SOUNZ_REPORTS;

CREATE TABLE role_contactinfos (
role_contactinfo_id  SERIAL               not null,
role_id              INT4                 not null,
contactinfo_id       INT4                 not null,
contactinfo_type     TEXT                 not null 
      CONSTRAINT CKC_CONTACTINFO_TYPE_ROLE_CON CHECK (contactinfo_type in ('postal','physical','billing')),
preferred            BOOL                 not null DEFAULT false,
CONSTRAINT PK_ROLE_CONTACTINFOS PRIMARY KEY (role_contactinfo_id)
);

CREATE INDEX ROLE_CINFO_CINFO_FK ON role_contactinfos (
contactinfo_id
);

CREATE INDEX ROLE_CINFO_ROLE_FK ON role_contactinfos (
role_id
);

CREATE unique INDEX ROLE_CINFO_UIX ON role_contactinfos (
contactinfo_id
);

GRANT SELECT ON role_contactinfos TO SOUNZ_REPORTS;

CREATE TABLE role_relationships (
role_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
role_id              INT4                 not null,
relationship_type_id INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_ROLE_RELATIONSHIPS PRIMARY KEY (role_relationship_id)
);

CREATE INDEX ROLE_RELATIONSHIP_FK ON role_relationships (
relationship_id
);

CREATE INDEX ROLE_RELTYPE_FK ON role_relationships (
relationship_type_id
);

CREATE INDEX ROLE_ENTITY_FK ON role_relationships (
role_id
);

CREATE unique INDEX ROLE_RELATIONSHIP_UIX ON role_relationships (
relationship_id,
relationship_type_id,
role_id
);

GRANT SELECT ON role_relationships TO SOUNZ_REPORTS;

CREATE TABLE role_types (
role_type_id         SERIAL               not null,
role_type_desc       TEXT                 not null,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_ROLE_TYPES PRIMARY KEY (role_type_id)
);

GRANT SELECT ON role_types TO SOUNZ_REPORTS;

CREATE TABLE roles (
role_id              SERIAL               not null,
role_type_id         INT4                 not null,
person_id            INT4                 null,
organisation_id      INT4                 null,
role_title           TEXT                 null,
general_note         TEXT                 null,
archive              BOOL                 not null DEFAULT false,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_ROLES PRIMARY KEY (role_id)
);

CREATE INDEX ROLE_ORGANISATION_FK ON roles (
organisation_id
);

CREATE INDEX ROLE_TYPE_FK ON roles (
role_type_id
);

CREATE INDEX PERSON_ROLE_FK ON roles (
person_id
);

CREATE INDEX UPDATED_BY_29_FK ON roles (
updated_by
);

GRANT SELECT ON roles TO SOUNZ_REPORTS;

CREATE TABLE sample_attachments (
sample_attachment_id SERIAL               not null,
attachment_type_id   INT4                 not null,
media_item_id        INT4                 not null,
sample_id            INT4                 not null,
CONSTRAINT PK_SAMPLE_ATTACHMENTS PRIMARY KEY (sample_attachment_id)
);

CREATE INDEX SAMPLE_ATT_MEDIA_FK ON sample_attachments (
media_item_id
);

CREATE INDEX SAMPLE_ATTACHMENT_FK ON sample_attachments (
sample_id
);

CREATE INDEX SAMPLE_ATT_TYPE_FK ON sample_attachments (
attachment_type_id
);

GRANT SELECT ON sample_attachments TO SOUNZ_REPORTS;

CREATE TABLE samples (
sample_id            SERIAL               not null,
expression_id        INT4                 null,
manifestation_id     INT4                 not null,
status_id            INT4                 not null,
sample_description   TEXT                 null,
sample_copyright     TEXT                 null,
location             TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SAMPLES PRIMARY KEY (sample_id)
);

CREATE INDEX MANIFESTATION_SAMPLE_FK ON samples (
manifestation_id
);

CREATE INDEX UPDATED_BY_14_FK ON samples (
updated_by
);

CREATE INDEX SAMPLES_PUBSTATUS_FK ON samples (
status_id
);

CREATE INDEX SAMPLE_EXPRESSION_FK ON samples (
expression_id
);

GRANT SELECT ON samples TO SOUNZ_REPORTS;

CREATE TABLE saved_contact_lists (
saved_contact_list_id SERIAL               not null,
list_name            TEXT                 not null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SAVED_CONTACT_LISTS PRIMARY KEY (saved_contact_list_id)
);

CREATE INDEX UPDATED_BY_3_FK ON saved_contact_lists (
updated_by
);

GRANT SELECT ON saved_contact_lists TO SOUNZ_REPORTS;

CREATE TABLE saved_role_contactinfos (
saved_role_contactinfo_id SERIAL               not null,
role_contactinfo_id  INT4                 not null,
saved_contact_list_id INT4                 not null,
CONSTRAINT PK_SAVED_ROLE_CONTACTINFOS PRIMARY KEY (saved_role_contactinfo_id)
);

CREATE INDEX SAVED_ROLECINFO_LIST_FK ON saved_role_contactinfos (
saved_contact_list_id
);

CREATE INDEX SAVED_ROLECINFO_CINFO_FK ON saved_role_contactinfos (
role_contactinfo_id
);

GRANT SELECT ON saved_role_contactinfos TO SOUNZ_REPORTS;

CREATE TABLE saved_searches (
search_id            SERIAL               not null,
saved_by_login_id    INT4                 not null,
search_name          TEXT                 not null,
search_data          TEXT                 null,
search_type          TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SAVED_SEARCHES PRIMARY KEY (search_id)
);

CREATE INDEX LOGIN_SAVED_SEARCH_FK ON saved_searches (
updated_by
);

CREATE INDEX UPDATED_BY_21_FK ON saved_searches (
saved_by_login_id
);

GRANT SELECT ON saved_searches TO SOUNZ_REPORTS;

CREATE TABLE settings (
setting_id           SERIAL               not null,
setting_name         TEXT                 not null,
setting_value        TEXT                 not null,
CONSTRAINT PK_SETTINGS PRIMARY KEY (setting_id)
);

GRANT SELECT ON settings TO SOUNZ_REPORTS;

CREATE TABLE sounz_donations (
sounz_donation_id    INT4                 not null DEFAULT nextval('manifestations_manifestation_id_seq'),
sounz_donation_price NUMERIC              not null DEFAULT 0.00,
sounz_donation_description TEXT                 null,
mw_code              TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SOUNZ_DONATIONS PRIMARY KEY (sounz_donation_id)
);

CREATE INDEX DONATION_UPDATED_BY_FK ON sounz_donations (
updated_by
);

CREATE TABLE sounz_services (
sounz_service_id     INT4                 not null DEFAULT nextval('manifestations_manifestation_id_seq'),
member_type_id       INT4                 null,
sounz_service_name   TEXT                 not null,
sounz_service_description TEXT                 null,
sounz_service_price  NUMERIC              not null DEFAULT 0.00,
subscription_duration INTERVAL             null,
zencart_tag          VARCHAR              null,
mw_code              TEXT                 null,
subscription_item_count INT4                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SOUNZ_SERVICES PRIMARY KEY (sounz_service_id)
);

CREATE INDEX UPDATED_BY_31_FK ON sounz_services (
updated_by
);

CREATE INDEX SERVICE_MEMBERTYPE_FK ON sounz_services (
member_type_id
);

CREATE TABLE superwork_relationships (
superwork_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
superwork_id         INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_SUPERWORK_RELATIONSHIPS PRIMARY KEY (superwork_relationship_id)
);

CREATE INDEX SUPERWORK_ENTITY_FK ON superwork_relationships (
superwork_id
);

CREATE INDEX SUPERWORK_RELTYPE_FK ON superwork_relationships (
relationship_type_id
);

CREATE INDEX SUPERWORK_RELATIONSHIP_FK ON superwork_relationships (
relationship_id
);

CREATE unique INDEX SUPERWORK_RELATIONSHIP_UIX ON superwork_relationships (
relationship_id,
relationship_type_id,
superwork_id
);

GRANT SELECT ON superwork_relationships TO SOUNZ_REPORTS;

CREATE TABLE superworks (
superwork_id         SERIAL               not null,
status_id            INT4                 not null,
superwork_title      TEXT                 not null,
superwork_title_alt  TEXT                 null,
source_material_note TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_SUPERWORKS PRIMARY KEY (superwork_id)
);

CREATE INDEX UPDATED_BY_8_FK ON superworks (
updated_by
);

CREATE INDEX SUPERWORKS_PUBSTATUS_FK ON superworks (
status_id
);

GRANT SELECT ON superworks TO SOUNZ_REPORTS;

CREATE TABLE valid_entity_entity_relationships (
id                   SERIAL               not null,
entity_type_from_id  INT4                 not null,
entity_type_to_id    INT4                 not null,
relationship_type_id INT4                 not null,
ruby_method_name     TEXT                 not null,
page_title           TEXT                 not null,
user_maintainable    BOOL                 not null DEFAULT true,
CONSTRAINT PK_VALID_ENTITY_ENTITY_RELATIO PRIMARY KEY (id)
);

CREATE INDEX VEER_ENTITY_TO_INDEX ON valid_entity_entity_relationships (
entity_type_to_id
);

CREATE INDEX VEER_ENTITY_FROM_INDEX ON valid_entity_entity_relationships (
entity_type_from_id
);

CREATE INDEX VEER_ENTITY_REL_TYPE ON valid_entity_entity_relationships (
relationship_type_id
);

GRANT SELECT ON valid_entity_entity_relationships TO SOUNZ_REPORTS;

CREATE TABLE work_access_rights (
work_access_right_id SERIAL               not null,
access_right_id      INT4                 not null,
work_id              INT4                 not null,
access_right_source  TEXT                 not null 
      CONSTRAINT CKC_ACCESS_RIGHT_SOUR_WORK_ACC CHECK (access_right_source in ('composer','publisher')),
CONSTRAINT PK_WORK_ACCESS_RIGHTS PRIMARY KEY (work_access_right_id)
);

CREATE INDEX WORK_AR_WORK_FK ON work_access_rights (
work_id
);

CREATE INDEX WORK_AR_RIGHTS_FK ON work_access_rights (
access_right_id
);

CREATE unique INDEX WORK_AR_UIX ON work_access_rights (
access_right_id,
work_id,
access_right_source
);

GRANT SELECT ON work_access_rights TO SOUNZ_REPORTS;

CREATE TABLE work_attachments (
work_attachment_id   SERIAL               not null,
attachment_type_id   INT4                 not null,
work_id              INT4                 not null,
media_item_id        INT4                 not null,
CONSTRAINT PK_WORK_ATTACHMENTS PRIMARY KEY (work_attachment_id)
);

CREATE INDEX WORK_ATTACHMENT_FK ON work_attachments (
work_id
);

CREATE INDEX WORK_ATT_MEDIA_FK ON work_attachments (
media_item_id
);

CREATE INDEX WORK_ATT_TYPE_FK ON work_attachments (
attachment_type_id
);

CREATE INDEX WORK_ATTACHMENT_UIX ON work_attachments (
work_id,
media_item_id
);

GRANT SELECT ON work_attachments TO SOUNZ_REPORTS;

CREATE TABLE work_categories (
work_category_id     SERIAL               not null,
work_category_desc   TEXT                 not null,
work_category_abbrev TEXT                 not null,
additional           BOOL                 not null DEFAULT false,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_WORK_CATEGORIES PRIMARY KEY (work_category_id)
);

GRANT SELECT ON work_categories TO SOUNZ_REPORTS;

CREATE TABLE work_categorizations (
work_categorization_id SERIAL               not null,
work_subcategory_id  INT4                 not null,
work_id              INT4                 not null,
CONSTRAINT PK_WORK_CATEGORIZATIONS PRIMARY KEY (work_categorization_id)
);

CREATE INDEX WORK_CATEG_WORK_FK ON work_categorizations (
work_id
);

CREATE INDEX WORK_CATEG_SUBCAT_FK ON work_categorizations (
work_subcategory_id
);

GRANT SELECT ON work_categorizations TO SOUNZ_REPORTS;

CREATE TABLE work_relationships (
work_relationship_id SERIAL               not null,
relationship_id      INT4                 not null,
relationship_type_id INT4                 not null,
work_id              INT4                 not null,
is_dominant_entity   BOOL                 not null DEFAULT true,
CONSTRAINT PK_WORK_RELATIONSHIPS PRIMARY KEY (work_relationship_id)
);

CREATE INDEX WORK_ENTITY_FK ON work_relationships (
work_id
);

CREATE INDEX WORK_RELTYPE_FK ON work_relationships (
relationship_type_id
);

CREATE INDEX WORK_RELATIONSHIP_FK ON work_relationships (
relationship_id
);

CREATE unique INDEX WORK_RELATIONSHIP_UIX ON work_relationships (
relationship_id,
relationship_type_id,
work_id
);

GRANT SELECT ON work_relationships TO SOUNZ_REPORTS;

CREATE TABLE work_subcategories (
work_subcategory_id  SERIAL               not null,
work_category_id     INT4                 not null,
work_subcategory_desc TEXT                 not null,
legacy_4d_identity_code TEXT                 not null,
additional           BOOL                 not null DEFAULT false,
display_order        INT4                 not null DEFAULT 0,
CONSTRAINT PK_WORK_SUBCATEGORIES PRIMARY KEY (work_subcategory_id)
);

CREATE INDEX WORK_CAT_SUBCAT_FK ON work_subcategories (
work_category_id
);

GRANT SELECT ON work_subcategories TO SOUNZ_REPORTS;

CREATE TABLE works (
work_id              SERIAL               not null,
work_subcategory_id  INT4                 not null,
superwork_id         INT4                 not null,
status_id            INT4                 not null,
work_title           TEXT                 not null,
work_description     TEXT                 null,
intended_duration    INTERVAL             null,
duration_varies      BOOL                 not null DEFAULT false,
no_duration          BOOL                 not null DEFAULT false,
difficulty           INT4                 null DEFAULT 0 
      CONSTRAINT CKC_DIFFICULTY_WORKS CHECK (difficulty is null or ( difficulty in (0,1,2,3) )),
difficulty_note      TEXT                 null,
applicable_for_youth BOOL                 not null DEFAULT false,
year_of_creation     INT4                 null 
      CONSTRAINT CKC_YEAR_OF_CREATION_WORKS CHECK (year_of_creation is null or (year_of_creation between 0 and 9999 )),
year_of_revision     INT4                 null 
      CONSTRAINT CKC_YEAR_OF_REVISION_WORKS CHECK (year_of_revision is null or (year_of_revision between 0 and 9999 )),
instrumentation      TEXT                 null,
programme_note       TEXT                 null,
text_note            TEXT                 null,
internal_note        TEXT                 null,
dedication_note      TEXT                 null,
commissioned_note    TEXT                 null,
contents_note        TEXT                 null,
iswc_code            TEXT                 null,
legacy_4d_identity_code TEXT                 null,
created_at           TIMESTAMP            not null,
updated_at           TIMESTAMP            not null,
updated_by           INT4                 not null,
CONSTRAINT PK_WORKS PRIMARY KEY (work_id)
);

CREATE INDEX WORK_SUPERWORK_FK ON works (
superwork_id
);

CREATE INDEX UPDATED_BY_9_FK ON works (
updated_by
);

CREATE INDEX WORKS_PUBSTATUS_FK ON works (
status_id
);

CREATE INDEX MAIN_WORK_SUBCATEGORY_FK ON works (
work_subcategory_id
);

GRANT SELECT ON works TO SOUNZ_REPORTS;

ALTER TABLE borrowed_items
   ADD CONSTRAINT fk_BORROWED_BORROWED__ITEMS FOREIGN KEY (item_id)
      REFERENCES items (item_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE borrowed_items
   ADD CONSTRAINT fk_BORROWED_BORROWED__LOGINS FOREIGN KEY (login_id)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE campaign_mailouts
   ADD CONSTRAINT fk_CAMPAIGN_CAMPAIGN__MARKETIN FOREIGN KEY (marketing_campaign_id)
      REFERENCES marketing_campaigns (marketing_campaign_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE campaign_mailouts
   ADD CONSTRAINT fk_updated_by_2 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE cm_content_attachments
   ADD CONSTRAINT fk_CM_CONTE_CM_CONTEN_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE cm_content_attachments
   ADD CONSTRAINT fk_CM_CONTE_CM_CONTEN_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE cm_content_attachments
   ADD CONSTRAINT fk_CM_CONTE_CM_CONTEN_CM_CONTE FOREIGN KEY (cm_content_id)
      REFERENCES cm_contents (cm_content_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE cm_contents
   ADD CONSTRAINT fk_CM_CONTE_CM_CONTEN_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE cm_contents
   ADD CONSTRAINT fk_CM_CONTE_UPDATED_B_LOGINS FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE communications
   ADD CONSTRAINT fk_contact_method FOREIGN KEY (communication_method_id)
      REFERENCES communication_methods (communication_method_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE communications
   ADD CONSTRAINT fk_COMMUNIC_COMMUNICA_ROLES FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE communications
   ADD CONSTRAINT fk_contact_type FOREIGN KEY (communication_type_id)
      REFERENCES communication_types (communication_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE communications
   ADD CONSTRAINT fk_updated_by_22 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concept_relationships
   ADD CONSTRAINT fk_CONCEPT__CONCEPT_E_CONCEPTS FOREIGN KEY (concept_id)
      REFERENCES concepts (concept_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concept_relationships
   ADD CONSTRAINT fk_concept_relationship2 FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concept_relationships
   ADD CONSTRAINT fk_concept_relationship3 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concepts
   ADD CONSTRAINT fk_CONCEPTS_CONCEPT_T_CONCEPT_ FOREIGN KEY (concept_type_id)
      REFERENCES concept_types (concept_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concepts
   ADD CONSTRAINT fk_CONCEPTS_PARENT_CO_CONCEPTS FOREIGN KEY (parent_concept_id)
      REFERENCES concepts (concept_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE concepts
   ADD CONSTRAINT fk_updated_by_13 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contactinfos
   ADD CONSTRAINT fk_CONTACTI_CONTACTIN_COUNTRIE FOREIGN KEY (country_id)
      REFERENCES countries (country_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE contactinfos
   ADD CONSTRAINT fk_CONTACTI_CONTACTIN_REGIONS FOREIGN KEY (region_id)
      REFERENCES regions (region_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contactinfos
   ADD CONSTRAINT fk_CONTACTI_PREFERRED_COMMUNIC FOREIGN KEY (preferred_comm_method)
      REFERENCES communication_methods (communication_method_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE contactinfos
   ADD CONSTRAINT fk_updated_by_20 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributor_attachments
   ADD CONSTRAINT fk_CONTRIBU_CONTRIB_A_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributor_attachments
   ADD CONSTRAINT fk_CONTRIBU_CONTRIBUT_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributor_attachments
   ADD CONSTRAINT fk_CONTRIBU_CONTRIBUT_CONTRIBU FOREIGN KEY (contributor_id)
      REFERENCES contributors (contributor_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributors
   ADD CONSTRAINT fk_contributor_role FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributors
   ADD CONSTRAINT fk_CONTRIBU_CONTRIBUT_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE contributors
   ADD CONSTRAINT fk_updated_by_7 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE controller_restrictions
   ADD CONSTRAINT fk_CONTROLL_CONTROLLE_PRIVILEG FOREIGN KEY (privilege_id)
      REFERENCES "privileges" (privilege_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE controller_restrictions
   ADD CONSTRAINT fk_CONTROLL_CONTROLLE_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE default_contactinfos
   ADD CONSTRAINT fk_def_cinfo_default FOREIGN KEY (d_contactinfo_id)
      REFERENCES contactinfos (contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE default_contactinfos
   ADD CONSTRAINT fk_def_cinfo_master FOREIGN KEY (contactinfo_id)
      REFERENCES contactinfos (contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_instances
   ADD CONSTRAINT fk_DISTINCT_DISTINCIN_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_instances
   ADD CONSTRAINT fk_distinction_inst_event FOREIGN KEY (event_id)
      REFERENCES events (event_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_instances
   ADD CONSTRAINT fk_distinction_instance FOREIGN KEY (distinction_id)
      REFERENCES distinctions (distinction_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_instances
   ADD CONSTRAINT fk_distinction_inst_role FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_instances
   ADD CONSTRAINT updated_by_18 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_relationships
   ADD CONSTRAINT fk_distinction_relationship3 FOREIGN KEY (distinction_instance_id)
      REFERENCES distinction_instances (distinction_instance_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_relationships
   ADD CONSTRAINT fk_distinction_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinction_relationships
   ADD CONSTRAINT fk_distinction_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinctions
   ADD CONSTRAINT fk_DISTINCT_DISTINCTI_CONTACTI FOREIGN KEY (contactinfo_id)
      REFERENCES contactinfos (contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinctions
   ADD CONSTRAINT fk_DISTINCT_DISTINCTI_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE distinctions
   ADD CONSTRAINT fk_updated_by_19 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE entity_relationship_types
   ADD CONSTRAINT fk_ENTITY_R_ENTITY_RE_RELATION FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE entity_relationship_types
   ADD CONSTRAINT fk_ENTITY_R_ENTITY_RE_ENTITY_T FOREIGN KEY (entity_type_id)
      REFERENCES entity_types (entity_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_attachments
   ADD CONSTRAINT fk_EVENT_AT_EVENT_ATT_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_attachments
   ADD CONSTRAINT fk_EVENT_AT_EVENT_ATT_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_attachments
   ADD CONSTRAINT fk_EVENT_AT_EVENT_ATT_EVENTS FOREIGN KEY (event_id)
      REFERENCES events (event_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_relationships
   ADD CONSTRAINT fk_EVENT_RE_EVENT_ENT_EVENTS FOREIGN KEY (event_id)
      REFERENCES events (event_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_relationships
   ADD CONSTRAINT fk_event_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE event_relationships
   ADD CONSTRAINT fk_event_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE events
   ADD CONSTRAINT fk_EVENTS_EVENT_CON_CONTACTI FOREIGN KEY (contactinfo_id)
      REFERENCES contactinfos (contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE events
   ADD CONSTRAINT fk_EVENTS_EVENT_TYP_EVENT_TY FOREIGN KEY (event_type_id)
      REFERENCES event_types (event_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE events
   ADD CONSTRAINT fk_EVENTS_EVENTS_PU_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE events
   ADD CONSTRAINT fk_EVENTS_PARENT_EV_EVENTS FOREIGN KEY (related_event_id)
      REFERENCES events (event_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE events
   ADD CONSTRAINT fk_updated_by_16 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE exam_set_works
   ADD CONSTRAINT fk_EXAM_SET_EXAM_SET__MANIFEST FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE exam_set_works
   ADD CONSTRAINT fk_EXAM_SET_SETWORK_E_EXAMBOAR FOREIGN KEY (examboard_id)
      REFERENCES examboards (examboard_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_access_rights
   ADD CONSTRAINT fk_EXPRESSI_EXPR_AR_E_EXPRESSI FOREIGN KEY (expression_id)
      REFERENCES expressions (expression_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_access_rights
   ADD CONSTRAINT fk_EXPRESSI_EXPR_AR_R_ACCESS_R FOREIGN KEY (access_right_id)
      REFERENCES access_rights (access_right_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_languages
   ADD CONSTRAINT fk_expression_lang_expression FOREIGN KEY (expression_id)
      REFERENCES expressions (expression_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_languages
   ADD CONSTRAINT fk_expression_lang_lang FOREIGN KEY (language_id)
      REFERENCES languages (language_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE expression_manifestations
   ADD CONSTRAINT fk_expression_manifestation FOREIGN KEY (expression_id)
      REFERENCES expressions (expression_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE expression_manifestations
   ADD CONSTRAINT fk_EXPRESSI_MANIFESTA_MANIFEST FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE expression_relationships
   ADD CONSTRAINT fk_expression_entity FOREIGN KEY (expression_id)
      REFERENCES expressions (expression_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_relationships
   ADD CONSTRAINT fk_expression_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expression_relationships
   ADD CONSTRAINT fk_expression_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expressions
   ADD CONSTRAINT fk_EXPRESSI_EXPRESSIO_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expressions
   ADD CONSTRAINT fk_EXPRESSI_MODE_OF_E_MODES FOREIGN KEY (mode_id)
      REFERENCES modes (mode_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expressions
   ADD CONSTRAINT fk_updated_by_10 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE expressions
   ADD CONSTRAINT fk_EXPRESSI_WORK_EXPR_WORKS FOREIGN KEY (work_id)
      REFERENCES works (work_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE items
   ADD CONSTRAINT fk_ITEMS_ITEM_TYPE_ITEM_TYP FOREIGN KEY (item_type_id)
      REFERENCES item_types (item_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE items
   ADD CONSTRAINT fk_ITEMS_ITEMS_PUB_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE items
   ADD CONSTRAINT fk_ITEMS_MANIFESTA_MANIFEST FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE items
   ADD CONSTRAINT fk_ITEMS_RESOURCE__RESOURCE FOREIGN KEY (resource_id)
      REFERENCES resources (resource_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE items
   ADD CONSTRAINT fk_updated_by_28 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE logins
   ADD CONSTRAINT fk_LOGINS_ORG_LOGIN_ORGANISA FOREIGN KEY (organisation_id)
      REFERENCES organisations (organisation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE logins
   ADD CONSTRAINT fk_LOGINS_PERSON_LO_PEOPLE FOREIGN KEY (person_id)
      REFERENCES people (person_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE logins
   ADD CONSTRAINT fk_updated_by_27 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_attachments
   ADD CONSTRAINT fk_MAILOUT__MAILOUT_A_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_attachments
   ADD CONSTRAINT fk_MAILOUT__MAILOUT_A_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_attachments
   ADD CONSTRAINT fk_MAILOUT__MAILOUT_A_CAMPAIGN FOREIGN KEY (campaign_mailout_id)
      REFERENCES campaign_mailouts (campaign_mailout_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_contacts
   ADD CONSTRAINT fk_MAILOUT__MAILOUT_C_CAMPAIGN FOREIGN KEY (campaign_mailout_id)
      REFERENCES campaign_mailouts (campaign_mailout_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_contacts
   ADD CONSTRAINT fk_MAILOUT__MAILOUT_R_ROLE_CON FOREIGN KEY (role_contactinfo_id)
      REFERENCES role_contactinfos (role_contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mailout_contacts
   ADD CONSTRAINT updated_by_1 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_access_rights
   ADD CONSTRAINT fk_MANIFEST_MANIF_AR__MANIFEST FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_access_rights
   ADD CONSTRAINT fk_MANIFEST_MANIF_AR__ACCESS_R FOREIGN KEY (access_right_id)
      REFERENCES access_rights (access_right_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_attachments
   ADD CONSTRAINT fk_MANIFEST_MANIFESTA_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_attachments
   ADD CONSTRAINT fk_MANIFEST_MANIFESTA_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_attachments
   ADD CONSTRAINT fk_manifestation_attachment FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_relationships
   ADD CONSTRAINT fk_manifestation_relationship3 FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_relationships
   ADD CONSTRAINT fk_manifestation_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_relationships
   ADD CONSTRAINT fk_manifestation_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestation_type_formats
   ADD CONSTRAINT fk_MANIFEST_MANIF_TYP_FORMATS FOREIGN KEY (format_id)
      REFERENCES formats (format_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE manifestation_type_formats
   ADD CONSTRAINT fk_MANIFEST_MANIF_TYP_MANIFEST FOREIGN KEY (manifestation_type_id)
      REFERENCES manifestation_types (manifestation_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE manifestations
   ADD CONSTRAINT fk_MANIFEST_MANIFESTA_FORMATS FOREIGN KEY (format_id)
      REFERENCES formats (format_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestations
   ADD CONSTRAINT fk_MANIFEST_MANIFESTA_MANIFEST FOREIGN KEY (manifestation_type_id)
      REFERENCES manifestation_types (manifestation_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE manifestations
   ADD CONSTRAINT fk_MANIFEST_MANIFESTA_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE manifestations
   ADD CONSTRAINT fk_updated_by_12 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE marketing_campaigns
   ADD CONSTRAINT fk_MARKETIN_CAMPAIGN__MGR FOREIGN KEY (campaign_manager)
      REFERENCES project_team_members (project_team_member_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE marketing_campaigns
   ADD CONSTRAINT fk_MARKETIN_PROJECT_C_PROJECTS FOREIGN KEY (project_id)
      REFERENCES projects (project_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE marketing_campaigns
   ADD CONSTRAINT fk_updated_by_24 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE marketing_subcategories
   ADD CONSTRAINT fk_MARKETIN_MARKETING_MARKETIN FOREIGN KEY (marketing_category_id)
      REFERENCES marketing_categories (marketing_category_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE media_items
   ADD CONSTRAINT fk_MEDIA_IT_MEDIA_ITE_MIME_TYP FOREIGN KEY (mime_type_id)
      REFERENCES mime_types (mime_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE media_items
   ADD CONSTRAINT fk_MEDIA_IT_PARENT_ME_MEDIA_IT FOREIGN KEY (parent_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE media_items
   ADD CONSTRAINT fk_updated_by_6 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE member_type_privileges
   ADD CONSTRAINT fk_MEMBER_T_MEMTYPE_P_PRIVILEG FOREIGN KEY (privilege_id)
      REFERENCES "privileges" (privilege_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE member_type_privileges
   ADD CONSTRAINT fk_MEMBER_T_MEMTYPE_P_MEMBER_T FOREIGN KEY (member_type_id)
      REFERENCES member_types (member_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE memberships
   ADD CONSTRAINT fk_MEMBERSH_MEMBERSHI_LOGINS FOREIGN KEY (login_id)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE memberships
   ADD CONSTRAINT fk_MEMBERSH_MEMBERSHI_MEMBER_T FOREIGN KEY (member_type_id)
      REFERENCES member_types (member_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE mime_types
   ADD CONSTRAINT fk_MIME_TYP_MIMETYPE__MIME_CAT FOREIGN KEY (mime_category_id)
      REFERENCES mime_categories (mime_category_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE news_article_attachments
   ADD CONSTRAINT fk_NEWS_ART_NEWS_ARTI_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE news_article_attachments
   ADD CONSTRAINT fk_NEWS_ART_NEWS_ARTI_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE news_article_attachments
   ADD CONSTRAINT fk_NEWS_ART_NEWS_ARTI_NEWS_ART FOREIGN KEY (news_article_id)
      REFERENCES news_articles (news_article_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE news_articles
   ADD CONSTRAINT news_article_pubstatus_fk FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE news_articles
   ADD CONSTRAINT fk_NEWS_ART_UPDATED_B_LOGINS FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE organisation_attachments
   ADD CONSTRAINT fk_ORGANISA_ORG_ATT_T_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE organisation_attachments
   ADD CONSTRAINT fk_ORGANISA_ORGANISAT_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE organisation_attachments
   ADD CONSTRAINT fk_ORGANISA_ORGANISAT_ORGANISA FOREIGN KEY (organisation_id)
      REFERENCES organisations (organisation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE organisations
   ADD CONSTRAINT fk_ORGANISA_ORGANISAT_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE organisations
   ADD CONSTRAINT fk_updated_by_5 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE people
   ADD CONSTRAINT fk_PEOPLE_PEOPLE_PU_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE people
   ADD CONSTRAINT fk_PEOPLE_PERSON_NO_NOMENS FOREIGN KEY (nomen_id)
      REFERENCES nomens (nomen_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE people
   ADD CONSTRAINT fk_updated_by_25 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE person_attachments
   ADD CONSTRAINT fk_PERSON_A_PERSON_AT_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE person_attachments
   ADD CONSTRAINT fk_PERSON_A_PERSON_AT_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE person_attachments
   ADD CONSTRAINT fk_PERSON_A_PERSON_AT_PEOPLE FOREIGN KEY (person_id)
      REFERENCES people (person_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE project_team_members
   ADD CONSTRAINT fk_PROJECT__PROJECT_T_PEOPLE FOREIGN KEY (person_id)
      REFERENCES people (person_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE project_team_members
   ADD CONSTRAINT fk_PROJECT__PROJECT_T_PROJECTS FOREIGN KEY (project_id)
      REFERENCES projects (project_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE projects
   ADD CONSTRAINT fk_updated_by_23 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_composer_bios
   ADD CONSTRAINT fk_prov_composer_bios_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_composer_bios
   ADD CONSTRAINT fk_prov_composer_bios_submitted_by FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_contact_updates
   ADD CONSTRAINT fk_prov_contact_updates_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_contact_updates
   ADD CONSTRAINT fk_prov_contact_updates_submitted_by FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_contributor_profiles
   ADD CONSTRAINT fk_prov_contributor_profiles_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_contributor_profiles
   ADD CONSTRAINT fk_prov_contributor_profiles_submitted_by FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_events
   ADD CONSTRAINT fk_prov_events_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_events
   ADD CONSTRAINT fk_prov_events_submitted_by FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_feedbacks
   ADD CONSTRAINT fk_prov_feedbacks_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_feedbacks
   ADD CONSTRAINT fk_prov_feedbacks_submitted_by FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_work_updates
   ADD CONSTRAINT fk_PROV_WOR_FK_PROV_W_LOGINS FOREIGN KEY (submitted_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE prov_work_updates
   ADD CONSTRAINT fk_prov_work_updates_pubstatus FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE regions
   ADD CONSTRAINT fk_REGIONS_REGION_CO_COUNTRIE FOREIGN KEY (country_id)
      REFERENCES countries (country_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE related_communications
   ADD CONSTRAINT fk_related_communication FOREIGN KEY (communication_id)
      REFERENCES communications (communication_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE related_communications
   ADD CONSTRAINT fk_related_communication2 FOREIGN KEY (com_communication_id)
      REFERENCES communications (communication_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE related_organisations
   ADD CONSTRAINT fk_related_org2 FOREIGN KEY (organisation_id)
      REFERENCES organisations (organisation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE related_organisations
   ADD CONSTRAINT fk_related_org FOREIGN KEY (org_organisation_id)
      REFERENCES organisations (organisation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE relationships
   ADD CONSTRAINT fk_entity_type_a FOREIGN KEY (ent_entity_type_id)
      REFERENCES entity_types (entity_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE relationships
   ADD CONSTRAINT fk_entity_type_b FOREIGN KEY (entity_type_id)
      REFERENCES entity_types (entity_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE relationships
   ADD CONSTRAINT fk_updated_by_11 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE reserved_items
   ADD CONSTRAINT fk_RESERVED_RESERVED__ITEMS FOREIGN KEY (item_id)
      REFERENCES items (item_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE reserved_items
   ADD CONSTRAINT fk_RESERVED_RESERVED__LOGINS FOREIGN KEY (login_id)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE resource_access_rights
   ADD CONSTRAINT fk_RESOURCE_RES_AR_RE_RESOURCE FOREIGN KEY (resource_id)
      REFERENCES resources (resource_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_access_rights
   ADD CONSTRAINT fk_RESOURCE_RES_AR_RI_ACCESS_R FOREIGN KEY (access_right_id)
      REFERENCES access_rights (access_right_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_attachments
   ADD CONSTRAINT fk_RESOURCE_RESOURCE__MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_attachments
   ADD CONSTRAINT fk_RESOURCE_RESOURCE__ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_attachments
   ADD CONSTRAINT fk_RESOURCE_RESOURCE__RESOURCE FOREIGN KEY (resource_id)
      REFERENCES resources (resource_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_relationships
   ADD CONSTRAINT fk_resource_relationship3 FOREIGN KEY (resource_id)
      REFERENCES resources (resource_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_relationships
   ADD CONSTRAINT fk_resource_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_relationships
   ADD CONSTRAINT fk_resource_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resource_type_formats
   ADD CONSTRAINT fk_RESOURCE_RES_TYPEF_FORMATS FOREIGN KEY (format_id)
      REFERENCES formats (format_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE resource_type_formats
   ADD CONSTRAINT fk_RESOURCE_RES_TYPEF_RESOURCE FOREIGN KEY (resource_type_id)
      REFERENCES resource_types (resource_type_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE resources
   ADD CONSTRAINT fk_RESOURCE_RESOURCE__FORMATS FOREIGN KEY (format_id)
      REFERENCES formats (format_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resources
   ADD CONSTRAINT fk_resource_type FOREIGN KEY (resource_type_id)
      REFERENCES resource_types (resource_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resources
   ADD CONSTRAINT fk_RESOURCE_RESOURCES_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE resources
   ADD CONSTRAINT fk_updated_by_17 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_categorizations
   ADD CONSTRAINT fk_ROLE_CAT_ROLE_CATE_ROLES FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE role_categorizations
   ADD CONSTRAINT fk_ROLE_CAT_ROLE_CATE_MARKETIN FOREIGN KEY (marketing_subcategory_id)
      REFERENCES marketing_subcategories (marketing_subcategory_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_contactinfos
   ADD CONSTRAINT fk_role_cinfo_cinfo FOREIGN KEY (contactinfo_id)
      REFERENCES contactinfos (contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_contactinfos
   ADD CONSTRAINT fk_role_cinfo_role FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_relationships
   ADD CONSTRAINT fk_contributor_relationship2 FOREIGN KEY (role_id)
      REFERENCES roles (role_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_relationships
   ADD CONSTRAINT fk_contributor_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE role_relationships
   ADD CONSTRAINT fk_contributor_relationship3 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE roles
   ADD CONSTRAINT fk_role_person FOREIGN KEY (person_id)
      REFERENCES people (person_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE roles
   ADD CONSTRAINT fk_role_org FOREIGN KEY (organisation_id)
      REFERENCES organisations (organisation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE roles
   ADD CONSTRAINT fk_ROLES_ROLE_TYPE_ROLE_TYP FOREIGN KEY (role_type_id)
      REFERENCES role_types (role_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE roles
   ADD CONSTRAINT fk_ROLES_UPDATED_B_LOGINS FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE sample_attachments
   ADD CONSTRAINT fk_SAMPLE_A_SAMPLE_AT_MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE sample_attachments
   ADD CONSTRAINT fk_SAMPLE_A_SAMPLE_AT_ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE sample_attachments
   ADD CONSTRAINT fk_SAMPLE_A_SAMPLE_AT_SAMPLES FOREIGN KEY (sample_id)
      REFERENCES samples (sample_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE samples
   ADD CONSTRAINT fk_SAMPLES_MANIFESTA_MANIFEST FOREIGN KEY (manifestation_id)
      REFERENCES manifestations (manifestation_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE samples
   ADD CONSTRAINT fk_sample_expression FOREIGN KEY (expression_id)
      REFERENCES expressions (expression_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE samples
   ADD CONSTRAINT fk_SAMPLES_SAMPLES_P_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE samples
   ADD CONSTRAINT fk_updated_by_14 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE saved_contact_lists
   ADD CONSTRAINT fk_updated_by_3 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE saved_role_contactinfos
   ADD CONSTRAINT fk_saved_rolecinfo_cinfo FOREIGN KEY (role_contactinfo_id)
      REFERENCES role_contactinfos (role_contactinfo_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE saved_role_contactinfos
   ADD CONSTRAINT fk_saved_rolecinfo_list FOREIGN KEY (saved_contact_list_id)
      REFERENCES saved_contact_lists (saved_contact_list_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE saved_searches
   ADD CONSTRAINT fk_updated_by_21 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE saved_searches
   ADD CONSTRAINT fk_saved_by_login_id FOREIGN KEY (saved_by_login_id)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE sounz_donations
   ADD CONSTRAINT fk_sounz_donations_updated_by FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE sounz_services
   ADD CONSTRAINT service_membertype_fk FOREIGN KEY (member_type_id)
      REFERENCES member_types (member_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE sounz_services
   ADD CONSTRAINT fk_sounz_services_updated_by FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE superwork_relationships
   ADD CONSTRAINT fk_SUPERWOR_SUPERWORK_SUPERWOR FOREIGN KEY (superwork_id)
      REFERENCES superworks (superwork_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE superwork_relationships
   ADD CONSTRAINT fk_superwork_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE superwork_relationships
   ADD CONSTRAINT fk_superwork_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE superworks
   ADD CONSTRAINT fk_SUPERWOR_SUPERWORK_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE superworks
   ADD CONSTRAINT fk_updated_by_8 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE valid_entity_entity_relationships
   ADD CONSTRAINT fk_veer_entitytype_from FOREIGN KEY (entity_type_from_id)
      REFERENCES entity_types (entity_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE valid_entity_entity_relationships
   ADD CONSTRAINT fk_veer_entitytype_to FOREIGN KEY (entity_type_to_id)
      REFERENCES entity_types (entity_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE valid_entity_entity_relationships
   ADD CONSTRAINT fk_veer_relationshiptype FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_access_rights
   ADD CONSTRAINT fk_WORK_ACC_WORK_AR_R_ACCESS_R FOREIGN KEY (access_right_id)
      REFERENCES access_rights (access_right_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_access_rights
   ADD CONSTRAINT fk_WORK_ACC_WORK_AR_W_WORKS FOREIGN KEY (work_id)
      REFERENCES works (work_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_attachments
   ADD CONSTRAINT fk_WORK_ATT_WORK_ATT__MEDIA_IT FOREIGN KEY (media_item_id)
      REFERENCES media_items (media_item_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_attachments
   ADD CONSTRAINT fk_WORK_ATT_WORK_ATT__ATTACHME FOREIGN KEY (attachment_type_id)
      REFERENCES attachment_types (attachment_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_attachments
   ADD CONSTRAINT fk_WORK_ATT_WORK_ATTA_WORKS FOREIGN KEY (work_id)
      REFERENCES works (work_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_categorizations
   ADD CONSTRAINT fk_WORK_CAT_WORK_CATE_WORK_SUB FOREIGN KEY (work_subcategory_id)
      REFERENCES work_subcategories (work_subcategory_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE work_categorizations
   ADD CONSTRAINT fk_WORK_CAT_WORK_CATE_WORKS FOREIGN KEY (work_id)
      REFERENCES works (work_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE work_relationships
   ADD CONSTRAINT fk_WORK_REL_WORK_ENTI_WORKS FOREIGN KEY (work_id)
      REFERENCES works (work_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_relationships
   ADD CONSTRAINT fk_work_relationship FOREIGN KEY (relationship_id)
      REFERENCES relationships (relationship_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_relationships
   ADD CONSTRAINT fk_work_relationship2 FOREIGN KEY (relationship_type_id)
      REFERENCES relationship_types (relationship_type_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE work_subcategories
   ADD CONSTRAINT fk_WORK_SUB_WORK_CAT__WORK_CAT FOREIGN KEY (work_category_id)
      REFERENCES work_categories (work_category_id)
      ON DELETE restrict ON UPDATE restrict;

ALTER TABLE works
   ADD CONSTRAINT fk_WORKS_MAIN_WORK_WORK_SUB FOREIGN KEY (work_subcategory_id)
      REFERENCES work_subcategories (work_subcategory_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE works
   ADD CONSTRAINT fk_updated_by_9 FOREIGN KEY (updated_by)
      REFERENCES logins (login_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE works
   ADD CONSTRAINT fk_WORKS_WORK_SUPE_SUPERWOR FOREIGN KEY (superwork_id)
      REFERENCES superworks (superwork_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE works
   ADD CONSTRAINT fk_WORKS_WORKS_PUB_PUBLISHI FOREIGN KEY (status_id)
      REFERENCES publishing_statuses (status_id)
      ON DELETE restrict ON UPDATE restrict
      DEFERRABLE INITIALLY DEFERRED;

