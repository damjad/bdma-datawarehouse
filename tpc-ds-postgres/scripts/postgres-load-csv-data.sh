#!/usr/bin/env bash
# For loading the data in to tpcds database.
# This file assumes that the file and table have same names and the schema is already created.
# USAGE: ./postgres-load-csv-data <DB_NAME> <CSV_FILE>

DB_NAME=$1
file=$2

table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
echo "Started processing file: $file and table: $table"
psql $DB_NAME -q -c "TRUNCATE $table"
psql $DB_NAME -c "\\copy $table FROM '$file' CSV DELIMITER '|'"
echo "End processing file: $file and table: $table"
