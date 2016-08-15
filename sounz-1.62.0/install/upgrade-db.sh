#!/bin/bash

# DATABASE UPGRADE
# Upgrade application database using a patch file containing SQL
# statements. This script is designed to be included by the 'postinst'
# script of SOUNZ packages, and assumes that certain vars such as
# DB_NAME, DB_USER etc. are already defined in the environment.
#
# Required defined variables:
#   APP_VERSION
#   SOUNZ_HOME, SOUNZ_LOGS
#   DB_NAME, DB_USER, DB_PASSWD, DB_HOST, DB_PORT
#   PG_BIN

# This relies on there being a special control table in the database
# called 'app_control' which contains a text field 'app_version'. The
# version of this upgrade is then compared and SQL patches sought
# in $SOUNZ_HOME/db/patches. This script will apply multiple patches to
# arrive at the new version, if required.
#
# Files in 'db/patche/' must adhere to a strict naming format if they are
# to be automatically picked up by the postinst patch-applier. The format
# is:
#     upgrade_P.Q.R_to_X.Y.Z.sql
#
# where:
#     P.Q.R is the version that the last patch upgraded to 
#     X.Y.Z is the new version this patch will upgrades the schema to
#
# The patch applier will apply mutiple patches to span more than one version
# in the sequence, if required.
#
# In general, there is not a database patch for each version upgrade of the
# package. That's just fine, and you can just create a database patch just for
# the versions which do need one, and the patcher will use it each time.
#
# Eg. if the last patch file was for the upgrade 2.3.0 --> 2.3.1, but there
# was no patch for 2.3.1 --> 2.3.2, or 2.3.2 --> 2.3.3, and then for the
# next upgrade of 2.3.3 --> 2.3.4, there IS a patch file, you would just
# name your patch file as: 'upgrade_2.3.3_to_2.3.4.sql' and the patcher
# will do the right thing.
#
# In other words, just include patche files for the upgrades which need 'em!

# Echo and log messages..
LOGFILE=${SOUNZ_LOGS}/upgrade-db.log

PSQL=${PG_BIN}/psql
PGDUMP=${PG_BIN}/pg_dump

