
DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/tpc-ds-git-hub/ds-data
ls $DIR/*.dat | while read file; do
    table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
    echo "Processing file: $file and table: $table"
    psql tpcds -q -c "TRUNCATE $table"
    psql tpcds -c "\\copy $table FROM '$file' CSV DELIMITER '|'"
done

