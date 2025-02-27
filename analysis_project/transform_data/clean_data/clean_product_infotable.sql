-- data cleaning in silver.prd_info table

select * from silver.prd_info;

-- check prd_id column,there is no duplicate prd_id column
select *
from (
select *,
row_number() over(partition by prd_id )as rn
from silver.prd_info)x
where rn>1;

-- check null values
select *
from silver.prd_info
where prd_cost="";

-- check prd_line data standardization & consistenct
select distinct prd_line
from silver.prd_info; 

-- check invalid date order
-- expectation: end date must not be the earlier than the start date
select *,
date_sub(lead(prd_startdt) over (partition by prd_key order by prd_startdt),interval 1 day)as enddt
from silver.prd_info
where prd_enddt < prd_startdt;

-- prd_key divide into category id and product key
-- in px_cat table in id column there is"_" instead of "-"
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