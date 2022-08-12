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

           


 






















