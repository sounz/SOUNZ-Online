#!/bin/bash

# Generate the diff which brings old SOUNZ db to new.

OLD_DB=diffsounz
OLD_SQL=sounz-online-schema-postgres.sql

NEW_DB=${OLD_DB}-new
NEW_SQL=sounz-online-schema-postgres-new.sql

echo "re-creating old schema.."
dropdb -U paul $OLD_DB >/dev/null 2>&1
createdb -U paul $OLD_DB >/dev/null 2>&1
psql -U paul -q -f $OLD_SQL $OLD_DB >/dev/null 2>&1

echo "re-creating new schema.."
dropdb -U paul $NEW_DB >/dev/null 2>&1
createdb -U paul $NEW_DB >/dev/null 2>&1
psql -U paul -q -f $NEW_SQL $NEW_DB >/dev/null 2>&1

# Directory of patches assumed to be in pwd..
PATCHDIR=patches

# This is the current patch file count..
COUNTFILE=patch-count
if [ ! -f $COUNTFILE ] ; then
  echo "1" >$COUNTFILE
fi

# Determine a patch filename. Use a counter as a part
# of it, so we increment patches. If the current one
# exists already then check SVN, and if it is actually
# committed there, bump the patch count. If not then
# just overwrite it. So patch files are only bumped
# when one is committed.

PATCHCOUNT=`cat $COUNTFILE`
if [ "$PATCHCOUNT" = "" ] ; then
  PATCHCOUNT=1
  echo $PATCHCOUNT >$COUNTFILE
fi

PATCHFILE=${PATCHDIR}/patch-schema-${PATCHCOUNT}.sql
gotit=0
while [ $gotit -eq 0 ] ; do
  if [ -f $PATCHFILE ] ; then
    SVNSTAT=`svn status -v $PATCHFILE | cut -d' ' -f1`
    if [ "$SVNSTAT" != "?" ] ; then 
      echo "$PATCHFILE has been committed to the repository."
      echo -n "Shall we bump the patch count? [Yn]:"
      read ANS
      if [ "$ANS" = "" -o "$ANS" = "y" ] ; then
        PATCHCOUNT=`expr $PATCHCOUNT + 1`
        echo $PATCHCOUNT >$COUNTFILE
        PATCHFILE=${PATCHDIR}/patch-schema-${PATCHCOUNT}.sql
      else
        echo -n "Overwrite it then? [Yn]:"
        read ANS
        if [ "$ANS" = "" -o "$ANS" = "y" ] ; then
          gotit=1
        else
          echo "Ok, aborting this run."
          exit 1
        fi 
      fi
    else
      echo -n "$PATCHFILE exists (uncommitted). Overwrite it? [Yn]:"
      read ANS
      if [ "$ANS" = "" -o "$ANS" = "y" ] ; then
        gotit=1
      else
        echo "Ok, aborting this run."
        exit 1
      fi 
    fi
  else
    gotit=1
  fi
done

echo "diffing into $PATCHFILE" 
THISDIR=`pwd`
cd /usr/share/axyl/scripts/
sudo ./dbdiff.php --target=$OLD_DB --ref=$NEW_DB >${THISDIR}/${PATCHFILE}

# END
