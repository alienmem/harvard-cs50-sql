/*
Your team is going to need a great home run hitter. Ken Griffey Jr., a long-time Silver Slugger and Gold Glove award winner, might be a good prospect. In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.

Sort by year in descending order.
Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
Your query should return a table with two columns, one for year and one for home runs.
*/

select
    year, hr
from
    players
join
    performances
on
    performances.player_id = players.id
where players.id = (select id from players where first_name = 'Ken' and birth_year = 1969)
order by
    year desc;
