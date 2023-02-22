-- Window Functions: Allows to slice and dice the data

SELECT department, COUNT(*)
FROM employees
GROUP BY department;

SELECT first_name, department,
(SELECT COUNT(*) FROM employees e1 WHERE e1.department = e2.department)
FROM employees e2
GROUP BY department, first_name;

-- the above can be done more simply using Window Functions

SELECT first_name, department,
COUNT(*) OVER()                 -- Gives the count of all the records
FROM employees;

SELECT first_name, department,
COUNT(*) OVER(PARTITION BY department)          -- Similar to the one where we used the correlated subqueries      
FROM employees; 

SELECT first_name, department,
SUM(salary) OVER(PARTITION BY department)          -- Similar to the one where we used the correlated subqueries      
FROM employees; 

SELECT first_name, department,
COUNT(*) OVER(PARTITION BY department) dept_count,          -- Similar to the one where we used the correlated subqueries     
region_id,
COUNT(*) OVER(PARTITION BY region_id) region_count
FROM employees
ORDER BY region_id ASC;

SELECT first_name, department, COUNT(*) OVER(PARTITION BY department)  -- Basically parition the data by department where 
FROM employees             												-- the region_id is 3
WHERE region_id = 3;

------------------------------------------------------------------------------------------------------------------------------
-- Getting cummulative sum of the salaries

SELECT first_name, hire_date, salary
FROM employees;

SELECT first_name, hire_date, salary      -- How to get running total (or cummualative sum over the rows)
FROM employees
ORDER BY hire_date;

SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_of_salaries
-- basically adds all the rows preceding the current row, unbounded just means all the preceding rows
FROM employees;

SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date) AS running_total_of_salaries
-- gives the same result as hte above
FROM employees;

SELECT first_name, hire_date, department, salary,   -- at the end of every department, it reset the cummulative sum
SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) AS running_total_of_salaries
FROM employees;

----------------- ORDER BY helps in creating frames, like  let us say we want to find the sum of nth rows etc

-- Sum the adjacent salaries: 1st row + 2nd row, 2nd row + 3rd row ...
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM employees;

-- Sum the adjacent salaries: 1st row + 2nd row, 2nd row + 3rd row ...
SELECT first_name, hire_date, department, salary,
SUM(salary) OVER(ORDER BY hire_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW)
FROM employees;

-- RANK Function

SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary ASC)
FROM employees;

--- Gets all the employees from the respective department at rank 8 in terms of salary
SELECT * FROM (
SELECT first_name, email, department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary ASC)
FROM employees) AS a
WHERE rank = 8;

-- NTILE Functions
-- 5 highest employees as rank 1 and etc

SELECT first_name, email, department, salary,
NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC) AS salary_bracket
FROM employees;

SELECT first_name, email, department, salary,        -- SIMILAR TO MAX(salary)
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS first_value
FROM employees;

-- But the advantage is that we can order by any other, column too

SELECT first_name, email, department, salary,        -- SIMILAR TO MAX(salary)
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY first_name ASC) AS first_value
FROM employees;

-- For the nth value, we use NTH_VALUE
SELECT first_name, email, department, salary,        -- SIMILAR TO MAX(salary)
NTH_VALUE(salary, 5) OVER(PARTITION BY department ORDER BY first_name ASC) AS nth_value
FROM employees;
