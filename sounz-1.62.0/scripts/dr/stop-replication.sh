#! /bin/bash

# Standby script
# Set up replication for SOUNZ.

# USAGE: Generally this script is not used from the command-line, but is
# used as a part of the following scripts:
#   SOUNZ_HOME/scripts/dr/switch-to-standby.sh
#   SOUNZ_HOME/scripts/dr/switch-to-production.sh
#   /etc/init.d/sounz-app
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

RSYNC=`which rsync`
if [ "$RSYNC" = "" ] ; then
  echo "Error: rsync is not installed on this machine."
  exit 4
fi

# Standard cron logfile
mklogfile sounz-general.log

# Disable replication activities
${SOUNZ_HOME}/scripts/dr/disable-replication.sh

# Find our pid file - if none then no error, just exit
PID=${SOUNZ_LOGS}/sounz-rsync.pid
if [ ! -f $PID ] ; then
  exit 0
fi

# Get PID from file
pid=$(<$PID)
if [ -z $pid ] ; then
  logit "Error: SOUNZ rsync PID was null in $PID - removing bad pidfile"
  rm -f $PID
  exit 5
fi

# Just kill it
kill $pid

# Wait until our rsyncd dies or we time out
dead=0
timer=0
timeout=300
while (( ! dead && timer < timeout ))
do
  if ps -eo pid | grep -qw $pid
  then
	  kill $pid
    (( timer++ ))
    sleep 1
  else
    dead=1
  fi
done

# Report if failed
if ps -eo pid | grep -qw $pid
then
  logit "Error: rsyncd failed to stop after $timeout seconds"
else
  logit "replication rsyncd was stopped"
fi


# END