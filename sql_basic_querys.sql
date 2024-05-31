#Q1 - List the number of films per category.
SELECT category.name AS category, COUNT(film.film_id) AS number_of_films
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY number_of_films DESC;

#Q2 - Retrieve the store ID, city, and country for each store.
SELECT store.store_id, city.city, country.country
FROM store
left JOIN address ON store.address_id = address.address_id
left JOIN city ON address.city_id = city.city_id
left JOIN country ON city.country_id = country.country_id;

#Q3 - Calculate the total revenue generated by each store in dollars.
SELECT payment.store_id, SUM(payment.amount) AS total_revenue
FROM payment
GROUP BY payment.store_id
ORDER BY total_revenue DESC;

#Q4 - Determine the average running time of films for each category.
SELECT category.name AS category, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time DESC;

#Identify the film categories with the longest average running time.
SELECT category.name AS category, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time DESC;

#Display the top 10 most frequently rented movies in descending order.
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;


#Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT 
    CASE 
        WHEN COUNT(inventory.inventory_id) > 0 THEN 'Available' 
        ELSE 'Not Available' 
    END AS availability
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Academy Dinosaur' AND inventory.store_id = 1;


#Provide a list of all distinct film titles, along with their availability status in the inventory.
SELECT 
    film.title, 
    CASE 
        WHEN IFNULL(inventory.film_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY film.title;


#Include a column indicating whether each title is 'Available' or 'NOT available.'
#Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
