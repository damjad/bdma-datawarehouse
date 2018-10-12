TPC_HOME=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/dwh/tpc-ds-git-hub/tpcds-kit
QUERY_TEMPLATES_DIR=$TPC_HOME/query_templates/
OUTPUT_DIR=/mnt/1717A37A1971CE02/WorkSpaces/BDMA/tmp
PWD=`pwd`

cd $TPC_HOME/tools

for tpl_file in `ls $QUERY_TEMPLATES_DIR/query*.tpl`; 
do 
./dsqgen \
-DIRECTORY $QUERY_TEMPLATES_DIR \
-TEMPLATE `basename $tpl_file` \
-VERBOSE Y \
-QUALIFY Y \
-SCALE 1 \
-DIALECT netezza \
-OUTPUT_DIR $OUTPUT_DIR && \
mv $OUTPUT_DIR/query_0.sql $OUTPUT_DIR/`basename ${tpl_file%.*}`.sql;
done;
cd $PWD;
