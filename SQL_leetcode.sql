-- Write an SQL query to find the employees who earn more than their managers.
-- Return the result table in any order.

SELECT e1.name AS Employee                 -- (Used Self Join)
FROM employee as e1, employee as e2
WHERE e1.managerID = e2.id
AND e1.salary > e2.salary

























