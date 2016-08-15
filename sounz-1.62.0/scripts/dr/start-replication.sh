#! /bin/bash

# Standby script
# Set up replication for SOUNZ.
# NOTE: Only a SOUNZ server in a 'standby' status will do this.

# USAGE: Generally this script is not used from the command-line, but is
# used as a part of the following scripts:
#   SOUNZ_HOME/scripts/dr/switch-to-standby.sh
#   SOUNZ_HOME/scripts/dr/switch-to-production.sh
#   /etc/init.d/sounz-app
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

# Rsync is in dependencies, so must be installed
RSYNC=`which rsync`
if [ "$RSYNC" = "" ] ; then
  echo "Error: rsync is not installed on this machine."
  exit 4
fi

# Standard cron logfile
mklogfile sounz-general.log

# Determine the IP address to bind the rsync daemon to. Note
# that we only start the daemon IF we are in a mode which
# requires rsync. Eg. Production running alone does not.
do_start=0
case $STATUS in
  production|production_as_standby)
    BIND_IP=$IP_PRIMARY_SERVER
    do_start=1
    ;;

  standby|standby_as_production)
    BIND_IP=$IP_SECONDARY_SERVER
    do_start=1
    ;;  
esac

# Start and check
if [ $do_start -eq 1 ] ; then

  # Start our replication daemon with 'nice' defaulting to +10.
  # Rsyncing is not a high priority function.
  /usr/bin/nice \
  $RSYNC --daemon \
         --port=$SOUNZ_RSYNC_PORT \
         --address $BIND_IP \
         --config=${CONFDIR}/rsync/rsyncd.conf </dev/null
  err=$?
  if [ $err -eq 0 ] ; then
    logit "started rsyncd on port $SOUNZ_RSYNC_PORT bound to $BIND_IP"
  else
    logit "Error: failed to start rsyncd on port $SOUNZ_RSYNC_PORT bound to $BIND_IP (err=$err)"
  fi

  # Enable replication activities
  ${SOUNZ_HOME}/scripts/dr/enable-replication.sh

fi

# END