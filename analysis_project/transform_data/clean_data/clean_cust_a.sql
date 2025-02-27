-- clean cust_a table

select * from silver.cust_a;

-- check date is out of range or not
-- solution 1: talk with colleague change date in source system
select b_date 
from silver.cust_a
where b_date < "1924-01-01" or b_date > current_date(); 

-- data standardization and consistency
SELECT DISTINCT gender,
    CASE 
        WHEN REGEXP_REPLACE(gender, '\\s+', '') IN ('M', 'Male') THEN 'Male'
        WHEN REGEXP_REPLACE(gender, '\\s+', '') IN ('F', 'Female') THEN 'Female'
       
        ELSE 'n/a' -- Handles unexpected values
    END AS standardized_gender
FROM silver.cust_a;

SELECT distinct gender, HEX(gender) FROM silver.cust_a;

-- c_id has extra character NAS ,so we need to remove it
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
