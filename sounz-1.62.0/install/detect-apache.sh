#!/bin/bash

# Detection of Apache settings, paths and general configuration system.
# This script is designed to be called either in-line, or run as a
# separate call. It defines the following variables, and exports them
# all into the environment.

if [ $(id -u) != 0 ]
then
  echo "You must be root to run this script."
  exit 11
fi

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Find apache configuration details. These are then set as exported
# variables for the current session.
APACHE_NAMES="apache2 apache apache-perl apache-ssl"
APACHE_NAME=apache                        # Name of the apache instance
APACHE_CONFDIR=/etc/${APACHE_NAME}        # Configuration files live here
APACHE_CONFSYS=confd                      # Type of configuration 'system'
APACHE_CONF=${APACHE_CONFDIR}/httpd.conf  # Main apache configuration file
APACHE_USER=www-data                      # User apache runs as
APACHE_GROUP=www-data                     # Group apache runs under

# Find out which brand of apache we have
for apachename in $APACHE_NAMES ; do
  find_location_of file httpd.conf in /etc/${apachename}
  if [ "$LOC" != "" ] ; then
    APACHE_CONFDIR=$LOC
    APACHE_NAME=$apachename
    break
  fi
done

# Determine the apache configuration system
if [ -d ${APACHE_CONFDIR}/sites-available ] ; then
  APACHE_CONFSYS=ap2
  if [ -r ${APACHE_CONFDIR}/apache2.conf ] ; then
  	APACHE_CONF=${APACHE_CONFDIR}/apache2.conf
  fi
elif [ -d ${APACHE_CONFDIR}/conf.d ] ; then
  APACHE_CONFSYS=confd
  if [ -r ${APACHE_CONFDIR}/apache2.conf ] ; then
  	APACHE_CONF=${APACHE_CONFDIR}/apache2.conf
  elif [ -r ${APACHE_CONFDIR}/httpd.conf ] ; then
  	APACHE_CONF=${APACHE_CONFDIR}/httpd.conf
  fi
elif [ -f ${APACHE_CONFDIR}/httpd.conf ] ; then
  APACHE_CONFSYS=httpd
  APACHE_CONF=${APACHE_CONFDIR}/httpd.conf
else
  APACHE_CONFSYS=unknown
fi

# Determine apache user and group. We have our fallback
# values defined above, but try to positively detect here.
if [ -r $APACHE_CONF ] ; then
  # apache2 has envvars to set up user/groups now
  if [ "$APACHE_CONFSYS" = "ap2" -a -r ${APACHE_CONFDIR}/envvars ] ; then
    . ${APACHE_CONFDIR}/envvars
    [ "$APACHE_RUN_USER"  != "" ] && APACHE_USER=$APACHE_RUN_USER
    [ "$APACHE_RUN_GROUP" != "" ] && APACHE_GROUP=$APACHE_RUN_GROUP
  else
    # try the main config file
    U=`grep "^User " $APACHE_CONF | cut -d" " -f2`
    G=`grep "^Group " $APACHE_CONF | cut -d" " -f2`
	[ "$G" != "" ] && APACHE_GROUP=$G
	[ "$U" != "" ] && APACHE_USER=$U
  fi
fi

export APACHE_NAME APACHE_CONFDIR APACHE_CONFSYS APACHE_CONF \
       APACHE_USER APACHE_GROUP

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# END