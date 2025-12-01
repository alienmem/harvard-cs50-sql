--DESE wants to assess which schools achieved a 100% graduation rate. In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.

select
    name
from
    schools
where
    id in
    (select
        school_id
    from
        graduation_rates
    where
        graduated = 100);