# Upgrade the database contents (tables and data)
if [ -x $PSQL ] ; then
    # Optional host settings for remotely accessed databases..
    HOSTOPTS=""
    #[ "$DB_HOST" != "" ] && HOSTOPTS="--host $DB_HOST --port $DB_PORT"
	
    # Make sure our database connection user is present..
    USER=`$PSQL --tuples-only --username postgres --dbname template1 $HOSTOPTS --command "SELECT usename FROM pg_user WHERE usename='$DB_USER'" | tr -d ' '`
    if [ "$USER" != "$DB_USER" ] ; then
        logit "creating database user ${DB_USER}.."
        $PSQL --username postgres --dbname template1 $HOSTOPTS --command "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWD' CREATEDB"
    else
        logit "database user $DB_USER exists - good."
    fi

    # Acquire application version from app_control table which must exist
    # or else we simply skip the rest of the process.
    APP_DB_VERSION=
    logit "checking for app_control existence.."
    APP_CONTROL=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "SELECT relname FROM pg_class WHERE relname='app_control'" | tr -d ' '`
    if [ "$APP_CONTROL" = "app_control" ] ; then
        logit "application app_control table was found"
        APP_DB_VERSION=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "SELECT app_version FROM app_control" | tr -d ' '`
        if [ "$APP_DB_VERSION" != "" ] ; then
            if [ "$APP_DB_VERSION" = "$APP_VERSION" ] ; then
                logit "database ${DB_NAME} is up to date."
            else
                # Ok, we know the database version, and we know the application installation version.
                # Now let's see if we have a patch file series for this upgrade.
                # No patch files, no upgrade.
                logit "current application version is registered as $APP_DB_VERSION"
                gotpatches=0
                skippatches=0
                LAST_DB_PATCH=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "SELECT last_db_patch FROM app_control" | tr -d ' '`
                if [ "$LAST_DB_PATCH" = "" ] ; then
                    logit "no patch reference, will skip patches this time around"
                    skippatches=1
                fi
                UPGRADEROOT=${SOUNZ_HOME}/db/patches
                cd ${UPGRADEROOT}
                patchSQL=`tempfile --prefix dbupgrade` 
                patchfiles=`${SOUNZ_HOME}/install/get_patchfiles.pl $UPGRADEROOT $LAST_DB_PATCH`
                logit $patchfiles
                for patchfile in $patchfiles ; do
                    chk=`echo $patchfile | cut -d'_' -f1`
                    if [ "$chk" = "upgrade" ] ; then
                        patchnos=`echo $patchfile | sed "s;.sql;;"`
                        if [ "$patchnos" != "" ] ; then
                            fromver=`echo $patchnos | cut -d'_' -f2`
                            nextver=`echo $patchnos | cut -d'_' -f4`
                            if [ $skippatches -eq 1 ] ; then
                                logit "skipping patch $fromver --> $nextver"
                            else
                                logit "adding patch $fromver --> $nextver"
                                cat $patchfile >> $patchSQL
                            fi
                            gotpatches=1
                        fi
                    else
                        LAST_DB_PATCH=$patchfile
                    fi
                done
                if [ $gotpatches -eq 1 ] ; then
                    if [ $skippatches -eq 0 ] ; then
                    	tell "dumping database before applying patches"
                        dumpdir=${SOUNZ_DATA}/backup
                        if [ ! -d $dumpdir ] ; then
                          mkthisdir $dumpdir
                          chown ${SOUNZ_USER}:${SOUNZ_USER} $dumpdir
                        fi
                        tstamp=`date +"%Y%m%d_%H%M%S"`
                        dumpfile=${dumpdir}/${DB_NAME}_${APP_DB_VERSION}_${tstamp}.sql.dump
                        sudo su $SOUNZ_USER -c "$PGDUMP --username $DB_USER --no-owner $DB_NAME >$dumpfile"
                        tell "database '$DB_NAME' dumped into $dumpfile"
                        logit "database '$DB_NAME' dumped into $dumpfile"
                        logit "patching $DB_NAME $APP_DB_VERSION --> $APP_VERSION"
                        $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --file $patchSQL >>$LOGFILE 2>&1
                        if [ $? -ne 0 ] ; then
                            logit "errors occurred during the patch process"
                        fi
                        logit "patches were applied."
                    fi
                    $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "UPDATE app_control SET last_db_patch='$LAST_DB_PATCH'" >>$LOGFILE 2>&1
                    logit "database patch record updated"
                else
                    tell "no patches to apply"
                    logit "no patches to apply"
                fi
            fi
            # Leave the application at the correct version for next time..
            $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "UPDATE app_control SET app_version='$APP_VERSION',updated_at=CURRENT_TIMESTAMP" >>$LOGFILE 2>&1
            logit "application version record was updated to $APP_VERSION"
            # Remove temporary patch file..
            rm -f $patchSQL
		else
            # All we do in this case is assume everything is up to date..
            logit "no version data found. Checking record exists.."
            LAST_DB_PATCH="000000000000-000100000000"
            N=`$PSQL --tuples-only --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "SELECT COUNT(*) FROM app_control" | tr -d ' '`
            if [ $N -eq 0 ] ; then
              logit "no record present. Inserting one with version $APP_VERSION of package $PACKAGE"
              $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "INSERT INTO app_control (app_version,last_db_patch,updated_at) VALUES('$APP_VERSION','$LAST_DB_PATCH',CURRENT_TIMESTAMP)" >>$LOGFILE 2>&1
            else
              logit "record exists, assuming $DB_NAME is up to date and updating version record to $APP_VERSION"
              $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "UPDATE app_control SET app_version='$APP_VERSION',last_db_patch='$LAST_DB_PATCH',updated_at=CURRENT_TIMESTAMP" >>$LOGFILE 2>&1
            fi
        fi
    else
        # No app_control..
        logit "no app_control table creating it now.."
        LAST_DB_PATCH="000000000000-000100000000"
        $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "CREATE TABLE app_control (app_version text, last_db_patch text, updated_at timestamp)" >>$LOGFILE 2>&1
        logit "seeding it with version $APP_VERSION of package $PACKAGE"
        $PSQL --username $DB_USER --dbname $DB_NAME $HOSTOPTS --command "INSERT INTO app_control (app_version,last_db_patch,updated_at) VALUES('$APP_VERSION','$LAST_DB_PATCH',CURRENT_TIMESTAMP)" >>$LOGFILE 2>&1
    fi
else
    logit "Postgres client utility 'psql' not found."
fi

tell "the database upgrade log is in $LOGFILE"

# END