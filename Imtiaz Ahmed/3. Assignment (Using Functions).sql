-- GROUP BY and HAVING

SELECT department, SUM(salary) FROM employees
WHERE region_id IN (4, 5, 6, 7)        -- returns those records which satisfy the condition, filters at a record level
GROUP BY department;

-- Total number of employees in each record

SELECT department, COUNT(employee_id)
FROM employees
GROUP BY department;

SELECT department, COUNT(employee_id) as total_employees, ROUND(AVG(salary)) as AVG_salary, MIN(salary) as MIN_salary, MAX(salary) as MAX_salary
FROM employees
WHERE salary > 70000            -- filters the records
GROUP BY department
ORDER BY total_employees DESC;

SELECT department, gender, COUNT(*) FROM employees
GROUP BY department, gender
ORDER BY department;

SELECT department, COUNT(*) FROM employees   -- Cannot use "WHERE" clause here, because it does work on the aggregate levels
GROUP BY department
HAVING COUNT(*) > 35       -- Used for group data
ORDER BY department;


------------------------------------------------------------------------------------------------------------------------------
-- EXERCISES
------------------------------------------------------------------------------------------------------------------------------

-- How many people are having same first names in the company, print them

SELECT first_name, COUNT(*) FROM employees
GROUP BY first_name
HAVING COUNT(*) > 1             -- Having more than once COUNT(*)
ORDER BY COUNT(*) DESC;

-- Unique departments in the employees table

SELECT DISTINCT department FROM employees;

SELECT department FROM employees        -- Without using DISTINCT CLAUSE
GROUP BY department;

-- Give out domain of email and respective number of employees with that email

SELECT SUBSTRING(email FROM POSITION('@' IN email) + 1) as domain_name, COUNT(employee_id) FROM employees
WHERE email IS NOT NULL
GROUP BY domain_name
ORDER BY COUNT(employee_id) desc;

-- Divide each region on the basis of male and female, print respective minimum, maximum, average salary for each region
-- and gender

SELECT gender, region_id, MIN(salary) as min_salary, MAX(salary) as max_salary, ROUND(AVG(salary)) as avg_salary
FROM employees
GROUP BY gender, region_id    -- as these columns need to be aggregated
ORDER BY gender, region_id;

-------------------------------------------------------------------------------------------------------------------------
-- Assignment:
-------------------------------------------------------------------------------------------------------------------------

-- Write a query that display only the state with the largest amount of fruit supply
SELECT * FROM fruit_imports;

SELECT state FROM fruit_imports
GROUP BY state
ORDER BY MAX(supply) DESC
LIMIT 1;

-- Write a query that returns the most_expensive cost_per_unit of every season. The query should display 2 columns, season and cost_per_unit
SELECT season, MAX(cost_per_unit) as cost_per_unit
FROM fruit_imports
GROUP BY season
ORDER BY MAX(cost_per_unit) desc;

-- Write a query that returns the state that has more than 1 import of the same fruit

SELECT state, name, COUNT(name) FROM fruit_imports
GROUP BY state, name
HAVING COUNT(name) > 1;

-- Write a query that takes into consideration the supply and cost_per_unit columns for determining the toal cost and returns
-- the most expensive state with the total cost.

SELECT state, SUM(supply*cost_per_unit) as total_cost FROM fruit_imports
GROUP BY state
ORDER BY total_cost DESC
LIMIT 1;

--CREATE table fruits(fruit_name varchar(10));
--INSERT INTO fruits VALUES ('Orange');             -- Used to create the table
--INSERT INTO fruits VALUES ('Apple');
--INSERT INTO fruits VALUES (NULL);
-- INSERT INTO fruits VALUES (NULL);

SELECT * FROM fruits;

-- Write a query that return the count of 4 without using COUNT(*), use the column fruit_name
SELECT COUNT(COALESCE(fruit_name, 'NONE'))
FROM fruits;

-- Write a query that returns the seasons that produce either 3 or 4 fruits

SELECT season, COUNT(name) FROM fruit_imports
GROUP BY season
HAVING COUNT(name) IN (3, 4);








