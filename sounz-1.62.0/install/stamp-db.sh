#!/bin/bash
# Stamp a POSTGRESQL database for an Axyl website, with the latest
# version of the Axyl installation.

# NOTE: This is not normally run standalone. The main DB upgrade
# script 'install/upgrade-axyl-databases.sh normally runs this, or
# the postinst script, if just stamping is being done.
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# INCOMING PARAMETERS
#  $1  - DBNAME
#  $2  - DBUSER
#  $3  - DBPASSWD ('none' means a blank password)
#  $4  - DBHOST ('direct' means a local database server)
#  $5  - DBPORT
#  $6  - AXYL_VERSION (Axyl version, '' or 'n.n.n'
DBNAME=""
DBUSER=""
DBPASSWD=""
DBHOST=""
DBPORT=5432
AXYL_VERSION="unknown"

POS=0
while [ $# -gt 0 ] ; do
  POS=`expr $POS + 1`
  case $POS in
    1)  DBNAME=$1
        ;;
    2)  DBUSER=$1
        ;;
    3)  DBPASSWD=$1
        ;;
    4)  DBHOST=$1
        ;;
    5)  DBPORT=$1
        ;;
    6)  AXYL_VERSION=$1
        ;;
  esac
  shift
done

# Cater for standalone running of this script. Normally we are called
# with AXYL_HOME et al already defined..
if [ -z $AXYL_HOME ] ; then
	CONFDIR=/etc/axyl
	CONF=${CONFDIR}/axyl.conf
	if [ ! -f $CONF ] ; then
	  echo "Axyl configuration file $CONF not found!"
	  exit 2
	else
	  . $CONF
	  if [ ! -d $AXYL_HOME ] ; then
	    echo "FATAL: the Axyl root directory '$AXYL_HOME' does not exist."
	    exit 6
	  fi
	  . ${AXYL_HOME}/install/axyl-common.sh
	fi
fi

# We require Postgres to be locally installed, at least as postgresql-client
# even if no servers are created locally. This is based on the standard
# Debian location, with a few likely fallbacks..
find_location_of directory bin containing psql in /usr/lib/postgresql /usr /usr/local
[ "$LOC" != "" ] && PG_BIN=$LOC

# Echo and log messages..
LOGFILE=${AXYL_LOGS}/upgrade-db.log
function logit() {
  echo $1
  echo `date` $1 >> $LOGFILE
}

# Exit if no Postgres executables..
[ -z $PG_BIN ] && exit 0

# Optional host settings for remotely accessed databases..
HOSTOPTS=""
[ "$DBHOST" != "direct" ] && HOSTOPTS="--host $DBHOST --port $DBPORT"

# Upgrade the database contents (tables and data)
PSQL=${PG_BIN}/psql
if [ -x $PSQL ] ; then
  # Acquire Axyl version from ax_control table. If this table doesn't
  # exist then skip this and we assume v2.1.0 as a default.
  AXYL_DB_VERSION="2.1.0"
  AXYL_CONTROL=`$PSQL --tuples-only --username $DBUSER --dbname $DBNAME $HOSTOPTS --command "SELECT relname FROM pg_class WHERE relname='ax_control'" | tr -d ' '`
  if [ "$AXYL_CONTROL" = "ax_control" ] ; then
    AXYL_DB_VERSION=`$PSQL --tuples-only --username $DBUSER --dbname $DBNAME $HOSTOPTS --command "SELECT site_axyl_version FROM ax_control" | tr -d ' '`
    if [ "$AXYL_DB_VERSION" = "" ] ; then
  	  AXYL_DB_VERSION="2.1.0"
    fi
  fi
  if [ "$AXYL_DB_VERSION" = "$AXYL_VERSION" ] ; then
    logit "${DBNAME} is up to date."
  else
    $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --command "UPDATE ax_control set site_axyl_version='${AXYL_VERSION}'" >/dev/null
    if [ $? -eq 0 ] ; then
      logit "database ${DBNAME} stamped with version ${AXYL_VERSION}"
    else
      logit "errors occurred trying to stamp database ${DBNAME} with version ${AXYL_VERSION}"
	fi
  fi  
else
  # No psql, no action..
  exit 0
fi

# END