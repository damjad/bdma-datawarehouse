#!/usr/bin/env bash

# For creating the results summary of execution time for all the queries.
# This script will generate a csv file with the following specifications:
# Columns:
# 1. The name of the file
# 2. Execution time of the query
# 3. If there are more than one queries, execution of the second query.

DB_RESULTS_DIR=ds-queries-results
CSV_NAME=query-time.csv
SUMMARY_DIR=`pwd`

if [ ! -z "`find $DB_RESULTS_DIR/* -name "*.err" -and ! -size 0`" ]; then
    echo "WARN: The directory also contains error files."
fi

for f in `ls $DB_RESULTS_DIR/*`
    do TIME=`cat $f | grep -Po "Time: \K\d*" | sed -e 'H;${x;s/\n/,/g;s/^,//;p;};d'`
    echo "$f,$TIME" >> $SUMMARY_DIR/$CSV_NAME
done