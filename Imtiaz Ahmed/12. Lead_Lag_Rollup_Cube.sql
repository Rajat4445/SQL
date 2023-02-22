-- LEAD and LAG Functions

SELECT first_name, last_name, salary
FROM employees;

SELECT first_name, last_name, salary,      -- gets the salary just next to the present record
LEAD(salary) OVER() next_salary
FROM employees;


SELECT first_name, last_name, salary,      -- gets the salary just previous to the present record
LAG(salary) OVER() previous_salary
FROM employees;

SELECT department, last_name, salary,                      -- find the closest higher salary
LAG(salary) OVER(ORDER BY salary DESC) next_higer_salary
FROM employees;

SELECT department, last_name, salary,                      -- find the closest higher salary
LEAD(salary) OVER(ORDER BY salary DESC) closest_lower_salary
FROM employees;


-- ROLLUP and CUBE

SELECT * FROM sales;

SELECT continent, country, city, SUM(units_sold)       -- shows all the data in single snapshots
FROM sales
GROUP BY GROUPING SETS(continent, country, city, ()); -- () Shows the total units sold 

-- instead of grouping individually, it groups them in the single group by clause

SELECT continent, country, city, SUM(units_sold)      -- group by all three columns, group by two, group by one of the columns
FROM sales
GROUP BY ROLLUP(continent, country, city); 

SELECT continent, country, city, SUM(units_sold)      -- all the possible combinations of the columns mentioned
FROM sales
GROUP BY CUBE(continent, country, city); 




