select count(distinct games) as count
from olympics_history
;

select distinct year,season,city
from olympics_history
order by year;
