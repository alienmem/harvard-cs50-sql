/*
In by_district.sql, write a SQL statement to create a view named by_district. This view should contain the sums for each numeric column in census, grouped by district. Ensure the view contains each of the following columns:

district, which is the name of the district.
families, which is the total number of families in the district.
households, which is the total number of households in the district.
population, which is the total population of the district.
male, which is the total number of people identifying as male in the district.
female, which is the total number of people identifying as female in the district.
*/

create view
    by_district as
select
    district,
    sum(families) families,
    sum(households) households,
    sum(population) population,
    sum(male) male,
    sum(female) female
from
    census
group by
    district;


