-- Write an SQL query to find the employees who earn more than their managers.
-- Return the result table in any order.

SELECT e1.name AS Employee                 -- (Used Self Join)
FROM employee as e1, employee as e2
WHERE e1.managerID = e2.id
AND e1.salary > e2.salary

----------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+-------------+---------+
| Column Name | Type    |
 +-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to report all the duplicate emails.

Return the result table in any order. */

SELECT email
FROM person
GROUP BY email
HAVING COUNT(email) > 1

------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key column for this table.
customerId is a foreign key of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 

Write an SQL query to report all customers who never order anything.

Return the result table in any order.        */


SELECT name AS customers FROM customers
WHERE id NOT IN (SELECT DISTINCT(customerID) FROM orders)

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write an SQL query to report the first login date for each player.

Return the result table in any order.           */

SELECT player_id, MIN(event_date) as first_login
FROM activity
GROUP BY player_id

-- if we do not use GROUP BY it returns the player with earliest first_login

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 

Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.                */

SELECT name 
FROM customer
WHERE referee_id <> 2 OR referee_id IS NULL

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.
 

Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.       */

SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) DESC
LIMIT 1

------------------------------------------------------------------------------------------------------------------------------------------------------
/*

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key column for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write an SQL query to report all the classes that have at least five students.

Return the result table in any order.               */

SELECT class
FROM courses
GROUP BY class
HAVING COUNT(class) >= 5


------------------------------------------------------------------------------------------------------------------------------------------------------
/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | int     |
+-------------+---------+
name is the primary key column for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
 

A country is big if:

it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write an SQL query to report the name, population, and area of the big countries.            */

SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000

------------------------------------------------------------------------------------------------------------------------------------------------------
/*

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.         */

SELECT *
FROM cinema
WHERE id%2 = 1 AND description <> 'boring'
ORDER BY rating DESC

------------------------------------------------------------------------------------------------------------------------------------------------------
/*

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
id is the primary key for this table.
The sex column is ENUM value of type ('m', 'f').
The table contains information about an employee.
 

Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.

Note that you must write a single update statement, do not write any select statement for this problem.       */

UPDATE salary
SET sex = if(sex = 'm', 'f', 'm')

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 +-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key column for this table.
 

Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times. */

SELECT actor_id, director_id
FROM actordirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3

------------------------------------------------------------------------------------------------------------------------------------------------------
/*

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.
 

Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive. */

SELECT product_id , product_name
FROM product
WHERE product_id IN
(SELECT product_id
FROM sales
GROUP BY product_id
HAVING MIN(sale_date) BETWEEN '2019-01-01' AND '2019-03-31' AND MAX(sale_date) BETWEEN'2019-01-01' AND '2019-03-31')

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the employee ID, employee name, and salary.
 

Write an SQL query to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.       */

SELECT employee_id,  
CASE 
    WHEN MOD(employee_id, 2) = 1 AND name NOT LIKE 'M%' THEN salary 
    ELSE 0
END AS bonus
FROM employees
ORDER BY employee_id

------------------------------------------------------------------------------------------------------------------------------------------------------
/*

Table: Salary

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
id is the primary key for this table.
The sex column is ENUM value of type ('m', 'f').
The table contains information about an employee.
 

Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.

Note that you must write a single update statement, do not write any select statement for this problem.      */

UPDATE salary
SET sex = CASE 
                WHEN sex = 'm' THEN 'f'
                WHEN sex = 'f' THEN 'm'
                END


------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id.
Note that you are supposed to write a DELETE statement and not a SELECT one.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. 
The final order of the Person table does not matter.              */

DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.                  */

SELECT user_id, 
               CONCAT(UCASE(SUBSTRING(name, 1,1)), LCASE(SUBSTRING(name, 2, LENGTH(name) + 1))) AS name
FROM users
ORDER BY user_id

------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

Return the result table in any order.     */
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT id,
SUM(CASE WHEN month = 'Jan' THEN revenueEND) AS 'Jan_Revenue',
SUM(CASE WHEN month = 'Feb' THEN revenueEND) AS 'Feb_Revenue',
SUM(CASE WHEN month = 'Mar' THEN revenueEND) AS 'Mar_Revenue',
SUM(CASE WHEN month = 'Apr' THEN revenueEND) AS 'Apr_Revenue',
SUM(CASE WHEN month = 'May' THEN revenueEND) AS 'May_Revenue',
SUM(CASE WHEN month = 'Jun' THEN revenueEND) AS 'Jun_Revenue',
SUM(CASE WHEN month = 'Jul' THEN revenueEND) AS 'Jul_Revenue',
SUM(CASE WHEN month = 'Aug' THEN revenueEND) AS 'Aug_Revenue',
SUM(CASE WHEN month = 'Sep' THEN revenueEND) AS 'Sep_Revenue',
SUM(CASE WHEN month = 'Oct' THEN revenueEND) AS 'Oct_Revenue',
SUM(CASE WHEN month = 'Nov' THEN revenueEND) AS 'Nov_Revenue',
SUM(CASE WHEN month = 'Dec' THEN revenueEND) AS 'Dec_Revenue'
FROM department
GROUP BY id

















