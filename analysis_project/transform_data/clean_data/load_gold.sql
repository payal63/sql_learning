-- transform all clean data from silver layer to gold layer table
use gold;

-- create table cust_info and insert data
create table cust_info(
cust_id int,
cust_key varchar(100),
cust_firstname varchar(100),
cust_lastname varchar(100),
cst_mariatal_status varchar(100),
cst_gender varchar(60),
cst_createdate date);


insert into gold.cust_info
(cust_id, cust_key, cust_firstname, cust_lastname, cst_mariatal_status, cst_gender, cst_createdate)
select cust_id,
	cust_key,
	trim(cust_firstname) as cust_firstname,
    trim(cust_lastname) as cust_lastname,
    case
   when trim(cst_mariatalstatus) ="M" then "Married"
   when trim(cst_mariatalstatus) ="S" then "Single"
   else "n/a"
   end as cst_marital_status,
    case
   when trim(cst_gender) ="M" then "Male"
   when trim(cst_gender) ="F" then "Female"
   else "n/a"
   end as cst_gender,
    cst_createdate
from (
select * ,
row_number() over(partition by cust_id order by cst_createdate desc) as rn
from silver.cust_info)x
where rn=1 
;

select count(*)
from gold.cust_info;

-- create table prd_info and insert clean data
create table prd_info(
prd_id int,
cat_id varchar(50),
prd_key varchar(100),
prd_nm varchar(100),
prd_cost varchar(100),
prd_line varchar(100),
prd_startdt date,
prd_enddt date);

insert into gold.prd_info
(prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_startdt, prd_enddt)
select 
	prd_id,
    replace(substring(prd_key,1,5),"-","_") as cat_id,
    substring(prd_key,7,length(prd_key))as prd_key,
    prd_nm,
    case when 
    prd_cost="" then 0 else prd_cost end as prd_cost,
    case upper(trim(prd_line))
    when "R" then "Road"
    when "M" then "Mountain"
    when "S" then "Other sales"
    when "T" then "Touring"
    else "n/a"
    end as prd_line,
    prd_startdt,
    date_sub(lead(prd_startdt) over (partition by prd_key order by prd_startdt),interval 1 day)as prd_enddt
    from silver.prd_info;
    
    select count(*)
    from gold.prd_info;
    
    -- create table slae_detail and insert data
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

insert into gold.sales_detail
(sla_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)
select  
	sla_ord_num,
    sls_prd_key,
    sls_cust_id,
    nullif(sls_order_dt,0)as sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    case when 
    sls_sales != sls_price * sls_quantity or  sls_sales <= 0 or sls_sales is null  
	then abs(sls_price) * sls_quantity 
    else sls_sales
    end as sls_sales,
    sls_quantity,
	case when sls_price <= 0 or sls_price is null 
    then round(abs(sls_sales)/sls_quantity)  
    else sls_price 
    end as sls_price
    from  silver.sales_detail
;

select count(*)
from gold.sales_detail;

-- create table cust_a and insert data into table
create table cust_a(
c_id varchar(100),
b_date date,
gender varchar(100));

insert into gold.cust_a
(c_id, b_date, gender)
select 
case when c_id like "NAS%" then substring(c_id,4,length(c_id))
else c_id
end as c_id,
case when b_date > current_date() then null 
else b_date 
end as b_date,
CASE 
        WHEN REGEXP_REPLACE(gender, '\\s+', '') IN ('M', 'Male') THEN 'Male'
        WHEN REGEXP_REPLACE(gender, '\\s+', '') IN ('F', 'Female') THEN 'Female'
       ELSE 'n/a' 
    END AS gender
from silver.cust_a
;

select count(*)
from gold.cust_a;

-- create table loc and load data
create table loc(
c_id varchar(100),
country varchar(100));

insert into gold.loc
(c_id,country)
  select replace(c_id,"-","")as c_id,
  case when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') = "DE" then "Germany"
  when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') in ("US","USA") then "United states"
  when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') = "" then "n/a"
  else country
  end as country  
 from silver.loc;
 
 select count(*) from gold.loc;
 
 -- create table product_category (px_cat) and load data
 create table px_cat(
id varchar(50),
cat varchar(100),
subcat varchar(100),
maintenance varchar(100));

INSERT INTO gold.px_cat 
SELECT * FROM silver.px_cat;

select count(*) from gold.px_cat;


