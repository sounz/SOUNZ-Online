#! /bin/bash

# Standby script
# Replicate all appropriate contents from the production server.
#
# NOTE: Only a SOUNZ server in a 'standby' status will do this.
# The basic operation here is that we replicate everything under
# SOUNZ_HOME, and SOUNZ_DATA across from Production. Exceptions
# are found in /etc/sounz/rsync/rsync-excludes.
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

# This script can be forced, otherwise flag-file required
if [ "$1" != "--force" ] ; then
  # Have to be enabled, else exit
  if ! ${SOUNZ_HOME}/scripts/dr/replication-enabled.sh
  then
    exit 0
  fi
fi

# Rsync is in dependencies, so must be installed
RSYNC=`which rsync`
if [ "$RSYNC" = "" ] ; then
  echo "Error: rsync is not installed on this machine."
  exit 4
fi

# Standard cron logfile
mklogfile sounz-general.log

# Acquire source IP/hostname depending on status. We only
# ever replicate as a 'standby' server, pulling content off
# production, so it is fairly simple.
IP_SOURCE=
case $STATUS in
  standby)
    IP_SOURCE=$IP_PRIMARY_SERVER
    ;;
  production_as_standby)
    IP_SOURCE=$IP_SECONDARY_SERVER
    ;;
esac

# If the status we are in yielded a replication source then
# we go ahead and replicate from it.
if [ "$IP_SOURCE" != "" ] ; then
    # rsync all content across
    $RSYNC --port=$SOUNZ_RSYNC_PORT \
           --recursive \
           --delete    \
           --times --owner --group \
           --omit-dir-times \
           --links \
           --exclude-from=/etc/sounz/rsync/rsync-excludes \
           ${SOUNZ_USER}@${IP_SOURCE}::sounz-data $SOUNZ_DATA
    err=$?
    if [ $err -eq 0 ] ; then
      logit "replicated application data from ${IP_PRIMARY_SERVER}:${SOUNZ_RSYNC_PORT}"
    else
      logit "Error: application data replication from ${IP_PRIMARY_SERVER}:${SOUNZ_RSYNC_PORT} failed (err=$err)"
    fi

    $RSYNC --port=$SOUNZ_RSYNC_PORT \
           --recursive \
           --delete    \
           --times --owner --group \
           --omit-dir-times \
           --links \
           --exclude-from=/etc/sounz/rsync/rsync-excludes \
           ${SOUNZ_USER}@${IP_SOURCE}::sounz-home $SOUNZ_HOME
    err=$?
    if [ $err -eq 0 ] ; then
      logit "replicated application home from ${IP_PRIMARY_SERVER}:${SOUNZ_RSYNC_PORT}"
    else
      logit "Error: application home replication from ${IP_PRIMARY_SERVER}:${SOUNZ_RSYNC_PORT} failed (err=$err)"
    fi

fi
  
# END