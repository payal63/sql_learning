-- clean loc table

select * from silver.loc;
 
 -- check cust_id format in other table
 select *
 from silver.cust_info;
 
 -- replace "-" into "" in c_id
 select replace(c_id,"-","")as c_id
 from silver.loc;
 
 -- check format is correct or not ,so check with other table.we didn't get result that's means it is perfect
 select c_id
 from silver.loc 
 where c_id not in (select cust_id from silver.cust_a);
 
 -- check country column (data standardization & consistency)
 select distinct country as original,
 case 
	when trim(country) = "DE" then "Germany"
  when trim(country) in ("US","USA") then "United states"
  when trim(country) = "" then "n/a"
  else country
  end as new_country  
 from (
 select c_id, REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') country from silver.loc
 ) sub;
 
 select * from silver.loc limit 10;
 
 -- change c_id format and remove new line.carriage return character from country column
  select replace(c_id,"-","")as c_id,
  case when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') = "DE" then "Germany"
  when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') in ("US","USA") then "United states"
  when REGEXP_REPLACE(country, '[\r\n\t\f\v]+', '') = "" then "n/a"
  else country
  end as country  
 from silver.loc;
