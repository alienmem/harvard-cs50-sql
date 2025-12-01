/*
In most_populated.sql, write a SQL statement to create a view named most_populated. This view should contain, in order from greatest to least, the most populated districts in Nepal. Ensure the view contains each of the following columns:

district, which is the name of the district.
families, which is the total number of families in the district.
households, which is the total number of households in the district.
population, which is the total population of the district.
male, which is the total number of people identifying as male in the district.
female, which is the total number of people identifying as female in the district.
*/

create view
    most_populated as
select
    district,
    families,
    households,
    population,
    male,
    female
from
    census
order by
    population desc;


