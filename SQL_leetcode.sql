-- Write an SQL query to find the employees who earn more than their managers.
-- Return the result table in any order.

SELECT e1.name AS Employee                 -- (Used Self Join)
FROM employee as e1, employee as e2
WHERE e1.managerID = e2.id
AND e1.salary > e2.salary

----------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+-------------+---------+
| Column Name | Type    |
 +-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to report all the duplicate emails.

Return the result table in any order. */

SELECT email
FROM person
GROUP BY email
HAVING COUNT(email) > 1

























