# TPC-DI PostgreSQL with Talend Open Studio
## Introduction
TPC-DI is a benchmark tool which is made to benchmark the data integration process. DI has two major goals. First, combine information from a plenty of sources and load it in a Data Warehouse. Second, keep the Data Warehouse synchronized with the sources. These sources contain an OLTP database and some metadata from other data sources. 

### Performing TPC DI
For performing TPC DI on PostgreSQL 10 on Linux please follow the following steps:

##### Pre-requisite
Installation of Java, Talend Open Studio and PostgreSQL is a pre-requisite for performing this benchmarking.

##### 1. Get the TPC KIT
The tpc kit can be downloaded from [here](http://www.tpc.org/TPC_Documents_Current_Versions/download_programs/tools-download-request.asp?bm_type=TPC-DI&bm_vers=1.1.0&mode=CURRENT-ONLY).

##### 2. Overview
TPC-DI consists of three phases for loading the data. First one is historical load, Second and Third ones are for Incremental loads. For this project, we were only required to perform the ETL for first phase.

##### 3. Process
For execution of the project, we had discussions and groomed the project. We came up with the following process for writing each job in Talend.
    1. For ETL job of any table, we have to look at Clause 4.5 for that table. It will have the information about the source file and all the transformation we need to apply. 
    2. Go to Clause 2 and read info (location, schema) about the source files needed.
    3. Go to Clause 3 and verify that the schema created is correct or not. If not edit the schema.sql file accordingly.
    4. Write transformation as a JOB in Talend.
    5. Run the transformation job
    6. Run audit job to load audit data if it wasn’t ran earlier. Once the data is loaded, run validation query and then run audit query. See the results of the table in question.
    7. After validation, commit the exported job from Talend in the repository. We will refer this repo in the rest of the report as repo.

##### 4. Custom Component Developed
Talend comes with a variety of components that are really handy in creating the ETL jobs. However, sometimes one cannot find a component according to ones needs. It happened to us while doing DimAccount and DimCustomer. Both of these dimensions are Slowly Changing Dimensions. Both of them have Type 2 columns. In theory, whenever there is an update in the data a new row is inserted with the updated values and rest of the values remain the same. But in reality, when the files contained the updated records, they only contained the updated columns and rest of the values were considered null. Because of this, the standard SCD component from Talend considered the nulls as new values and tried to insert them in the database.
 
For handling these kinds of updates, we developed a new SCD component in Talend. We used the standard PostgresSCD component and added this functionality for all the data types. The idea is that when performing SCD we have the instance of last inserted value for that key. We are just using that instance and getting value from the previous one if the new one has null for that attribute. 

The implementation of the component can be found in the [folder](Talend/Custom-Components).

##### 5. ETL Jobs 
The ETL jobs are developed in Talend Open Studio and they are placed in this [folder](Talend/Jobs).


##### 6. PostgreSQL scripts
Scripts for loading the schema and performing audit and validation queries is present in this [folder](Postgres)


