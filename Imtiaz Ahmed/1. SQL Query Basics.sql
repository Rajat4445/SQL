SELECT * FROM employees; -- select all the columns from the table

SELECT employee_id, first_name, department    -- selecting specific columns
FROM employees;

SELECT * 
FROM employees            -- But the data is sensitive
WHERE department = 'Sports';  -- Even the table names are not case sensitive

SELECT * 
FROM employees
WHERE department LIKE '%nitu%';   -- all department with nitu in them

SELECT *
FROM employees
WHERE department LIKE 'F%nitu%';  -- Selects all the values, the name starts with 'F' and contains 'nitu'

SELECT * 
FROM employees
WHERE salary > 100000;

SELECT * FROM employees;

SELECT * FROM employees
WHERE 1 = 1;          -- Returns all the records as 1 = 1, as the record is equal to itself

SELECT * FROM employees
WHERE 1<1;      -- Nothing gets returned as the condition is not true

SELECT * FROM employees
WHERE salary < 100000;    -- Check all the records for this condition, condition is evaluated to true as we do have records with this condition as true

SELECT * FROM employees
WHERE department = 'Clothing' AND salary > 90000  -- All the conditions must be true for some data to return
AND region_id = 2;

SELECT * FROM employees
WHERE department = 'Clothing' OR salary > 90000;    -- either must be true

SELECT * FROM employees
WHERE salary < 40000 AND         -- Parenthesis is very important to make the conditions count together
(department = 'Clothing' OR department = 'Pharmacy');  

SELECT * FROM employees
WHERE department = 'Sports' AND department = 'Tools'; -- Where checks for the conditions in all records, return nothing as both of them are not true 


----------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM employees
WHERE NOT department = 'Sports';   -- Just add not to find all the records where the department is not Sports

-- WHERE department <> 'Sports'             -- Above query can be done with this also
-- WHERE department != Sports

SELECT * FROM employees 
WHERE NULL = NULL;   -- NULL is never = to null, there will be no output

-- NULL != NULL      -- Null values are not comparable at all

SELECT * FROM employees
WHERE email IS null;        -- 'null' and 'NULL' works either way

SELECT * FROM employees
WHERE email IS NOT null;  -- All emails with no null values

SELECT * FROM employees
WHERE department IN ('Sports', 'First Aid', 'Toys', 'Garden'); -- All the records with department in the parenthesis, can work

SELECT * FROM employees
WHERE salary BETWEEN 80000 AND 100000;  -- Between is inclusive i.e., [a, b]

---------------------------------------------------------------------------------------------------------------------------
-- EXERCISES
---------------------------------------------------------------------------------------------------------------------------
-- Return the first_name and email of females that work in the tools department having a salary greater than 110000
SELECT first_name, email
FROM employees
WHERE gender = 'F' AND department = 'Tools' AND salary > 110000;

-- Return the fisrt_name and hire_date of those employeees who earn more than 165000 as well as those employees that work in
-- the sports department and also happen to be men

SELECT first_name, hire_date
FROM employees
WHERE salary > 165000 OR (department = 'Sports' AND gender = 'M');

-- Return the first names and hiredates of those employees who were hored during Jan 1st 2002 and Jan 1st 2004
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2002-01-01' AND '2004-01-01';

-- Return the male employees who work in the automotive deparmtent and earn more than 40000 and less than 100000 as well as 
-- females that work in the toys department
SELECT * FROM employees
WHERE (gender = 'M' AND department = 'Automotive' AND salary > 40000 AND salary < 100000)
OR (gender = 'F' AND department = 'Toys');

---------------------------------------------------------------------------------------------------------------------------
-- Using ORDER BY, LIMIT, DISTINCT, renaming columns

SELECT * FROM employees
ORDER BY department DESC;

SELECT DISTINCT department FROM employees;   -- Gives unique list of the departments

SELECT DISTINCT department FROM employees
ORDER BY 1
LIMIT 10 ;         -- Prints first 10 departments alphabatically -- FETCH FIRST 10 ROWS ONLY 


SELECT first_name, last_name, department, salary AS "yearly salary"   -- Use double quotes for providing alias
FROM employees ;


---------------------------------------------------------------------------------------------------------------------------
-- Exercises
---------------------------------------------------------------------------------------------------------------------------
-- Write a query to display the names of those students that are between the age of 18 and 20
SELECT student_name FROM students
WHERE age BETWEEN 18 AND 20;


-- Write a query to display all of those students that contain the letter 'ch' in their name or their name ends with 'nd'
SELECT student_name FROM students
WHERE student_name LIKE '%ch%' OR student_name LIKE '%nd';

-- Write a query to display the name of those students that have the letter 'ae' or 'ph' in their names and are not 19 years old
SELECT student_name FROM students 
WHERE (student_name LIKE '%ae%' OR student_name LIKE '%ph%') AND age != 19;   -- No Output

-- Write a wuery that lists the names of those students sorted by their age from largest to the smallest
SELECT student_name FROM students
ORDER BY age DESC;

-- Write a query that displays the names and age of the top 4 oldest students
SELECT student_name, age FROM students
ORDER BY age DESC
LIMIT 4;

-- Write a query that returns the students based on following criteria:
-- The student must not be older than age 20 if their studnet_no is either between 3 and 5 or their student_no is 7. Your query
-- should also return students older than age 20 but in that case they must have a student_no that is at least 4
SELECT * FROM students
WHERE (age <= 20 AND (student_no BETWEEN 3 AND 5) OR student_no = 7)
OR (age > 20 AND student_no >= 4)

