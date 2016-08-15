#!/bin/bash

# Does various housekeeping tasks - usually this is only run something
# like once per week.
#

# Basic configuration already exists - read it in now
CONFDIR=/etc/sounz
CONF=${CONFDIR}/sounz.conf
if [ -f $CONF ] ; then
 . $CONF
else
  echo "Error: SOUNZ configuration $CONF was not found."
  exit 1
fi

# Get server status
STATUSFILE=${CONFDIR}/sounz.status
if [ -f $STATUSFILE ] ; then
  STATUS=`cat $STATUSFILE`
else
  echo "Error: SOUNZ status file $STATUSFILE was not found."
  exit 2
fi

# Grab SOUNZ common functions..
if [ -f ${SOUNZ_HOME}/install/install-funcs.sh ] ; then
  . ${SOUNZ_HOME}/install/install-funcs.sh
else
  echo "Error: failed to load SOUNZ common functions from ${SOUNZ_HOME}/install"
  exit 3
fi

# Standard cron logfile
mklogfile sounz-general.log

case $STATUS in
  production|standby_as_production|production_alone)
    # production mode housekeeping
    # Remove old upgrade database dumps
    if [ -d ${SOUNZ_DATA}/backup ] ; then
      find ${SOUNZ_DATA}/backup -type f -name "*.dump" -mtime +7 -exec rm {} \;
    fi
    ;;

  standby|production_as_standby)
    # standby mode housekeeping
    # Remove old database dumps
    if [ -d ${SOUNZ_DATA}/replication ] ; then
      find ${SOUNZ_DATA}/replication -type f -name "*.bak.gz" -mtime +1 -exec rm {} \;
    fi
    ;;
    
  *)
    # do nothing
    ;;
esac

# END