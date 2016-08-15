#!/bin/bash

# Runs a cronjob script. The name of the script to run should be provided
# as the first command-line argument, and is mandatory. It must also be
# executable. All other args are passed to the script.
#
# NOTE: This wrapper is designed to only run the script when the server
#       is running in a "production" status. The script will do nothing
#       when it is in a standby status. If you want your script to run
#       no matter what the status, then do NOT use this wrapper!
#
#       An optional first parameter '--nice N' will run the script at a
#       priority adjusted by N. In this case, N *must* be given, unlike
#       the 'nice' command itself, which defaults to 10 if omitted.
#
#       NOTE: The positions of arguments below IS important. Keep usage
#             to exactly as shown here.
#
# Usage: run-cron-job.sh scriptname [--nice N] [scriptargs]

# Must have at least a script name
[ "$1" = "" ] && exit 0

# Script name
CRONSCRIPT=$1
shift

# Optional nice setting
NICE=
NICE_ADJ=
if [ "$1" = "--nice" ] ; then
  NICE=`which nice`
  NICE_ADJ="$2"
  shift
  shift
fi

# Command line args
CRONARGS=$*

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

  production|production_as_standby|production_alone)

    logit "$CRONSCRIPT start"
    # The cron scripts are always found here..
    cd ${SOUNZ_HOME}/scripts/cron
    if [ -x $CRONSCRIPT ] ; then
      if [ "$NICE" != "" -a "$NICE_ADJ" != "" ] ; then
        logit "using nice $NICE_ADJ with this command"
        $NICE -n ${NICE_ADJ} ./${CRONSCRIPT} ${CRONARGS} >>$LOGFILE 2>&1
      else
        ./${CRONSCRIPT} ${CRONARGS} >>$LOGFILE 2>&1
      fi
    else
      logit "Error: $CRONSCRIPT is not executable."
    fi
    logit "$CRONSCRIPT finished"
    ;;

  *)
    # do nothing
    ;;
esac

# END