#!/bin/bash
# Install a POSTGRESQL database for an Axyl website.

# NOTE: This is not normally run standalone. The main DB installation
# script 'install/install-db.sh normally runs this.
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# The database type this install script is for. This is just
# for messages and display..
DBTYPE="PostgreSQL"

# INCOMING PARAMETERS
#  $1  - INSTALLTYPE
#  $2  - DBNAME
#  $3  - DBUSER
#  $4  - DBPASSWD ('none' means a blank password)
#  $5  - DBHOST ('direct' means a local database server)
#  $6  - DBPORT
#  $7  - META ('y' or 'n') - meta-data extension
#  $8  - MICRO ('y' or 'n') - microsites extension
#  $9  - AXVER (Axyl version, '' or 'n.n.n'
#  $10 - APFX (Application prefix)
#  $11 - DOCROOT (site docroot of website)
INSTALLTYPE=""
DBNAME=""
DBUSER=""
DBPASSWD=""
DBHOST=""
DBPORT=5432
META=n
MICRO=n
AXVER="unknown"
APFX=""
DOCROOT=""

POS=0
while [ $# -gt 0 ] ; do
  POS=`expr $POS + 1`
  case $POS in
    1)  INSTALLTYPE=$1
        ;;
    2)  DBNAME=$1
        ;;
    3)  DBUSER=$1
        ;;
    4)  DBPASSWD=$1
        ;;
    5)  DBHOST=$1
        ;;
    6)  DBPORT=$1
        ;;
    7)  META=$1
        ;;
    8)  MICRO=$1
        ;;
    9)  AXVER=$1
        ;;
   10)  APFX=$1
        ;;
   11)  DOCROOT=$1
        ;;
  esac
  shift
done

if [ "$INSTALLTYPE" = "" -o "$AXUSER" = "" -o "$AXYL_HOME" = "" -o "$AXYL_DATA" = "" ] ; then
  echo "ERROR: $DBTYPE install-db.sh: parameters."
  echo "usage: install-db.sh empty|demo dbname dbuser [dbpasswd] [dbhost] [dbport] [ax ver] [app pfx]"
  exit 1
fi

echo " $DBTYPE database - $INSTALLTYPE version"
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


# Now set paths to our executables
PG_INITD=/etc/init.d/postgresql${PG_VERSION_SUFFIX}
PSQL=`which psql`
CREATEDB=`which createdb`
CREATELANG=`which createlang`

