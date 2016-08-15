#! /bin/bash

# Returns true if replication is enabled
CONF=/etc/sounz/sounz.conf
if [ -f $CONF ] ; then
 . $CONF
fi
test -f ${SOUNZ_LOGS}/replication-enabled
