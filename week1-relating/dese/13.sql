--In 13.sql, write a SQL query to answer a question you have about the data! The query should:

--Involve at least one JOIN or subquery

select
    expenditures.district_id, evaluated
from
    staff_evaluations
join
    expenditures on expenditures.district_id=staff_evaluations.district_id
limit 20;

