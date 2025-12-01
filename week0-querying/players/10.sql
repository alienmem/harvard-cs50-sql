--In 10.sql, write SQL query to answer a question of your choice. This query should:
--Make use of AS to rename a column
--Involve at least condition, using WHERE
--Sort by at least one column using ORDER BY


SELECT
    "last_name" AS "Americans"
FROM
    "players"
WHERE
    "birth_country" = 'USA'
ORDER BY
    "height" DESC;