# LOCALHOST INSTALLATION
if [ "$DBHOST" = "direct" -o "$DBHOST" = "localhost" -o "$DBHOST" = "127.0.0.1" ] ; then
  # Try to detect the Postgres security settings, since these will determine
  # what we can and cannot do in the way of configuration from here.
  # First, let's locate the config files..
  if [ "$PG_CONF" != "" ] ; then
    PG_HBA=${PG_CONF}/pg_hba.conf
    LTRUST=`perl -n -e "m;^local[\s]+all[\s]+all[\s]+trust$; && print;" ${PG_HBA}`
    HTRUST=`perl -n -e "m;^host[\s]+all[\s]+all[\s]+127.0.0.1[\s]+255.255.255.255[\s]+trust$; && print;" ${PG_HBA}`
    LTRUST_ENTRY="  local all  all                              trust"
    HTRUST_ENTRY="  host  all  all  127.0.0.1  255.255.255.255  trust"
    if [ "$LTRUST" = "" -o "$HTRUST" = "" ] ; then
      echo "POSTGRES SECURITY SETTINGS"
      echo "Your current Postgres security settings do not have a 'trust' set up for"
      echo "local database connections. This will probably prevent this script from"
      echo "doing its job. The script can fix this for you by putting the following"
      echo "into your ${PG_HBA} file for you, otherwise you can set something similar"
      echo "up yourself:"
      echo ""
      if [ "$LTRUST" = "" ] ; then
        echo $LTRUST_ENTRY
      fi
      if [ "$HTRUST" = "" ] ; then
        echo $HTRUST_ENTRY
      fi
      echo ""
      echo "Make these changes now?"
      echo -n "Enter Y or N [Y] :"
      read ANS
      [ "$ANS" = "" ] && ANS="y"
      if [ "$ANS" = "y" -o "$ANS" = "Y" -o "$ANS" = "yes" ] ; then
        PG_HBA_NEW=${PG_HBA}.new
        DONE=0
        (while read line ; do
          echo $line >> $PG_HBA_NEW
          if [ $DONE -eq 0 ] ; then
            A=`echo $line | perl -n -e "m;^# TYPE ; && print;"`
            if [ "$A" != "" ] ; then
              if [ "$LTRUST" = "" ] ; then
                echo $LTRUST_ENTRY >> $PG_HBA_NEW
              fi
              if [ "$HTRUST" = "" ] ; then
                echo $HTRUST_ENTRY >> $PG_HBA_NEW
              fi
              DONE=1
            fi
          fi
        done) < $PG_HBA
        TSTAMP=`date +'%F_%H%M%S'`
        mv $PG_HBA ${PG_HBA}.${TSTAMP}
        mv $PG_HBA_NEW $PG_HBA
        echo "security changes have been made"
        echo "re-loading Postgresql with the new config.."
        $PG_INITD reload
      else
        echo "Ok, no changes - installation will proceed, but you are on your own!"
      fi
    else
      echo "Postgresql security settings are ok, no changes necessary"
    fi
  fi

  # The database user should have an account on the machine too..
  mkuser $DBUSER normal default any /home/$DBUSER /bin/bash Axyl DB Admin

  # Create the appropriate database user
  tmp1=`tempfile -s axdbinst`
  tmp2=`tempfile -s axdbinst`
  if su - postgres -c "${PSQL} template1" &> /dev/null <<-EOF
CREATE USER $DBUSER WITH PASSWORD '$DBPASSWD' CREATEDB;
EOF
  then
    echo "postgres '$DBUSER' user present and correct"
  else
    echo ""
    echo "ERROR: Cannot create PostgreSQL user '${DBUSER}'."
    echo "Maybe a problem in your PostgreSQL configuration?"
    exit 1
  fi

  # Create the appropriate database
  tmp1=`tempfile -s axdbinst`
  tmp2=`tempfile -s axdbinst`
  if su - postgres -c "${CREATEDB} --username ${DBUSER} --encoding UTF-8 ${DBNAME}" 1> $tmp1 2> $tmp2 \
    && [ "$(head -1 $tmp1)" = 'CREATE DATABASE' ]
  then
    # Creation OK..
    echo "database '$DBNAME' created.."
    rm -f $tmp1 $tmp2
  else
    if grep -q "\"$DBNAME\" already exists" $tmp2
    then
      echo ""
      echo "ERROR: PostgreSQL database '${DBNAME}' already exists. As a"
      echo "failsafe measure we will not drop it. Please do so yourself"
      echo "and then re-run this script to install Axyl."
      rm -f $tmp1 $tmp2
      exit 1
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
  fi

  tmp1=`tempfile -s axdbinst`
  tmp2=`tempfile -s axdbinst`
  if [ -x $CREATELANG ] ; then
    if su - postgres -c "${CREATELANG} plpgsql ${DBNAME}" 1>$tmp1 2>$tmp2 \
      || grep -q "plpgsql added to $DBNAME" $tmp1 \
      || grep -q "plpgsql is already enabled in $DBNAME" $tmp1
    then
      # Creation OK or language already set up -- no problem here
      echo "plpgsql is enabled.."
      rm -f $tmp1 $tmp2
    else
      echo ""
      echo "Cannot enable the PLPGSQL language in the database."
      echo "Maybe a problem in your PostgreSQL configuration?"
      echo "Please report a bug to the Axyl developers, with the following:"
      echo "createlang's STDOUT:"
      cat $tmp1
      echo "enable_lang's STDERR:"
      cat $tmp2
      rm -f $tmp1 $tmp2
      exit 1
    fi
  else
    echo ""
    echo "Warning: Postgres $CREATELANG not found. Please ensure"
    echo "that the 'plpgsql' language is created/enabled in your database."
  fi
