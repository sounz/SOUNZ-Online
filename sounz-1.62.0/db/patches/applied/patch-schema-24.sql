----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 27/10/2007 17:20:47
--
-- Instructions:
-- apply this script to target database diffsounz, This will then
-- make it identical to the reference database, diffsounz-new.
--
-- This update patch defines the PROVIDER tables.
----------------------------------------------------------------------------

BEGIN;

-- CREATING NEW TABLE prov_composer_bios
create table prov_composer_bios (
  "prov_composer_bio_id" serial not null,
  "status_id" int4 not null,
  "name" text,
  "email" text,
  "date_of_birth" text,
  "replacing_bio" bool not null default false,
  "amending_bio" bool not null default false,
  "bio" text,
  "author_or_source" text,
  "pull_quote" text,
  "attaching_photo" bool not null default false,
  "photo_credit" text,
  "website" text,
  "awards" text,
  "publisher_info" text, 
  "use_my_current_works" bool not null default false,
  "selected_works_to_delete" text,
  "selected_works_to_add" text,
  "genres_and_influences" text,
  "influence_maori" bool not null default false,
  "influence_landscape" bool not null default false,
  "influence_culture_nz" bool not null default false,
  "influence_culture_pacific" bool not null default false,
  "influence_culture_other" bool not null default false,
  "influence_religion_spirit" bool not null default false,
  "influence_lang_lit" bool not null default false,
  "influence_perf_or_visual" bool not null default false,
  "influence_politics" bool not null default false,
  "influence_history" bool not null default false,
  "influence_maths_science" bool not null default false,
  "influence_none_abstract" bool not null default false,
  "pub_licence_already" bool not null default false,
  "pub_licence_forms_send" bool not null default false,
  "member_canz" bool not null default false,
  "member_apra" bool not null default false,
  "other_contact" text,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4 not null
);

-- CREATING NEW TABLE prov_contact_updates
create table prov_contact_updates (
  "prov_contact_update_id" serial not null,
  "status_id" int4 not null,
  "name" text,
  "email" text,
  "new_contact" bool not null default false,
  "existing_contact" bool not null default false,
  "nomen_none" bool not null default false,
  "nomen_mr" bool not null default false,
  "nomen_ms" bool not null default false,
  "nomen_mrs" bool not null default false,
  "nomen_mme" bool not null default false,
  "nomen_dr" bool not null default false,
  "nomen_prof" bool not null default false,
  "nomen_lady" bool not null default false,
  "nomen_sir" bool not null default false,
  "nomen_dame" bool not null default false,
  "nomen_miss" bool not null default false,
  "job_title" text,
  "organisation" text,
  "postal_address" text,
  "postcode" text,
  "physical_address" text,
  "phone_home" text,
  "phone_work" text,
  "phone_fax" text,
  "phone_mobile" text,
  "website" text,
  "pref_comm_method_email" bool not null default false,
  "pref_comm_method_phone" bool not null default false,
  "pref_comm_method_fax" bool not null default false,
  "pref_comm_method_post" bool not null default false,
  "other_info" text,
  "send_sounz_news_email" bool not null default false,
  "send_sounz_events_post" bool not null default false,
  "send_sounz_events_email" bool not null default false,
  "send_sounz_updates" bool not null default false,
  "send_donor_info" bool not null default false,
  "send_bequest_info" bool not null default false,
  "send_sounz_news_post" bool not null default false,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4 not null
);

-- CREATING NEW TABLE prov_contributor_profiles
create table prov_contributor_profiles (
  "prov_contributor_profile_id" serial not null,
  "status_id" int4 not null,
  "name" text,
  "email" text,
  "date_of_est_birth" text,
  "new_profile" bool not null default false,
  "updated_profile" bool not null default false,
  "profile" text,
  "author_or_source" text,
  "attaching_photo" bool default false,
  "photo_credit" text,
  "attaching_logo" bool not null default false,
  "website" text,
  "awards" text,
  "other_contact" text,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4 not null
);

