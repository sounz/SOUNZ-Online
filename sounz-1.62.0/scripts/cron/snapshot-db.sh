#! /bin/bash

# Standby script
# Dump a snapshot of the database to replication area.
#
# NOTE: Only a SOUNZ server in a 'production' status will do this.
# The replication area is in the SOUNZ_DATA directory - a sub-directory
# called 'replication'. The pg_dump is dropped into that directory,
# over-writing the one already there. Cronjob timing takes care of
# avoiding race conditions with readers of this dump. The dump is
# then rsynced over with the normal SOUNZ data, to be used as reqd
# by the standby server.
#
SCRIPTNAME=${0##*/}

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

# Have to be enabled, else exit
if ! ${SOUNZ_HOME}/scripts/dr/replication-enabled.sh
then
  exit 0
fi

# Standard cron logfile
mklogfile sounz-general.log

# Snapshotting is a good thing, and we do this any time we are
# some kind of production server.
case $STATUS in
  production|production_alone|standby_as_production)
    # Now set paths to our executables
    PG_INITD=/etc/init.d/postgresql
    PSQL=`which psql`
    PGDUMP=`which pg_dump`
  
    # Assert replication area
    REPLICATION_DIR=${SOUNZ_DATA}/replication
    if [ ! -d $REPLICATION_DIR ] ; then
      mkdir $REPLICATION_DIR
      chown ${SOUNZ_USER}:${SOUNZ_USER} $REPLICATION_DIR
      chmod 6775 $REPLICATION_DIR
    fi

    # Dump snapshot of the database. Use nice to lessen impact, since
    # this will be running on the Production server.
    if [ -x $PGDUMP ] ; then
      /usr/bin/nice $PGDUMP --no-owner $DB_NAME >${REPLICATION_DIR}/${DB_NAME}-snapshot.sql
      logit "created new snapshot for $DB_NAME"
    else
      logit "Error: no executable pg_dump at $PGDUMP"
    fi
    ;;
    
  *)
    # do nothing
    ;;
    
esac

# END