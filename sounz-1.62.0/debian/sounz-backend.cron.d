# ----------------------------------------------------------------------------
# SOUNZ CRON SCHEDULE
# This file is intended to be put into /etc/cron.d/ as filename 'sounz-backend'
# These cron jobs are for the general working of the SOUNZ website and have
# been installed by Debian postinst. Modify in-situ as required.
#
# ----------------------------------------------------------------------------

# CRM Mailout Emailer
# This is intended to check for CRM mailout requests, and process them to
# send all of the emails out.
# min hr dy m dow user     command
#NORUN# */15  *  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh crm-emailer.php >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Housekeeping cleanup jobs to be run every day
# min hr dy m dow user  command
#NORUN# 0  3  *  *  *  _SOUNZ_USER_ _SOUNZ_HOME_/scripts/cron/housekeeping.sh >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# SOUNZ database replication - SNAPSHOT
# This is process which creates a database snapshot. The script will only
# do anything from the production machine, dumping the database there.
# min hr dy m dow user     command
#NOSNAP# _DB_SNAP_CRON_  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/snapshot-db.sh >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# SOUNZ database replication - UPDATE
# This is process which acquires a database snapshot. The script will only
# do anything from the standby machine, using scp to get the database and
# then installing it locally.
# NB: We do this as root, so that we can stop/start sounz-app.
# min hr dy m dow user     command
#NOUPDT# _DB_UPDT_CRON_  *  *  *  root    _SOUNZ_HOME_/scripts/cron/update-db.sh >>_SOUNZ_LOGS_/sounz-general.log 2>&1
