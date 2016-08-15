#!/bin/bash
dropdb sounz_test
createdb sounz_test
psql sounz_test < ../sounz/db/sounz-online-schema-postgres.sql
psql sounz_test < ../sounz/db/patch.sql