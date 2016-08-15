#! /bin/bash

set -e

# Local defaults..
PACKAGE=sounz
DB_NAME=sounz
DB_HOST=localhost
DB_PORT=5432
DB_USER=sounz
DB_PASSWD=

# Basic configuration already exists - read it in now
PACKAGE_CONFDIR=/etc/${PACKAGE}
PACKAGE_CONF=${PACKAGE_CONFDIR}/${PACKAGE}.conf
if [ -f $PACKAGE_CONF ] ; then
 . $PACKAGE_CONF
else
  echo "Error: $PACKAGE configuration $PACKAGE_CONF not found." >/dev/tty
  exit 1
fi 


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTIONS

# Grab SOUNZ common functions..
if [ -f ${SOUNZ_HOME}/install/install-funcs.sh ] ; then
  . ${SOUNZ_HOME}/install/install-funcs.sh
else
  echo "Error: failed to load SOUNZ common functions from ${SOUNZ_HOME}/install" >/dev/tty
  exit 2
fi

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# DATABASE ENVIRONMENT

if [ -x ${SOUNZ_HOME}/install/detect-db.sh ] ; then
  . ${SOUNZ_HOME}/install/detect-db.sh

  # Now set paths to our executables
  PG_INITD=/etc/init.d/postgresql${PG_VERSION_SUFFIX}
  PSQL=${PG_BIN}/psql
  CREATEDB=${PG_BIN}/createdb
  CREATELANG=${PG_BIN}/createlang
else
  echo "Error: ${SOUNZ_HOME}/install/detect-db.sh not found." >/dev/tty
  exit 4
fi

RET=0
# Check if a given table exists. RET=0 if not, else 1 on return.
function check_table_exists () {
  T=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME --command "SELECT relname FROM pg_class WHERE relname='$1'" | tr -d ' '`
  if [ "$T" = "" ] ; then
    RET=0
  else
    RET=1
  fi
}

# Sets global var RET to the number of rows of data found in the table.
function count_table_rows () {
  T=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME --command "SELECT COUNT(*) FROM $1" | tr -d ' '`
  if [ "$T" = "" ] ; then
    RET=0
  else
    RET=$T
  fi
}

# Delete a table if no rows of data present. Sets RET to 0 on
# return if table deleted, else number of rows of data.
function delete_table () {
  check_table_exists $1
  if [ $RET -eq 1 ] ; then
  	count_table_rows $1
  	if [ $RET -eq 0 ] ; then
  	  echo "Warning: DROPPING existing table $1"
      $PSQL --username $DB_USER --dbname $DB_NAME --command "DROP TABLE $1"
  	else
  	  echo "Warning: not deleting table $1 ($RET rows of data found)"
  	fi
  fi
}

