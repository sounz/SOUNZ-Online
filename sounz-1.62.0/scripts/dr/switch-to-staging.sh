#!/bin/bash
#
# SOUNZ SERVER - SWITCH TO STAGING
#
# This script switches the current server (the one you are running it on) to
# be the STAGING SOUNZ server machine.
#
# NOTE: This supports usage of a SOUNZ server in a 'staging' mode, which is
# to say, operating standalone, with no replication activity at all.
#
# USAGE: Intended to be used from command-line for Staging important site
# developments as a temporary thing - ie. short durations, due to the
# inherent lack of Standby capability during this time.
#
SCRIPTNAME=${0##*/}

# Must be root..
if [ `whoami` != "root" ]; then
  echo "this script needs to be run as ROOT!"
  exit 0
fi

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

echo ""
echo "SWITCHING THIS SERVER TO STAGING STATUS"
echo "======================================="
echo "Current status: $STATUS"
echo ""
echo "1  Staging: Operate this server standalone (no standby capability)"
echo "Q  Quit"
echo ""
echo -n "Enter choice: [Q]"
read ANS
case $ANS in
  1) NEW_STATUS="staging"
     ;;
  *) echo "no changes made"
     exit 0
     ;;
esac

# Stop replication
${SOUNZ_HOME}/scripts/dr/stop-replication.sh

# Confirmation
echo "setting server status to '$NEW_STATUS'"
echo $NEW_STATUS >$STATUSFILE
logit "server was set into $NEW_STATUS status"


# Now configure it for zencart..
${SOUNZ_HOME}/install/config-zencart.sh

# Confirm we have finished..
echo "This is now a STAGING Sounz server"
echo ""
echo "IMPORTANT NOTICE:"
echo "Whilst this server is in Staging status, no replication to it or"
echo "from it will occur. This normally means that you are operating the"
echo "SOUNZ cluster WITH NO DR CAPABAILITY whilst in this status."
echo ""
echo "Therefore, make sure you keep the duration of your testing in"
echo "staging status to a minimum."

# END