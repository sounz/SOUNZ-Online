#!/bin/bash
# Detect the database installation settings. This is ENTIRELY database
# dependent. This script is used to set WHATEVER environment variables
# that you want to be used by subsequent scripts to do stuff with the
# database.
#
# NOTE: This is not normally run standalone. The main DB manipulation
# scripts usually call this to set up environment vars for themselves.
#
# THIS SCRIPT REQUIRES THE SOUNZ COMMON FUNCTIONS TO BE DEFINED
# To do this source ${SOUNZ_HOME}/install/install-funcs.sh from a
# containing shell script, which then sources this one.
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Variables to be set by this detaction script:
if [ -z $PG_VERSION ] ; then
  PG_VERSION=          # Version of the database eg. '8.1'
fi
if [ -z $PG_MULTI_CLUSTER ] ; then
  PG_MULTI_CLUSTER=    # Eg. '8.1/main' Postgres version and cluster
fi
if [ -z $PG_BIN ] ; then
  PG_BIN=              # Path to the Postgres binary files
fi
if [ -z $PG_CONF ] ; then
  PG_CONF=             # Path to the Postgre configuration files
fi

# Vars we always set here..
PG_VERSION_SUFFIX=   # Version suffix eg. '-8.1'

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# The database type this remove script is for. This is just
# for messages and display..
DBTYPE="postgresql"
NAME="detect-db.sh"

# Database detection mode, can be 'interactive' or 'auto'. The former
# will be noisy and ask questions if it has to, whereas the latter
# just makes silent assumptions.
DB_DETECT_MODE="auto"

POS=0
while [ $# -gt 0 ] ; do
  POS=`expr $POS + 1`
  case $POS in
    1)  DB_DETECT_MODE=$1
        ;;
  esac
  shift
done

# NOTE: We are in a transition period to the multiversion architecture now used
# by PostgreSQL. So we first check if that arrangement is in force, and if it
# is, and there are multiple, we have to ask the user which version to use.
# Either way we also have to ask which cluster to use (sheesh, this is getting
# to be a maze of twisty little passages, all different!)
if [ ! -f /etc/postgresql/postgresql.env ] ; then

  # Step 1: find out which postgres client version we are using. Here we cater for
  # the fact we might already have it defined in our environment, due to a
  # previous detection run..
  if [ "$PG_VERSION" = "" ] ; then
    PG_VERSIONS="8.3 8.2 8.1 7.4"
    PG_VERSIONS_INST=
    PG_VERSIONS_COUNT=0
    for pgver in $PG_VERSIONS ; do
      PG_LOCATIONS="/usr/lib/postgresql/${pgver} /usr/local/${pgver}"
      find_location_of directory bin containing psql in $PG_LOCATIONS
      if [ "$LOC" != "" ] ; then
        PG_VERSIONS_INST="$PG_VERSIONS_INST $pgver"
        PG_VERSIONS_COUNT=`expr $PG_VERSIONS_COUNT + 1`
      fi
    done
  
    if [ $PG_VERSIONS_COUNT -eq 0 ] ; then
      if [ "$DB_DETECT_MODE" = "interactive" ] ; then
        msg="${DBTYPE} ${NAME}: WARNING: no versions of Postgresql were found."
        tell $msg
        logit $msg
      fi
      exit 1
    elif [ $PG_VERSIONS_COUNT -eq 1 ] ; then
      PG_VERSION=`echo $PG_VERSIONS_INST | cut -d' ' -f 1`
    else
      if [ "$DB_DETECT_MODE" = "interactive" ] ; then
        gotversion=0
        while [ $gotversion -eq 0 ] ; do
          PG_VERSION=`echo $PG_VERSIONS_INST | cut -d' ' -f 1`
          tell ""
          tell "Postgresql installed versions found are: $PG_VERSIONS_INST"
          tell -n "Please choose the version you want to use [$PG_VERSION]:"
          getans $PG_VERSION
          if [ "$ANS" != "" ] ; then
            PG_VERSION=$ANS
          fi
          # Check it is one of our allowed versions
          for ver in $PG_VERSIONS_INST ; do
            if [ "$ver" = "$PG_VERSION" ] ; then
              gotversion=1
              break
            fi
          done
          if [ $gotversion -eq 0 ] ; then
            tell "Sorry '$PG_VERSION' isn't an installed version. Please try again."
          fi
        done
      else
        # Auto-choose the first
        PG_VERSION=`echo $PG_VERSIONS_INST | cut -d' ' -f 1`
      fi
    fi
  fi
  
  # Create a suffix for getting correct command names. This is just a
  # dash followed by the postgres version string. For the old uni-version
  # postgres arrangement this suffix remains as a nullstring.
  PG_VERSION_SUFFIX="-${PG_VERSION}"

  # Now we can set the actual binary location..
  if [ "$PG_BIN" = "" ] ; then
    PG_LOCATIONS="/usr/lib/postgresql/${PG_VERSION} /usr/local/${PG_VERSION}"
    find_location_of directory bin containing psql in $PG_LOCATIONS
    if [ "$LOC" != "" ] ; then
      PG_BIN=$LOC
    else
      if [ "$DB_DETECT_MODE" = "interactive" ] ; then
        tell "${DBTYPE} ${NAME}: WARNING: Postgresql binary files were not found one one of these paths:"
        tell "  $PG_LOCATIONS"
        tell "Please make sure postgresql (or at least postgresql-client) of the"
        tell "given version $PG_VERSION is installed."
        logit "${DBTYPE} ${NAME}: WARNING: Postgresql client binary files were not found."
      fi
      exit 1
    fi
  fi
  
  # Determine the cluster name
  if [ "$PG_MULTI_CLUSTER" = "" ] ; then
    CLUSTER=main
    if [ "$DB_DETECT_MODE" = "interactive" ] ; then
      tell ""
      tell "Postgresql now supports 'clusters' of databases, so you have to tell"
      tell "us which one here. If you don't know what this means then just accept"
      tell "the default cluster name below."
      tell -n "Which Posgresql cluster are you using? [$CLUSTER]:"
      getans $CLUSTER
      [ "$ANS" != "" ] && CLUSTER=$ANS
    fi
    PG_MULTI_CLUSTER="${PG_VERSION}/${CLUSTER}"
  fi

  # set configuration paths for multiversion setup. At this point we expect
  # PG_MULTI_CLUSTER to contain something like '8.2/main'
  PG_CONFPATHS="/etc/postgresql/${PG_MULTI_CLUSTER} /var/lib/postgresql/${PG_MULTI_CLUSTER}"
  
