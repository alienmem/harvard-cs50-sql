--Is there a relationship between school expenditures and graduation rates? In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name.

--You should assume a school spends the same amount per-pupil their district as a whole spends.


select
    name,
    per_pupil_expenditure,
    graduated
from
    schools
join
    graduation_rates on graduation_rates.school_id=schools.id
join
    expenditures on schools.district_id=expenditures.district_id
order by
    per_pupil_expenditure desc,
    name;




