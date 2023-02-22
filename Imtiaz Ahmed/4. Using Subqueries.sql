SELECT first_name, last_name, * FROM employees;   -- but here, we get both the columns and the entire table

SELECT d.department FROM employees AS e, departments AS d;     -- Giving the alias to the tables

SELECT * FROM employees               -- All the departments in the employees table which are not in the departments table
WHERE department NOT IN (SELECT department FROM departments);

SELECT * 
FROM (SELECT * FROM employees WHERE salary > 150000) AS a_table;

-- Return all the records from the 'employees' table which belong to the 'electronics' division of the 'departments' table

SELECT * FROM departments;
SELECT * FROm employees;

SELECT * FROM employees 
WHERE department IN (SELECT department FROM departments WHERE division = 'Electronics');

-- Find employees who work in either Africa or Canada and make a salary of more than 130000
SELECT * FROM regions;
SELECT * FROM employees;

SELECT * FROM employees
WHERE region_id IN (SELECT region_id FROM regions WHERE country IN ('Asia', 'Canada')) AND salary > 130000
ORDER BY region_id;

-- first_name, department and how much less they earn from the person earning the max salary in region Asia or Canada

SELECT first_name, department, salary, (SELECT MAX(salary) FROM employees) - salary AS difference  FROM employees
WHERE region_id IN (SELECT region_id FROM regions WHERE country IN ('Asia', 'Canada'));


-- Putting MAX(salary) alone will just repeat the salary column as every salary in the record will be the maximum of itself

SELECT * FROM employees
WHERE region_id IN (SELECT region_id FROM regions WHERE country = 'United States');

SELECT * FROM employees              -- Returns all the employees where ANY of the region_id is greater than the output of the subquery
WHERE region_id > ANY(SELECT region_id FROM regions WHERE country = 'United States');

SELECT * FROM employees             -- Returns ALL the employees where the region_id is greater than the output of region_id in the subquery
WHERE region_id > ALL(SELECT region_id FROM regions WHERE country = 'United States');

-- ANY and ALL can be used in the WHERE and HAVING Clause

-- Write a query that returns all of those employees that work in the kids division AND the dates at which those employees were hired
-- is greater than all teh hire_dates of the employees who work in the maintainence department

SELECT * FROM employees
WHERE department IN (SELECT department FROM departments WHERE division = 'Kids')
AND 
hire_date > ALL(SELECT hire_date FROM employees WHERE department = 'Maintenance'); -- We have to use ALL because we get multiple outputs in
-- the subquery and '>' operator is used to compare with only one value

-- Find the salary from the employees table which is occuring the most frequently

SELECT salary FROM 
(SELECT salary, COUNT(salary) FROM employees
GROUP BY salary
ORDER BY COUNT(salary) DESC, salary DESC
LIMIT 1) AS a;

-- Another way
SELECT salary FROM employees 
GROUP BY salary
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM employees
					  GROUP BY salary)
					  
ORDER BY salary DESC
LIMIT 1;

------------------------------------------------------------------------------------------------------------------------------------------
-- ASSIGNMENT
------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM dupes;

SELECT min(id), name FROM dupes
GROUP BY name;

SELECT * FROM employees;

-- Find the average salary without considering the minimum and the maximum salary in that average (employees table)

SELECT * FROM employees;

SELECT ROUND(AVG(salary)) FROM employees
WHERE salary NOT IN ((SELECT MIN(salary) FROM employees), (SELECT MAX(salary) FROM employees));




