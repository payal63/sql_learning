-- sql project
-- bronze layer
use  bronze;

-- create customer_information table
create table cust_info(
cust_id int,
cust_key varchar(100),
cust_firstname varchar(100),
cust_lastname varchar(100),
cst_mariatalstatus varchar(100),
cst_gender varchar(60),
cst_createdate date);

-- create product_information table
create table prd_info(
prd_id int,
prd_key varchar(100),
prd_nm varchar(100),
prd_cost varchar(100),
prd_line varchar(100),
prd_startdt date,
prd_enddt date);

-- create sales_detail table
create table sales_detail(
sla_ord_num varchar(50),
sls_prd_key varchar (100),
sls_cust_id varchar(100),
sls_order_dt date,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int);

-- create customer detail table
create table cust_a(
c_id varchar(100),
b_date date,
gender varchar(100));

-- create location table
create table loc(
c_id varchar(100),
country varchar(100));

-- create product_category table
create table px_cat(
id varchar(50),
cat varchar(100),
subcat varchar(100),
maintenance varchar(100));

-- load all data in cust_info
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\cust_info.csv'
ignore INTO TABLE cust_info
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- This code is a MySQL statement that grants file-related privileges to the root user and refreshes the privilege system.
GRANT FILE ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

-- check the directory path where my sql is allowed to read and write file
SHOW VARIABLES LIKE 'secure_file_priv';

select count(1) from bronze.cust_info;

-- load all data in product information
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\prd_info.csv'
ignore INTO TABLE prd_info
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(1) from bronze.prd_info;

-- load all data in sales_detail
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\sales_details.csv'
ignore INTO TABLE sales_detail
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(1) from bronze.sales_detail;

-- load all data  in customer detail table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\CUST_AZ12.csv'
ignore INTO TABLE cust_a
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(1) from bronze.cust_a;

-- load all data in location
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\LOC_A101.csv'
ignore INTO TABLE loc
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- load all data in prodct category
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\PX_CAT_G1V2.csv'
ignore INTO TABLE px_cat
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(1) from bronze.px_cat;
