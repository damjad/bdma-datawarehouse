#!/usr/bin/env bash
# For running the queries in a parallel fashion using n cores. Using n cores instead of 1 increases the
# throughput of running a set of queries.
#
# USAGE: ./postgres-execute-queries.sh 2
# where 2 is the number of cpus.

QUERY_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries
OUTPUT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries-results
SCRIPT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/scripts
DB_NAME=tpcds

CORES=$1

if [ -z $CORES ]; then 
    CORES=1;
fi

set -e

# Delete previous items
rm -f $OUTPUT_DIR/*;

ls $QUERY_DIR/query*.sql | xargs -P $CORES -n 1 $SCRIPT_DIR/postgres-execute-query.sh $OUTPUT_DIR $DB_NAME
 
 # Delete empty files.
 find $OUTPUT_DIR -size 0 -delete

# Show all the queries that returned an error.
if [ ! -z "`find $OUTPUT_DIR/* -name "*.err" -and ! -size 0`" ]; then
    echo "Following queries resulted in errors:"
    find $OUTPUT_DIR/* -name "*.err" -and ! -size 0
    exit 1;
fi