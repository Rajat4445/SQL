-- UPPER(), LOWER(), LENGTH(), TRIM() + Boolean Expressions and Concatenation

SELECT UPPER(first_name), LOWER(department), LENGTH(first_name)      -- Changes the column values into uppercase
FROM employees;

SELECT LENGTH(TRIM('    Rajat Bahuguna   '));  --- Trims the extra spaces and also calculates the length of the string

SELECT first_name || ' ' || last_name AS full_name FROM employees;     -- concatinating the values, not changing the data

SELECT first_name || ' ' || last_name AS full_name, salary > 40000 FROM employees;

-- Exercise: Put all the true values on the top from the previous query

SELECT first_name || ' ' || last_name AS full_name, salary > 40000 FROM employees -- boolean column
ORDER BY salary desc;


SELECT department, ('Clothing' IN (department, first_name)) FROM employees;  -- Similar to OR 

SELECT department, (department LIKE '%oth%') FROM employees;


-----------------------------------------------------------------------------------------------------------------------------
-- String Functions: SUBSTRING(), REPLACE(), POSITION(), COALESCE()

SELECT 'This is test data' AS test_data;

SELECT SUBSTRING('This is test data' FROM 1 FOR 4) AS test_data_extracted; -- Start from position 1, for a total of 4 characters 

SELECT SUBSTRING('This is test data' FROM 9) AS all_from;  -- Selects everthing after 9 including 9

-- Replaces the column department's 'Clothing' values to attire (column, value, new_value)
SELECT department, REPLACE(department, 'Clothing', 'Attire') AS modified_data FROM departments;

-- After the department value add the word 'Department' to it, meaning Clothing department, Grocery department etc
SELECT department, REPLACE(department, department, department || ' ' || 'Department') AS answer FROM departments;

-- Find the domain name of the email

SELECT POSITION('@' IN email) FROM employees; -- Gives the position of the '@' in string

SELECT email, SUBSTRING(email FROM POSITION('@' IN email) + 1) AS domain_name FROM employees;

-- USING COALESCE: Allows to put something in place of null
SELECT email FROM employees;

SELECT email, COALESCE(email, 'NONE') AS email FROM employees; -- Replaces all the nulls with 'NONE'

-----------------------------------------------------------------------------------------------------------------------------
-- GROUPING functions; Group data together and aggregate the information together

SELECT MAX(salary) FROM employees;   -- They return a single values back

SELECT MIN(salary) FROM employees;

SELECT ROUND(AVG(salary)) FROM employees;

SELECT COUNT(employee_id) FROM employees;   -- As employee id is the primary key

SELECT COUNT(email) FROM employees;   -- It only counts the cells which have data in the cell

SELECT SUM(salary) FROM employees;

SELECT SUM(salary) FROM employees
WHERE department = 'Clothing';

-------------------------------------------------------------------------------------------------------------------
-- EXERCISES
-------------------------------------------------------------------------------------------------------------------
-- Write a query against the professors table that can output the following results:
-- "Chong works in the Science Department"

SELECT last_name || ' works in the ' || department || 'department' FROM professors;

-- Write a SQL query against the professors table that would return:
-- "It is false that professor Chong is highly paid"

SELECT 'It is '|| (salary > 95000)||' that professor '||last_name||' is highly paid.' FROM professors; 

-- Write a query that returns all the records and columns from the professors table but shorten the department names to 
-- only three characters in UPPER CASE.

SELECT UPPER(SUBSTRING(department FROM 1 FOR 3)) AS Department_Code FROM professors;

-- Write a query that returns the highest and lowest salary from the professors table excluding the professor named "Wilson"

SELECT MAX(salary) as highest, MIN(salary) as lowest FROM professors
WHERE last_name != 'Wilson';

-- Write a query that will display the hiredate of the professor that has been teaching the longest

SELECT MIN(hire_date) FROM professors








