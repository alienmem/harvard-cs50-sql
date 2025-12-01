select
    first_name as "first name",
    last_name as "last name",
    salary,
    HR as "home runs",
    salaries.year as "year"
from
    players
join
    salaries
on
    salaries.player_id = players.id
join
    performances
on
    performances.player_id=salaries.player_id
and
    salaries.year = performances.year
order by
    players.id,
    salaries.year desc,
    "home runs" desc,
    salary desc;








