/*
Hits are great, but so are RBIs! In 12.sql, write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.

Your query should return a table with two columns, one for the players’ first names and one of their last names.
You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).
Keep in mind the lessons you’ve learned in 10.sql and 11.sql!
*/

select
    first_name,
    last_name
from
    players
where
    id in (
        select
            s.player_id
        from
            salaries as s
        join
           performances as p
        on
            s.player_id = p.player_id
        where
            s.year = 2001
        and
            p.year = 2001
        and
            H > 0
    order by
        s.salary / H
    limit 10
    )
intersect
select
    first_name,
    last_name
from
    players
where
    id in (
        select
            s.player_id
        from
            salaries as s
        join
            performances as p
        on
            s.player_id = p.player_id
        where
            s.year = 2001
            and p.year = 2001
            and RBI > 0
        order by
            s.salary / RBI
        limit
            10
    )
order by
    last_name,
    first_name;
