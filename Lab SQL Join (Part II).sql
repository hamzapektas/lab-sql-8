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

-- 7 Get all pairs of actors that worked together.
-- 8 Get all pairs of customers that have rented the same film more than 3 times.
-- 9 For each film, list actor that has acted in more films.





