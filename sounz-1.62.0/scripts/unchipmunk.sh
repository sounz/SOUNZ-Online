#!/bin/bash

# Exterminate all the SOUNZ chipmunks

CONF=/etc/sounz/sounz.conf
if [ -f $CONF ] ; then
  . $CONF
else
  echo "No $CONF found!"
  exit 1
fi

TMP=`tempfile -p mp3list`
LOGFILE=/tmp/mp3conv.log
echo "" >>$LOGFILE
echo "starting mp3 conversion at " `date` >>$LOGFILE

MEDIA=${SOUNZ_DATA}/media_items
if [ ! -d $MEDIA ] ; then
  echo "No media items at $MEDIA"
  exit 1
fi

LAME=`which lame`
if [ "$LAME" = "" ] ; then
  echo "install lame first"
  echo "apt-get install lame"
  exit 1
fi

MP3INFO=`which mp3info`
if [ "$MP3INFO" = "" ] ; then
  echo "install mp3info first"
  echo "apt-get install mp3info"
  exit 1
fi


# Go to media items dir
cd $MEDIA
find . -type f -name "*.mp3" -print >$TMP
 
wrkmp3=/tmp/new.mp3
(
while read mp3path ; do
  TSTAMP=`date "+%Y-%m-%d %H:%M:%S"`
  chk=`$MP3INFO -x $mp3path 2>/dev/null | grep "Audio:" | grep "44 kHz"`
  if [ "$chk" = "" ] ; then
    $LAME --silent --resample 44.1 -b 64 --cbr $mp3path $wrkmp3 >/dev/null 2>&1
    err=$?
    if [ $err -eq 0 ] ; then
      cp $wrkmp3 $mp3path
      if [ $? -eq 0 ] ; then
        status="RESAMPLED"
      else
        status="**ERROR $err"
      fi
    fi
  else
    status="44KHz OK "
  fi
  echo "${TSTAMP} ${status} ${mp3path}" >>$LOGFILE
done
) < $TMP

rm -f $wrkmp3
rm -f $TMP
