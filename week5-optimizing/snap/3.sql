/*
The app needs to rank a user’s “best friends,” similar to Snapchat’s “Friend Emojis” feature. Find the user IDs of the top 3 users to whom creativewisdom377 sends messages most frequently. Order the user IDs by the number of messages creativewisdom377 has sent to those users, most to least.

Ensure your query uses the search_messages_by_from_user_id index, which is defined as follows:

CREATE INDEX "search_messages_by_from_user_id"
ON "messages"("from_user_id");
*/
select
    to_user_id
from
    (select
        to_user_id, count(*) as messages_sent
    from
        messages
    where
        from_user_id = (select id from users where username ='creativewisdom377')
    group by
        to_user_id
    order by
        messages_sent desc
    limit
        3
    );

