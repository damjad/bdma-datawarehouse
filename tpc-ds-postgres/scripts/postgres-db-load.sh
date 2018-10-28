#!/usr/bin/env bash
# For loading the csv files tpc ds data into the database using n cores. Using n cores instead of 1 increases the
# throughput of loading the data.
#
# USAGE: ./postgres-db-load.sh 2
# where 2 is the number of cpus.

SCHEMA_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/tpcds-kit/tools
DATA_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-data
SCRIPT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/scripts
CORES=$1

if [ -z $CORES ]; then 
    CORES=1;
fi

# exit on error
set -e

# DROP DATABASE AND CREATE A NEW ONE
echo "Dropping and creating database!"
psql postgres -q -c "drop database if exists tpcds;"
psql postgres -q -c "create database tpcds;"
psql -d tpcds < $SCHEMA_DIR/tpcds.sql

ls $DATA_DIR/*.dat | xargs -P $CORES -n 1 $SCRIPT_DIR/postgres-load-csv-data.sh

