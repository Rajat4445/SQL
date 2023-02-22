/*Normalization is the process of structuring your tables and columns in the relational database ro minimise reduncy and preserve
data integrity. Eliminating duplicate values and reducing errors and anomalies are some of the benifits. */

-- Primary Keys are UNIQUE and NOT NULL
-- INNER JOIN: Gives the records that exists in both the tables
-- LEFT JOIN: All the records from the LEFT table and any matching record from the right table
-- RIGHT JOIN: All the records from the RIGHT table and any matching record from the right table
-- FULL OUTER JOIN: Returns all the records from both the tables including the non-matching records
-- UNION: Retuns all the data from one table with all the data from the other table appended to the end

SELECT DISTINCT inventory.inventory_id         -- inventory.inventory_id has been done to tell SQL that we want the ids from the inventory table
FROM inventory
INNER JOIN rental                         -- Inner Join practice
ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

SELECT title AS 'Title', description AS 'Description', store_id AS 'STORE ID', inventory_id AS 'Inventory ID'     
-- As all the columns here are unique in both the tables and exist separately, we don't need to use table.column syntax
-- Check the previous example to get more clarity
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id;

-- Let's see the difference between the INNER join and LEFT join
SELECT DISTINCT inventory.inventory_id AS 'Inventory ID FROM Inventory', rental.inventory_id AS 'Inventory ID FROM rental'
FROM inventory
INNER JOIN rental                                -- INNER JOIN
ON inventory.inventory_id = rental.inventory_id;

SELECT DISTINCT inventory.inventory_id AS 'Inventory ID FROM Inventory', rental.inventory_id AS 'Inventory ID FROM rental'
FROM inventory
LEFT JOIN rental                                 -- LEFT JOIN
ON inventory.inventory_id = rental.inventory_id;

-- You will observe in the results of the above query that all the inventory id from inventory table exists but not from rental which shows 
-- NULL at the id value 5

SELECT film.title AS 'Title', COUNT(film_actor.actor_id) AS 'Number of Actors'
FROM film
LEFT JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.title;

-- FULL JOIN (Only handy when you want to use all the results from both the tables

-- Using bridge, to connect two unrelated table using another table which has column which are common in both the unrelated tables
SELECT film.film_id, film.title, category.name AS 'Category Name'        -- Very very Important
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id;

-- Get a list of all actors, which each title they appeared in?

SELECT CONCAT(actor.first_name," ", actor.last_name) AS 'Name of Actor', film.title      -- CONCAT helps in combining two columns
FROM actor
INNER JOIN film_actor                        -- Assignment
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

-- Pull a list of distinct titles and their descriptions, currently available in inventory at store 2

SELECT DISTINCT film.title AS 'Title', film.description AS 'Description'
FROM film                                                      -- Assignment
INNER JOIN inventory
ON film.film_id = inventory.film_id AND inventory.store_id = 2;

-- UNION returns all the data from the FIRST table, with all from the second table appended at the end
-- Conditions to use: Two SELECT statements must have same number of columns, columns are in same order and the data type is same as well

-- UNION deduplicates (it only keeps the distinct values), if you want the duplicates too use UNION ALL

-- UNION makes the tables longer while the JOINS make the tables wider
SELECT 'advisor' AS type, first_name, last_name FROM advisor        -- Here the type must be same for the tables, here it is string
UNION
SELECT 'investor' AS type, first_name, last_name FROM investor;

-- Pull a list of all staff and advisor names and include a column noting whether they are advisors or staff members?
SELECT 'Staff Member' AS type, first_name, last_name FROM staff
UNION
SELECT 'Advisor' AS type, first_name, last_name FROM advisor;

-- FINAL PROJECT

-- 1
SELECT staff.store_id AS 'Store ID', CONCAT(staff.first_name," ", staff.last_name) AS 'Manager Name',
address.address AS 'Street Address', address.district AS 'District', city.city AS 'City', country.country AS 'Country'
FROM staff
INNER JOIN address
ON staff.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

-- 2
SELECT inventory.store_id AS 'Store ID', inventory.inventory_id AS 'Inventory ID', film.title AS 'Name of film', film.rating AS 'Rating',
film.rental_rate AS 'Rental Rate', film.replacement_cost AS 'Replacement Cost'
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id;

-- 3
SELECT inventory.store_id AS 'Store ID', COUNT(inventory.inventory_id) AS 'Number of Inventory', film.rating AS 'Rating'
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY store_id, rating
ORDER BY store_id ASC; 

-- 4
SELECT inventory.store_id AS 'Store ID', COUNT(film.title) AS 'Number of Films', AVG(film.replacement_cost) AS 'Average Replacement Cost',
SUM(film.replacement_cost) AS 'Total Replacement Cost', category.name AS 'Category Name'
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY store_id, category.name ORDER BY store_id ASC;

-- 5
SELECT CONCAT(customer.first_name, " ", customer.last_name) AS 'Name of Customer', customer.store_id AS 'Store ID', 
customer.active AS 'Active', address.address AS 'Street Address', city.city AS 'City', country.country AS 'Country'
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
GROUP BY CONCAT(customer.first_name, " ", customer.last_name), customer.store_id, customer.active, address.address, city.city, country.country
ORDER BY customer.store_id ASC;

-- 6
SELECT CONCAT(customer.first_name, " ", customer.last_name) AS 'Name of Customer', COUNT(DISTINCT rental.rental_id) AS 'Total Rentals',
SUM(payment.amount) AS 'Total Payment'              -- Wrongly Done... look at the solution
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
INNER JOIN rental
ON payment.customer_id = rental.customer_id
GROUP BY CONCAT(customer.first_name, " ", customer.last_name)
ORDER BY SUM(payment.amount) DESC;

-- 7
SELECT 'Advisor' AS type, CONCAT(advisor.first_name, " ", advisor.last_name) AS 'Name', NULL AS 'Name of Company' FROM advisor
UNION
SELECT 'Investor' AS type, CONCAT(investor.first_name, " ", investor.last_name) AS 'Name', investor.company_name AS 
'Name of Company' FROM investor;

-- 8
SELECT
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards, 
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
	
FROM actor_award
	

GROUP BY 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END;
