--A parent asks you for advice on finding the best public school districts in Massachusetts. In 12.sql, write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).

--You might find it helpful to know that subqueries can be inserted into most any part of a SQL query, including conditions. For instance, the following is valid SQL syntax:

--SELECT "column" FROM "table"
--WHERE "column" > (
    --SELECT AVG("column")
    --FROM "table"
--);

select
    name,
    per_pupil_expenditure,
    exemplary
from
    districts
join
    expenditures on districts.id = expenditures.district_id
join
    staff_evaluations on districts.id = staff_evaluations.district_id
where
    districts.type like '%Public%'
    and
    expenditures.per_pupil_expenditure > (select avg(per_pupil_expenditure) from expenditures)
    and
    staff_evaluations.exemplary > (select avg(exemplary) from staff_evaluations)
order by
    staff_evaluations.exemplary desc,
    expenditures.per_pupil_expenditure desc;



