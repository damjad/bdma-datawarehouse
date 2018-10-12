
QUERY_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/tpc-ds-git-hub/ds-queries
OUTPUT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/tpc-ds-git-hub/ds-queries-results
for q_file in `ls $QUERY_DIR/query*.sql`; 
do 
    echo "Executing `basename ${q_file%.*}`"
    psql -d tpcds -A -t -F "," < $q_file > "$OUTPUT_DIR/`basename ${q_file%.*}`.res" 2> "$OUTPUT_DIR/`basename ${q_file%.*}`.err"
done;
