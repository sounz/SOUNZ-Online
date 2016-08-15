#!/bin/bash
#
# Restart or re-load Apache process
# P Waite
set -e

# Name of this script
THIS=`basename $0`

# Gotta have the power..
if [ $(id -u) != 0 ] ; then
  echo "$THIS: You must be root to run this script."
  exit 2
fi

# Must have all parms for this..
if [ $# -lt 1 ] ; then
  echo "usage: $THIS restart|reload"
  exit 3
fi

INITMODE=$1
if [ "$INITMODE" != "restart" -a "$INITMODE" != "reload" ] ; then
  INITMODE=restart
fi

APACHE_NAME=apache
if [ "$2" != "" ] ; then
  APACHE_NAME=$2
fi

# Restart apache..
if [ -x /etc/init.d/${APACHE_NAME} ] ; then
  /etc/init.d/${APACHE_NAME} $INITMODE
fi

exit 0

# END