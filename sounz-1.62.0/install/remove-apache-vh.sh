#! /bin/bash
#
# Remove an Apache Virtual Host config for SOUNZ.  Depending on the Apache
# configuration systenm in force this will either mean that the 'a2dissite'
# apache2 utility is used, or a virtualhost conf file is removed from
# the 'conf.d' directory, or (old system) an embedded virtual host setting
# is removed from the 'httpd.conf' file.
#
# NOTE: this is a utility script and does not reload apache or restart it
# after the changes have been made. Nor, does it make any backup of the
# original file.
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
if [ $# -lt 1 ] ; then
  echo "usage: $THIS servername"
  exit 3
fi
VSERVERNAME=$1
MODE="interactive"

# Files..
apache_reload=0

case $APACHE_CONFSYS in
  ap2)
    if [ -e ${APACHE_CONFDIR}/sites-enabled/${VSERVERNAME}.conf ] ; then
      tell "disabling virtualhost ${VSERVERNAME}.conf"
      if [ -x /usr/sbin/a2dissite ] ; then
      	/usr/sbin/a2dissite ${VSERVERNAME}.conf
      	if [ $? -eq 0 ] ; then
          apache_reload=1
      	fi
      else
        rm -f ${APACHE_CONFDIR}/sites-enabled/${VSERVERNAME}.conf
        apache_reload=1
      fi
    fi
    ;;
  confd)
    CONF=${APACHE_CONFDIR}/conf.d/${VSERVERNAME}.conf
    if [ -w $CONF ] ; then
      tell "removing $CONF"
      rm -f $CONF
      apache_reload=1
    fi
  	;;
  httpd)
    tell "removing embedded vhost $VSERVERNAME"
    CONF=${APACHE_CONFDIR}/httpd.conf
    APACHE_CONF_TMP=`tempfile -s vhrem`
    ${SOUNZ_HOME}/install/remove-apache-vh.pl $CONF $APACHE_CONF_TMP $VSERVERNAME $MODE
    if [ -e $APACHE_CONF_TMP ] ; then
      mv $APACHE_CONF_TMP $CONF
      apache_reload=1
    else
      tell "$THIS: a virtual host for $VSERVERNAME was not found."
    fi
  	;;
esac

# END