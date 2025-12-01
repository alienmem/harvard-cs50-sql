create table users (
    id integer,
    username text not null,
    first_name text not null,
    last_name text not null,
    password text not null,
    primary key(id)
);

create table schools (
    school_id integer,
    name text not null,
    type text not null,
    location text not null,
    foundation_year integer not null,
    primary key(school_id)
);

create table companies (
    company_id integer,
    name text not null,
    industry text not null,
    location text not null,
    primary key(company_id)
);

create table user_connections (
    user_id_1 integer,
    user_id_2 integer,
    primary key(user_id_1, user_id_2),
    foreign key(user_id_1) references users(id),
    foreign key(user_id_2) references users(id)
);

create table school_connections (
    user_id integer,
    school_id integer,
    startdate datetime not null,
    enddate datetime,
    degree_earned text,
    primary key(user_id, school_id),
    foreign key(user_id) references users(id),
    foreign key(school_id) references schools(school_id)
);

create table company_connections (
    user_id integer,
    company_id integer,
    startdate datetime not null,
    enddate datetime,
    title_held text,
    primary key(user_id, company_id),
    foreign key(user_id) references users(id),
    foreign key(company_id) references companies(company_id)
);
