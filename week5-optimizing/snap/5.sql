/*
For any two users, the app needs to quickly show a list of the friends they have in common. Given two usernames, lovelytrust487 and exceptionalinspiration482, find the user IDs of their mutual friends. A mutual friend is a user that both lovelytrust487 and exceptionalinspiration482 count among their friends.

Ensure your query uses the index automatically created on primary key columns of the friends table. This index is called sqlite_autoindex_friends_1.
*/

select
    fa.friend_id
from
    friends fa
join
    friends fb
on
    fb.friend_id=fa.friend_id
where
    fa.user_id = (select id from users where username ='lovelytrust487')
and
    fb.user_id = (select id from users where username ='exceptionalinspiration482');
