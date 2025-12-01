/*
It’s a bit of a slow day in the office. Though Satchel no longer plays, in 5.sql, write a SQL query to find all teams that Satchel Paige played for.

Your query should return a table with a single column, one for the name of the teams.
*/


select
    name
from
    teams
join
    performances
on
    performances.team_id = teams.id
join
    players
on
    players.id = performances.player_id
where
    first_name = 'Satchel' and last_name = 'Paige'
group by
    name;

