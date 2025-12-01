create table passengers (
    id integer,
    first_name text not null,
    last_name text not null,
    age integer not null check(age >= 0),
    primary key(id)
);

create table check_ins (
    passenger_id integer,
    checkin_time datetime not null,
    flight_number text not null,
    foreign key(passenger_id) references passengers(id),
    foreign key(flight_number) references flights(number),
    primary key(passenger_id)
);

create table airlines (
    id text,
    name text not null,
    concourse text not null check(concourse in('A', 'B', 'C', 'D', 'E', 'F', 'T')),
    primary key(id)
);

create table flights(
    number integer,   --numbers are sometimes reused hence the composite primary key
    airline_id text not null,
    airport_departure text not null,
    airport_destination text not null,
    departure_datetime datetime not null,
    arrival_datetime datetime not null,
    foreign key(airline_id) references airlines(id),
    primary key(number, departure_datetime)
);
