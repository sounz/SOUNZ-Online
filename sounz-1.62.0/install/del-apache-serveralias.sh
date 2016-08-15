#! /bin/bash
#
# Remove an Apache ServerAlias from an existing Virtual Host entry.
# P Waite
set -e

# Name of this script
THIS=`basename $0`

# Get common funcs and config vars etc.
# Acquire the local configuration..
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

# Parameters..
# Must have all parms for this..
if [ $# -lt 2 ] ; then
  echo "usage: $THIS servername serveralias [silent]"
  exit 3
fi
VSERVERNAME=$1
SERVERALIAS=$2
if [ "$3" != "" ] ; then
  MODE=$3
else
  MODE="interactive"
fi

# Files..
# New format or old?
if [ -e ${APACHE_CONFDIR}/conf.d ] ; then
  CONF=${APACHE_CONFDIR}/conf.d/${VSERVERNAME}.conf
  CONF_OLD=${CONF}.axyl-old
else
  CONF=${APACHE_CONFDIR}/httpd.conf
  CONF_OLD=${CONF}.axyl-old
fi

if [ -e $CONF ] ; then
  A=`perl -n -e "m;ServerAlias $SERVERALIAS; && print;" $CONF`
  if [ "$A" != "" ] ; then
    cp -a $CONF $CONF_OLD
    perl -pi -e "s;^[\s]*ServerAlias ${SERVERALIAS}[\s]*.*$;;i" ${CONF}
  else
    tell "apache server alias $SERVERALIAS not defined."
  fi
else
  tell "ERROR: no apache config found."
  exit 7
fi

# END