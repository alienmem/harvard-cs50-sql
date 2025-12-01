--In 10.sql, write a SQL query to answer a question of your choice about the prints. The query should:
--Make use of AS to rename a column
--Involve at least one condition, using WHERE
--Sort by at least one column, using ORDER BY


SELECT
    "japanese_title" AS "Original Title"
FROM
    "views"
WHERE
    "id" BETWEEN 5 AND 15
ORDER BY
    "print_number" ASC;
