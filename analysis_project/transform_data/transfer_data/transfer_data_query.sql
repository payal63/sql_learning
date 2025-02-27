-- put all data from one schema table to other schema table

use silver;

-- create cust_info table in silver schema
create table cust_info(
cust_id int,
cust_key varchar(100),
cust_firstname varchar(100),
cust_lastname varchar(100),
cst_mariatalstatus varchar(100),
cst_gender varchar(60),
cst_createdate date);

-- another type how to copy one table from one schema to another schema
CREATE TABLE silver.cust_info AS
SELECT * FROM bronze.cust_info;

-- copy data from one table to other table
INSERT INTO silver.cust_info 
SELECT * FROM bronze.cust_info;

select * from silver.cust_info;

-- create loc table
CREATE TABLE silver.loc AS
SELECT * FROM bronze.loc;

-- copy data one table to another table
INSERT INTO silver.loc 
SELECT * FROM bronze.loc;

select * from bronze.loc;

-- create table prd_info
create table silver.prd_info(
prd_id int,
prd_key varchar(100),
prd_nm varchar(100),
prd_cost varchar(100),
prd_line varchar(100),
prd_startdt date,
prd_enddt date);

-- load data but getting error so try to update table but still getting error
UPDATE bronze.prd_info
SET prd_enddt = NULL
WHERE prd_enddt = '0000-00-00';

UPDATE bronze.prd_info
SET date_column = CASE 
    WHEN date_column = '0000-00-00' THEN NULL 
    ELSE date_column 
END;

-- check table and find that date is '0000-00-00'
select * from bronze.prd_info;

-- it happens may be SQL mode settings in MySQL that prevent updates to invalid date formats.
-- SQL mode may be set to STRICT_TRANS_TABLES, which can prevent operations on invalid dates
--  STRICT_TRANS_TABLES or NO_ZERO_DATE is present, it could be the cause of the issue.
SELECT @@sql_mode;

-- You can temporarily change the SQL mode to allow updates with invalid dates.
SET sql_mode = '';

-- update table where invalid date ,convert into null
UPDATE bronze.prd_info
SET prd_enddt = CASE 
    WHEN prd_enddt = '0000-00-00' THEN NULL 
    ELSE prd_enddt
END;

-- load data successfully
INSERT INTO silver.prd_info 
SELECT * FROM bronze.prd_info;

select * from silver.prd_info;

-- create table product category and load data
create table silver.px_cat as
select * from bronze.px_cat;

select * from silver.px_cat;

-- create table sales detail and load data
create table silver.sales_detail as
select * from bronze.sales_detail;

select * from silver.sales_detail;

-- create table customer detail and load data
create table silver.cust_a as
select * from bronze.cust_a;

select * from silver.cust_a;