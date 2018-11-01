#!/usr/bin/env bash
# For running a query in tpcds database.
# USAGE: ./postgres-execute-query.sh <OUTPUT_DIR> <DB_NAME> <QUERY_FILE>

OUTPUT_DIR=$1
DB_NAME=$2
q_file=$3

echo "Started executing `basename ${q_file%.*}`"
psql -d $DB_NAME -A -F "," < $q_file > "$OUTPUT_DIR/`basename ${q_file%.*}`.res" 2> "$OUTPUT_DIR/`basename ${q_file%.*}`.err"
echo "Ended executing `basename ${q_file%.*}`"
