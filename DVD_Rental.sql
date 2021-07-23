-- Provide manager with list of customer ID, their first and last names, and store ID
SELECT customer_id, first_name, last_name, store_id
FROM customer;

-- View all data from payment table 
SELECT *
FROM payment; 

-- Retrieve the address and district data from address 
SELECT address, district
FROM address; 

-- Get the customer ID, store ID and email address for a customer named Nancy Thomas
SELECT customer_id, store_id, email
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- Obtain the customer information (customer ID, first name, last name) for customer ID no.1 to 10
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id BETWEEN 1 AND 10;

-- Provide list of films (titles, film IDs and ratings) that are NOT rated NC-17
SELECT film_id, title, rating 
FROM film
WHERE rating != 'NC-17';

-- Get the addresses and postal codes of customers who live in the Michigan district
SELECT address, postal_code
FROM address
WHERE district = 'Michigan';

-- Payment transactions between 2007-02-18 and 2007-02-20. Retrieve payment ID, customer ID, amount and payment dates.
SELECT payment_id, customer_id, amount, payment_date
FROM payment
WHERE payment_date BETWEEN '2007-02-18' AND '2007-02-20'; 

-- Retrieve all information for customers whose last names are either Williams, Taylor or Andrews
SELECT *
FROM customer
WHERE last_name IN ('Williams', 'Taylor', 'Andrews');

-- Manager asks for rental ID and customer ID of transactions that have rental date starting May 26, 2005 and return date before May 29, 2005
SELECT rental_id, customer_id
FROM rental
WHERE rental_date >= '2005-05-26' AND return_date < '2005-05-29';

-- Email address of customers named Janice, Mildred, Jared and Angela
SELECT email
FROM customer
WHERE first_name IN ('Janice','Mildred','Jared','Angela'); 

-- Find address, districts and postal codes of customers who DO NOT live in the following districts: Chiba, Nebraska, Michigan and Hamilton
SELECT *
FROM address
WHERE district NOT IN ('Chiba','Nebraska','Michigan','Hamilton');

-- Show the customer ID's and amount paid of customers who paid the following amounts: 0.99 and 2.99 to staff ID no.1
SELECT *
FROM payment
WHERE amount IN (0.99, 2.99) AND staff_id = 1;

-- Retrieve customer ID, first name, last name and email address of all customers whose last names end with "son"
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE last_name LIKE '%son';

-- Provide all payment attributes (payment ID, customer ID, staff ID, rental ID, etc.) for the top 20 amount paid by customers
SELECT *
FROM payment
ORDER BY amount DESC
LIMIT 20;

-- Provide a list of the 5 shortest films with "G" rating and rental rates ranging from 2.99 to 4.99. Show their film ID and title.
SELECT film_id, title
FROM film
WHERE rating = 'G' AND rental_rate BETWEEN 2.99 AND 4.99
ORDER BY length
LIMIT 5;

-- Find top 10 customers who paid the most in a single transaction
SELECT c.customer_id, first_name, last_name, amount 
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id
ORDER BY 4 DESC, 1
LIMIT 10; 

-- Elizabeth Brown, find all the amounts she paid, the payment dates as well as the staff's first and last name who served her. 
-- Add another column to show either 'true' or 'false' for "amount > 2.99"
SELECT amount, payment_date, s.first_name, s.last_name, (amount > 2,99) "Amount > 2.99"
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
JOIN staff s 
ON p.staff_id = s.staff_id
WHERE c.first_name = 'Elizabeth' AND c.last_name = 'Brown'
ORDER BY 2 DESC;

-- Produce a table showing the film id, title, category name and inventory id of films that do not have any inventory
SELECT f.film_id, title, name AS category, inventory_id
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
LEFT JOIN inventory i
ON f.film_id = i.film_id
WHERE inventory_id IS NULL; 

-- What's the country of origing of customer ID no.1?
SELECT customer_id, email, g.city, country
FROM customer c 
JOIN address a
ON c.address_id = a.address_id
JOIN city g 
ON a.city_id = g.city_id
JOIN country y
ON g.country_id = y.country_id
ORDER BY 1 
LIMIT 10;

-- Monthly average number of unique film rentals per month
SELECT DATE_TRUNC('month', rental_date), COUNT(rental_id) AS total_amount, COUNT(DISTINCT(film_id)) AS unique_films, COUNT(rental_id) / COUNT(DISTINCT film_id) AS "Average Number of Unique Film Rentals"
FROM inventory i
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY 1;

-- Company is partnering with a bank to offer platinum credit cards to customers who had at least 36 transactions
SELECT c.customer_id, first_name, last_name, COUNT(amount) AS total_transactions
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 1
HAVING COUNT(amount) >= 36
ORDER BY 4 DESC; 

-- Companies lifelong customers
SELECT c.customer_id, first_name, last_name, DATE_TRUNC('month', rental_date) AS month, COUNT(rental_id) AS rental_count
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY 1,4
HAVING COUNT(rental_id) >= 5
ORDER BY 1,4;

-- Top 5 countires where most customers come from
SELECT co.country_id, country, COUNT(customer_id)
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5; 

-- Average amount paid by all customers
SELECT AVG(amount)
FROM payment; 

-- In the email attribute, extract the 'sakilacustomer.org' and call this new attribute web_address
SELECT SUBSTRING(email, POSITION('@' IN email)+1, LENGTH(email)) AS web_address
FROM customer;












