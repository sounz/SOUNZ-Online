#!/bin/bash
#
# Rebuilds a sounz database named on the command line
# Options to this script:
#   The first argument is the name of the database to rebuild
#   The rest of the options are the ones that you would pass to psql to connect
#   to the database
#


# Helper: Prints a message and exits
exit_msg () {
    echo $1
    exit 1
}

DATABASE=$1
if [ -z $DATABASE ]; then
    echo "This script rebuilds a sounz database you name"
    echo -n "Database? "
    read DATABASE

    if [ -z $DATABASE ]; then
        exit_msg "No database specified, aborting"
    fi
fi

# Read in config file and set defaults
if echo "$0" | grep "^/" > /dev/null; then
    SCRIPTPATH=`dirname $0`
else
    SCRIPTPATH=`pwd`/`dirname $0`
fi

# Remove the last run log
rm $SCRIPTPATH/dbcreation.log


# Drop, recreate, and import schema into the databases
echo "Rebuilding database $DATABASE..."
echo "Rebuilding database $DATABASE..." >> $SCRIPTPATH/dbcreation.log

# Drop the database if it exists
if psql $@ -l | grep " $DATABASE " > /dev/null; then
    dropdb $@ -q || exit_msg "The database is still being accessed. Perhaps you have the rails server or a psql terminal open connected to it?"
fi

# Create the database and schema
createdb -q -EUTF8 $@ || exit_msg "Could not connect to the database server"
psql $@ < $SCRIPTPATH/../sounz/db/sounz-online-schema-postgres.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-1.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-2.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-3.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-4.sql >> $SCRIPTPATH/dbcreation.log 2>&1
#psql $@ < $SCRIPTPATH/../sounz/db/patch-5.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-6.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-7.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-8.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-9.sql >> $SCRIPTPATH/dbcreation.log 2>&1
psql $@ < $SCRIPTPATH/../sounz/db/patch-10.sql >> $SCRIPTPATH/dbcreation.log 2>&1

# Show the errors in the log for interests sake
if egrep "ERROR|HINT" $SCRIPTPATH/dbcreation.log > /dev/null; then
    echo "*************************************************************"
    echo "WARNING: Errors were detected when rebuilding the database!!!"
    echo "Please check $SCRIPTPATH/dbcreation.log for more information "
    echo "Errors pulled from the logs follow:"
    echo "*************************************************************"
    egrep "Rebuilding|ERROR|HINT" $SCRIPTPATH/dbcreation.log --color
    echo "*************************************************************"
else
    echo "Database rebuilt successfully"
fi


echo "Reloading fixtures..."

pushd $SCRIPTPATH/../sounz/ > /dev/null
F=`cat $SCRIPTPATH/fixtures.txt`
FIXTURES=`echo $F | sed 's/\s/,/g'`
rake db:fixtures:load FIXTURES="$FIXTURES"
popd > /dev/null
