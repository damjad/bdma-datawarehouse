mysql -urefill -prefill -Dtpcds -e "drop database tpcds; create database tpcds;"mysql -urefill -prefill -Dtpcds < tpcds.sql
DIR=/tmp/dsd
ls $DIR/*.dat | while read file; do
    pipe=$file.pipe
    mkfifo $pipe
    table=`basename $file .dat | sed -e 's/_[0-9]_[0-9]//'`
    echo $file $table
    LANG=C && sed -e ':loop' -e 's_^|_\\N|_g' -e 's_||_|\\N|_g' -e 's_||$_|\\N|_g' -e 't loop' $file > $pipe & \
    mysql --local-infile -Dtpcds -e \
          "load data local infile '$pipe' replace into table $table character set latin1 fields terminated by '|'"
    rm -f $pipe
done

