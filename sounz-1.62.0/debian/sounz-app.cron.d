# ----------------------------------------------------------------------------
# SOUNZ-APP CRON SCHEDULE
# This file is intended to be put into /etc/cron.d/ as filename 'sounz-app'
# These cron jobs are for the general working of the SOUNZ website and have
# been installed by Debian postinst. Modify in-situ as required.
#
# ----------------------------------------------------------------------------

# Main SOUNZ replication process
# This is the main SOUNZ replication process to support DR. The rsync is done
# from the standby machine, pulling data and code from the production machine.
# If THIS machine is running as Production, the replication script will do
# absolutely nothing.
# NB: This needs root privileges so that rsync can assert file ownerships etc.
# min hr dy m dow user     command
#NORUN# _RSYNC_CRON_  *  *  *  root    _SOUNZ_HOME_/scripts/cron/replicate.sh >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Update front page featured artists rotation list
# This generates a new, random list of artists to display on the front page.
# We re-generate this every day, early morning when everyone is asleep.
# min hr dy m dow user     command
#NORUN# 1  5  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh update_front_page_rotation.rb -e production >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Index all entities in the SOUNZ database to Solr.
# This re-generates all Solr indexing information from scratch, but does it without
# interrupting service on the website. We do this every night, so as to keep the
# indexing information fully correct, no matter what has happened during the day.
# min hr dy m dow user     command
#NORUN# 40  1  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh index_all_entities_to_solr.rb -e production --nice 12 >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Cleanup script for temporary Ruby sessions. This one is always enabled.
# Do this every day, in the early hours. Remove all older than today or yesterday.  This was originally 7 days but the Amanda tape backup software did not ignore
# this directory, and was causing backups to time out.
  1  4  *  *  *  root     find _SOUNZ_HOME_/sounz/tmp/sessions -type f -daystart -mtime +1 -exec rm {} \; >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Process the expired memberships: delete the expired memberships and emails notifications to SOUNZ administrators and appropriate users.
# Do this every day, in the early hours, to minimise the risk that the process will affect online shopping.
 1  3  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh delete_expired_memberships.rb -e production >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Process the failed ecommerce orders check: checks whether there are any successful DPS transactions that do not have an order assigned to them and emails notifications to SOUNZ administrators if there are.
# We run the script every day, in the early hours, when most of SOUNZ Ecommerce customers are logged out (the notification is not sent if the affected customer is loged in).
# min hr dy m dow user     command
 30   3  *  *  *  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh failed_orders_check.rb -e production >>_SOUNZ_LOGS_/sounz-general.log 2>&1

# Prepare the lists of the memberships that are due to expire and email links to those lists to SOUNZ administrators.
# Do this every Sunday, as requested by SOUNZ.
 1  6  *  *  0  _SOUNZ_USER_    _SOUNZ_HOME_/scripts/cron/run-cron-job.sh generate_expiring_memberships.rb -e production >>_SOUNZ_LOGS_/sounz-general.log 2>&1
