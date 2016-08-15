#!/bin/bash
#
# SOUNZ SERVER - SWITCH TO PRODUCTION
#
# This script switches the current server (the one you are running it on) to
# be the PRODUCTION SOUNZ server machine.
#
# NOTE: If Apollo is locally installed that will also put it into 'master'
# mode, unless the server is running alone, in which case it will be disabled.
#
# USAGE: Intended to be used from command-line for Disaster Recovery.
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
echo "SWITCHING THIS SERVER TO PRODUCTION STATUS"
echo "=========================================="
echo "Current status: $STATUS"
echo ""
echo "1  EMERGENCY: production running standalone (no Stand-by)"
echo "2  Normal:    production alongside working Stand-by server"
echo "3  Recovery:  standby as production w/Production server as Standby"
echo "Q  Quit"
echo ""
echo -n "Enter choice: [Q]"
read ANS
case $ANS in
  1) NEW_STATUS="production_alone"
     if [ "$STATUS" = "standby" ] ; then
       # Standby machine being switched to Production Alone is a possible
       # emergency situation, so offer options to rescue latest data.
       echo ""
       echo "If this is an emergency you can copy the latest data now:"
       echo ""
       echo "If the Production server is still up and it's data is reliable, you"
       echo "will probably want to grab the latest data and code from it. If there"
       echo "is some question of reliability, then don't do this."
       echo ""
       echo -n "Rsync data from Production and update this local database? [yN]: "
       read ANS
       if [ "$ANS" = "y" -o "$ANS" = "Y" ] ; then
         ${SOUNZ_HOME}/scripts/cron/replicate.sh --force
         ${SOUNZ_HOME}/scripts/cron/update-db.sh --force
         echo "done!"
       fi
     fi
     ;;
  2) NEW_STATUS="production"
     ;;
  3) NEW_STATUS="standby_as_production"
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

# Start replication in new status
${SOUNZ_HOME}/scripts/dr/start-replication.sh

# Confirm we have finished..
echo "This is now a PRODUCTION Sounz server"

# END