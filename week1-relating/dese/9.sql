--Another parent wants to send their child to a district with few other students. In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. Report only the name(s).

select
    name
from
    districts
where id in (
    select
        district_id
    from
        expenditures
    where
        pupils = (
            select
                min(pupils)
            from
                expenditures)
);

