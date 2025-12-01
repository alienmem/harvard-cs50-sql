/*
Which teams might be the biggest competition for the A’s this year? In 6.sql, write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.

Call the column representing total hits by players in 2001 “total hits”.
Sort by total hits, highest to lowest.
Your query should return two columns, one for the teams’ names and one for their total hits in 2001.
*/

select
    name,
    sum(H) as "total hits"
from
    teams
join
    performances
on
    performances.team_id = teams.id
where
    performances.year = 2001
group by
    name
order by
    "total hits" desc
limit
    5;


