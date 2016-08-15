-- Patch for SOUNZ database upgrade
-- 1.16.0 to 1.17.0
--

BEGIN;

CREATE SEQUENCE distinction_types_distinction_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE distinction_types (
    distinction_type_id integer DEFAULT nextval('distinction_types_distinction_type_id_seq'::regclass) NOT NULL,
    distinction_type_name text NOT NULL,
    distinction_type_desc text
);

CREATE SEQUENCE distinction_distinction_types_distinction_distinction_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE distinction_distinction_types (
    distinction_distinction_type_id integer DEFAULT nextval('distinction_distinction_types_distinction_distinction_type_id_seq'::regclass) NOT NULL,
    distinction_id integer NOT NULL,
    distinction_type_id integer NOT NULL
);

ALTER TABLE ONLY distinction_types
    ADD CONSTRAINT pk_distinction_types PRIMARY KEY (distinction_type_id);

ALTER TABLE ONLY distinction_distinction_types
    ADD CONSTRAINT pk_distinction_distinction_types PRIMARY KEY (distinction_distinction_type_id);

CREATE INDEX distincti_distincti_types_distincti_fk ON distinction_distinction_types USING btree (distinction_id);

CREATE INDEX distincti_distincti_types_distincti_type_fk ON distinction_distinction_types USING btree (distinction_type_id);

ALTER TABLE ONLY distinction_distinction_types
    ADD CONSTRAINT fk_distincti_distincti_types_distincti FOREIGN KEY (distinction_id) REFERENCES distinctions(distinction_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY distinction_distinction_types
    ADD CONSTRAINT fk_distincti_distincti_types_distincti_type FOREIGN KEY (distinction_type_id) REFERENCES distinction_types(distinction_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;

-- distinction_types data as listed in DISTINCTIONS rev 300308.doc of WR#50294
INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Award', 'includes Fellowhips');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Residency', 'including composer exchanges etc');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Prize', 'Awarded through competitive process');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Commission', 'competive commission - eg SOUNZ Community Commission');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Performance', 'chosen through competitive / submission process for a particular performance / broadcast opportunity');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Recording', 'chosen through competitive submission process for a particular recording/CD opportunity');

INSERT INTO distinction_types (distinction_type_name, distinction_type_desc) VALUES ('Publication', 'chosen through competitive submission process for a particular recording/CD opportunity');

UPDATE zencartconfiguration SET configuration_value = 
  (SELECT countries_id FROM sounz_zencart_countries WHERE countries_name = 'New Zealand') 
    WHERE configuration_key = 'STORE_COUNTRY';

-- WR#51731 - titles for CM pages
ALTER TABLE cm_contents ADD COLUMN cm_page_title TEXT;

UPDATE cm_contents SET cm_page_title = 'About SOUNZ - Centre for NZ Music' 
  WHERE cm_content_name = 'about';

UPDATE cm_contents SET cm_page_title = 'Contact SOUNZ - Centre for NZ Music' 
  WHERE cm_content_name = 'contact';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - NZ Music projects' 
  WHERE cm_content_name = 'projects';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - NZ Music Membership' 
  WHERE cm_content_name = 'membership';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - NZ Music Community' 
  WHERE cm_content_name = 'community';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Terms and Conditions' 
  WHERE cm_content_name = 'General_terms';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - Terms and Conditions' 
  WHERE cm_content_name = 'ONLINE_terms';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - Terms and Conditions' 
  WHERE cm_content_name = 'LIBRARY_terms';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - NZ Music Links' 
  WHERE cm_content_name = 'links';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - SOUNZ Contemporary Award' 
  WHERE cm_content_name = 'SOUNZ_Contempy';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - NZSO-SOUNZ Readings' 
  WHERE cm_content_name = 'project_readings';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - SOUNZfine promotional CDs' 
  WHERE cm_content_name = 'SOUNZfine';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - Trans-Tasman Composer Exchange' 
  WHERE cm_content_name = 'Tr_Tasmn';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - SOUNZ Community Commission' 
  WHERE cm_content_name = 'Comm_Comm';

UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - SOUNZwrite Education Guides' 
  WHERE cm_content_name = 'SOUNZwrite';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - NZCT Chamber Contest - SOUNZ Prize' 
  WHERE cm_content_name = 'Chamber_Music';
  
UPDATE cm_contents SET cm_page_title = 'SOUNZ - Project - The BIG SING - NZCF Composition Competition' 
  WHERE cm_content_name = 'BIG_SING';
  
-- WR#50291 - changed the page title of distinctions to 'Awards'
UPDATE valid_entity_entity_relationships SET page_title = 'Awards' WHERE page_title = 'Distinctions';


COMMIT;