# This function adds in the extra fields we need for the SOUNZ
# schema, to the given table in $1. These are audit fields.
function add_audit_fields () {
  # Created-at timestamp
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD COLUMN created_at timestamp"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE $1 SET created_at=CURRENT_TIMESTAMP"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ALTER COLUMN created_at SET NOT NULL"
  
  # Updated-at timestamp
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD COLUMN updated_at timestamp"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE $1 SET updated_at=CURRENT_TIMESTAMP"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ALTER COLUMN updated_at SET NOT NULL"
  
  # Updated-by auditing - foreign keyed to logins table
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD COLUMN updated_by int4"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE $1 SET updated_by=1000"  # batch user ID
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ALTER COLUMN updated_by SET NOT NULL"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD CONSTRAINT fk_${1}_UPDATED_BY FOREIGN KEY (updated_by) REFERENCES logins (login_id) ON DELETE restrict ON UPDATE restrict DEFERRABLE INITIALLY DEFERRED"

  # Status ID - publishing status - foreign keyed to publishing_statuses table
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD COLUMN status_id int4"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE $1 SET status_id=1"  # pending
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ALTER COLUMN status_id SET NOT NULL"
  $PSQL --username $DB_USER --dbname $DB_NAME --command "ALTER TABLE $1 ADD CONSTRAINT fk_${1}_PUBLISH FOREIGN KEY (status_id) REFERENCES publishing_statuses (status_id) ON DELETE restrict ON UPDATE restrict DEFERRABLE INITIALLY DEFERRED"
  
  # Permissions
  $PSQL --username $DB_USER --dbname $DB_NAME --command "GRANT SELECT ON $1 TO SOUNZ_REPORTS"
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
# Define the provider tables here.
# The first line is the tablename, with a '^' on the following line.
# Next come the fields, one per line.
# Delimit the next table with a comma on its own line, repeat.
#
NUMTABLES=6

TABLES=`cat <<EOF
prov_composer_bios
^
 name:string
 email:string
 date_of_birth:string
 replacing_bio:boolean
 amending_bio:boolean
 bio:text
 author_or_source:string
 pull_quote:text
 attaching_photo:boolean
 photo_credit:string
 website:string
 awards:text
 use_my_current_works:boolean
 selected_works_to_delete:text
 selected_works_to_add:text
 genres_and_influences:text
 influence_maori:boolean
 influence_landscape:boolean
 influence_culture_nz:boolean
 influence_culture_pacific:boolean
 influence_culture_other:boolean
 influence_religion_spirit:boolean
 influence_lang_lit:boolean
 influence_perf_or_visual:boolean
 influence_politics:boolean
 influence_history:boolean
 influence_maths_science:boolean
 influence_none_abstract:boolean
 pub_licence_already:boolean
 pub_licence_forms_send:boolean
 member_canz:boolean
 member_apra:boolean
 other_contact:text
,
prov_feedbacks
^
 visit_daily:boolean
 visit_weekly:boolean
 visit_monthly:boolean
 visit_as_needed:boolean
 use_educator:boolean
 use_student:boolean
 use_performer:boolean
 use_composer:boolean
 use_conductor:boolean
 use_arts_mgr:boolean
 use_customer:boolean
 use_member:boolean
 use_retailer:boolean
 use_other:boolean
 find_what:boolean
 how_improve_website:text
 how_improve_services:text
 how_improve_resources:text
 comments:text
 respond_contact:text
,
prov_contributor_profiles
^
 name:string
 email:string
 date_of_est_birth:string
 new_profile:boolean
 updated_profile:boolean
 profile:text
 author_or_source:string
 attaching_photo:boolean
 photo_credit:string
 attaching_logo:boolean
 website:string
 awards:text
 other_contact:text
,
prov_work_updates
^
 work_title:string
 composed_by:string
 description:text
 instrumentation:text
 work_duration:string
 difficulty_beginner:boolean
 difficulty_intermediate:boolean
 difficulty_advanced:boolean
 suitable_for_youth:boolean
 sacred:boolean
 year_creation:string
 year_revised:string
 revision_note:text
 contents:text
 commissioning_info:text
 text_info:text
 languages:string
 dedication:string
 programme_note:text
 first_perf_day:string
 first_perf_month:string
 first_perf_year:string
 venue:string
 city:string
 performers:text
 other_performances:text
 will_lodge_score:boolean
 will_lodge_parts:boolean
 format_pdf:boolean
 format_hardcopy:boolean
 score_sample:text
 for_sale_hardcopy:boolean
 for_sale_download:boolean
 for_hire_parts_only:boolean
 commercial_publish_details:text
 will_lodge_recording:boolean
 recording_performers:text
 recording_date:string
 recording_duration:string
 recording_permission:boolean
 pref_sample_in_minutes:string
 for_sale_download_licence:boolean
 commercial_release_details:text
 other_materials:text
 genres_and_influences:text
 influence_maori:boolean
 influence_landscape:boolean
 influence_culture_nz:boolean
 influence_culture_pacific:boolean
 influence_culture_other:boolean
 influence_religion_spirit:boolean
 influence_lang_lit:boolean
 influence_perf_or_visual:boolean
 influence_politics:boolean
 influence_history:boolean
 influence_maths_science:boolean
 influence_none_abstract:boolean
 restriction_info:text
 copyright_owner:text
 other_info:text
,
prov_contact_updates
^
 name:string
 email:string
 nomen_none:boolean
 nomen_mr:boolean
 nomen_ms:boolean
 nomen_mrs:boolean
 nomen_mme:boolean
 nomen_dr:boolean
 nomen_prof:boolean
 nomen_lady:boolean
 nomen_sir:boolean
 nomen_dame:boolean
 nomen_miss:boolean
 job_title:string
 organisation:string
 postal_address:text
 postcode:string
 physical_address:text
 phone_home:string
 phone_work:string
 phone_fax:string
 phone_mobile:string
 website:string
 pref_comm_method_email:boolean 
 pref_comm_method_phone:boolean 
 pref_comm_method_fax:boolean 
 pref_comm_method_post:boolean
 other_info:text
 send_sounz_news_post:boolean
 send_sounz_news_email:boolean
 send_sounz_events_post:boolean
 send_sounz_events_email:boolean
 send_sounz_updates:boolean
 send_donor_info:boolean
 send_bequest_info:boolean
,
prov_events
^
 event_name:string
 type_concert:boolean
 type_seminar:boolean
 type_film:boolean
 type_workshop_reading:boolean
 type_dance_performance:boolean
 type_exhibition_installation:boolean
 type_theatre:boolean
 type_broadcast:boolean
 type_launch:boolean
 type_rehearsal:boolean
 type_pre_concert_talk:boolean
 type_opera_musical:boolean
 type_ceremony:boolean
 type_opportunity:boolean
 part_of_conference:boolean
 part_of_festival:boolean
 part_of_tour:boolean
 part_of_season:boolean
 umbrella_event:string
 venue:string
 venue_address:text
 event_start_date:string
 event_start_time:string
 event_finish_date:string
 event_finish_time:string
 presenter:string
 event_notes:text
 composers:text
 work:text
 performers:text
 booking_website:string
 booking_email:string
 booking_phone:string
 booking_mobile:string
 booking_fax:string
 booking_note:text
 other_info:text
 attachment_info:text
 send_sounz_news_post:boolean
 send_sounz_news_email:boolean
 send_sounz_events_post:boolean
 send_sounz_events_email:boolean
 send_sounz_updates:boolean
EOF`

# Do it from here
cd ${SOUNZ_HOME}/sounz

function define_provider () {
  DEF=$*
  TABLENAME=`echo $DEF | cut -d'^' -f1`
  TABLEDEFS=`echo $DEF | cut -d'^' -f2`
  if [ "$TABLENAME" != "" ] ; then
    delete_table $TABLENAME
    # clear previous one if present
    echo "table $TABLENAME"
    MIGRATE_FILES=`find db/migrate -name "*create_${TABLENAME}.rb"`
    if [ "$MIGRATE_FILES" != "" ] ; then
      for $MIG in $MIGRATE_FILES ; do
        rm -f $MIG
      done
    fi
  
    # Generate it
    echo "generating provider scaffold for '$TABLENAME'"	
    ./script/generate scaffold_resource $TABLENAME $TABLEDEFS
    tablesdone="$tablesdone $TABLENAME"
  else
    echo "null tablename ignored"
  fi
}

# Do them all..
$PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE schema_info SET version=0"

tablenum=1
tablesdone=
while [ $tablenum -le $NUMTABLES ] ; do
  echo ""
  echo "+++++++"
  TABLEDEF=`echo $TABLES | cut -d',' -f$tablenum`
  define_provider $TABLEDEF
  tablenum=`expr $tablenum + 1`
done

# Do the migration now..
rake db:migrate

# Add the audit fields
echo ""
echo "Adding audit fields.."
for table in $tablesdone ; do
  check_table_exists $table
  if [ $RET -eq 1 ] ; then
  	echo "$table"
    add_audit_fields $table   
  fi
done

exit 0