#! /bin/bash
#
# Add an Apache ServerAlias to and existing Virtual Host entry
# P Waite
set -e

# Name of this script
THIS=`basename $0`

# Get common funcs and config vars etc.
# Acquire the local configuration..
CONFDIR=/etc/sounz
CONF=${CONFDIR}/sounz.conf
if [ ! -f $CONF ] ; then
  echo "SOUNZ configuration file $CONF not found!"
  exit 2
else
  . $CONF
  if [ ! -d $SOUNZ_HOME ] ; then
    echo "FATAL: the SOUNZ home directory '$SOUNZ_HOME' does not exist."
    exit 6
  fi
	# Detect the APACHE configuration settings. Sets up the following vars:
	# APACHE_NAME     # Name of the apache instance eg. 'apache2'
	# APACHE_CONFDIR  # Configuration files live here
	# APACHE_CONFSYS  # Type of config system: 'ap2', 'confd' or 'httpd'
	# APACHE_CONF     # Path to main apache configuration file
	# APACHE_USER     # User apache runs as eg. 'www-data'
	# APACHE_GROUP    # Group apache runs under eg. 'www-data'
	if [ -f ${SOUNZ_HOME}/install/detect-apache.sh ] ; then
	  	. ${SOUNZ_HOME}/install/detect-apache.sh
	fi
fi

# Parameters..
if [ $# -lt 2 ] ; then
  echo "usage: $THIS servername serveralias"
  exit 3
fi
VSERVERNAME=$1
SERVERALIAS=$2
MODE="interactive"

# Files..
# New format or old?
if [ -e ${APACHE_CONFDIR}/conf.d ]
then
  CONF=${APACHE_CONFDIR}/conf.d/${VSERVERNAME}.conf
  CONF_OLD=${CONF}.sounz-old
else
  CONF=${APACHE_CONFDIR}/httpd.conf
  CONF_OLD=${CONF}.sounz-old
fi

if [ -e $CONF ] ; then
  A=`perl -n -e "m;ServerAlias $SERVERALIAS; && print;" $CONF`
  if [ "$A" = "" ] ; then
    cp -a $CONF $CONF_OLD
    perl -pi -e "s;^[\s]*ServerName ${VSERVERNAME}$;  ServerName ${VSERVERNAME}\n  ServerAlias ${SERVERALIAS};i" ${CONF}
  else
    tell "apache server alias $SERVERALIAS already exists."
  fi
else
  tell "ERROR: no apache config found."
  exit 7
fi

# END