else
  # This is the case where we have the OLD arrangement of non-hierarchical configs.
  # We are assuming at least postgres 7.4 is installed. Ok, will probably break if
  # earlier versions are prresent, but those are truly *ancient* and it's time the
  # upgraded already!
  if [ "$PG_VERSION" = "" ] ; then
    PG_VERSION=7.4
  fi
  
  if [ "$PG_BIN" = "" ] ; then
    PG_LOCATIONS="/usr/lib/postgresql /usr /usr/local"
    find_location_of directory bin containing psql in $PG_LOCATIONS
    if [ "$LOC" != "" ] ; then
      PG_BIN=$LOC
    else
      if [ "$DB_DETECT_MODE" = "interactive" ] ; then
        tell "${NAME}: WARNING: Postgresql binary files were not found one one of these paths:"
        tell "  $PG_LOCATIONS"
        tell "Please make sure postgresql (or at least postgresql-client) of the"
        tell "given version $PG_VERSION is installed."
        logit "${DBTYPE} ${NAME}: WARNING: Postgresql binary files were not found"
      fi
      exit 1
    fi
  fi
  # set configuration paths for universion setup
  PG_CONFPATHS="/etc/postgresql /var/lib/postgresql"
fi

# Detect configuration location
if [ "$PG_CONF" = "" ] ; then
  find_location_of file pg_hba.conf in $PG_CONFPATHS
  [ "$LOC" != "" ] && PG_CONF=$LOC  
  if [ -z $PG_CONF ] ; then
    if [ "$DB_DETECT_MODE" = "interactive" ] ; then
      tell "${NAME}: WARNING: Postgres config files not found, or not in any of the following paths:"
      tell "  $PG_CONFPATHS"
      tell "This is just because this install script probably doesn't grok your installation"
      tell "so don't panic. However it also means that we can't suss out your Postgres settings"
      tell "for security, so it's down to you I'm afraid. You need to go and make sure that"
      tell "your 'pg_hba.conf' permissions will allow database access for this (and future)"
      tell "SOUNZ databases, connecting locally. If you don't know what that means, you should"
      tell "talk to your local Postgres database guru!"
      logit "${DBTYPE} ${NAME}: WARNING: Postgresql config files (eg. pg_hba.conf) were not found"
    fi
  fi
fi

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Export detection vars..
export PG_MULTI_CLUSTER \
       PG_VERSION \
       PG_VERSION_SUFFIX \
       PG_BIN \
       PG_CONF

# END