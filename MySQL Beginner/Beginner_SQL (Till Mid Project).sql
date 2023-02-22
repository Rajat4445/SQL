USE mavenmovies;

-- BIG 6: SELECT, FROM, WHERE (Optional), GROUP BY (Optional), HAVING (Optional), ORDER BY (Optional)


SELECT * FROM rental;
SELECT customer_id, rental_id FROM rental;         -- Selecting multiple columns 

SELECT first_name, last_name, email FROM customer; -- #A1

SELECT DISTINCT rating FROM film;

SELECT DISTINCT rental_duration FROM film; -- #A2

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE amount = 0.99;

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE payment_date > '2006-01-01';

SELECT customer_id, rental_id, amount, payment_date FROM payment         -- #A3
WHERE customer_id <= 100;

SELECT customer_id, rental_id, amount, payment_date FROM payment         -- #A3 another way
WHERE customer_id BETWEEN 1 AND 100;

SELECT customer_id, rental_id, amount, payment_date FROM payment 
WHERE amount = 0.99 AND payment_date > '2006-01-01';          -- Whenever date, always use inverted commas

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE customer_id < 101 AND amount >= 5 AND payment_date > '2006-01-01';         -- #A4

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE customer_id = 42 OR customer_id = 53 OR customer_id = 60 OR customer_id = 75 OR amount > 5; -- #A5

SELECT customer_id, rental_id, amount, payment_date FROM payment
WHERE customer_id IN (42, 53, 60, 75) OR amount > 5;                 -- Better way of writing #A5

-- SOME POWERFUL OPERATORS NOW

SELECT title, description FROM film          -- LIKE is used for pattern matching
WHERE description LIKE '%Epic%';          -- Epic can be anywhere in the description (Look in the page 67 of the slides)

SELECT title, special_features FROM film
WHERE special_features LIKE '%Behind the Scenes%';          -- #A6

SELECT rating, COUNT(film_id) AS 'Total Films' FROM film          -- COUNT is the metric function which needs to be cared by a proper dimension
GROUP BY rating;                            -- GROUP BY takes the column which is serving as the dimension for the resulting output

SELECT rental_duration, COUNT(film_id) AS films_with_this_rental_duration FROM film     -- #A7
GROUP BY rental_duration;

-- Below Output is similar what you get when you look at the subcategories of the total orders
SELECT rental_duration, rating, replacement_cost, COUNT(film_id) AS films_with_this_rental_duration FROM film     
GROUP BY rental_duration, rating, replacement_cost;

-- COUNT (Except COUNT(*)), COUNT DISTINCT, MIN, MAX, AVG, skip all the NULL values
-- SUM treats NULL values as Zero

SELECT rating, COUNT(film_id) AS 'Count of films',
MIN(length) AS 'Shortest film', MAX(length) AS 'Longest film', AVG(length) AS 'Average Length of films',
AVG(rental_duration) AS 'Average Rental duration'
FROM film
GROUP BY rating;                -- Here, rating serves as the dimension and all the others are just metrics

SELECT replacement_cost, COUNT(film_id) AS 'Number of films', MIN(rental_rate) AS 'Cheapest Rental',       -- #A8
MAX(rental_rate) as 'Most Expensive Rental', AVG(rental_rate) AS 'Average Rental Rate'
FROM film 
GROUP BY replacement_cost;

SELECT customer_id, COUNT(rental_id) AS 'Total Rental' FROM rental       -- Look Closely at this example
GROUP BY customer_id HAVING COUNT(rental_id) >= 30;

SELECT customer_id, COUNT(rental_id) AS 'Total Rental' FROM rental
GROUP BY customer_id HAVING COUNT(rental_id) < 15;

SELECT customer_id, rental_id, amount, payment_date FROM payment
ORDER BY amount DESC;

SELECT title, length, rental_rate FROM film            -- #A9
ORDER BY length DESC, rental_rate DESC;

