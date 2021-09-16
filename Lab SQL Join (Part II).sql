USE sakila;

-- 1 Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, ci.city, co.country
FROM sakila.store s
JOIN sakila.address a USING (address_id)
JOIN sakila.city ci USING (city_id)
JOIN sakila.country co USING (country_id)
GROUP BY s.store_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, sum(p.amount) as $
FROM sakila.store s
JOIN sakila.staff st USING(store_id)
JOIN sakila.payment p USING(staff_id)
GROUP BY s.store_id; 

-- 3 Which film categories are longest?

SELECT fc.category_id AS category, count(fc.category_id) AS 'number_of_films', sum(f.length)
FROM sakila.film_category fc
JOIN sakila.film f USING (film_id)
GROUP BY fc.category_id
ORDER BY sum(f.length) DESC;

-- 4 Display the most frequently rented movies in descending order.
SELECT * FROM rental;
SELECT * FROM inventory;

SELECT film_id, f.title, count(i.film_id) AS 'most_frequently_rented_movies'
FROM sakila.inventory i 
JOIN sakila.rental r USING(inventory_id)
JOIN sakila.film f USING(film_id)
GROUP BY f.film_id
ORDER BY count(i.film_id) DESC;

-- 5 List the top five genres in gross revenue in descending order.

SELECT c.name AS 'GENRE', sum(p.amount) AS'gross revenue'
FROM sakila.payment p
JOIN sakila.rental r USING(customer_id)
JOIN sakila.inventory i USING(inventory_id)
JOIN sakila.film_category f USING(film_id)
JOIN sakila.category c USING(category_id)
GROUP BY c.category_id
ORDER BY sum(p.amount) DESC
LIMIT 5;

-- 6 Is "Academy Dinosaur" available for rent from Store 1?

SELECT film_id FROM film
WHERE title = 'Academy Dinosaur';

SELECT inventory_id FROM inventory
WHERE film_id = 1 AND store_id = 1;

SELECT inventory_id, return_date
FROM rental
WHERE return_date IS NOT NULL AND inventory_id <= 4;

-- So yes it is.

-- 7 Get all pairs of actors that worked together.

SELECT * FROM (SELECT f1.film_id, f1.actor_id AS firstactor, a1.first_name AS firstactor_firstname, a1.last_name AS firstactor_last_name, f2.actor_id AS secondactor
FROM film_actor f1
JOIN film_actor f2
ON (f1.actor_id<>f2.actor_id) AND f1.film_id = f2.film_id
JOIN actor a1
ON f1.actor_id = a1.actor_id) j1
JOIN actor a2
ON j1.secondactor = a2.actor_id;

-- 8 Get all pairs of customers that have rented the same film more than 3 times.

SELECT i.film_id, title, r1.inventory_id, r1.customer_id as first_customer, r2.customer_id as second_customer
FROM rental r1
JOIN rental r2
ON r1.customer_id <> r2.customer_id AND r1.inventory_id = r2.inventory_id
JOIN inventory i
ON r1.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY r1.inventory_id
HAVING count(i.film_id)>3
ORDER BY i.film_id asc;


SELECT i.film_id, r1.inventory_id, r1.customer_id, r2.customer_id 
FROM rental r1
JOIN rental r2
ON r1.customer_id <> r2.customer_id AND r1.inventory_id = r2.inventory_id
JOIN inventory i
ON r1.inventory_id = i.inventory_id
GROUP BY r1.inventory_id
HAVING count(i.film_id)>3
ORDER BY i.film_id asc;


-- 9 For each film, list actor that has acted in more films.

SELECT title as film, concat(first_name,' ',last_name) as actor
FROM film_actor fa
JOIN film f
ON fa.film_id = f.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY f.film_id
HAVING count(fa.film_id) > 1
ORDER BY film asc;


