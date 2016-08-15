#! /bin/bash

# Standby script
# Install a snapshot of the database from production server.
#
# NOTE: Only a SOUNZ server in a 'standby' status will do this.
#
# Modus Operandum: The database dump to install is always found
# in:
#    ${SOUNZ_DATA}/replication/${DB_NAME}-snapshot.sql
#
# This dump arrives care of the SOUNZ_DATA rsync process. An md5sum
# is kept in the same directory: 'snapshot.md5' which is unaffected by
# the rsync processes. This script compares that last md5sum with
# the current snapshot and if it is different (or absent), installs
# the database locally.
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

# This script can be forced, otherwise flag-file required
if [ "$1" != "--force" ] ; then
  # Have to be enabled, else exit
  if ! ${SOUNZ_HOME}/scripts/dr/replication-enabled.sh
  then
    exit 0
  fi
fi

# Checking/creating md5 of database snapshot. Part of core utils
# so it should always be installed.
MD5SUM=`which md5sum`
if [ "$MD5SUM" = "" ] ; then
  echo "Error: md5sum is not installed on this machine."
  exit 4
fi

# check for gzip to compress backup db dump
GZIP=`which gzip`
if [ "$GZIP" = "" ] ; then
  echo "Error: gzip is not installed on this machine."
  exit 4
fi

# Standard cron logfile
mklogfile sounz-general.log

# We will only be updating our local database if we are
# a standby server of some kind.
case $STATUS in
  standby|production_as_standby)
      # Now set paths to our executables
      PG_INITD=/etc/init.d/postgresql
      PSQL=`which psql`
      DROPDB=`which dropdb`
      PGDUMP=`which pg_dump`
      CREATEDB=`which createdb`
      CREATELANG=`which createlang`
      if [ ! -x $PSQL ] ; then
        echo "Error: postgresql executables not found."
        exit 5
      fi

    # Assert replication area
    REPLICATION_DIR=${SOUNZ_DATA}/replication
    if [ ! -d $REPLICATION_DIR ] ; then
      mkdir $REPLICATION_DIR
      chown ${SOUNZ_USER}:${SOUNZ_USER} $REPLICATION_DIR
      chmod 6775 $REPLICATION_DIR
    fi

    # Install database from primary server if changed
    if [ -f ${REPLICATION_DIR}/${DB_NAME}-snapshot.sql ] ; then
      # Determine whether to install it
      do_install=0
      SNAPMD5=${REPLICATION_DIR}/snapshot.md5
      if [ -f $SNAPMD5 ] ; then
        $MD5SUM -c $SNAPMD5 >/dev/null 2>&1
        do_install=$?
      else
        do_install=1
      fi

      # Snapshot installation
      if [ $do_install -gt 0 ] ; then
        # Stop sounz-app to free up the database
        logit "stopping sounz-app"
        /usr/sbin/invoke-rc.d sounz-app stop

        # Always keep the last database dump
        STAMP=$(date +"%Y%m%d%H%M%S")
        DBDUMP="${REPLICATION_DIR}/${DB_NAME}-dump.sql.${STAMP}.bak"
        
        # check if 'sounz' database exists to be dumped
        DBOK=$(su postgres -c "$PSQL --list --tuples-only" | cut -d'|' -f1 | tr -d ' ' | grep "^$DB_NAME")

        doupdate=1
        if [ -n "${DBOK}" ] ; then
          su sounz -c "$PGDUMP --no-owner --username $SOUNZ_USER $DB_NAME >$DBDUMP"
          if [ $? -eq 0 ] ; then
            logit "pre-update database dump saved in $DBDUMP"
            su sounz -c "$GZIP $DBDUMP"
            # Drop database
            su postgres -c "$DROPDB $DB_NAME" >/dev/null 2>&1
            if [ $? -eq 0 ] ; then
              logit "dropped database $DB_NAME"
            else
              logit "Error: failed to drop current ${DB_NAME}"
              doupdate=0
            fi
          else
            logit "Error: failed to save current ${DB_NAME} into $DBDUMP"
            doupdate=0
          fi
        else
          logit "Warning: database ${DB_NAME} is already dropped. Continuing."
        fi            

        # if we are all set, then create database and populate it from snapshot
        if [ $doupdate -eq 1 ] ; then
          su postgres -c "$CREATEDB --username $SOUNZ_USER --encoding UTF-8 $DB_NAME --template=template0" >/dev/null 2>&1
          if [ $? -eq 0 ] ; then
            logit "created new database $DB_NAME"
            su postgres -c "$CREATELANG plpgsql $DB_NAME"
            su $SOUNZ_USER -c "$PSQL --username $SOUNZ_USER --quiet --file ${REPLICATION_DIR}/${DB_NAME}-snapshot.sql $DB_NAME" >/dev/null 2>&1
            err=$?
            if [ $err -eq 0 ] ; then
              logit "successfully installed database snapshot"
              # Now configure it for zencart..
              ${SOUNZ_HOME}/install/config-zencart.sh
              # And update the MD5 for next time
              $MD5SUM ${REPLICATION_DIR}/${DB_NAME}-snapshot.sql >$SNAPMD5
            else
              logit "Error: psql failed to install ${REPLICATION_DIR}/${DB_NAME}-snapshot.sql (code=$err)"
            fi
          else
            logit "Error: failed to create new ${DB_NAME}"
          fi
        else
          logit "Aborted: database dump/drop/create process"
        fi

        # Start sounz-app again
        logit "re-starting sounz-app"
        /usr/sbin/invoke-rc.d sounz-app start
      else
        logit "Notice: database snapshot unchanged."
      fi
    else
      logit "No database snapshot available."
    fi
    ;;

  *)
    # do nothing
    ;;

esac

# END