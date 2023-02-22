-- Conditional Logic using CASE WHEN

SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'
	WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
	WHEN salary > 160000 THEN 'EXECUTIVE'
	ELSE 'UNPAID'
END AS Category
FROM employees
ORDER BY salary;

-- Use the above query to find the count of all the categories of employees in terms of salary (category and count)

SELECT category, COUNT(*) FROM (SELECT first_name, salary,
CASE
	WHEN salary < 100000 THEN 'UNDER PAID'       -- it can be equal to int type instead of string in this example
	WHEN salary > 100000 AND salary < 160000 THEN 'PAID WELL'
	WHEN salary > 160000 THEN 'EXECUTIVE'
	ELSE 'UNPAID'
END AS Category
FROM employees
ORDER BY salary) AS tab

GROUP BY category;

-- Transposing the result from the above query
SELECT SUM(CASE WHEN salary < 100000 THEN 1 ELSE 0 END) AS under_paid,
SUM(CASE WHEN salary > 100000 AND salary > 150000 THEN 1 ELSE 0 END) AS upaid_well,
SUM(CASE WHEN salary < 150000 THEN 1 ELSE 0 END) AS executive
FROM employees;


-- Give the total number of employees from each department and transpose it

SELECT SUM(CASE WHEN department = 'Sports' THEN 1 ElSE 0 END) AS sports_employees,
SUM(CASE WHEN department = 'Tools' THEN 1 ElSE 0 END) AS tools_employees,
SUM(CASE WHEN department = 'Clothing' THEN 1 ElSE 0 END) AS clothing_employees,
SUM(CASE WHEN department = 'Computers' THEN 1 ElSE 0 END) AS computers_employees

FROM employees;

-- Look at the output

SELECT * FROM regions;
SELECT * FROM employees;

SELECT first_name, 
CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) ELSE NULL END AS region_1,
CASE WHEN region_id = 2 THEN (SELECT country FROM regions WHERE region_id = 2) ELSE NULL END AS region_2,
CASE WHEN region_id = 3 THEN (SELECT country FROM regions WHERE region_id = 3) ELSE NULL END AS region_3,
CASE WHEN region_id = 4 THEN (SELECT country FROM regions WHERE region_id = 4) ELSE NULL END AS region_4,
CASE WHEN region_id = 5 THEN (SELECT country FROM regions WHERE region_id = 5)ELSE NULL END AS region_5,
CASE WHEN region_id = 6 THEN (SELECT country FROM regions WHERE region_id = 6) ELSE NULL END AS region_6,
CASE WHEN region_id = 7 THEN (SELECT country FROM regions WHERE region_id = 7) ELSE NULL END AS region_7

FROM employees;

-- get the total number of employees from different coutries using CASE WHEN
SELECT * FROM employees;
SELECT * FROM regions;

SELECT COUNT(*) FROM employees WHERE region_id IN (SELECT region_id FROM regions WHERE country = 'United States');

SELECT 
SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'United States') THEN 1 ELSE 0 END) AS united_states,
SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'Asia') THEN 1 ELSE 0 END) AS asia,
SUM(CASE WHEN region_id IN (SELECT region_id FROM regions WHERE country = 'Canada') THEN 1 ELSE 0 END) AS canada

FROM employees



