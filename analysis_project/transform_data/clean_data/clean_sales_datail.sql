-- data cleaning in sales_detail table 

select *
from  silver.sales_detail;

-- check unwanted space,there is no white space
select sla_ord_num
from silver.sales_detail
where sla_ord_num!= trim(sla_ord_num);

-- check prd_key and sls_cust_id format
select sls_prd_key 
from silver.sales_detail
where sls_prd_key not in( select prd_key from silver.prd_info);

-- check cust_id and sls_cust_id format
select sls_cust_id 
from silver.sales_detail
where sls_cust_id not in( select cust_id from silver.cust_info);

-- check sls_order_dt,sls_ship_dt,sls_due_dt
select nullif(sls_order_dt,0)as sls_order_dt
from silver.sales_detail
where sls_order_dt in ("",0);

select sls_due_dt as sls_ship_dt
from silver.sales_detail
where sls_due_dt in ("",0);

select sls_ship_dt as sls_ship_dt
from silver.sales_detail
where sls_ship_dt in ("",0);

-- check invalid date order ,order date must be earlier than the due date and shipping date
select sls_order_dt,sls_due_dt,sls_ship_dt
from silver.sales_detail
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_ship_dt;

-- bussiness rule is sales never allowed zero ,null, negative number
-- sales always price*quantity
-- there is bad data so soltion 1: data issue will be fixed direct in source system
-- soluton 2 : we dont have budget and data is very old then data issue has to be fixed in data warehouse
select *
from silver.sales_detail
where sls_sales != sls_price * sls_quantity
or sls_sales < 0 or sls_price < 0 or sls_quantity < 0
or sls_sales is null or sls_price is null or sls_quantity is null
order by sls_sales,sls_price,sls_quantity;

-- this project i applied 3 rules 1: if sales is negative, zero, null, derive it using quantity and price
-- 2: if price is zero or null ,calculate it using sales and quantity
-- 3: if price is negative ,convert it to a positive values

select sls_sales as old_sales, sls_quantity as old_quantity, sls_price as old_price,
case when sls_sales != sls_price * sls_quantity or  sls_sales <= 0 
or sls_sales is null  then abs(sls_price) * sls_quantity end as new_sales,
case when sls_price <= 0 or sls_price is null then round(abs(sls_sales)/sls_quantity)  else sls_price end as new_price
from silver.sales_detail
where sls_sales != sls_price * sls_quantity
or sls_sales < 0 or sls_price < 0 or sls_quantity < 0
or sls_sales is null or sls_price is null or sls_quantity is null
order by sls_sales,sls_price,sls_quantity;


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
