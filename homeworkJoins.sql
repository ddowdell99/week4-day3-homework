-- Question 1: List all customers who live in Texas (use JOINs)

SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Answer: Kim Cruz, Jennifer Davis, Bryan Hardison, Ian Still and Richard Mccray

-- Question 2: Get all payments above $6.99 with the Customer's Full Name

SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;
-- Answer: See query/table above.

-- Question 3: Show all customers names who have made payments over $175 (use subqueries)

-- 1st step in just seeing how many customers have made a payment over $175
SELECT DISTINCT customer_id
FROM payment
WHERE amount > 175

-- 2nd query to look for all customers first and last name
SELECT first_name, last_name
FROM customer

-- Put them together
SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 175
);
-- Answer: Harold Martino, Jennifer Davis, Mildred Bailey

-- Question 4: List all customers that live in Nepal (use the city table)

SELECT *
FROM country
WHERE country = 'Nepal';

-- country id is 66 for Nepal

SELECT first_name, last_name
FROM customer
WHERE address_id in (
    SELECT address_id -- Created an inner join to connect city with country knowing Nepal's country id
    FROM address
    INNER JOIN city
    ON city.city_id = address.city_id
    WHERE country_id = 66
);
-- Answer: Kevin Schuler is the only customer

-- Question 5: Which staff member had the most transactions?

SELECT first_name, last_name, COUNT(*)
FROM staff
INNER JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC
LIMIT 1;
-- Answer: Jon Stephens

-- Question 6: How many movies of each rating are there?

SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;
-- Answer: See query/table.

-- Question 7: Show all customers who have made a single payment above $6.99 (Use Subqueries) 

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 6.99
    ORDER BY customer_id
);

-- Answer: See table/query. Used distinct to ensure the same customer not pulled twice. 

-- Question 8: How many free rentals did our stores give away?

SELECT payment_id, amount, rental_id
FROM payment
WHERE amount = 0 OR amount = NULL
ORDER BY amount DESC;

-- Answer: None? But we did give some money away :/