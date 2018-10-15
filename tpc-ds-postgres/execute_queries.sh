
QUERY_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries-tmp
OUTPUT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/bdma-datawarehouse/tpc-ds-postgres/ds-queries-results-tmp

# Delete previous items
rm -f $OUTPUT_DIR/*;

for q_file in `ls $QUERY_DIR/query*.sql`; 
do 
    echo "Executing `basename ${q_file%.*}`"
    psql -d tpcds -A -t -F "," < $q_file > "$OUTPUT_DIR/`basename ${q_file%.*}`.res" 2> "$OUTPUT_DIR/`basename ${q_file%.*}`.err"
done;
 
 # Delete empty files.
 find $OUTPUT_DIR -size 0 -delete

