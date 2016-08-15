#!/bin/bash
#
# CONFIGURE ZENCART
#
# This script configures zencart appropriately depending on the status
# of the server. It needs no parameters - just run it whenever you
# need to ensure that Zencart is configured properly.
#
# USAGE: Mainly intended to be used from command-line for Disaster Recovery.
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

# Standard logfile
mklogfile sounz-general.log

# Grab DB settings required..

# Now set paths to our executables
PSQL=`which psql`
if [ ! -x $PSQL ] ; then
  echo "Error: postgresql executables not found."
  exit 5
fi

# Tweak zencart config according to status
case $STATUS in
  production|production_alone|standby_as_production)
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='SOUNZ' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_USERID'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='1ab7a8f93f4e67bcc66490d889813f89fcdcb7a7bbe1e81f' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_DESKEY'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='548705c56d735cd9' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_MACKEY'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='SOUNZ' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_USERID'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='1ab7a8f93f4e67bcc66490d889813f89fcdcb7a7bbe1e81f548705c56d735cd9' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_KEY'" >>$LOGFILE 2>&1
    logit "zencart configuration updated for production operation"
    ;;
    
  standby|production_as_standby|staging)
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='SOUNZ_dev' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_USERID'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='0e33b0f5bc5cd948ced947f37b5c0d8a9a021d9b26989dfb' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_DESKEY'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='fa6b4bb6cf092d8b' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_MACKEY'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='SOUNZ_dev' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_USERID'" >>$LOGFILE 2>&1
    $PSQL --username $DB_USER --dbname $DB_NAME --command "UPDATE zencartconfiguration SET configuration_value='0e33b0f5bc5cd948ced947f37b5c0d8a9a021d9b26989dfbfa6b4bb6cf092d8b' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_KEY'" >>$LOGFILE 2>&1
    logit "zencart configuration updated for standby (test mode) operation"
    ;;

  *)
    # do nothing
    ;;
    
esac

# END
