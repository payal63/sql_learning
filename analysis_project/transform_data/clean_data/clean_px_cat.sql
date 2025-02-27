-- clean pe_cat table
select * from silver.px_cat;

-- check unwanted space
select *
from silver.px_cat
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance);

-- check normalization and consistency

select distinct * 
from silver.px_cat;

-- this table data is good
