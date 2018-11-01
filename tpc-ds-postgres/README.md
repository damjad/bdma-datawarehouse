# TPC-DS PostgreSQL
## Introduction
TPC DS is a standard used for benchmarking relational databases with a power test.
We have used V2.10.0.

### Performing TPC DS
For performing TPC DS on PostgreSQL 10 on Linux please follow the following steps:

##### 1. Get the TPC KIT
First of all get the tpc-kit from the following github repository and build it. Build instructions are given in README.md of the repo.

URL: https://github.com/gregrahn/tpcds-kit.git
Branch: v2.10.0

##### 2. Generate data
For generating the data for different scale factors we can use the following:

````
cd tpc-kit/tools
./dsdgen -dir <data-dir> -scale <N>  -verbose y -terminate n 
````

where:
`<data-dir>`: the directory in which data is generated.
`<N>` : scale factor in *GB*. If it's 1, it will generate 1GB of data.

##### 3. Load Database
For loading the database with the generated data. We can use the following script:

````
cd tpc-ds-postgres/scripts
./postgres-db-load.sh <C>
````

where:
`<C>`: Number of processors you want to use. The script will run **C** number of parallel processes for loading the data. We recommend you to use one less than the max number of available threads.

**Important variables in the script**
* SCHEMA_DIR: The directory in which the schema (tpcds.sql) is stored. Usually `tpcds-kit/tools`
* DATA_DIR: The directory in which the data was generated.
* SCRIPT_DIR: The scripts directory of this repo. `tpc-ds-postgres/scripts`.
* DB_NAME: The name of the database. Usually `tpcds`.

After loading the data in the database check the count of records in every table. It is necessary to check whether the data is successfully loaded or not. Take a look at Table 3-2 of the specification document.

##### 4. Query Execution
For running the power test, you can use the following script to run all the queries and store the results in some directory. 
But before running the queries, make sure that you have turned on the timing feature for psql client. Otherwise, there will be no timing information.
````
vi ~/.psqlrc
# write the following
\timing on 
```` 

Now run the following for executing all the queries:
````
cd tpc-ds-postgres/scripts
./postgres-execute-queries.sh <C>
````

where:
`<C>`: Number of processors you want to use. The script will execute **C** number of parallel queries. Since PostgresSQL 10 is unable to use parallel query plan for any of the TPC queries, we recommend you to use one less than the max number of available threads.

The script will generate _*.res_ files for successful results and _*.err_ for erroneous results.

**Important variables in the script**
* QUERY_DIR: The directory in which the queries are stored i.e `tpc-ds-postgres/ds-queries`. These queries are corrected syntactically for usage in Postgres and according to the Appendix B mentioned in the specification.
* OUTPUT_DIR: The directory in which all the query results are going to be stored.
* SCRIPT_DIR: The scripts directory of this repo. `tpc-ds-postgres/scripts`.
* DB_NAME: The name of the database. Usually `tpcds`.

If you have generated the queries yourself using `dsqgen`, compare the results of the queries present in ds-queries-results or ds-queries-results-expected. 
##### 4. Results Summary
If all the queries are successful and you want to generate the results summary in a csv file, use the following bash script:

````
cd scripts
./postgres-generate-results-summary.sh
````

### Our results
Results summary obtained from the execution of the tests are stored in statistics folder.