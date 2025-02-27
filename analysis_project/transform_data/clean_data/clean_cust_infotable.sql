-- bronze layer
-- check null or duplicate value in cust_info

select *
from silver.cust_info;

select cust_id,count(*)
from silver.cust_info
group by cust_id
having count(*)>1;

-- this cust_id 29433,0,29449,29466,29473,29483 is duplicate.remove duplicate and double check that we dont have duplicate row
select * from
(
select * ,
row_number() over(partition by cust_id order by cst_createdate desc) as rn
from silver.cust_info)x
where rn=1 
;

-- check for unwanted space
-- expectation=no result,but we got result in firstname & lastname.so there is white space
select cust_firstname
from silver.cust_info
where cust_firstname != trim(cust_firstname);

select cust_lastname
from silver.cust_info
where cust_lastname != trim(cust_lastname);

select cst_gender
from silver.cust_info
where cst_gender != trim(cst_gender);

-- data standardization and consistency
select cst_gender,cst_mariatalstatus
from silver.cust_info;

-- final query
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
