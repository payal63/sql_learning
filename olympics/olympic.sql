select count(distinct games) as count
from olympics_history
;

select distinct year,season,city
from olympics_history
order by year;

--
select count(distinct region),games from(
select oh.*,ng.region
from practice.olympics_history oh
join practice.olympics_history_noc_regions ng on oh.noc = ng.noc)x
group by games;