-- CREATING NEW TABLE prov_events
create table prov_events (
  "prov_event_id" serial not null,
  "status_id" int4 not null,
  "name" text,
  "email" text,
  "event_name" text,
  "type_concert" bool not null default false,
  "type_seminar" bool not null default false,
  "type_film" bool not null default false,
  "type_workshop_reading" bool not null default false,
  "type_dance_performance" bool not null default false,
  "type_exhibition_installation" bool not null default false,
  "type_theatre" bool not null default false,
  "type_broadcast" bool not null default false,
  "type_launch" bool not null default false,
  "type_rehearsal" bool not null default false,
  "type_pre_concert_talk" bool not null default false,
  "type_opera_musical" bool not null default false,
  "type_ceremony" bool not null default false,
  "type_opportunity" bool not null default false,
  "part_of_conference" bool not null default false,
  "part_of_festival" bool not null default false,
  "part_of_tour" bool not null default false,
  "part_of_season" bool not null default false,
  "umbrella_event" text,
  "venue" text,
  "venue_address" text,
  "event_start_date" text,
  "event_start_time" text,
  "event_finish_date" text,
  "event_finish_time" text,
  "presenter" text,
  "event_notes" text,
  "composers" text,
  "performers" text,
  "booking_email" text,
  "booking_phone" text,
  "booking_mobile" text,
  "booking_fax" text,
  "booking_note" text,
  "other_info" text,
  "attachment_info" text,
  "booking_website" text,
  "work" text,
  "send_sounz_news_post" bool not null default false,
  "send_sounz_news_email" bool not null default false,
  "send_sounz_events_post" bool not null default false,
  "send_sounz_events_email" bool not null default false,
  "send_sounz_updates" bool not null default false,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4 not null
);

-- CREATING NEW TABLE prov_feedbacks
create table prov_feedbacks (
  "prov_feedback_id" serial not null,
  "status_id" int4 not null,
  "visit_daily" bool not null default false,
  "visit_weekly" bool not null default false,
  "visit_monthly" bool not null default false,
  "visit_as_needed" bool not null default false,
  "use_educator" bool not null default false,
  "use_student" bool not null default false,
  "use_performer" bool not null default false,
  "use_composer" bool not null default false,
  "use_conductor" bool not null default false,
  "use_arts_mgr" bool not null default false,
  "use_customer" bool not null default false,
  "use_member" bool not null default false,
  "use_retailer" bool not null default false,
  "use_other" bool not null default false,
  "find_what" bool not null default false,
  "how_improve_website" text,
  "how_improve_services" text,
  "how_improve_resources" text,
  "comments" text,
  "respond_contact" text,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4
);

-- CREATING NEW TABLE prov_work_updates
create table prov_work_updates (
  "prov_work_update_id" serial not null,
  "status_id" int4 not null,
  "name" text,
  "email" text,
  "work_title" text,
  "composed_by" text,
  "description" text,
  "instrumentation" text,
  "work_duration" text,
  "difficulty_beginner" bool not null default false,
  "difficulty_intermediate" bool not null default false,
  "difficulty_advanced" bool not null default false,
  "suitable_for_youth" bool not null default false,
  "sacred" bool default false,
  "year_creation" text,
  "year_revised" text,
  "revision_note" text,
  "contents" text,
  "commissioning_info" text,
  "text_info" text,
  "languages" text,
  "dedication" text,
  "programme_note" text,
  "first_perf_day" text,
  "first_perf_month" text,
  "first_perf_year" text,
  "venue" text,
  "city" text,
  "performers" text,
  "other_performances" text,
  "will_lodge_score" bool not null default false,
  "will_lodge_parts" bool not null default false,
  "format_pdf" bool not null default false,
  "format_hardcopy" bool not null default false,
  "score_sample" text,
  "for_sale_hardcopy" bool not null default false,
  "for_sale_download" bool not null default false,
  "for_hire_parts_only" bool not null default false,
  "commercial_publish_details" text,
  "will_lodge_recording" bool not null default false,
  "recording_performers" text,
  "recording_date" text,
  "recording_duration" text,
  "recording_permission" bool not null default false,
  "pref_sample_in_minutes" text,
  "for_sale_download_licence" bool not null default false,
  "commercial_release_details" text,
  "other_materials" text,
  "genres_and_influences" text,
  "influence_maori" bool default false,
  "influence_landscape" bool default false,
  "influence_culture_nz" bool default false,
  "influence_culture_pacific" bool default false,
  "influence_culture_other" bool default false,
  "influence_religion_spirit" bool default false,
  "influence_perf_or_visual" bool default false,
  "influence_politics" bool default false,
  "influence_history" bool default false,
  "influence_maths_science" bool default false,
  "influence_none_abstract" bool default false,
  "restriction_info" text,
  "copyright_owner" text,
  "other_info" text,
  "influence_lang_lit" bool default false,
  "created_at" timestamp not null,
  "updated_at" timestamp not null,
  "submitted_by" int4 not null
);

-- CREATING NEW CONSTRAINT fk_prov_composer_bios_submitted_by
alter table prov_composer_bios
  add constraint fk_prov_composer_bios_submitted_by foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_composer_bios_pubstatus
alter table prov_composer_bios
  add constraint fk_prov_composer_bios_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_composer_bios
alter table prov_composer_bios
  add constraint pk_prov_composer_bios primary key (prov_composer_bio_id);

-- CREATING NEW CONSTRAINT fk_prov_contact_updates_submitted_by
alter table prov_contact_updates
  add constraint fk_prov_contact_updates_submitted_by foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_contact_updates_pubstatus
