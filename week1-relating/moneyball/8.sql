/*
How much would the A’s need to pay to get the best home run hitter this past season? In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.

Your query should return a table with one column, the salary of the player.
*/

select
    salary
from
    salaries
join
    performances
on
    performances.player_id = salaries.player_id
where
    salaries.year = 2001
order by
    HR desc
limit 1;


