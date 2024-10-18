select count(distinct games) as count
from olympics_history
;

select distinct year,season,city
from olympics_history
order by year;

--*
select count(distinct region),games from(
select oh.*,ng.region
from practice.olympics_history oh
join practice.olympics_history_noc_regions ng on oh.noc = ng.noc)x
group by games;

with cte as(
select count(distinct region) total,games from(
select oh.*,ng.region
from practice.olympics_history oh
join practice.olympics_history_noc_regions ng on oh.noc = ng.noc)x
group by games),
cte2 as
(
select min(total)lower,max(total)upper
from cte)
select c.total,c.games
from cte2 c2 join
cte c where c2.lower=c.total or c2.upper=c.total;