alter table prov_contact_updates
  add constraint fk_prov_contact_updates_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_contact_updates
alter table prov_contact_updates
  add constraint pk_prov_contact_updates primary key (prov_contact_update_id);

-- CREATING NEW CONSTRAINT fk_prov_contributor_profiles_submitted_by
alter table prov_contributor_profiles
  add constraint fk_prov_contributor_profiles_submitted_by foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_contributor_profiles_pubstatus
alter table prov_contributor_profiles
  add constraint fk_prov_contributor_profiles_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_contributor_profiles
alter table prov_contributor_profiles
  add constraint pk_prov_contributor_profiles primary key (prov_contributor_profile_id);

-- CREATING NEW CONSTRAINT fk_prov_events_submitted_by
alter table prov_events
  add constraint fk_prov_events_submitted_by foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_events_pubstatus
alter table prov_events
  add constraint fk_prov_events_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_events
alter table prov_events
  add constraint pk_prov_events primary key (prov_event_id);

-- CREATING NEW CONSTRAINT fk_prov_feedbacks_submitted_by
alter table prov_feedbacks
  add constraint fk_prov_feedbacks_submitted_by foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_feedbacks_pubstatus
alter table prov_feedbacks
  add constraint fk_prov_feedbacks_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_feedbacks
alter table prov_feedbacks
  add constraint pk_prov_feedbacks primary key (prov_feedback_id);

-- CREATING NEW CONSTRAINT fk_prov_work_updates_pubstatus
alter table prov_work_updates
  add constraint fk_prov_work_updates_pubstatus foreign key (status_id) references publishing_statuses (status_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW CONSTRAINT fk_prov_wor_fk_prov_w_logins
alter table prov_work_updates
  add constraint fk_prov_wor_fk_prov_w_logins foreign key (submitted_by) references logins (login_id) on update restrict on delete restrict deferrable initially deferred;

-- CREATING NEW PRIMARY KEY CONSTRAINT pk_prov_work_updates
alter table prov_work_updates
  add constraint pk_prov_work_updates primary key (prov_work_update_id);

-- CREATING NEW INDEX prov_composer_bios_submitted_by_fk
create index prov_composer_bios_submitted_by_fk on prov_composer_bios using btree (submitted_by);

-- CREATING NEW INDEX prov_composer_bios_pubstatus_fk
create index prov_composer_bios_pubstatus_fk on prov_composer_bios using btree (status_id);

-- CREATING NEW INDEX pk_prov_composer_bios
-- primary key index already implicitly created via constraint

-- CREATING NEW INDEX prov_contact_updates_submitted_by_fk
create index prov_contact_updates_submitted_by_fk on prov_contact_updates using btree (submitted_by);

-- CREATING NEW INDEX prov_contact_updates_pubstatus_fk
create index prov_contact_updates_pubstatus_fk on prov_contact_updates using btree (status_id);

-- CREATING NEW INDEX pk_prov_contact_updates
-- primary key index already implicitly created via constraint

-- CREATING NEW INDEX prov_contributor_profiles_submitted_by_fk
create index prov_contributor_profiles_submitted_by_fk on prov_contributor_profiles using btree (submitted_by);

-- CREATING NEW INDEX prov_contributor_profiles_pubstatus_fk
create index prov_contributor_profiles_pubstatus_fk on prov_contributor_profiles using btree (status_id);

-- CREATING NEW INDEX pk_prov_contributor_profiles
-- primary key index already implicitly created via constraint

-- CREATING NEW INDEX prov_events_submitted_by_fk
create index prov_events_submitted_by_fk on prov_events using btree (submitted_by);

-- CREATING NEW INDEX prov_events_pubstatus_fk
create index prov_events_pubstatus_fk on prov_events using btree (status_id);

-- CREATING NEW INDEX pk_prov_events
-- primary key index already implicitly created via constraint

-- CREATING NEW INDEX prov_feedbacks_submitted_by_fk
create index prov_feedbacks_submitted_by_fk on prov_feedbacks using btree (submitted_by);

-- CREATING NEW INDEX prov_feedbacks_pubstatus_fk
create index prov_feedbacks_pubstatus_fk on prov_feedbacks using btree (status_id);

-- CREATING NEW INDEX pk_prov_feedbacks
-- primary key index already implicitly created via constraint

-- CREATING NEW INDEX fk_prov_work_updates_submitted_by_fk
create index prov_work_updates_submitted_by_fk on prov_work_updates using btree (submitted_by);

-- CREATING NEW INDEX prov_work_updates_pubstatus_fk
create index prov_work_updates_pubstatus_fk on prov_work_updates using btree (status_id);

-- CREATING NEW INDEX pk_prov_work_updates
-- primary key index already implicitly created via constraint


COMMIT;

