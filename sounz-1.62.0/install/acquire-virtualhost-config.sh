#!/bin/bash
# Prints out the following virtualhost configuration settings
# to stdout for the virtualhost specified on command-line:
#     DocumentRoot
#     VirtualHost
#     ServerName
#     ServerAdmin
#
# The virtualhost will be recognised by either:
#     ServerName or DocumentRoot
#
# Parameters passed in are:
#     <config filepath> -d|-s <DocumentRoot>|<ServerName>
#
# Paul Waite
#
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -e
set -f

THIS=`basename $0`

function usage_exit () {
  echo "usage: $THIS configfile -d DocumentRoot|-s ServerName"
  exit 0
}

[ $# -lt 3 ] && usage_exit
CONF=$1
MODE=$2
PATTERN=$3
[ ! -e $CONF ] && usage_exit
[ "$MODE" != "-d" -a "$MODE" != "-s" ] && usage_exit

TMPFILE=`tempfile --prefix vhdata` || true
>$TMPFILE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cat $CONF | (
  vh=""; dr=""; sn=""; sa=""
  found=0
  while read line ; do
    if [ "$vh" = "" ] ; then
      A=`echo $line | perl -ne 'm;^[\s]*<VirtualHost;i && print;'`
      if [ "$A" != "" ] ; then
        vh=`echo $line | perl -ne 's/^[\s]*<VirtualHost[\s]*(.+)>.*$/$1/ && print;'`
        vh=`echo $vh | sed -e "s;\*;ASTERISK;g"`
        sn="" ; sa=""; dr=""
        found=0
      fi
    else
      # Check for ServerName
      A=`echo $line | perl -ne 'm;^[\s]*ServerName;i && print;'`
      if [ "$A" != "" ] ; then
        sn=`echo $line | perl -ne 's/^[\s]*ServerName[\s]*(.+).*$/$1/ && print;'`
        if [ "$MODE" = "-s" ] ; then
          [ "$sn" = "$PATTERN" ] && found=1
        fi
      else
        # Check for DocumentRoot
        A=`echo $line | perl -ne 'm;^[\s]*DocumentRoot;i && print;'`
        if [ "$A" != "" ] ; then
          dr=`echo $line | perl -ne 's;^[\s]*DocumentRoot[\s]*(.+).*$;$1; && print;'`
          if [ "$MODE" = "-d" ] ; then
            [ "$dr" = "${PATTERN}" -o "$dr" = "${PATTERN}/" ] && found=1
          fi
        else
          # Check for ServerAdmin
          A=`echo $line | perl -ne 'm;^[\s]*ServerAdmin;i && print;'`
          if [ "$A" != "" ] ; then
            sa=`echo $line | perl -ne 's;^[\s]*ServerAdmin[\s]*(.+).*$;$1; && print;'`
          else
            # Check for /VirtualHost
            A=`echo $line | perl -ne 'm;^[\s]*</VirtualHost;i && print;'`
            if [ "$A" != "" ] ; then
              if [ $found -eq 1 ] ; then
                [ "$sn" = "" ] && sn=undef
                [ "$dr" = "" ] && dr=undef
                [ "$sa" = "" ] && sa=undef
                echo -n $dr $vh $sn $sa >$TMPFILE
                break
              fi
              vh=""; dr=""; sn=""; sa=""
            fi
          fi
        fi
      fi
    fi
  done
)

cat $TMPFILE
rm -f $TMPFILE

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

exit 0

# END