-- JOINS: A Technique to link two or more tables on the common columns

SELECT first_name, country
FROM employees, regions
WHERE employees.region_id  = regions.region_id;

-- Display fisrt_name, email, division 
SELECT * FROM departments;
SELECT * FROM employees;

SELECT first_name, email, division 
FROM employees, departments
WHERE employees.department = departments.department AND email IS NOT NULL;   -- Null cannot be compared

-- getting country also in the output
SELECT first_name, email, division, country 
FROM employees, departments, regions
WHERE employees.department = departments.department
AND employees.region_id = regions.region_id
AND email IS NOT NULL; 

-- Country and total number of employees assigned to that country

SELECT * FROM employees;
SELECT * FROM regions;

SELECT country, COUNT(employee_id)
FROM employees, regions
WHERE employees.region_id = regions.region_id
GROUP BY country;

-- INNER JOIN: Retuns all the records which are there in both the tables

SELECT first_name, country
FROM employees
INNER JOIN regions
ON employees.region_id = regions.region_id;

SELECT first_name, email, division, country
FROM employees
INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions                  				-- Regions is getting joined with both employees and departments table
ON employees.region_id = regions.region_id
WHERE email IS NOT NULL;

SELECT DISTINCT employees.department, departments.department
FROM employees INNER JOIN departments ON employees.department = departments.department;

-- Give all departments from the employees table whether that department is not present in the second table
SELECT DISTINCT employees.department AS employees_department, departments.department AS departments_department
FROM employees LEFT JOIN departments ON employees.department = departments.department;

-- RIGHT JOIN (or RIGHT OUTER JOIN); just does the opposite of the left join, gives priority to the right table

-- ## 2: Give all the departments that exist in the employees table and not in the deparments table

SELECT * FROM employees;
SELECT * FROM departments;

SELECT DISTINCT employees.department, departments.department 
FROM employees
LEFT JOIN departments 
ON employees.department = departments.department
WHERE departments.department IS NOT NULL;

-- FULL OUTER JOIN: Gives all the records from both the tables and points NULL to the records which are not 
-- available in the corresponding tables

SELECT DISTINCT employees.department, departments.department 
FROM employees
FULL OUTER JOIN departments 
ON employees.department = departments.department;

-- UNION: To stack one set of data on another, without duplicates

SELECT department FROM employees     
UNION -- Removes duplicates
SELECT department FROM departments

-- UNION ALL: Stacks one set of data on another, with duplicates

SELECT DISTINCT department FROM employees     -- columns should match (datatypes as well as number of columns must be same)
UNION ALL -- does not eliminate duplicates
SELECT department FROM departments

--EXCPET: Gives all the departments which are not a part of departments table (In Oracle, we use MINUS)

SELECT DISTINCT department FROM employees     
EXCEPT 
SELECT department FROM departments

-- ##3 output departments and the respective count of employees in them using joins

SELECT DISTINCT department FROM employees;
SELECT * FROM departments;

SELECT department, COUNT(employee_id)
FROM employees
GROUP BY department
UNION ALL
SELECT 'TOTAL', COUNT(employee_id)
FROM employees


-- Cartesian Product with Cross Join
-- bascially a cartesian product
SELECT * FROM employees, departments     -- Gives every single combination between employees and departments
-- bascially this makes the number of records, a*b (a: number of records in employees, b: " " in departments)

SELECT *
FROM employees CROSS JOIN departments;   -- Similar to above



-------------------------------------------------------------------------------------------------------------------
-- EXERCISES
-------------------------------------------------------------------------------------------------------------------

-- Write a query to get first_name, department, hire_date and country of the first and last employee of the data
SELECT * FROM (SELECT first_name, department, hire_date, country
FROM employees
LEFT JOIN regions
ON employees.region_id = regions.region_id
ORDER BY hire_date DESC
LIMIT 1) AS a

UNION ALL

SELECT * FROM (SELECT first_name, department, hire_date, country
FROM employees
LEFT JOIN regions
ON employees.region_id = regions.region_id
ORDER BY hire_date ASC
LIMIT 1) AS b

-- Understand this one again!!! (Important look at correlated subqueries again)

SELECT hire_date, salary,
(SELECT SUM(salary) FROM employees e2
WHERE e2.hire_date BETWEEN e.hire_date - 90 AND e.hire_date) AS spending_pattern
FROM employees e
ORDER BY hire_date



-- Views: Virtual table, not an actual table, it is generated via SQL query. You cannot insert or delete data from it
-- Kind of similar to a Temporary table of MySQL
CREATE VIEW v_employee_information AS 
SELECT first_name, email, e.department, salary, division, region, country
FROM employees e, departments d, regions r
WHERE e.department = d.department AND e.region_id = r.region_id;

SELECT * FROM v_employee_information;    -- Cannot insert or delete data from it, query saved in the database

-- Inline View: When you have a subquery inside main query

SELECT * FROM (SELECT * FROM departments);












