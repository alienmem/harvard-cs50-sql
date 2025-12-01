create table meteorites_temp (
    name text,
    id integer,
    nametype text,
    class text,
    mass real,
    discovery text check(discovery in ('Fell','Found')),
    year integer,
    lat real,
    long real,
    primary key(id)
);


--In import.sql, write a series of SQL (and SQLite) statements to import and clean the data from meteorites.csv into a table, meteorites, in a database called meteorites.db.

.import --csv --skip 1 meteorites.csv meteorites_temp

--Any empty values in meteorites.csv are represented by NULL in the meteorites table.
--Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.

update
    meteorites_temp
set
    mass = null
where
    mass = '';

update
    meteorites_temp
set
    year = null
where
    year = '';

update
    meteorites_temp
set
    lat = null
where
    lat = '';

update
    meteorites_temp
set
    long = null
where
    long = '';

--All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
--Keep in mind that the mass, lat, and long columns have decimal values.

update
    meteorites_temp
set
    mass = round(mass, 2), lat = round(lat, 2), long = round(long, 2);

--All meteorites with the nametype “Relict” are not included in the meteorites table.

delete from
    meteorites_temp
where
    nametype = 'Relict';

--The meteorites are sorted by year, oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.

create table meteorites (
    id integer,
    name text,
    class text,
    mass real,
    discovery text,
    year integer,
    lat real,
    long real,
    primary key(id)
);

insert into
    meteorites(name, class, mass, discovery, year, lat, long)
select
    name, class, mass, discovery, year, lat, long
from
    meteorites_temp
order by
    year,
    name;

/*You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.*/