-- CASE Statement

SELECT DISTINCT length,                           -- Look Closely
CASE 
	WHEN length < 60 THEN 'Under 1 hr'
	WHEN length BETWEEN 60 AND 90 THEN '1-1.5 hrs'
	WHEN length > 90 THEN 'Over 1.5 hrs'
	ELSE 'Uh oh...check logic'

END AS 'Length Bucket'
FROM film;

SELECT DISTINCT title,

CASE
	WHEN rental_duration <= 4 THEN 'Rental too short'
    WHEN rental_rate >= 3.99 THEN 'Too Expensive'
    WHEN rating IN ('NC-17', 'R') THEN 'Too Adult'
    WHEN length NOT BETWEEN 60 AND 90 THEN 'Too short or Too long'
    WHEN description LIKE '%Shark%' THEN 'Nope has sharks'
    ELSE 'Great Recommendation for my niece'
END AS 'Fit for Recommendation'
FROM film;


SELECT first_name, last_name,

CASE 
	WHEN store_id = 1 AND active = 1 THEN 'Store 1 Active'
    WHEN store_id = 1 AND active = 0 THEN 'Store 1 Inactive'
    WHEN store_id = 2 AND active = 1 THEN 'Store 2 Active'
    WHEN store_id = 2 AND active = 0 THEN 'Store 2 Inactive'
    ELSE 'Fuck OFF!!'
END AS 'Store and Status'
FROM customer;

-- Pivoting using COUNT and CASE (Similar to Excel)         LOOK Very Closely and understand

SELECT film_id,
COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END) AS 'Store 1 Copies',    -- Counts store_ids where value is 1 and otherwise keeps it 0
COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END) AS 'Store 2 Copies',
COUNT(inventory_id) AS 'Total Copies'
FROM inventory
GROUP BY film_id
ORDER BY film_id;

SELECT store_id,                                                                             -- #A10
COUNT(CASE WHEN store_id IN (1, 2) AND active = 1 THEN active ELSE NULL END) AS 'Active',
COUNT(CASE WHEN store_id IN (1, 2) AND active = 0 THEN active ELSE NULL END) AS 'Inactive'
FROM customer
GROUP BY store_id
ORDER BY store_id;

SELECT store_id,
COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS 'Active',            -- Another way of doing #A10
COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS 'Inactive'
FROM customer
GROUP BY store_id
ORDER BY store_id;



-- MID Course Project
-- 1 
SELECT first_name AS 'First Name', last_name AS 'Last name', email AS 'Email Address', store_id AS 'Store Identification Number' FROM staff;

-- 2
SELECT store_id AS 'Store Identification',
COUNT(inventory_id) AS 'Items in Store'
FROM inventory
GROUP BY store_id
ORDER BY store_id;

-- 3
SELECT store_id AS 'Store Identification',
COUNT(customer_id) AS 'Total Active Customers' 
FROM customer
WHERE active = 1
GROUP BY store_id;

-- 4
SELECT COUNT(DISTINCT email) AS 'Total Emails in the database' FROM customer; 

-- 5
SELECT store_id, COUNT(DISTINCT film_id) AS 'Unique Movies' FROM inventory GROUP BY store_id;
SELECT COUNT(DISTINCT category_id) AS 'Unique Category' FROM film_category;

-- 6
SELECT MIN(replacement_cost) AS 'Least Expensive', MAX(replacement_cost) AS 'Most Expensive', AVG(replacement_cost) AS 'Average Replacement Cost'
FROM film;

-- 7
SELECT AVG(amount) AS 'Average Amount Processed', MAX(amount) AS 'Maximum Amount Processed' FROM payment;

-- 8
SELECT customer_id AS 'Customer Identification Value', COUNT(rental_id) AS 'Total Rental Made' FROM rental GROUP BY customer_id 
ORDER BY COUNT(rental_id) DESC


