#! /bin/bash

# Standby script
# Disable replication activities.

# USAGE: Generally this script is not used from the command-line, but is
# used as a part of the following scripts:
#   SOUNZ_HOME/scripts/dr/start-replication.sh
#   SOUNZ_HOME/scripts/dr/stop-replication.sh
#
# However, it can be used from the command-line, if you need to be
# abolutely sure no replication activity is going to take place. The
# activites that this script will disable are:
#
#  - snapshot/dumping of the database on a Production server
#  - rsyncing (pulling) of data and code from Production to Standby
#  - updating of a Standby database with dumped database from Production
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

# Grab SOUNZ common functions..
if [ -f ${SOUNZ_HOME}/install/install-funcs.sh ] ; then
  . ${SOUNZ_HOME}/install/install-funcs.sh
else
  echo "Error: failed to load SOUNZ common functions from ${SOUNZ_HOME}/install"
  exit 2
fi

# Standard cron logfile
mklogfile sounz-general.log

# Always remove this flag-file. This is what permits replication
# activities scross the board. If absent nothing will be replicated.
rm -f ${SOUNZ_LOGS}/replication-enabled
if [ -f ${SOUNZ_LOGS}/replication-enabled ] ; then
  logit "Error: failed to disable replication!"
else
  logit "replication was disabled"
fi


# END