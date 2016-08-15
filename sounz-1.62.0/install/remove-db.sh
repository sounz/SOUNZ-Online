#!/bin/bash
# Remove a POSTGRESQL database for an Axyl website.

# NOTE: This is not normally run standalone. The main DB installation
# script 'install/remove-db.sh normally runs this.
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# The database type this remove script is for. This is just
# for messages and display..
DBTYPE="PostgreSQL"

# INCOMING PARAMETERS
#  $1  - DBNAME
#  $2  - DBUSER
#  $3  - DBPASSWD ('none' means a blank password)
#  $4  - DBHOST ('direct' means a local database server)
#  $5  - DBPORT
DBNAME=""
DBUSER=""
DBPASSWD=""
DBHOST=""
DBPORT=5432

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
  esac
  shift
done

if [ "$DBNAME" = "" -o "$DBUSER" = "" ] ; then
  echo "ERROR: $DBTYPE remove-db.sh: parameters."
  echo "usage: remove-db.sh dbname dbuser [dbpasswd] [dbhost] [dbport]"
  exit 1
fi

echo " $DBTYPE database - removal"
echo " database name: $DBNAME"
echo " connecting as: $DBUSER"
[ "$DBPASSWD" != "none" ] && echo " password: $DBPASSWD"
[ "$DBHOST" != "direct" ] && echo " remote host: $DBHOST"
[ "$DBHOST" != "direct" ] && echo " port: $DBPORT"
echo ""

# Optional host settings for remotely accessed databases..
HOSTOPTS=""
[ "$DBHOST" != "direct" ] && HOSTOPTS="--host $DBHOST --port $DBPORT"

# We require Postgres to be locally installed, at least as postgresql-client
# even if no servers are created locally. This is based on the standard
# Debian location, with a few likely fallbacks.

# Detect database, and set up database vars. This set up the following
# variables:
# PG_MULTI_CLUSTER     # Eg. '8.1/main' Postgres version and cluster
# PG_VERSION           # Version of the database eg. '8.1'
# PG_VERSION_SUFFIX    # Version suffix eg. '-8.1'
# PG_BIN               # Path to the Postgres binary files
# PG_CONF              # Path to the Postgre configuration files

. ${AXYL_HOME}/db/postgres/detect-db.sh $DBNAME $DBUSER $DBPASSWD $DBHOST $DBPORT

# Now set paths to our executables
DROPDB=${PG_BIN}/dropdb
PSQL=${PG_BIN}/psql

# LOCALHOST REMOVAL
if [ "$DBHOST" = "direct" -o "$DBHOST" = "localhost" -o "$DBHOST" = "127.0.0.1" ] ; then
  # Drop the appropriate database
  tmp1=`tempfile -s axdbrem`
  tmp2=`tempfile -s axdbrem`
  if su - postgres -c "${DROPDB} --username ${DBUSER} ${DBNAME}" 1> $tmp1 2> $tmp2 \
    && [ "$(head -1 $tmp1)" = 'DROP DATABASE' ]
  then
    # Dropped OK..
    echo "database '$DBNAME' was removed.."
    rm -f $tmp1 $tmp2
  else
    echo ""
    echo "ERROR: Cannot create PostgreSQL database '${DBNAME}'."
    echo "Maybe a problem in your PostgreSQL configuration?"
    echo "Please report a bug to the Axyl developers, with the following:"
    echo "createdb's STDOUT:"
    cat $tmp1
    echo "createdb's STDERR:"
    cat $tmp2
    rm -f $tmp1 $tmp2
    exit 1
  fi
else
  if [ -x $PSQL ] ; then
    echo "removing on remote database server --> ${DBHOST}:${DBPORT}"
    echo "(assuming Postgresql, user and passwords are already set up)"
    if [ "$DBPASSWD" = "none" ] ; then
      $PSQL --username $DBUSER --dbname template1 --host $DBHOST --port $DBPORT --command "DROP DATABASE $DBNAME"
    else
      echo "Enter password, when prompted, as: $DBPASSWD"
      $PSQL --username $DBUSER --password --dbname template1 --host $DBHOST --port $DBPORT --command "DROP DATABASE $DBNAME"
    fi
  else
    echo "ERROR: $PSQL not found."
    echo "to set up a Postgres database remotely, you must at least have the"
    echo "'psql' utility available locally. For Debian systems this requires"
    echo "installation of the 'postgresql-client' package. For other systems,"
    echo "download the applicable RPM, or tarball from the website:"
    echo "http://www.postgresql.org/"
    exit 1
  fi
fi

# END