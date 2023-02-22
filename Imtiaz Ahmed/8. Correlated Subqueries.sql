-- Correlated Subqueries, when the nested subquery uses the values from the outer query

SELECT salary FROM employees                               -- salary of all employees greater than the average salary
WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees);    -- not correlated


-- Gives all the employees who make more than the avergae salaries of their respective departments
SELECT first_name, salary, department FROM employees e1
WHERE salary > (SELECT ROUND(AVG(salary))       -- the inside query runs for all the records of the outer query
			   FROM employees e2 WHERE e1.department = e2.department);

SELECT first_name, salary, department FROM employees e1
(SELECT ROUND(AVG(salary)) FROM employees e2 WHERE e1.department = e2.department);


-- name of the departments with more than 38 employees
SELECT department, COUNT(employee_id) FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 38;

SELECT department FROM departments
WHERE 38 < (SELECT COUNT(*)
		   FROM employees e
		   WHERE e.department = departments.department);

SELECT department, (SELECT MAX(salary) FROM employees WHERE department = departments.department) FROM departments
WHERE 38 < (SELECT COUNT(*)
		   FROM employees e
		   WHERE e.department = departments.department);

-- ASSIGNMENT 7 (Understand this very well!!)

SELECT department, first_name, salary,
CASE WHEN salary = max_by_department THEN 'HIGHEST SALARY'
	 WHEN salary = min_by_department THEN 'LOWEST SALARY'
END AS salary_in_department
FROM (
SELECT department, first_name, salary, 
		(SELECT MAX(salary) FROM employees e2
		WHERE e1.department = e2.department) as max_by_department,
		(SELECT MIN(salary) FROM employees e2
		WHERE e1.department = e2.department) as min_by_department
FROM employees e1) a

WHERE salary IN (max_by_department, min_by_department)
ORDER BY department





