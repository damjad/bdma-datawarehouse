QUERY_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries-tmp
OUTPUT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries-results-tmp
SCRIPT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/scripts

CORES=$1

if [ -z $CORES ]; then 
    CORES=1;
fi

set -e

# Delete previous items
rm -f $OUTPUT_DIR/*;

ls $QUERY_DIR/query*.sql | xargs -P $CORES -n 1 $SCRIPT_DIR/postgres-execute-query.sh $OUTPUT_DIR
 
 # Delete empty files.
 find $OUTPUT_DIR -size 0 -delete

