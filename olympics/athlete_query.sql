-- olympic game sql query

-- how many olympic games have been held?
select count(distinct games) as count
from olympics_history
;

-- list down all olympic games held so far?
select distinct year,season,city
from olympics_history
order by year;

-- Mention the total no of nations who participated in each olympics game?
select count(distinct region) as total_nation,games from(
select oh.*,ng.region
from practice.olympics_history oh
join practice.olympics_history_noc_regions ng on oh.noc = ng.noc)x
group by games;

-- Which year saw the highest and lowest no of countries participating in olympics?
with cte as(
select count(distinct region) total,games from(
select oh.*,ng.region
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc = ng.noc)x
group by games),
cte2 as
(
select min(total)as lower,max(total)as upper
from cte)
select c.total,c.games
from cte2 c2 join
cte c where c2.lower=c.total or c2.upper=c.total;

-- Which nation has participated in all of the olympic games?

with cte as(
select oh.games,ng.region as country
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.NOC
group by oh.games,ng.region),
total_game as
(
select count(distinct games) as total_games
from practice.olympics_history),
participate_country as
(select country,count(*)as total from cte
group by country)
select pc.*
from participate_country pc
join total_game tg on pc.total=tg.total_games;

-- Identify the sport which was played in all summer olympics?.

with t1 as
( 
select count(distinct games) as total_games
from practice.olympics_history
where season="summer"),
t2 as
(select distinct games ,sport
from practice.olympics_history
where season ="summer"),
t3 as
(
select sport,count(1)as total
from t2
group by sport)
select t3.sport,t3.total
from t3 join t1 on t3.total=t1.total_games;

-- Which Sports were just played only once in the olympics?
with t1 as(
select distinct games,sport
from practice.olympics_history
)
select sport,count(*)as total
from t1
group by sport
having total =1;

-- Fetch the total no of sports played in each olympic games?
select distinct games ,count(distinct sport)as total
from practice.olympics_history
group by games
order by total desc;

--  Fetch oldest athletes to win a gold medal

select name,max(age)as age
from practice.olympics_history
where medal ="gold"
group by age,name
order by age desc
limit 2;

-- Find the Ratio of male and female athletes participated in all olympic games.

select concat("1: ",round(male/female,2))as ratio from (
select
sum(case when sex="M" then 1 else 0 end) as male,
sum(case when sex="F" then 1 else 0 end) as female
from practice.olympics_history)x;

--  Fetch the top 5 athletes who have won the most gold medals?
select name,count(*) as total
from practice.olympics_history
where medal="gold"
group by name
order by total desc
limit 5;

-- Fetch the top 5 athletes who have won the most medals ?
select name, count(medal) as total
from practice.olympics_history
where medal in ("gold","silver","bronze")
group by name
order by total desc
limit 5;

--  Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.?
select ng.region as country,count(oh.medal) as total
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze")
group by country
order by total desc
limit 5;

--  List down total gold, silver and bronze medals won by each country.
with t1 as (
select ng.region as country,oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze"))
select country,
sum(case when medal="gold" then 1 else 0 end) as gold,
sum(case when medal="silver" then 1 else 0 end) as silver,
sum(case when medal="bronze" then 1 else 0 end) as bronze
from t1
group by country
order by gold desc;

-- List down total gold, silver and bronze medals won by each country corresponding to each olympic games.?
with t1 as (
select oh.games as games,ng.region as country,oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze"))
select games,country,
sum(case when medal="gold" then 1 else 0 end) as gold,
sum(case when medal="silver" then 1 else 0 end) as silver,
sum(case when medal="bronze" then 1 else 0 end) as bronze
from t1
group by games,country
order by games;

-- Identify which country won the most gold, most silver and most bronze medals in each olympic games.
with t1 as (
select oh.games as games, ng.region as country, oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze")),
t2 as
(select games, country,
sum(case when medal="gold" then 1 else 0 end) as gold,
sum(case when medal="silver" then 1 else 0 end) as silver,
sum(case when medal="bronze" then 1 else 0 end) as bronze
from t1
group by games,country),
t3 as (
select games,
max(gold)as max_gold,
max(silver)as max_silver,
max(bronze)as max_bronze
from t2
group by games
)
select t3.games,
concat(tg.country, ' - ', tg.gold) as gold,
concat(ts.country, ' - ', ts.silver) as silver,
concat(tb.country, ' - ', tb.bronze) as bronze
from t3 left join t2 as tg on (t3.games = tg.games and t3.max_gold = tg.gold)
left join t2 as ts on (t3.games = ts.games and t3.max_silver = ts.silver)
left join t2 as tb on (t3.games = tb.games and t3.max_bronze = tb.bronze)
;

-- Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
with t1 as (
select oh.games as games, ng.region as country, oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze")),
t2 as
(select games, country,
sum(case when medal="gold" then 1 else 0 end) as gold,
sum(case when medal="silver" then 1 else 0 end) as silver,
sum(case when medal="bronze" then 1 else 0 end) as bronze,
sum(case when medal in ("gold","silver","bronze") then 1 else 0 end) as total_medal
from t1
group by games,country),
t3 as(
select games,
max(gold)as max_gold,
max(silver)as max_silver,
max(bronze)as max_bronze,
max(total_medal) as max_total
from t2
group by games)
select t3.games,
concat(tg.country, ' - ', tg.gold) as gold,
concat(ts.country, ' - ', ts.silver) as silver,
concat(tb.country, ' - ', tb.bronze) as bronze,
concat(tm.country, " - ", tm.total_medal) as max_country
from t3 left join t2 as tg on (t3.games = tg.games and t3.max_gold = tg.gold)
left join t2 as ts on (t3.games = ts.games and t3.max_silver = ts.silver)
left join t2 as tb on (t3.games = tb.games and t3.max_bronze = tb.bronze)
left join t2 as tm on (t3.games = tm.games and t3.max_total =tm.total_medal)
;


-- Which countries have never won gold medal but have won silver/bronze medals?
with t1 as (
select oh.games as games, ng.region as country, oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where medal in("gold","silver","bronze")),
t2 as
(select  country,
sum(case when medal="gold" then 1 else 0 end) as gold,
sum(case when medal="silver" then 1 else 0 end) as silver,
sum(case when medal="bronze" then 1 else 0 end) as bronze
from t1
group by country)
select country,silver,bronze
from t2
where gold=0;

-- In which Sport/event, India has won highest medals.
with t1 as
(
select oh.sport as sport, oh.event as event, ng.region as country, oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where ng.region = "india" and medal in ("gold","silver","bronze"))
select sport,event,count(medal) as total
from t1
group by sport, event
order by total desc
limit 1;

-- Break down all olympic games where India won medal for Hockey and how many medals in each olympic games?
with t1 as
(
select oh.sport as sport, oh.games as games, ng.region as country, oh.medal as medal
from practice.olympics_history oh
join practice.noc_regions ng on oh.noc=ng.noc 
where ng.region = "india" and medal in ("gold","silver","bronze"))
select sport,games,count(medal) as total
from t1
group by games,sport
order by total desc;