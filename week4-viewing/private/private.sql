/*Inscribed is the following table:
    14	    98	4
    114	    3	5
    618	    72	9
    630	    7	3
    932	    12	5
    2230	50	7
    2346	44	10
    3041	14	5
*/

create table pieces (
    sentence_number int,
    character_number int,
    message_length int
);

insert into
    pieces(sentence_number,character_number,message_length)
values
    (14,98,4),
    (114,3,5),
    (618,72,9),
    (630,7,3),
    (932,12,5),
    (2230,50,7),
    (2346,44,10),
    (3041,14,5);

create view
    message as
select
    substr(s.sentence,p.character_number,p.message_length) as phrase
from
    sentences as s
join
    pieces as p
on
    p.sentence_number = s.id;

