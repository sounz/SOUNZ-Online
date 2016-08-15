#!/bin/bash

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# COMMON FUNCTIONS
# Some common functions which SOUNZ packages can source for use in
# various scripts, such as postinst etc.
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# ...........................................................................
# Make a directory path, if not already made..
mkthisdir () {
 if [ ! -d $1 ] ; then
   mkdir --verbose --parents $1
 fi
 if [ ! -d $1 ] ; then
   tell "ERROR: failed to create $1"
   tell "check permissions, and try again."
   exit 1
 fi
}

# ...........................................................................
# Duplicate the contents of one directory across to another directory.
# Create destination dir if reqd. Removes any SVN directories.
dupedir () {
 if [ -d $1 -a "$1" != "" -a "$2" != "" ] ; then
   mkthisdir $2
   set +f   
   cp -a ${1}/* $2
   find $2 -depth -type d -name ".svn" -exec rm -rf {} \;
 fi
}

# ...........................................................................
# Make a user, in all kinds of ways including system users and with or
# without preferred groups and UID's.
# $1  - the Unix username
# $2  - user type 'normal' or 'system'
# $3  - the group to be a member of, or 'default'
# $4  - the preferred UID, or 'any'
# $5  - the home directory path, or 'nohome', or 'default'
# $6  - path to the login shell, or 'noshell', or 'default'
# $7* - full user name
# egs: mkuser john normal users any /home/george /bin/bash John H. Doe
#      mkuser fred normal default 1234 nohome noshell Feddy Nobody
#      mkuser sam system default 87 default default Sam Spade
#
mkuser () {
  USR=$1; shift
  UTYPE=$1; shift
  UGROUP=$1; shift
  UUID=$1; shift
  UXUID="`grep ^${USR}: /etc/passwd | cut -d : -f 3`"
  if [ "$UXUID" = "" ] ; then
    UHOME=$1; shift
    USHELL=$1; shift
    GECOS=$*
    # Standard options..
    USER_OPTS="--quiet --disabled-password"
    if [ "$UTYPE" = "system" ] ; then
      USER_OPTS="$USER_OPTS --system --group --no-create-home"
    else
      # Group options..
      if [ "$UGROUP" != "default" ] ; then
        USER_OPTS="$USER_OPTS --ingroup $UGROUP"
      fi
      # Shell options..
      if [ "$USHELL" != "default" ] ; then
      	if [ "$USHELL" = "noshell" ] ; then
          USER_OPTS="$USER_OPTS --shell /bin/false"
      	else
          USER_OPTS="$USER_OPTS --shell $USHELL"
        fi
      fi
      # Home options..
      if [ "$UHOME" != "default" ] ; then
        if [ "$UHOME" = "nohome" ] ; then
          USER_OPTS="$USER_OPTS --no-create-home"
        else
          USER_OPTS="$USER_OPTS --home $UHOME"
        fi
      fi
    fi
    # User ID..
    if [ "$UUID" != "any" ] ; then
      UXUID="`grep :${UUID}: /etc/passwd | cut -d : -f 3`"
      if [ "$UXUID" = "" ] ; then
      	TRY_UUID=$UUID
      	END_UUID=`expr $TRY_UUID + 100`
      	set +e
      	while [ $TRY_UUID -lt $END_UUID ] ; do
          adduser $USER_OPTS --uid $TRY_UUID --gecos "$GECOS" $USR >/dev/null 2>&1
          if [ $? -ne 0 ] ; then
          	tell "Creating user $USR with UID=${TRY_UUID} failed."
            TRY_UUID=`expr $TRY_UUID + 1`
            tell "Trying UID=${TRY_UUID}.."
          else
            break
      	  fi
      	done
      	set -e
      else
        tell "User with UID=$UUID already exists. Creating $USR with next available UID.."
        adduser $USER_OPTS --gecos "$GECOS" $USR
      fi
    else
      adduser $USER_OPTS --gecos "$GECOS" $USR
    fi
    # Check it is ok..	  
    UXUID="`grep ^${USR}: /etc/passwd | cut -d : -f 3`"
    if [ "x$UXUID" = "x" ] ; then
      tell "Error: failed to create unix user account $USR"
      exit 3
    else
      tell "Unix user account $USR successfully added ($UXUID)."
    fi
  else
    # Make sure group is defined..
    if [ "$UGROUP" != "default" ] ; then
      mkgroup $UGROUP $UUID
    fi
  fi
}

# ...........................................................................
# Make sure we have a group in existence, or create it. An optional
# second argument is the preferred GID. If present we try to use it
# but repeat with no GID if we get an error - which would mean it
# is in use already. If GID is 'any' we take that as meaning no
# preference is being specified.
# $1  - the Unix group name
# $2  - Optional GID, or 'any' for the default
#
mkgroup () {
  UGROUP=$1
  UGID=$2
  UXGID="`grep ^${UGROUP}: /etc/group | cut -d : -f 3`"
  if [ "$UXGID" = "" ] ; then
    if [ "$UGID" != "" -a "$UGID" != "any" ] ; then
      UXGID="`grep :${UGID}: /etc/group | cut -d : -f 3`"
      if [ "$UXGID" = "" ] ; then
        addgroup --gid $UGID $UGROUP
      else
        addgroup $UGROUP
      fi
    else  
      addgroup $UGROUP
    fi
  fi
}

# ...........................................................................
# If interactive mode then echo message, else dont. We cater for being
# called from a Debian postinst here, by checking for the telltale
# var DEBIAN_FRONTEND being set, otherwise just a straight shell echo.
function tell () {
  if [ "$DEBIAN_FRONTEND" ] ; then
    if [ "$DEBIAN_FRONTEND" != "noninteractive" ] ; then
      if [ "$1" = "-n" ] ; then
        shift
        echo -n $1 >/dev/tty
      else
        echo $1 >/dev/tty
      fi
    fi
  else
    if [ "$MODE" = "interactive" ] ; then
      if [ "$1" = "-n" ] ; then
        shift
        echo -n $1
      else
        echo $1
      fi
    fi
  fi
}

# ...........................................................................
# If interactive mode then readin input, else set ANS=$1 (the default). We
# cater for being called from a Debian postinst here, by checking for the
# telltale var DEBIAN_FRONTEND being set. If we are not in an interative
# mode then we return $1 - which should be the required default.
function getans () {
  ANS=$1
  if [ "$DEBIAN_FRONTEND" ] ; then
    if [ "$DEBIAN_FRONTEND" != "noninteractive" ] ; then
      read ANS </dev/tty
    fi
  else
    if [ "$MODE" = "interactive" ] ; then
      read ANS </dev/tty
    fi
  fi
}

# ...........................................................................
# Asserts that a named logfile exists, owned by the SOUNZ USER. Only
# the logfile file-name is required. The directory is always assumed
# to be what $SOUNZ_LOGS is defined as. If it isn't defined, then
# /var/log is used as a failsafe.
function mklogfile() {
  if [ "$1" != "" ] ; then
    logfile=$1
    if [ -z $SOUNZ_LOGS ] ; then
      logdir=/var/log
    else
  	  logdir=$SOUNZ_LOGS
    fi
    mkthisdir $logdir
    
    # Assert logfile in that directory. NB LOGFILE
    # is a global variable used by logit()
    LOGFILE=${logdir}/${logfile}
    if [ ! -f $LOGFILE ] ; then
      >$LOGFILE
    fi

    # Always make sure it is accessible to SOUNZ apps
    chown ${SOUNZ_USER}:${SOUNZ_USER} $LOGFILE
    chmod 0664 $LOGFILE
  fi
}

# ...........................................................................
# Log a given message. If a global $LOGFILE variable is available, and
# exists as a file, then log to that. In any case also log the message
# to the syslog.
function logit() {
  [ -z $SCRIPTNAME ] && SCRIPTNAME=SOUNZ
  if [ "$1" != "" ] ; then
    # Out to logfile
    if [ ! -z $LOGFILE -a -w $LOGFILE ] ; then
      msg="[$$] ${SCRIPTNAME}: $1"
      echo `date +"%Y/%m/%d %H:%M:%S"` $msg >>$LOGFILE
    fi
    # And to syslog logger
    echo $1 | logger -t $SCRIPTNAME
  fi
}

# ...........................................................................
# Variable substitution in a directory tree..
function sub_vars () {
  A=`find $1 -type f -exec grep -l "$2" {} \;`
  if [ "$A" != "" ]; then
    wrk=`tempfile --prefix sub`
    for F in $A; do
      sed -e "s;$2;$3;g" $F > $wrk && cp $wrk $F
    done
    rm -f $wrk
  fi
}

# ...........................................................................
# Look in a set of locations for a named file or directory. If we find
# the file or directory, then return the containing directory in $LOC
# otherwise return with $LOC unset.
#
# $1 - Type of recognition item: "file" or "directory"
# $2 - Name of recognition item
# $3 - Validation flag: If "containing", then check given file is present.
#                       If "in" then following args are as per $* below.
# $4 - If $3 is "containing", then the name of the file to look for
# $5 - If $3 is "containing", then this will be set to "in"
# $* - the remaining arguments are a list of directories to look in
#
# examples:
#   find_location_of directory bin containing psql in /usr/lib/postgresql /usr /usr/local
#   find_location_of directory bin in /usr/lib/postgresql /usr /usr/local
#   find_location_of file pg_hba.conf in /etc/postgresql /var/lib/postgresql

function find_location_of () {
  LOC=
  recog_item_type=$1
  recog_item_name=$2
  validation_flag=$3
  shift ; shift ; shift
  if [ "$validation_flag" = "containing" ] ; then
    validation_file=$1 ; shift ; shift
  fi
  recog_locs=$*

  if [ "$recog_item_type" = "file" ] ; then
    validation_flag="in"
    findtype="f"
  else
    findtype="d"
  fi
  
  for loc in $recog_locs ;  do
    paths=""
    if [ -e "$loc" ]; then
  	  paths=`find $loc -type $findtype -name "$recog_item_name"`
    fi
    if [ "$paths" != "" ] ; then
  	  for path in $paths ; do
  	  	if [ "$recog_item_type" = "directory" -a "$validation_flag" = "containing" ] ; then
          if [ -e ${path}/${validation_file} ] ; then
            LOC=$path
            break
          fi
        else
          if [ "$recog_item_type" = "file" ] ; then
  	        path=`dirname $path`
            if [ -e ${path}/${recog_item_name} ] ; then
              LOC=$path
              break
            fi
          else
            LOC=$path
            break
          fi
        fi
  	  done
    fi
    [ "$LOC" != "" ] && break
  done
  true
}

# END