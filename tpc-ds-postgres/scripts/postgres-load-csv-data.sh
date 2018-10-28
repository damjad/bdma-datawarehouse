file=$1
table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
echo "Started processing file: $file and table: $table"
psql tpcds -q -c "TRUNCATE $table"
psql tpcds -c "\\copy $table FROM '$file' CSV DELIMITER '|'"
echo "End processing file: $file and table: $table"
