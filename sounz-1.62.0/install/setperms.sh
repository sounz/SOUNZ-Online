#! /bin/bash
# Set SOUNZ distribution permissions
# Execute this script to set the permissions for the SOUNZ HOME
# distribution tree in its entirety.
#
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -e

# Get common funcs and config vars etc.
# Acquire the local configuration..
PACKAGE=sounz
CONFDIR=/etc/${PACKAGE}
CONF=${CONFDIR}/${PACKAGE}.conf
if [ ! -f $CONF ]
then
  echo "SOUNZ configuration file $CONF not found!"
  exit 2
else
  . $CONF
  if [ ! -d $SOUNZ_HOME ] ; then
    echo "FATAL: the SOUNZ root directory '$SOUNZ_HOME' does not exist."
    exit 6
  fi
  . ${SOUNZ_HOME}/install/install-funcs.sh
fi

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ASSERT MAIN INSTALLATION PERMISSIONS and OWNERSHIP
if [ "${SOUNZ_HOME}" != "" ]
then
  chown -R ${SOUNZ_USER}:${SOUNZ_USER} ${SOUNZ_HOME}
  chmod -R 0664 ${SOUNZ_HOME}
  chmod -R ug+w ${SOUNZ_HOME}
  find ${SOUNZ_HOME} -type d -exec chmod a+x {} \;

  # Fix perms by extension
  EXEC_EXTNS="pl php rb sh"
  for extn in $EXEC_EXTNS ; do
    find ${SOUNZ_HOME} -iname "*.${extn}" -exec chmod 0775 {} \;
  done
	
  # SOUNZ executable scripts - not covered above
  # since they don't have extensions
  EXEDIRS="bin sounz/script scripts"
  for exedir in $EXEDIRS ; do
    chmod -R a+x ${SOUNZ_HOME}/${exedir}
  done

fi

# Data area
if [ "${SOUNZ_DATA}" != "" ]
then
  chown -R ${SOUNZ_USER}:${SOUNZ_USER} ${SOUNZ_DATA}
  find ${SOUNZ_DATA} -type f -exec chmod 0664 {} \;
  find ${SOUNZ_DATA} -type d -exec chmod 0775 {} \;
fi

# Logging area
if [ "${SOUNZ_LOGS}" != "" ]
then
  chown -R ${SOUNZ_USER}:${SOUNZ_USER} ${SOUNZ_LOGS}
  find ${SOUNZ_LOGS} -type f -exec chmod 0666 {} \;
  find ${SOUNZ_LOGS} -type d -exec chmod 0775 {} \;
fi

# SOUNZ config files..
if [ "${CONFDIR}" != "" ]
then
  chown -R ${SOUNZ_USER}:${SOUNZ_USER} $CONFDIR
  chmod -R 0664 $CONFDIR
  find $CONFDIR -type d -exec chmod 0775 {} \;
fi
# These files located inside config directory need to be secured
CONFSECURES="sounz.conf email.yml database.yml"
for SECURE in $CONFSECURES ; do
  if [ -f ${CONFDIR}/${SECURE} ] ; then
    chmod 0600 ${CONFDIR}/${SECURE}
  fi
done

# Apache web writeable areas. We change the group ownership and
# permissions of specific directories so that Apache processes
# can write into them.
if [ -f ${SOUNZ_HOME}/install/detect-apache.sh ] ; then
  . ${SOUNZ_HOME}/install/detect-apache.sh
  if [ "$APACHE_GROUP" != "" ] ; then
    WWWDIRS="${SOUNZ_HOME}/zencart/cache ${SOUNZ_HOME}/zencart/var ${SOUNZ_HOME}/zencart/pub ${SOUNZ_DATA}/dokuwiki"
    for WWWDIR in $WWWDIRS ; do 
      if [ -d $WWWDIR ] ; then
        chown -R ${SOUNZ_USER}:${APACHE_GROUP} $WWWDIR
        chmod -R ug+rw $WWWDIR
      fi
    done
  fi
fi

# Areas which are writeable to the 'sounzreports' user. This is the
# user that SOUNZ log on as to do reports, and also other functions
# such as uploading content.
SOUNZ_RPTS_DIRS="${SOUNZ_DATA}/download ${SOUNZ_DATA}/catalog"
for rptsdir in $SOUNZ_RPTS_DIRS ; do
  chown -R sounzreports:sounzreports $rptsdir
  find $rptsdir -type f -exec chmod 0664 {} \;
  find $rptsdir -type d -exec chmod 0775 {} \;
done

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
exit 0