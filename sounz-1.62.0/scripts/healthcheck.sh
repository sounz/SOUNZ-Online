#!/bin/bash
# SOUNZ monitor wrapper.

# This script gets the environment set up, and then calls the
# Ruby script which does the healthcheck. The Ruby script is only
# called if this is running on a production server, otherwise it
# always returns as 'healthy'.

# Name of this script
SCRIPTNAME=${0##*/}

# Basic configuration already exists - read it in now
CONFDIR=/etc/sounz
CONF=${CONFDIR}/sounz.conf
if [ -f $CONF ] ; then
 . $CONF
fi

# Get server status: production, standby..
STATUSFILE=${CONFDIR}/sounz.status
if [ -f $STATUSFILE ] ; then
  STATUS=`cat $STATUSFILE`
else
  STATUS=unknown
fi

# Check for running server PIDs - if not then set the status to
# 'stopped' for the purposes of this script. That will result in
# an 'OK' healthcheck being returned, which is fine.
ls ${SOUNZ_LOGS}/${NAME}*.pid >/dev/null 2>&1
if [ $? -gt 0 ]; then
  STATUS=stopped
fi

# Defaults..
health="OK: SOUNZ Healthcheck good"
returncode=0

case $STATUS in
  production|standby_as_production|production_alone)
    # Check database connection is available first, else do not
    # try the script as it will fail nastily
    # Grab SOUNZ common functions..
    if [ -f ${SOUNZ_HOME}/install/install-funcs.sh ] ; then
      . ${SOUNZ_HOME}/install/install-funcs.sh
    
      # Now set paths to our executables
      PG_INITD=/etc/init.d/postgresql
      PSQL=`which psql`
      dbver=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "SELECT app_version FROM app_control" 2>/dev/null | tr -d ' '`
      if [ "$dbver" != "" ] ; then
        # The scripts are always found here
        cd ${SOUNZ_HOME}/scripts
        rbscript=./healthcheck.rb
        if [ -x $rbscript ] ; then
          # Run the Ruby healthcheck script, grab output from it. The output should be
          # emitted (printed) from the Ruby script, and be one of the following two
          # statuses:
          #   'OK: SOUNZ Healthcheck good'
          #   'CRITICAL: SOUNZ <info>'
          # <info> should be very short, just a few words,
          # eg: 'Solr not responding'
          health=`$rbscript ${MONGREL_PORTS}`
          state=${health%%:*}
          case $state in
            OK)
              returncode=0
              ;;
            WARNING)
              returncode=1
              ;;
            CRITICAL)
              returncode=2
              ;;
            *)
              returncode=0
              ;;
          esac
          # Log it in syslog
          echo $health | logger -t $SCRIPTNAME
        fi
      fi
    fi
    ;;
  *)
    # do nothing
    ;;
esac

# Output it and return..
echo $health
exit $returncode

# END