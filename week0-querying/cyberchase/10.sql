--In 10.sql, write a SQL query to list the ids, titles, and production codes of all episodes. Order the results by production code, from earliest to latest.

SELECT "id", "production_code", "title"
FROM "episodes"
ORDER BY "production_code";