else
  if [ -x $PSQL ] ; then
    echo "Installing on remote database server --> ${DBHOST}:${DBPORT}"
    echo "(assuming Postgresql, user and passwords are already set up)"
    if [ "$DBPASSWD" = "none" ] ; then
      $PSQL --username $DBUSER --dbname template1 --host $DBHOST --port $DBPORT --command "CREATE DATABASE $DBNAME"
    else
      echo "Enter password, when prompted, as: $DBPASSWD"
      $PSQL --username $DBUSER --password --dbname template1 --host $DBHOST --port $DBPORT --command "CREATE DATABASE $DBNAME"
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

# Install/upgrade the database contents (tables and data)
if [ -x $PSQL ] ; then
  DB=${AXYL_HOME}/db/postgres
  DBSCHEMA=${DB}/axyl_core.sql
  DBTRIG=${DB}/axyl_trig.sql
  DBCOREDATA=${DB}/axyl_core_data.sql
  DBMETADATA=${DB}/axyl_meta_data.sql
  DBMICRODATA=${DB}/axyl_microsite_data.sql
  DBDEMO=${DB}/axyl_demo.db
  DBTEMP=/tmp/axyldb.sql
  if [ ! -f $DBMETADATA ] ; then
    META=n
  fi
  if [ ! -f $DBMICRODATA ] ; then
    MICRO=n
  fi

  # Create database to load. We create a temporary file with the SQL in
  # it to define the database, potentially with fixed-up Lucene port..
  if [ "$LUCENE_PORT" != "" ] ; then
    CHARCNT=`echo $LUCENE_PORT | wc --chars`
    CHARCNT=`expr $CHARCNT - 1`
  fi

  case "$INSTALLTYPE" in
    empty)
      if [ "$LUCENE_PORT" != "" ] ; then
        sed -e "s/s:5:\"22222\";/s:$CHARCNT:\"$LUCENE_PORT\";/" $DBCOREDATA > $DBTEMP
      else
        sed -e "s/\"Lucene_Site_Indexing\";b:1;/\"Lucene_Site_Indexing\";b:0;/" $DBCOREDATA > $DBTEMP
      fi
      ;;
    demo)
      if [ "$LUCENE_PORT" != "" ] ; then
        sed -e "s/s:5:\"22222\";/s:$CHARCNT:\"$LUCENE_PORT\";/" $DBDEMO > $DBTEMP
      else
        sed -e "s/\"Lucene_Site_Indexing\";b:1;/\"Lucene_Site_Indexing\";b:0;/" $DBDEMO > $DBTEMP
      fi
      ;;
  esac

  # Now load the database, either direct or remotely..
  case "$INSTALLTYPE" in
    empty)
      # Load core schema and then core data..
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBSCHEMA
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBTRIG
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBTEMP
      if [ "$META" = "y" ] ; then
        $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBMETADATA
      fi
      if [ "$MICRO" = "y" ] ; then
        $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBMICRODATA
      fi
      # Insert the Axyl control record..
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --command "INSERT INTO ax_control (site_axyl_version,app_prefix,site_docroot) VALUES ('${AXVER}','${APFX}','${DOCROOT}')"
      ;;
    demo)
      # For the demo, we load a complete database dump which
      # includes the schema and data..
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --file $DBTEMP
      # Update the Axyl control record..
      $PSQL --username $DBUSER --dbname $DBNAME $HOSTOPTS --command "UPDATE ax_control SET site_axyl_version='${AXVER}',app_prefix='${APFX}',site_docroot='${DOCROOT}'"
      ;;
  esac
  #rm -f $DBTEMP
  echo "finished"
else
  echo ""
  echo "ERROR: Could not import Axyl data - $PSQL not found."
  echo "to set up data, you must have the 'psql' utility available locally."
  echo "For Debian systems this requires installation of the 'postgresql-client'"
  echo "package. For other systems, download the applicable RPM, or tarball from"
  echo "the Postgres website: http://www.postgresql.org/"
  exit 1
fi

# END