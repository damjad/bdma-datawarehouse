#!/usr/bin/env bash
# For running a query in tpcds database.
# USAGE: ./postgres-execute-query.sh <OUTPUT_DIR> <QUERY_FILE>

q_file=$2
OUTPUT_DIR=$1
echo "Started executing `basename ${q_file%.*}`"
psql -d tpcds -A -F "," < $q_file > "$OUTPUT_DIR/`basename ${q_file%.*}`.res" 2> "$OUTPUT_DIR/`basename ${q_file%.*}`.err"
echo "Ended executing `basename ${q_file%.*}`"