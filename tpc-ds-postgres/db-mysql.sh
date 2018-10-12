mysql -urefill -prefill -Dtpcds -e "drop database tpcds; create database tpcds;"mysql -urefill -prefill -Dtpcds < tpcds.sql
bash /tmp/load-tcp-data.sh

